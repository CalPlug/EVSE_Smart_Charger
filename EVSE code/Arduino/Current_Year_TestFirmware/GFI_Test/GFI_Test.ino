#include <dummy.h>


#include <WiFi.h>
#include "esp32-hal-spi.h"
#include "esp32-hal-adc.h"
#include "PubSubClient.h"
#include <Time.h>
#include <driver/adc.h>
#include "ADE7953ESP32.h"
#include <SPI.h>
#include <DNSServer.h>
#include <EEPROM.h>
#include <esp32-hal-gpio.h>


#define m_irmsA 0.00000175811759528647 // gain current channel 1...prev 907...prev .0024
#define b_irmsA -0.002937872 // offset current channel 1...prev 603...prev -.0068

#define m_irmsB 0.0000093475476482166 // gain current channel 2...prev 1391...prev .0127
#define b_irmsB -0.011603168 // offset current channel 2...prev 119...prev -.0159
// NOTE: GFI threshold set in EEPROM, but current A and B used to determine GFI leakage current


time_t gfifailure; // tests the GFI interface


// General struct to keep track of variables
typedef struct {     
  char state;
  bool lv_1, lv_2, watttime, load_on, statechange;
  bool GFIfail, lvlfail, pilotError, pilotreadError, groundfail;  
  int chargerate, saverate, namelength, chargeCounter, totalCounter;  
  float ADemandCharge, ADemandTotal;
  char nameofdevice[50];
  char *mqttuser;
  char *mqttpassword;
  char *mqttserver;
  int mqttport;
  char *wifiname;
  char *wifipassword;
  bool wificonnection;
  bool diodecheck;
} ChargeState;


// GPIOs for the board
const int LED_PIN_BLUE = 22;
const int LED_PIN_GREEN = 16;
const int LED_PIN_RED = 4;
const int buttonPin = 34;
const int multiplex = 27;
const int relay1 = 32;
const int relay2 = 33;
const int relayenable = 21; // output
const int dutyout = 25;
const int GFIin = 26;
const int ADE795_reset = 12;
const int NULL_input = 35;

// main struct to hold important variables
ChargeState charge;

#define local_SPI_freq 1000000  //Set SPI_Freq at 1MHz (#define, (no = or ;) helps to save memory)
#define local_SS 14  //Set the SS pin for SPI communication as pin 5  (#define, (no = or ;) helps to save memory)
ADE7953 myADE7953(local_SS, local_SPI_freq);

int GFIthreshold;
char data[150] = {};

// temporary char buffers for SSID and MQTT parameters
char ssideeprom[25] = "";
char pwdeeprom[25] = "";
char mqtt_servereeprom[25] = "";
char mqtt_porteeprom[25] = "";
char mqtt_usereeprom[25] = "";
char mqtt_pwdeeprom[25] = "";
char GFI_eeprom[25] = "";
char lv1_eeprom[25] = "";
char lv2_eeprom[25] = "";

char configured[] = {'0', 0};

char ssid[30] = "";
char pssw[30] = "";
char mqttserver[30] = "";
char port[30] = "";
char username[30] = "";
char mqttpssw[30] = "";

void setup()
{
  Serial.begin(115200);

  // TURNS ON RELAYS
  pinMode(relayenable, OUTPUT);
  digitalWrite(relayenable, HIGH); // turn off relay enable pin
  digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid   
  digitalWrite(relay1, HIGH);  
  digitalWrite(relay2, HIGH);
  digitalWrite(relayenable, HIGH); // turn off relay enable pin
  delay(1000);
  
  #ifdef DEBUG
  Serial.println("Turning on relay enable pin! Setting relays ON!");
  #endif
  
  load_data(); //Loads the data saved on the EEPROM
  #ifdef DEBUG
  Serial.println("Initial data loaded from EEPROM");
  #endif  
  
  #ifdef DEBUG
  Serial.println("In Setup function - ADE7359 initialized");
  #endif 

  // establishes the SPI bus on the ESP32 to communicate with the ADE7953
  SPI.begin();
  delay(200);
  //SPI communication started,reset ADE7953 before use.
  pinMode(ADE795_reset, OUTPUT); //define ADE7953 reset pin as output
  digitalWrite(ADE795_reset, LOW); //perform reset 
  delay(10);
  digitalWrite(ADE795_reset, HIGH); // bring back into run state
  
  myADE7953.initialize(); //initialize function on ADE7953 object

  #ifdef DEBUG
  Serial.println("ADE initialized");
  #endif
  
  strcat(data, GFI_eeprom);
 // save_data(data);
  pinMode(GFIin, INPUT); // define GFI input pin 
  pinMode(NULL_input, INPUT); //hold as an input that is unused
  GFIthreshold = atoi(GFI_eeprom);
  //#ifdef DEBUG
  Serial.println("The GFI threshold value is: ");
  Serial.println(GFIthreshold);
  //#endif
  
}

  
// GFI safety check. Fails if the instant current between channels A and B are over
// a certain threshold
void loop()
{
  float IrmsAraw, IrmsBraw, IrmsA, IrmsB;
  IrmsAraw = myADE7953.getIrmsA();
  IrmsBraw = myADE7953.getIrmsB();
  Serial.println("Irms1");
  Serial.println(IrmsAraw);
  Serial.println("Irms2");
  Serial.println(IrmsBraw);
  IrmsA = (IrmsAraw*m_irmsA)+b_irmsA;
  IrmsB = (IrmsBraw*m_irmsB)+b_irmsB;

  Serial.println("IrmsA:");
  Serial.println(IrmsA);
  Serial.println("IrmsB:");
  Serial.println(IrmsB);
 
 
  if(abs(IrmsA - IrmsB) <= GFIthreshold) {
    charge.GFIfail = false;
    //#ifdef DEBUG
    Serial.print("GFI leakage current (IrmsA - IrmsB): "); 
    Serial.println(IrmsA - IrmsB);  
    Serial.println("GFI passed test");
   // #endif
  } else {
    //#ifdef DEBUG
    Serial.println("GFI failed test");
    //#endif
    charge.GFIfail = true;
    Serial.println("Turn relays off due to GFI test fail.");
    //TURN OFF RELAYS
    digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid  
    digitalWrite(relay1, LOW);
    digitalWrite(relay2, LOW);  
    delay(1000);
    digitalWrite(relayenable, HIGH); //when high, relay multiplexer disabled
  }
}

