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


#define m_irmsA 0.00000175811759528647 // gain current channel 1...prev 907
#define b_irmsA -0.002937872 // offset current channel 1...prev 603

#define m_irmsB 0.0000093475476482166// gain current channel 2...prev 1391
#define b_irmsB -0.011603168 // offset current channel 2...prev 119
// NOTE: GFI threshold set in EEPROM, but current A and B used to determine GFI leakage current


#define m_vRMS_chA 0.0190823244616849//0.0000559380239087644//0.0000362377103681644 // gain current channel 2...prev 1391
#define b_vRMS_chA 43.37478//-62.88006101//2.001195632 // gain current channel 2...prev 1391

#define m_vRMS_chB 0.0245991111587208//0.0000578332580889683//0.0000361706472528342 // offset current channel 2...prev 119
#define b_vRMS_chB 22.45193362//-63.90359892//2.35396552 // offset current channel 2...prev 119


#define m_powerFactorA 0.000026631068583386// offset current channel 2...prev 119
#define b_powerFactorA 0.176931253// offset current channel 2...prev 119


#define m_powerFactorB 0.0000304672528385695// offset current channel 2...prev 119
#define b_powerFactorB -0.00256881// offset current channel 2...prev 119

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
  pinMode(multiplex, OUTPUT);
  digitalWrite(multiplex, LOW); // defaults to line 2 initially
  delay(1000);

  delay(1000);
  
  #ifdef DEBUG
  Serial.println("Turning on relay enable pin! Setting relays ON!");
  #endif
  
  /*load_data(); //Loads the data saved on the EEPROM
  #ifdef DEBUG
  Serial.println("Initial data loaded from EEPROM");
  #endif */ 
  
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
  
  //strcat(data, GFI_eeprom);//
 // save_data(data);
  //pinMode(GFIin, INPUT); // define GFI input pin //
 // pinMode(NULL_input, INPUT); //hold as an input that is unused//
 // GFIthreshold = atoi(GFI_eeprom);//
  //#ifdef DEBUG
 // Serial.println("The GFI threshold value is: ");//
  //Serial.println(GFIthreshold);//
  //#endif
  
}

  
// GFI safety check. Fails if the instant current between channels A and B are over
// a certain threshold
void loop()
{
    float vRMS_chA,vRMS_chB, iRMSA, powerFactorA, powerFactorB, apparentPowerA, reactivePowerA, activePowerA, iRMSB, activeEnergyA, PrmsA, PrmsB, iRMSA_cal,iRMSB_cal, vRMS_chA_cal, vRMS_chB_cal, powerFactorA_cal, powerFactorB_cal, power_chA, power_chB;    
    //#ifdef DEBUG
    Serial.println("Received request for test 1");    
    Serial.println("Verifying that instcurrent is 0.0: ");
    //#endif

    char buffer[50];
//vRMS_chA  
    digitalWrite(multiplex, HIGH); // line 1 when set to HIGH
    delay(100);
    
  
    vRMS_chA = myADE7953.getVrms();
    vRMS_chA_cal= (m_vRMS_chA*vRMS_chA)+b_vRMS_chA;
    Serial.print("Vrms_chA RAW: ");
    Serial.println(vRMS_chA);

    Serial.print("Vrms_chA CALIBRATED (V): ");
    Serial.println(vRMS_chA_cal);
    delay(2000);
    
//vRMS_chB 
    digitalWrite(multiplex, LOW); // line 2 when set to LOW
    delay(100);
    
   
    vRMS_chB = myADE7953.getVrms();
    vRMS_chB_cal= (m_vRMS_chB*vRMS_chB)+b_vRMS_chB;
    Serial.print("Vrms_chB RAW: ");
    Serial.println(vRMS_chB);

    Serial.print("Vrms_chB CALIBRATED (V): ");
    Serial.println(vRMS_chB_cal);
    delay(2000);

//iRMSA
    iRMSA = myADE7953.getIrmsA();  
    iRMSA_cal= (m_irmsA*iRMSA)+b_irmsA;
    Serial.print("IrmsA RAW: ");
    Serial.println(iRMSA);
    
    Serial.print("IrmsA Calibrated (A): ");
    Serial.println(iRMSA_cal);

//iRMSB
    iRMSB = myADE7953.getIrmsB();
    iRMSB_cal= (m_irmsB*iRMSB)+b_irmsB;
    Serial.print("IrmsB RAW: ");
    Serial.println(iRMSB);
      
    Serial.print("IrmsB Calibrated (A): ");
    Serial.println(iRMSB_cal);

  

    apparentPowerA = myADE7953.getInstApparentPowerA();  
    Serial.print("Apparent Power A (mW): ");
    Serial.println(apparentPowerA);

    activePowerA = myADE7953.getInstActivePowerA();  
    Serial.print("Active Power A (mW): ");
    Serial.println(activePowerA);

    reactivePowerA = myADE7953.getInstReactivePowerA();  
    Serial.print("Rective Power A (mW): ");
    Serial.println(reactivePowerA);
    
//PowerFactorA
    powerFactorA = myADE7953.getPowerFactorA();  
    powerFactorA_cal= (m_powerFactorA*powerFactorA)+b_powerFactorA ;
    Serial.print("Power Factor A RAW (x100): ");
    Serial.println(powerFactorA);

    Serial.print("powerFactorA Calibrated (A): ");
    Serial.println(powerFactorA_cal);
    
//PowerFactorB
    powerFactorB = myADE7953.getPowerFactorB(); 
    powerFactorB_cal= (m_powerFactorB*powerFactorB)+b_powerFactorB ; 
    Serial.print("Power Factor B RAW (x100): ");
    Serial.println(powerFactorB);

    Serial.print("powerFactorB Calibrated (A): ");
    Serial.println(powerFactorB_cal);
    
    power_chA=(powerFactorA_cal*iRMSA_cal*vRMS_chA_cal);
    power_chB=(powerFactorB_cal*iRMSB_cal*vRMS_chB_cal);

    Serial.print("power_chA CALC: ");
    Serial.println(power_chA);

    Serial.print("power_chB CALC: ");
    Serial.println(power_chB);
    
    activeEnergyA = myADE7953.getActiveEnergyA();  
    Serial.print("Active Energy A (hex): ");
    Serial.println(activeEnergyA);
  
    PrmsA = vRMS_chA_cal * iRMSA_cal * powerFactorA_cal;
    Serial.println("PrmsA:");
    Serial.println(PrmsA);
    
    PrmsB = vRMS_chB_cal * iRMSB_cal * powerFactorB_cal;
    Serial.println("PrmsB:");
    Serial.println(PrmsB);
  
  
 /* float IrmsAraw, IrmsBraw, IrmsA, IrmsB;
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
  }*/
}

/*void load_data()
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
*/