void load_data()
{
  Serial.println("Call to read data from EEPROM");
  EEPROM.begin(512);
  int count = 0;
  int address = 0;
  char data[150] = {};
  while (count < 10)
  {
    char read_char = (char)EEPROM.read(address);
    delay(1);
    if (read_char == '#')
    {
      Serial.println(data);
      switch (count)
      {
        case 0: strcpy(configured, data); break;
        case 1: strcpy(ssideeprom, data); break;
        case 2: strcpy(pwdeeprom, data); break;
        case 3: strcpy(mqtt_servereeprom, data); break;
        case 4: strcpy(mqtt_porteeprom, data); break;
        case 5: strcpy(mqtt_usereeprom, data); break;
        case 6: strcpy(mqtt_pwdeeprom, data); break;
        case 7: strcpy(GFI_eeprom, data); break;
        case 8: strcpy(lv1_eeprom, data); break;
        case 9: strcpy(lv2_eeprom, data); break;         
      }
      count++;
      strcpy(data,"");
    } 
    else
    {
      strncat(data, &read_char, 1);  
    }
    ++address;
  }
  delay(100);
  Serial.println("<--Read data complete, this was read");
}

/*void save_data(char* data)
{
  Serial.println("Call to write data to EEPROM");
  EEPROM.begin(512);
  for (int i = 0; i < strlen(data); ++i)
  {
    EEPROM.write(i, (int)data[i]);
    delay(1);
  }
  EEPROM.commit();
  Serial.println("Write data complete");
  load_data();// read back in data to verify write was proper
  delay(100);
}*/

/*// resets parameters to default values
void EEPROMReset(void) {
  
  delay(100);
  Serial.println("Resetting EEPROM to default values!");
  char data[150] = "0#ssid#pw123456789#m10.cloudmqtt.com#19355#dqgzckqa#YKyAdXHO9WQw#800#20#20#";
  save_data(data);
  delay(100);
  Serial.println("EEPROM overwrite complete, restarting...");
  ESP.restart();
  delay(500);
  //esp_restart_noos();  commented out 02/12, reinsert into the code
}*/

/*void savethedata(void) {
  char data[150] = {};
  Serial.println("Connected. Saving to EEPROM and resetting Wifi connection");
  configured[0] = '1';
  char* sep = "#";
  strcat(data, configured);
  strcat(data, sep);
  strcat(data, ssideeprom);
  strcat(data, sep);
  strcat(data, pwdeeprom);
  strcat(data, sep);
  strcat(data, mqtt_servereeprom);
  strcat(data, sep);
  strcat(data, mqtt_porteeprom);
  strcat(data, sep);
  strcat(data, mqtt_usereeprom);
  strcat(data, sep);
  strcat(data, mqtt_pwdeeprom);
  strcat(data, sep);
  strcat(data, GFI_eeprom);
  strcat(data, sep);
  strcat(data, lv1_eeprom);
  strcat(data, sep);
  strcat(data, lv2_eeprom);
  strcat(data, sep);
  Serial.println("Current values ready to be updated to EEPROM: ");
  Serial.println(data);
  Serial.println();
  save_data(data);
}*/
