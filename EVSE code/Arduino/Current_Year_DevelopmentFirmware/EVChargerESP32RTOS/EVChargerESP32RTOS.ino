/* ESP32 based EVSE electric vehicle supply equipment charge controller
Original Development Project Team: Circuit Banditos (Andy Begey, Luis Contreras, Shermaine Dayot, Brandon Metcalf): Major Post Project Revisions by: Luis Contreras 
Version 1.0: 5/31/2018
2nd Development Project Team: SMARTION (Omair Farooqui, Krishan Solanki, Alex Ramirez, Emon Sahaba)
Version 1.1: 2/15/2019
Copyright: 
Reagents of Univesity of California, Irvine
Released into public domain
*/
//Button functions
// in between the first button press after 10 seconds.
// 1-4: Toggles load on/off
// 5: Resets EEPROM
// 6-8: Changes current 6A, 10A, 20A
// 9-10: Posts test to MQTT broker
// 11-12: Calls AP Mode
// 13+: Resets ESP32

//Program Libraries
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
//RTOS Libraries
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"


//******************************Configuration Options******************************************************

//DEBUG Options
//Canned WIFI Parameters
// UCIWIFI & CALIT2TESTWIFI - no longer needed
//#define CALIT2TESTWIFI
//#define UCIWIFI

// debug statements are outputted on the serial monitor
// DEBUG - general debug statements
// PILOT - ADC values are printed

#define DEBUG
#define PILOT


//************************************Global Variables and Structures**************************************

//Semiphore controls for Multiple Tasks
bool clientconnectionactive = false; //Is the MQTT client connected, if so, activate this variable, start initialized as false
bool WiFiconnectionactive = false;


// ADE7953 SPI functions 
#define local_SPI_freq 1000000  //Set SPI_Freq at 1MHz (FYI: #define, (no = or ;) helps to save memory - replacement happens at compile-time!)
#define local_SS 14  //Set the SS pin for SPI communication as pin 5  (#define, (no = or ;) helps to save memory)
ADE7953 myADE7953(local_SS, local_SPI_freq);

// MQTT Broker Connection Settings
const char * mqtt_server = "m10.cloudmqtt.com";
int mqttPort = 17934;
const char * mqttUser = "dkpljrty";
const char * mqttPassword = "ZJDsxMVKRjoR";


/* Connection parameters */
#ifdef UCIWIFI
const char * networkName = "UCInet Mobile Access";
const char * networkPswd = "";
#endif

#ifdef CALIT2TESTWIFI
const char * networkName = "CalPlugSimHome";
const char * networkPswd = "A8E61C58F8";
#endif


//**************************************************
// Calibration values
#define m_v1 0.0000559380239087644 // gain voltage channel 1...prev .818
#define b_v1 -62.88006101 // offset voltage channel 1 previously -2.32. testing with new valuse to bypass fault...prev -32
  
#define m_v2 0.0000578332580889683 // gain voltage channel 2...prev 1.24
#define b_v2 -63.90359892 // offset voltage channel 2 previously -51.8. testing with new valuse to bypass fault...prev -90

#define v1_threshmax 130.0 // maximum allowed voltage before fault for active phase line compared to ground
#define v1_threshmin 110.0 // minimum allowed voltage before fault for active phase line compared to ground

#define v2_threshmax 130.0 // maximum allowed voltage before fault for active phase line compared to ground
#define v2_threshmin 110.0 // minimum allowed voltage before fault for active phase line compared to ground

#define v1_neutralmin -5.0 // maximum allowed voltage before fault for neutral line compared to ground
#define v1_neutralmax 10.0 // minimum allowed voltage before fault for neutral line compared to ground

#define v2_neutralmin -5.0 // maximum allowed voltage before fault for neutral line compared to ground
#define v2_neutralmax 10.0 // minimum allowed voltage before fault for neutral line compared to ground

#define m_irmsA 0.00000175811759528647 // gain current channel 1...prev 907
#define b_irmsA -0.002937872 // offset current channel 1...prev 603

#define m_irmsB 0.0000093475476482166 // gain current channel 2...prev 1391
#define b_irmsB -0.011603168 // offset current channel 2...prev 119
// NOTE: GFI threshold set in EEPROM, but current A and B used to determine GFI leakage current

#define m_instactivepower 0.0 // gain instant active power 
#define b_instactivepower 0.0 // offset instant active power

// pilot static thresholds
int ADC_A = 2350; //5925; // ADC value when not plugged and not charging (center point)
int ADC_Athreshold = 150; //150; // ADC threshold when not plugged and not charging (variance threshold) Plus and minus

int ADC_B = 2176; //5242; // ADC value when plugged and not charging (center point)
int ADC_Bthreshold = 400; //150; // ADC threshold value when plugged and not charging (variance threshold)Plus and minus

int ADC_C = 1414; //3480; // ADC value when plugged and charging (center point)
int ADC_Cthreshold = 1300; // ADC threshold value when plugged and charging (variance threshold)Plus and minus

int ADC_E = 10; // State E - Error with the pilot grounded
int ADC_Ethreshold = 10; // (variance threshold) Plus and minus

//State D does not exist for LiPo batteries that are charged without venting

int ADC_F = 10; // State F - Error with the pilot Low set at -12V constant, this is an unknown/error condition
int ADC_Fthreshold = 10; // \(variance threshold) Plus and minus
//**************************************************
//Non-Linear Threshold functions - values regressed from ADC measurements for known states and threshold points
//defined from 3A to 35A
double StateAThresholdLookupBase = 7.7303; 
double StateAThresholdLookupInter = 2367.7; 

double StateBThresholdLookupBase = 17.409; 
double StateBThresholdLookupInter=2120.1;
//double StateBThresholdLookupInter = 2120.1;  

double StateCThresholdLookupBase = 3.3321; //1966.7;
double StateCThresholdLookupInter  = 1401.8; //-0.99;

double ThresholdLookupThresholdBase = 20.021;
double ThresholdLookupLookupInter  = -0.451;


//**************************************************

static bool lock = 0; //SEMAPHORE VARIABLE

// parameters for Default Access Point mode
const byte DNS_PORT = 53;
IPAddress apIP(192, 168, 10, 10); // default IP for AP mode
DNSServer dnsServer;
WiFiServer server(80);

// temporary char buffers for SSID and MQTT parameters
char linebuf[150];
int charcount=0;
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

// HTML output on AP mode, canned HTML statements
String internetsetup = ""
  "<form>"
    "<fieldset>"
      "<label for=\"SSID\">SSID</label>"
      "<input type=\"text\" name=\"SSID\" id=\"SSID\"><br>"
      "<label for=\"PSSW\">Password:</label>"
      "<input type=\"text\" name=\"PSSW\" id=\"PSSW\"><br>"
      "<label for=\"MQTTServe\">MQTT Server:</label>"
      "<input type=\"text\" name=\"MQTTServe\" id=\"MQTTServe\" value=\"m10.cloudmqtt.com\"><br>"
      "<label for=\"PORT\">MQTT Port:</label>"
      "<input type=\"text\" name=\"PORT\" id=\"PORT\" value=\"17934\"><br>"
      "<label for=\"USRNM\">MQTT User Name:</label>"
      "<input type=\"text\" name=\"USRNM\" id=\"USRNM\" value=\"dkpljrty\"><br>"
      "<label for=\"MQTTPSSW\">MQTT Password:</label>"
      "<input type=\"text\" name=\"MQTTPSSW\" id=\"MQTTPSSW\" value=\"ZJDsxMVKRjoR\"><br>"
      "<input type=\"Submit\" value=\"Submit\">"
    "</fieldset>"
  "</form>";

String responseHTML = ""
  "<!DOCTYPE html>"
  "<html><head><title>CalPlug EVSE Setup</title><style>body {background-color:#90c132; font-family:sans-serif; text-align:center;} #content{ background-color:white; display:inline-block; padding:1em;} form{text-align:left;} input{width:100%;margin-bottom: 0.5rem;}</style></head>"
  "<body><div id='content'><h1>CalPlug EVSE</h1><h3>Smart Charger portal<h3>"
  "<hr/><p>Please enter your Wi-Fi and MQTT credentials here.</p>"+internetsetup+"</div></body></html>";

String submitHTML = ""
  "<!DOCTYPE html>"
  "<html><head><title>CalPlug EVSE Setup</title><style>body {background-color:#90c132; font-family:sans-serif; text-align:center;} #content{ background-color:white; display:inline-block; padding:1em;}</style></head>"
  "<body><div id='content'><h1>CalPlug EVSE</h1><h3>Smart Charger portal<h3>"
  "<hr/><p>Credentials saved successfully! Access point will now disconnect.</p></div></body></html>";


// variables for the button interface
bool buttonIsPressed = false;
int numPressed = 0;
bool timeStarted;
bool ButtonPressAction = false;
bool ButtonPressTimerAction = false;
unsigned long  lastDebounceTime = 0;
unsigned long debounceDelay = 300;

// timer variables to keep track of the passage of time
time_t t;  // button presses are tracked for 5 seconds
time_t Wt; // wattmeter checks every 10 seconds
time_t Rp; // pilot averages readings every 1/10 second
time_t wifitime; // disconnected esp32 module reconnects every 10 minutes
time_t gfifailure; // tests the GFI interface
time_t mqtttime; // Call client.loop every 5 seconds


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


WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;
QueueHandle_t mqttQueue;
typedef struct MqttMessage{
  const char* topic;
  const char* payload;
  MqttMessage() : topic(""), payload("") {}
  MqttMessage(const char* sTopic, const char* sPayload) : topic(sTopic), payload(sPayload) {}
} MqttMessage;


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

ChargeState charge;  // main struct to hold important variables

// parmeters used for PWM output to the LED 
// freq determines how often the PWM cycles
// resolution determines how accurate the PWM signal outputs
int freq = 1;
int resolution = 10; // for LED PWM
int pilotresolution = 13; // for Pilot PWM, be careful range is modified. Changing this value will not propogate everything required. Must update both intermediate value range AND mapping
int relayEnable = 0;
int pilotfreq = 1000;

// variables to keep track of the data line on ADC
int average = 0;
int counter = 0;
const int pilotout = 25;

float requestedCurrentinAMPS=40.0;

// global variable to track that the Wi-Fi module has disconnected
bool reconnected;

// GFI variables
int GFIthreshold;


//************************************Program Functions************************************************
int newmap(void) {
  #ifdef DEBUG
  Serial.print("Intended pilot duty cycle: ");
  Serial.println((float)charge.chargerate / 2000.0);
  #endif
  return map(charge.chargerate, 0, 2000, 0, ((int)(pow(2.0, (double)pilotresolution)) - 1));
}

float pwmDutyCycleLookup(float requestedCurrent) { //Map requested current (in Amps) to duty cucle in decimal percent using the J1772 standard, top off at 80A, anything above this is returned to the PWM value for 80A.
  float calculatedPWMValue = 0;
  #ifdef DEBUG
  Serial.println("J1772 Current Lookup Function Called");
  Serial.print("Input Requested Current: ");
  Serial.println(requestedCurrent);
  #endif
  if (requestedCurrent==0)
  {
    #ifdef DEBUG
    Serial.print("Requested value 0 or lower than 0 A, defaulting to 0% Duty Cycle ");
    #endif
    calculatedPWMValue = 0; //this is an invalid request that is remained zero'ed out
  }
  else if (requestedCurrent<51) //first regression before discontinuity
  {
    calculatedPWMValue = (requestedCurrent*0.0166)+0.0009;
  }
  else if (requestedCurrent>51) //second regression after discontinuity
  {
    calculatedPWMValue = (requestedCurrent*0.004)+0.64; 
  }
  else if (requestedCurrent>80)  //case above 80A requested, invalid for J1772
  {
    #ifdef DEBUG
    Serial.print("Requested Value greater than 80A, defaulting to 80A");
    #endif
    requestedCurrent = 80;
    calculatedPWMValue = (requestedCurrent*0.004)+0.64; 
  }
  #ifdef DEBUG
  Serial.print("Corresponding Pilot duty cycle: ");
  Serial.println(calculatedPWMValue);
  #endif
  return calculatedPWMValue;
}


void dummyAPmode(void) {
  // AP mode inconsistent on the first attempt
// however it works fine on other attempts
// this calls AP mode once and exits immediately
  
  ledcWrite(1, 500);
  ledcWrite(2, 500);
  ledcWrite(3, 500);  
  APsetupdummy();
}

// dummy AP mode that is called. 
// Only lasts for 5 seconds before calling the real AP mode function
void APsetupdummy(void) {
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0));
  WiFi.softAP("EVSESetup920644"); //AP should be EVSESETUP and the last 4 elements of the MAC address of the WiFi in infrastructure mode
  #ifdef DEBUG
  Serial.println("AP mode initialized!(dummy run)");
  #endif
  dnsServer.start(DNS_PORT, "*", apIP);  
  server.begin();
  bool clientcomplete = false;
  time_t servertimedout;
  servertimedout = time(NULL);
  while(!clientcomplete) {
    dnsServer.processNextRequest();
    WiFiClient client = server.available();   // listen for incoming clients
    if(difftime(time(NULL), servertimedout) >= 5.0)
      clientcomplete = true;
    if (client) {
      Serial.println("New client");
      memset(linebuf,0,sizeof(linebuf));
      charcount=0;
      String currentLine = "";
      boolean currentLineIsBlank = true;
      while (client.connected()) {
        if (client.available()) {
          char c = client.read();
          Serial.write(c);
          linebuf[charcount]=c;
          if(charcount<sizeof(linebuf)-1) charcount++;
          if(c == '\n' && currentLineIsBlank) {
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println();
            client.print(responseHTML);
            client.println(internetsetup);
            break;
          }
          if (c == '\n') {
            currentLineIsBlank = true;
            if(strstr(linebuf, "GET /?") > 0){
              Serial.println("Submit pressed!");
              Serial.println("------------------");
              Serial.println(linebuf);
              Serial.println("------------------");
              SaveCredentials();
              clientcomplete = true;
            }
            currentLineIsBlank = true;
            memset(linebuf, 0, sizeof(linebuf));
            charcount = 0;                   
          } 
          else if (c != '\r') {
            currentLineIsBlank = false;
          }
        }
      }
      delay(1);    
      client.stop();
      Serial.println("Client disconnected!");
    }
  }
  server.stop();
  server.close();
  server.end();
}

// This function sets up the DNS server on the ESP32
// Calls the HTML string setup up during the beginning of the program
// waits for 5 minutes for the client to set up
// can be initiated by pressing the button 11-13 times
void APsetup(void) {
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0));
  WiFi.softAP("EVSESetup9B25B2");
  #ifdef DEBUG
  Serial.println("AP mode initialized!(Normal AP Network Setup Mode)");
  #endif
  dnsServer.start(DNS_PORT, "*", apIP);  
  server.begin();
  bool clientcomplete = false;
  time_t servertimedout;
  servertimedout = time(NULL);
  while(!clientcomplete) {
    dnsServer.processNextRequest();
    WiFiClient client = server.available();   // listen for incoming clients
    if(difftime(time(NULL), servertimedout) >= 300.0)
      clientcomplete = true;
    if (client) {
      Serial.println("New client");
      memset(linebuf,0,sizeof(linebuf));
      charcount=0;
      String currentLine = "";
      boolean currentLineIsBlank = true;
      while (client.connected()) {
        if (client.available()) {
          char c = client.read();
          Serial.write(c);
          linebuf[charcount]=c;
          if(charcount<sizeof(linebuf)-1) charcount++;
          if (c == '\n') {
            // currentLineIsBlank = true;
            if(!currentLineIsBlank && strstr(linebuf, "GET /?") > 0){
              Serial.println("Submit pressed!");
              Serial.println("------------------");
              Serial.println(linebuf);
              Serial.println("------------------");
              SaveCredentials();
              client.println("HTTP/1.1 200 OK");
              client.println("Content-type:text/html");
              client.println();
              client.println(submitHTML);
              clientcomplete = true;
              break;
            } else if (currentLineIsBlank){
              client.println("HTTP/1.1 200 OK");
              client.println("Content-type:text/html");
              client.println();
              client.println(responseHTML);
              break;
            }
            currentLineIsBlank = true;
            memset(linebuf, 0, sizeof(linebuf));
            charcount = 0;                   
          } 
          else if (c != '\r') {
            currentLineIsBlank = false;
          }
        }
      }
      delay(1);    
      client.stop();
      Serial.println("Client disconnected!");
    }
  }
  server.stop();
  server.close();
  server.end();
}

// APmode sets up the parameters to initiate AP 
// Disconnects from current WiFi connection and Broker
// Turns off relays for safety
void APmode(void) {
  client.disconnect();
  WiFi.disconnect();
  digitalWrite(relayenable, LOW);
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);
  delay(100);
  digitalWrite(relayenable, HIGH);
  APsetup();
  load_data();  
}

// Helper function that converts HTML keys to special characters. 
// This is needed since special keys are sent over during AP mode 
// to initialize Wi-Fi and MQTT
char checkchar(char a, char b) {  
  if(a == '2') {
    if(b == '5') {
      return '%';
    } else if(b == '1') {
      return '!';
    } else if(b == '3') {
      return '#';
    } else if(b == '4') {
      return '$';
    } else if(b == '6') {
      return '&';
    } else if(b == '7') {
      return '\'';
    } else if(b == '8') {
      return '(';
    } else if(b == '9') {
      return ')';
    } else if(b == 'A') {
      return '*';
    } else if(b == 'B') {
      return '+';
    } else if(b == 'C') {
      return ',';
    } else if(b == 'F') {
      return '/';
    } else if(b == '0') {
      return '_';
    } else if(b == '2') {
      return '"';
    } else if(b == 'D') {
      return '-';
    } else if(b == 'E') {
      return '.';
    }
  } else if(a == '3') {
      if(b == 'A') 
        return ':';
      else if(b == 'B') 
        return ';';
      else if(b == 'D') 
        return '=';
      else if(b == 'F') 
        return '?';
      else if(b == 'C') 
        return '<';
      else if(b == 'E') 
        return '>';
  } else if(a == '4') {
      if(b == '0') 
        return '@';
  } else if(a == '5') {
      if(b == 'B') 
        return '[';
      else if(b == 'D') 
        return ']';
      else if(b == 'C') 
        return '\\';
      else if(b == 'E') 
        return '^';
      else if(b == 'F') 
        return '_';            
  } else if(a == '6' && b == '0') {
    return '`'; 
  } else if(b == '7') {
      if(b == 'B') 
        return '{';
      else if(b == 'C') 
        return '|';
      else if(b == 'D') 
        return '}';
      else if(b == 'E') 
        return '~';
  }
  return ' ';
}

// This function reads the string as provided by the user through APmode
// and parses the information for storage on the EEPROM
// The function size can be optimized and decreased if needed
void SaveCredentials(void) {
  char *p1;
  char *p2;
  char *p3;
  char *p4;
  char *p5;
  char *p6;
  p1 = strstr(linebuf, "SSID=");
  p2 = strstr(linebuf, "PSSW=");
  p3 = strstr(linebuf, "MQTTServe=");
  p4 = strstr(linebuf, "PORT=");
  p5 = strstr(linebuf, "USRNM=");
  p6 = strstr(linebuf, "MQTTPSSW=");
  char buff[150];  
  strcpy(buff, p1);  
  unsigned int stringsize = (unsigned)strlen(linebuf);

  // these buffers need to be cleared before saving to them otherwise you'll combine strings
  // that were previously there
  memset(&ssideeprom[0], 0, sizeof(ssideeprom));
  memset(&pwdeeprom[0], 0, sizeof(pwdeeprom));
  memset(&mqtt_servereeprom[0], 0, sizeof(mqtt_servereeprom));
  memset(&mqtt_porteeprom[0], 0, sizeof(mqtt_porteeprom));
  memset(&mqtt_usereeprom[0], 0, sizeof(mqtt_usereeprom));
  memset(&mqtt_pwdeeprom[0], 0, sizeof(mqtt_pwdeeprom));
  int place = 0;

  for(int i = 5; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      ssideeprom[place++] = ' ';
      continue;
    } else if(buff[i] == '%') {
      char x = checkchar(buff[i+1], buff[i+2]);      
      ssideeprom[place++] = x;  
      i = i + 2;          
      continue;
    }
    ssideeprom[place++] = buff[i];
  }
  strcpy(buff, p2);  
  place = 0;
  for(int i = 5; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      pwdeeprom[place++] = ' ';
      continue;
    } else if(buff[i] == '%') {
      char x = checkchar(buff[i+1], buff[i+2]);
      pwdeeprom[place++] = x;
      i = i + 2;     
      continue;
    }
    pwdeeprom[place++] = buff[i];
  }
  place = 0;
  strcpy(buff, p3);  
  for(int i = 10; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      mqtt_servereeprom[place++] = ' ';
      continue;
    } else if(buff[i] == '%') {
      char x = checkchar(buff[i+1], buff[i+2]);
      mqtt_servereeprom[place++] = x;
      i = i + 2; 
      continue;
    }
    mqtt_servereeprom[place++] = buff[i];
  }
  place = 0;
  strcpy(buff, p4);  
  for(int i = 5; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      mqtt_porteeprom[place++] = ' ';
      continue;
    } else if(buff[i] == '%') {
      char x = checkchar(buff[i+1], buff[i+2]);
      mqtt_porteeprom[place++] = x;
      i = i + 2;     
      continue;
    }
    mqtt_porteeprom[place++] = buff[i];
  }
  place = 0;
  strcpy(buff, p5);  
  for(int i = 6; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      mqtt_usereeprom[place++] = ' ';
      continue;
    } else if(buff[i] == '%') {
      char x = checkchar(buff[i+1], buff[i+2]);
      mqtt_usereeprom[place++] = x;
      i = i + 2;
      continue;
    }
    mqtt_usereeprom[place++] = buff[i];
  }
  place = 0;
  delay(100);
  strcpy(buff, p6);  
  for(int i = 9; buff[i] != ' '; i++) {
    if(buff[i] == '+') {
      mqtt_pwdeeprom[place++] = ' ';
      continue;
    } else if(buff[i] == '%') {
      char x = checkchar(buff[i+1], buff[i+2]);
      mqtt_pwdeeprom[place++] = x;
      i = i + 2;      
      continue;
    }
    mqtt_pwdeeprom[place++] = buff[i];
  }

  #ifdef DEBUG
  Serial.println(ssideeprom);
  Serial.println(pwdeeprom);
  Serial.println(mqtt_servereeprom);
  Serial.println(mqtt_porteeprom);
  Serial.println(mqtt_usereeprom);
  Serial.println(mqtt_pwdeeprom);
  #endif  
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
  char dummy[150] = "0#ssid#pw123456789#m10.cloudmqtt.com#19355#dqgzckqa#YKyAdXHO9WQw#800#20#20#";
  save_data(dummy);
  save_data(data);
}

// Function sets up the wifi using the settings stored in EEPROM
// Also connects to MQTT broker using those parameters
// Disconnects from setup if the connection fails
// WHEN CALLED, IT MAY CAUSE A TASK WATCHDOG ISSUE FOR a_task AND b_task
void Wifisetup(void) {
  WiFi.mode(WIFI_STA);
  if(connectToWiFi(ssideeprom, pwdeeprom)) {
    client.setServer(mqtt_servereeprom, atoi(mqtt_porteeprom));
    client.setCallback(callback);
    int timeout = 0;
    while(!client.connected()) {
      #ifdef DEBUG
      Serial.println("Connecting to MQTT...");
      #endif
      if(client.connect("ESP32Client", mqtt_usereeprom, mqtt_pwdeeprom)){
        #ifdef DEBUG
        Serial.println("Connected");
        #endif
        mqtttime = time(NULL);
        topicsSubscription();
      } else {
        #ifdef DEBUG
        Serial.print("Connection failed with state ");
        #endif
        Serial.println(client.state());
        delay(2000);
        if(timeout > 5) {
          #ifdef DEBUG
          Serial.println("MQTT connection failed.");
          #endif
          client.disconnect();
          WiFi.disconnect();
          // WiFi.mode(WIFI_AP);
          return;
        }
        timeout++;
        
      }
    }
  }
}

// Add MQTT topics to connect to 
void topicsSubscription(void) {
  Serial.println("MQTT Topics Subscription");
  client.publish("esp/test", "Hello from ESP32!");
  client.subscribe("esp/test");
  client.subscribe("test1");
  client.subscribe("switchmux");
  client.subscribe("devicename");

  // Energy monitoring topics
  client.subscribe("in/devices/240AC4110540/1/OnOff/OnOff");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/CurrentSummation/Delivered");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/InstantaneousDemand");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/RmsCurrent");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/Voltage");
  client.subscribe("in/devices/");

  //load control
  client.subscribe("in/devices/240AC4110540/1/OnOff/Toggle");
  client.subscribe("in/devices/240AC4110540/1/OnOff/On");
  client.subscribe("in/devices/240AC4110540/1/OnOff/Off");

  //factory reset
  client.subscribe("in/devices/240AC4110540/0/cdo/reset");
  client.subscribe("Reconnect");
  // Mike functions

  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/GroundLeakage");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/SaveLevel1Charge");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/SaveLevel2Charge");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/UpdateGroundThreshold");
  
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/GROUNDOK");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/GFIState");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/SUPLevel");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/LVoltage");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/RequestCurrent");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/DeliveredCurrent");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/ChargeState");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/INSTCurrent");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge");
  client.subscribe("in/devices/240AC4110540/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal");

  //Send Ping
  enqueueMessage("out/devices/240AC4110540/1/Notification/Ping", "1");
}

// GFI safety check. Fails if the instant current between channels A and B are over
// a certain threshold
void GFItestinterrupt(void) 
{
  unsigned long interval=1000; // the time we need to wait
  unsigned long previousMillis=0; // millis() returns an unsigned long
  unsigned long currentMillis = millis();
  float IrmsAraw, IrmsBraw, IrmsAcal, IrmsBcal;
  
  IrmsAraw = myADE7953.getIrmsA();
  IrmsBraw = myADE7953.getIrmsB();
  IrmsAcal = (IrmsAraw*m_irmsA)+b_irmsA;
  IrmsBcal = (IrmsBraw*m_irmsB)+b_irmsB;
  
 
  
  if(abs(IrmsAcal - IrmsBcal) <= GFIthreshold) {
    charge.GFIfail = false;
    #ifdef DEBUG
    //Serial.print("GFI leakage current (IrmsA - IrmsB): "); 
    //Serial.println(IrmsAcal - IrmsBcal);  
    //Serial.println("GFI passed test");
    #endif
  } else {
    #ifdef DEBUG
    Serial.println("GFI failed test");
    #endif
    charge.GFIfail = true;
    Serial.println("Turn relays off due to GFI test fail.");
    digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid  
    digitalWrite(relay1, LOW);
    digitalWrite(relay2, LOW);  
    delay(1000);
    //if ((unsigned long)(currentMillis - previousMillis) >= interval)
    //{
      digitalWrite(relayenable, HIGH); //when high, relay multiplexer disabled
      //previousMillis = millis();
    //}
  }
}

// Reset function. Hard resets the ESP32 when called
void(* resetFunc)(void) = 0;

// Wi-Fi scan function 
// call to scan Wi-Fi signals near the device
void wifiscan(void) {
  delay(100);
  Serial.println("Wi-Fi setup complete!");
  Serial.println("Starting scan");
  int n = WiFi.scanNetworks();
    Serial.println("scan done");
    if (n == 0) {
        Serial.println("no networks found");
    } else {
        Serial.print(n);
        Serial.println(" networks found");
        for (int i = 0; i < n; ++i) {
            // Print SSID and RSSI for each network found
            Serial.print(i + 1);
            Serial.print(": ");
            Serial.print(WiFi.SSID(i));
            Serial.print(" (");
            Serial.print(WiFi.RSSI(i));
            Serial.print(")");
            Serial.println((WiFi.encryptionType(i) == WIFI_AUTH_OPEN)?" ":"*");
            delay(10);
        }
    }
    Serial.println("");
}

// Function checks how many button presses have occurred and performs actions
void buttonCheck(void) {
  if(timeStarted == true && (difftime(time(NULL), t) >= 10.0)) {
    #ifdef DEBUG
    Serial.println("10 seconds have passed since initial button push.");
    Serial.print("The button was pressed ");
    Serial.println(numPressed);
    #endif
    if(numPressed >= 1 && numPressed < 5){
      // toggle load on/off
      #ifdef DEBUG
      Serial.println("Button was pressed 1-6 times");
      Serial.print("Device will toggle load to: ");
      #endif
      charge.statechange = true;
      if(charge.load_on) {
        charge.load_on = false;        
        #ifdef DEBUG
        Serial.println("Off");        
        #endif
      } else {
        charge.load_on = true;        
        #ifdef DEBUG
        Serial.println("On");        
        #endif
      }      
    }    
    else if (numPressed == 5) {
      EEPROMReset();
    }
    else if (numPressed == 6) {
      charge.chargerate = 17;
      requestedCurrentinAMPS=10;
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("The load has been changed to 10A");
      #endif
    }
    else if (numPressed == 7) {
      charge.chargerate = 33;
      requestedCurrentinAMPS=20;
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("The load has been changed to 20A");
      #endif
    }
    else if (numPressed == 8) {
      charge.chargerate = 66;
      requestedCurrentinAMPS=40;
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("The load has been changed to 40A");
      #endif
    }
    else if (numPressed >= 9 && numPressed < 11) {
      // request OTA update
      client.publish("out/devices/1/SimpleMeteringServer/MQTTtest", "I am on");
    }
    else if (numPressed >= 11 && numPressed < 13) {
      // soft reset
      dummyAPmode();
      APmode();
      resetFunc();
    }
    else if(numPressed >= 13) {
      // hard reset
      resetFunc();
    }
    else {
      #ifdef DEBUG
      Serial.println("Invalid number entered somehow... Disregarding...");
      #endif
    }
    numPressed = 0;
    #ifdef DEBUG 
    Serial.print("Resetting...");
    #endif
    timeStarted = false;
  }
  if(buttonIsPressed) {
    if((millis() - lastDebounceTime) > debounceDelay) {
      buttonIsPressed = false;
    }
  }
}

int ADCmedianValueRead(void) {
// helper function for read pilot
// is supposed to help obtain consistent values from ADC
// This uses a non-linear median function to remove extraneous values
  int a, b, c, middle;
  a = adc1_get_raw(ADC1_CHANNEL_3);
  //delayMicroseconds(1); // Must be within the minimum period to pass median filter
  b = adc1_get_raw(ADC1_CHANNEL_3);
  //delayMicroseconds(1); // Must be within the minimum period to pass median filter
  c = adc1_get_raw(ADC1_CHANNEL_3);
   /*Serial.println("adc raws for a b c");
   Serial.println(a);
   Serial.println(b);
   Serial.println(c);*/
  if ((a <= b) && (a <= c)) {
    middle = (b <= c) ? b : c;
  } else if ((b <= a) && (b <= c)) {
    middle = (a <= c) ? a : c;
  } else {
    middle = (a <= b) ? a : b;
  }
  return middle;
}

int ThresholdedADCmedianValueRead(int threshold) { //median filter that operates when 3 values are present, otherwise a selection is made aand a single value returned
// helper function for read pilot
// is supposed to help obtain consistent values from ADC
// This uses a non-linear median function to remove extraneous values
  int a, b, c, middle; //holders for the reads and the computed median (if needed)
  int avalid = 0; //integer used because they are added later w/o need for typecasting - initialized as 0
  int bvalid = 0;  //integer used because they are added later w/o need for typecasting - initialized as 0
  int cvalid = 0;  //integer used because they are added later w/o need for typecasting - initialized as 0
  
  //Three successive reads of the ADC
  a = adc1_get_raw(ADC1_CHANNEL_3);
  b = adc1_get_raw(ADC1_CHANNEL_3);
  c = adc1_get_raw(ADC1_CHANNEL_3);
  
  //Now determine the case for the read values, how many and which ones are above the lower noise threshold
	if (a>threshold){  //check to see validity of each value against threshold
		avalid = 1;
	}
	if (b>threshold){  //check to see validity of each value against threshold
		bvalid = 1;
	}
	if (c>threshold){  //check to see validity of each value against threshold
		cvalid = 1;
	}
  
   if ((avalid+bvalid+cvalid)==0) // case where none are greater than the threshold, return 0
  {
	  return 0; //no valid reading, return 0
  }
  
  if ((avalid+bvalid+cvalid)==3) // case where all three are greater than the threshold, take and return the median value
  {
	  if ((a <= b) && (a <= c)) {
		middle = (b <= c) ? b : c;
	  } else if ((b <= a) && (b <= c)) {
		middle = (a <= c) ? a : c;
	  } else {
		middle = (a <= b) ? a : b;
	  }
	  return middle; //should return at this point and not continue in the outer If statement
  }
  else if ((avalid+bvalid+cvalid)==1) // case where one is greater than the threshold, take and return the only valid number, check each for validity, one must be valid based on intial check
  {
	if (avalid == 1)
	{
		return a;	
	}	
	else if (bvalid == 1)
	{
		return b;
	}	
	else if (cvalid == 1)
	{
		return c;	
	}	
	else
	{} //default case that never should be entered because one value is OK
  }
  
  else if ((avalid+bvalid+cvalid)==2) // case where one is greater than the threshold, take and return the only valid number, check each for validity, one must be valid based on initial check
  {
	if (avalid == 1 && bvalid == 1)
	{
		return a; //returns either the first value or the one furthest away from the threshold fail
		//return (a+b/2); //The alternative is a quick integer division to average the valid readings
	}	
	else if (bvalid == 1 && cvalid == 1)
	{
		return b;  //returns either the first value or the one furthest away from the threshold fail
		//return (b+c/2); //The alternative is a quick integer division to average the valid readings
	}	
	else if (avalid == 1 && cvalid == 1)
	{
		return a;	//returns either the first value or the one furthest away from the threshold fail
		//return (a+c/2); //Likely not a good approach for averaging two sides of a discontinuity - he alternative is a quick integer division to average the valid readings
	}	
	else
	{} //default case that never should be entered because one value is OK
  }
  else
  {
	  return 0;  //default case that should never be entered
  }
}

void readPilot(void) {

// Reads ADC coming the pilot signal on the J1772
// This sets the state on the charger automatically in order to 
// turn off loads, or to determine if the charger is connected to the car
// So far only works for 5 - 40Amps
  int lowernoisethreshold = 10;
  int maxvalidreads = 25000;
  int maxcounts = 2000;
  int reqcurrentA = 0; //define the current value in A holder var
   //Lookup threshold ranges using a non-linear lookup table approach with the requested current value to lookup the threshold based on current.
  
  float ADC_A_nonlinear = StateAThresholdLookupBase*log(requestedCurrentinAMPS) + StateAThresholdLookupInter;//StateAThresholdLookupBase*pow(reqcurrentA,StateAThresholdLookupInter);
  float ADC_B_nonlinear = StateBThresholdLookupBase*log(requestedCurrentinAMPS) + StateBThresholdLookupInter;//StateBThresholdLookupBase*pow(reqcurrentA,StateBThresholdLookupInter);
   float ADC_C_nonlinear = StateCThresholdLookupBase*log(requestedCurrentinAMPS) + StateCThresholdLookupInter;//StateCThresholdLookupBase*pow(reqcurrentA,StateCThresholdLookupInter);
  #ifdef DEBUG
  Serial.println("Read Pilot Function Called");
  #endif
  if(1 ){ // this checks the average of pilot every 1/10 of second
    int high = 0;
    int count = 0;
    int success_count=0;
     if (requestedCurrentinAMPS<=0.99){
       Serial.print("WARNING REQUESTD CURRENT UNDER SPEC OF 1A, MIGHT RESULT IN IRREGULAR STATE CHANGE ");  

     }
            
    for(int i = 0; i < 25000; i++) { // sample regularly across periodic pilot signal -- absolute maximum number of loop runs, high number for low duty cycle to make sure pilot read occurs
     if (requestedCurrentinAMPS>=0.9){ //if greater than 1 AMP use median filter
        high = adc1_get_raw(ADC1_CHANNEL_3);//non-median filter single read.

     }
     if (requestedCurrentinAMPS>3.5){// if less
        high = ADCmedianValueRead(); //ThresholdedADCmedianValueRead(lowernoisethreshold);
       
        
      }
     if (requestedCurrentinAMPS<=3.5){// if less than 3.5 amps use non-median filter single read to get read at generation.
      high = adc1_get_raw(ADC1_CHANNEL_3);//non-median filter single read.
     }
      
      
      if(high <= lowernoisethreshold) { // if reading is at the bottom of the square wave of the pilot throw this out.Assume anything below 0 is the bottom of the square wave.
        success_count++;
        
        continue;
      }
      count++;
      average += high; // this is a running total until the averaging function is run      
      if(count >= 10000) 
        break; // limit total number of reads if pilot read is good, generally okay for high duty cycles
       

    } 

    if(count == 0) // avoids divide by zero if no readings are taken
      count++;
      
    average /= count; // running total based on total counted reads comprising the running sum. read multiple times to produce average to get stable pilot reading            
    
  
    delay(1000);
    Serial.print(count);    
    Serial.print(" points averaged yielding average with modification: ");    
    Serial.println(average);
    //delay(1000);
    // 10% duty 
    // A - 1192 - 1211 
    // B - 1068
    // C - 694 
    // 33%
    // A - 1187-1207 
    // B - 1055 - 1077
    // C - 687 - 705
    // 67%
    // A - 1174 - 1209 
    // B - 1061 - 1070
    // C - 694 - 707
    
   
//    Serial.print("ADC_A_nonlinear: ");    
//    Serial.println(ADC_A_nonlinear);
//    Serial.print("ADC_A: ");    
//    Serial.println(ADC_A);
//    Serial.println("--------------------------- ");    
//    Serial.print("ADC_B_nonlinear: ");    
//    Serial.println(ADC_B_nonlinear);
//    Serial.print("ADC_B: ");    
//    Serial.println(ADC_A);
//     Serial.println("--------------------------- ");  
//    Serial.print("ADC_C_nonlinear: ");    
//    Serial.println(ADC_C_nonlinear);
//    Serial.print("ADC_C: ");    
//    Serial.println(ADC_C);
  

    //Determine the state based on the response based on fixed thresholds, this is tricky in some cases without consistant sampling for small values, conisder implementing a lookup table
    if(average >= (ADC_A-ADC_Athreshold)) { // state not plugged in not charging
      if(average<=ADC_A_nonlinear){
        if(average>=ADC_B) { // state not plugged in not charging
          if(charge.state != 'A'){
            charge.state = 'A';
            charge.statechange = true;
            charge.diodecheck = false;
            Serial.println(" STATE A "); 
                //delay(1000);
          }
        }
      }
    }

    // TODO Go from state A to B or C. It is currently not happening!!!!
    else if(average>=(ADC_C+ADC_Bthreshold)){
//    if(average <= ADC_B) { // state plugged in not charging
         if(average<=ADC_B_nonlinear){
//            if(average>=(ADC_C+ADC_Bthreshold)){ // state plugged in not charging
//            if(average<=ADC_B){
              if(charge.state != 'B') { 
                
                if (charge.state == 'C') {
                  Serial.println("C -> B");
                }
                charge.state = 'B';
                charge.statechange = true;
                charge.diodecheck = false;
                Serial.println(" STATE B ");
              }
//            }
         } 
    } 
    else if(average >= (ADC_E+ADC_Ethreshold)) { // state plugged in charging
       if((ADC_C + ADC_Ethreshold)>=average && average<=ADC_C_nonlinear+ADC_Ethreshold){
            if(charge.state != 'C'){
              if (charge.state == 'B') 
              {
                Serial.println("B -> C");
              }
              charge.state = 'C';
              charge.statechange = true;
              charge.diodecheck = false;
              Serial.println(" STATE C "); 
            }
      }
    }
    else{
      if(charge.state != 'E'){//EVSE disconnected, utility power not available--> 0V
        charge.state = 'E';
        charge.statechange = true;
        charge.diodecheck = true;
        Serial.println(" EVSE disconnected, utility power not available, or other EVSE problem"); 
        
      }
      
    }
    //average = 0;
    counter = 0;
    Rp = time(NULL);    
    }
  
  counter++;
  

  // if the reading isn't within a given range tolerance of 90, the read will default to 
  // state nine, which signals that we're getting weird voltage values
  // Update: Apparently, you cannot read a negative voltage on Arduino. Of course because there is no reference voltage!  Offset is shifted to new baseline to correspond,. per design in schematic.
  //The problem is that we need to read the 
  // duty cycle of the pin to determine the maximum charge rate of the car that 
  // it can accept. 
}

// this function tallys the amount of power for the current and total cycle
void timeWatts(void) {
  if(difftime(time(NULL), Wt) >= 10.0) { // checks every ten seconds to save wattage
    #ifdef DEBUG
    //Serial.println("10 seconds have passed. Saving watt meter information.");
    #endif
    Wt = time(NULL);
    charge.chargeCounter++;
    charge.totalCounter++;
    float activePower = myADE7953.getInstActivePowerA();
    charge.ADemandCharge += activePower;
    charge.ADemandTotal += activePower;
  }  
}

void ButtonPressed(void) {  // Interrupt function for the button (ISR) - this is optimized to run fast - this function  tallies button presses 
  if(!buttonIsPressed){
    lastDebounceTime = millis();
    buttonIsPressed = true;
    numPressed++;
    ButtonPressAction = true;
    
    if(timeStarted == false) {
      timeStarted = true;
      t = time(NULL);      
      ButtonPressTimerAction = true;
    }
  }
}

void LevelDetection(void) 
// level detection safety check
// voltage levels need to either be
// ~120V and ~0V for level 1 charging
// ~120V and ~120V for level 2 charging
// safety check fails otherwise
{  
  digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid   
  digitalWrite(relay1, HIGH);  
  digitalWrite(relay2, HIGH);
  delay(1000);
  digitalWrite(relayenable, HIGH); // turn off relay enable pin
  
  digitalWrite(multiplex, HIGH); //in power test this channel is high
  delay(100);
  unsigned long Vrms_chA = 0.0;
  float Vrms_chA_cal, Vrms_chB_cal;
  unsigned long Vrms_chB = 0.0;   
  bool test1 = false;
  bool test2 = false;
  Vrms_chA = 0; //initialize holder for new value
  for(int i = 0; i < 20; i++)
  { 
    Vrms_chA += myADE7953.getVrms(); //read 20 times, this is rms not instantaneous voltage value
    delay(1); //delay between readings in the loop  
    //Serial.println("Vrms_chA:");
    //Serial.println(Vrms_chA);
  } 
  Vrms_chA = Vrms_chA / 20.0; // this finds the average value for voltage 1
  Vrms_chA_cal = (Vrms_chA * m_v1) + b_v1;
  //#ifdef DEBUG
  Serial.println("The VRMS_A Raw:");
  Serial.println(Vrms_chA);
  Serial.println("The VRMS_A for multiplex HIGH:"); 
  Serial.println(Vrms_chA_cal);  //return average value with callibration
  //#endif
  delay(2000);
  
  digitalWrite(multiplex, LOW);  //in power test this channel is low
  delay(100);
  Vrms_chB = 0; //initialize holder for new value
  for(int i = 0; i < 20; i++)
  { 
    Vrms_chB += myADE7953.getVrms();   
    delay(1);
    //Serial.println("Vrms_chB:");
    //Serial.println(Vrms_chB); 
  } 
  Vrms_chB = Vrms_chB / 20.0; // this finds the average value for voltage 2
  Vrms_chB_cal = (Vrms_chB * m_v2) +b_v2;
  //#ifdef DEBUG
  Serial.println("The VRMS_B Raw:");
  Serial.println(Vrms_chB);
  Serial.println("The VRMS_B for multiplex LOW:");
  Serial.println(Vrms_chB_cal);
  //#endif
  
  char buffer[50];
  
    char *p1 = dtostrf(Vrms_chA_cal, 10, 6, buffer);
  //#ifdef DEBUG
  Serial.print("Vrms_chA_cal voltage average reading: ");
  Serial.println(p1);
  char *p2 = dtostrf(Vrms_chB_cal, 10, 6, buffer);
  Serial.print("Vrms_chB_cal voltage average reading: ");
  Serial.println(p2);
  //#endif
  bool test1high = false;
  bool test1low = false;
  
  if(Vrms_chA_cal > v1_threshmin && Vrms_chA_cal < v1_threshmax) 
  {
    test1 = true;
    charge.lvlfail = false;
    #ifdef DEBUG
    Serial.println("L1 voltage reading is within valid range for 120 volt phase line.");
    #endif
  } else if(Vrms_chA_cal >= v1_neutralmin && Vrms_chA_cal < v1_neutralmax) {
    #ifdef DEBUG
    Serial.println("L1 voltage reading is within valid range for neutral.");
    #endif
  } else if(Vrms_chA_cal > v1_threshmax) {
    #ifdef DEBUG
    Serial.println("L1 voltage reading is too high.");    
    #endif
    test1high = true;
    charge.lvlfail = true;
  } else {
    #ifdef DEBUG
    Serial.println("L1 voltage is in between 10 and 115 V. It's too low for valid voltage");
    Serial.println("L1 voltage is a fail.");
    #endif
    test1low = true;
    charge.lvlfail = true;
  } 

  bool test2high = false;
  bool test2low = false;

   
  if(Vrms_chB_cal > v2_threshmin && Vrms_chB_cal < v2_threshmax) 
  {
    test2 = true;
    #ifdef DEBUG
    Serial.println("L2 voltage reading is within valid range for 120 volt phase line.");
    #endif
  } 
  else if(Vrms_chB_cal >= v2_neutralmin && Vrms_chB_cal < v2_neutralmax) 
  {    
    #ifdef DEBUG
    Serial.println("L2 voltage reading is within valid range for neutral.");
    #endif
  } 
  else if(Vrms_chB_cal > v2_threshmax) 
  {    
    #ifdef DEBUG
    Serial.println("L2 voltage reading is too high.");    
    Serial.println("L2 voltage is a fail");
    #endif
    test2high = true;
    charge.lvlfail = true;
  } 
  else 
  {    
    #ifdef DEBUG
    Serial.println("L2 voltage is below threshold and too high for a neutral.");
    Serial.println("L2 voltage is a fail.");
    #endif
    test2low = true;
    charge.lvlfail = true;
  } 
 
  //test1 = true; test2 = true; //made test1 and test2 variables 1
  if(test1 && test2) 
  {
    charge.lv_2 = true;    
    #ifdef DEBUG
    Serial.println("Level 2 voltage set for charger.");    
    #endif
  } 
  else if(test1 && !test2) 
  {
    #ifdef DEBUG
    Serial.println("Level 1 voltage set for charger.");    
    #endif
    charge.lv_1 = true;
  } 
  else if(!test1 && test2) 
  {
    #ifdef DEBUG
    Serial.println("Voltage is detected but they are backwards. Charger failed test.");    
   #endif    
    charge.lvlfail = true;
  } 
  else 
  {
    charge.lvlfail = true;
    charge.groundfail = true;
    #ifdef DEBUG
    Serial.println("Charge level detection has failed. GROUNDOK test failed.");
    #endif
  }

  /*digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid   
  digitalWrite(relay1, LOW); //change relay state 
  digitalWrite(relay2, LOW); //change relay state
  delay(1000);
  digitalWrite(relayenable, HIGH); // turn off relay enable pin */
}



bool connectToWiFi(const char * ssid, const char * pwd) // Wi-Fi setup
{
  printLine();
  #ifdef DEBUG
  Serial.println("Connecting to WiFi network: " + String(ssid) + " " + String(pwd));
  #endif
  WiFi.begin(ssid, pwd);  
  int timeout = 0;
  while(WiFi.status() != WL_CONNECTED)
  {    
    delay(500);
    #ifdef DEBUG
    Serial.print(".");  
    #endif
    if(timeout >= 60) { // will disconnect from Wi-Fi after 60 seconds 
      #ifdef DEBUG
      Serial.println("Wi-Fi connection timeout.");
      Serial.println("Disconnecting!");
      #endif
      WiFi.disconnect();
      // WiFi.mode(WIFI_AP);
      // APsetup();
      // load_data(); 
      
      return false;
    } else {
      Serial.println("WiFi waiting again....");
    }
    timeout++;    
  }
  #ifdef DEBUG
  Serial.println();
  Serial.println("WiFi connected!");
  Serial.print("IP address: ");
  #endif
  Serial.println(WiFi.localIP());
  return true;
}

void printLine(void)
{
  Serial.println();
  for(int i = 0; i<30; i++)
    Serial.print("-");
  Serial.println();
}

// ChargeState MQTT
void publishChargeState(bool isNotification = false){
  #ifdef DEBUG
  Serial.println((isNotification) ? "Sending notification for J1772 state change" :
                                    "ChargeState request accepted! Checking status...");
  #endif
  if(charge.state == 'C') {
    #ifdef DEBUG 
    Serial.println("Charger is currently charging and connected! (C)");
    #endif
    enqueueMessage((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "2");
//    client.publish((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "2");
  } else if(charge.state == 'B') {
    #ifdef DEBUG 
    Serial.println("Charger is currently connected but not charging! (B)");
    #endif
    enqueueMessage((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "1");
//    client.publish((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "1");
  } else if(charge.state == 'A') {
    #ifdef DEBUG 
    Serial.println("Charger is not connected! (A)");
    #endif
    enqueueMessage((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "3");
//    client.publish((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "3");
  } else {
    #ifdef DEBUG 
    Serial.println("Diode check failed! (F)");
    #endif
    enqueueMessage((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "0");
//    client.publish((isNotification) ? "out/devices/240AC4110540/1/Notification/ChargeState" : "out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "0");
  } 
}

// Publish whether charge is supplying a load.
// Only "1" at J1772 State C and var load_on is true
void publishLoadOn(void){
    enqueueMessage("out/devices/240AC4110540/1/Notification/LoadEnabled", (charge.state == 'C' && charge.load_on) ? "1" : "0");
}

// Used for MQTT communication. All interactions occur within this function
// Every statement checks the respective topic and message for accuracy 
// Check every statement and the document to determine their individual functionality
void callback(char * topic, byte* payload, unsigned int length) {
//  #ifdef DEBUG
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.println("] ");
//  #endif
  char str[length]; 
  #ifdef DEBUG
  Serial.print("The length is: ");
  Serial.println(length);
  #endif
  for(int i = 0; i < length; i++) {
    //Serial.print((char)payload[i]);   
    str[i] = (char)payload[i];
    #ifdef DEBUG
    Serial.print(str[i]);
    #endif
  } 
  #ifdef DEBUG
  Serial.println();
  #endif
  char dest[length + 1] ="";  
  
  if(length > 0) {
    strncat(dest, str, length);
    #ifdef DEBUG
    Serial.println("Message true is: ");
    Serial.println(dest);
    #endif
  }
  #ifdef DEBUG
  Serial.println();
  Serial.println("----------------"); 
  #endif
  // determines whether or not the load is on or off
  if(strcmp(topic, "in/devices/240AC4110540/1/OnOff/OnOff") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG 
    Serial.println("Device received OnOff message from broker!");
    #endif
    if(charge.state == 'C' && charge.load_on) {
      #ifdef DEBUG
      Serial.println("Device is on! Sending status to broker!");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/OnOff/OnOff", "1");
    } else {
      #ifdef DEBUG
      Serial.println("Device is off! Sending status to broker!");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/OnOff/OnOff", "0");
    }
  }

  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/GroundLeakage") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Device received Ground Leakage command from broker!");
    #endif
    float IrmsA, IrmsB;
    IrmsA = myADE7953.getIrmsA();
    IrmsB = myADE7953.getIrmsB();
    IrmsA = (IrmsA*m_irmsA)+b_irmsA;
    IrmsB = (IrmsB*m_irmsB)+b_irmsB;
//    IrmsA = (IrmsA*12.6)-17.8; example values that worked for one case
//    IrmsB = (IrmsB*12.3)+0.058; example values that worked for one case
    
    char buffer[50];    
    char *p1 = dtostrf(abs(IrmsA-IrmsB), 10, 2, buffer);
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GroundLeakage", p1);    
  }
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/UpdateGroundThreshold") == 0) {
    #ifdef DEBUG
    Serial.println("Device received command to update ground leakage threshold");
    #endif
    int testlength = 39;
    testlength = length - testlength;
    char ratenum[testlength + 1]="";
    for(int i = 36; i < 36 + testlength; i++){
      ratenum[i - 36] = str[i];
      Serial.print(ratenum[i-36]);
    }
    Serial.println();
    
    int threshold = 0;
    threshold = atoi(ratenum);
    #ifdef DEBUG
    Serial.print("Trying to change the ground threshold to: ");
    Serial.println(threshold);
    #endif
    
    if(threshold >= 0) {      
      GFIthreshold = threshold;
      itoa(threshold, GFI_eeprom, 10);
      savethedata();
       #ifdef DEBUG
      Serial.println("GFI value updated.");
      #endif
      
      #ifdef DEBUG
      Serial.println("The value provided is valid and will be used to adjust car charge settings.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/UpdateGroundThreshold", "1");
    } else {
      #ifdef DEBUG
      Serial.println("The value provided is invalid. Disregarding new leakage threshold.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/UpdateGroundThreshold", "0");
    }
    
  }
  else if(strcmp(topic, "Reconnect") == 0) {
    Wifisetup();    
  }
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Obtained request to check status of GFI in charger.");
    #endif
    if(str[36] != '0') {      
      if(charge.GFIfail) {
        #ifdef DEBUG
        Serial.println("Failure with GFI. Sending data to server.");
        #endif
        enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault", "1");        
      } 
      if(charge.lvlfail) {
        #ifdef DEBUG
        Serial.println("Failure with level detection. Sending data to server.");
        #endif
        enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault", "2");
      }
      if(charge.diodecheck){
        #ifdef DEBUG
        Serial.println("Failure with pilot read. Sending data to server.");
        #endif
        enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault", "4");
      }
      if(charge.groundfail) {
        #ifdef DEBUG
        Serial.println("Ground test failed. Sending data to server.");
        #endif
        enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault", "3");
      }
      if(!charge.GFIfail && !charge.lvlfail) {        
        #ifdef DEBUG
        Serial.println("No fault is in place. Sending results to server.");
        #endif
        enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault", "0"); 
      }
    } else {
      #ifdef DEBUG
      Serial.println("Request for recovery obtained.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GeneralFault", "0");
    }   
  }
  // checks status of ground and wiring
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/GROUNDOK") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Request for ground check receieved.");
    #endif
    if(charge.groundfail) {
      #ifdef DEBUG
      Serial.println("The device failed the ground check. Sending status to broker..");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GROUNDOK", "0");   
    } else {
      #ifdef DEBUG 
      Serial.println("The device passed the ground check. Sending status to broker..");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GROUNDOK", "1");   
    }
  }
  // checks to see if either in level 1 or level 2 charging
  // returns error otherwise
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/SUPLevel") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("SUPLevel request! Checking status...");
    #endif
    if(charge.lv_1 == true && charge.lv_2 == false) {
      #ifdef DEBUG
      Serial.println("The device is in level one charge. Sending status to broker...");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/SUPLevel", "1");
    } else if (charge.lv_1 == false && charge.lv_2 == true) {
      #ifdef DEBUG
      Serial.println("The device is in level two charge. Sending status to broker...");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/SUPLevel", "2");
    } else {
      #ifdef DEBUG 
      Serial.println("The device has not determined level charging. Returning ERROR. Please reboot");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/SUPLevel", "0");
    }
  }
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/GFIState") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Obtained request for GFIState!");
    #endif
    if(charge.GFIfail) {
      #ifdef DEBUG
      Serial.println("There is a failure in the device. Sending back data to server.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GFIState", "0");      
    } else {
      #ifdef DEBUG
      Serial.println("Device is ok! Sending status to server.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/GFIState", "1");
    }
  }
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/LVoltage") == 0) {
    if(strcmp(dest, "{\"method\": \"get\",\"params\":{\"value\":\"L1\"}}") == 0) {
      if(digitalRead(multiplex) != LOW) {
        digitalWrite(multiplex, LOW);
        delay(100);
      }
      long vRMS = myADE7953.getVrms();
      vRMS = (vRMS*m_v1)+b_v1;
      char buffer[50];      
      #ifdef DEBUG
      Serial.print("Value obtained from ADE is: ");
      Serial.println(vRMS);
      #endif
      char *p1 = dtostrf(vRMS, 10, 2, buffer);
      
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/LVoltage", p1);
    } 
    else if (strcmp(dest, "{\"method\": \"get\",\"params\":{\"value\":\"L2\"}}") == 0) {
      if(digitalRead(multiplex) != HIGH) {
        digitalWrite(multiplex, HIGH);
        delay(100);
      }
      long vRMS = myADE7953.getVrms();
      vRMS = (vRMS * m_v2) + b_v2;
      char buffer[50];      
      #ifdef DEBUG
      Serial.print("Value obtained from ADE is: ");
      Serial.println(vRMS);
      #endif
      char *p1 = dtostrf(vRMS, 10, 2, buffer);
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/LVoltage", p1);
    } 
    else {
      #ifdef DEBUG
      Serial.println("Invalid message string.");
      #endif
    }
  }  
  else if(strcmp(topic, "switchmux") == 0) {
    if(digitalRead(multiplex) == LOW) {
      digitalWrite(multiplex, HIGH);
      Serial.println("multiplex switched to HIGH");
    } else{
      digitalWrite(multiplex, LOW);
      Serial.println("multiplex switched to LOW");
    }
  }
  else if(strcmp(topic, "test1") == 0) {
    long apnoload, activeEnergyA;
    float vRMS, iRMSA, powerFactorA, apparentPowerA, reactivePowerA, activePowerA, iRMSB;    
    #ifdef DEBUG
    Serial.println("Received request for test 1");    
    Serial.println("Verifying that instcurrent is 0.0: ");
    #endif

    char buffer[50];
    vRMS = myADE7953.getVrms();
    Serial.print("Vrms (V): ");
    Serial.println(vRMS);
  
    iRMSB = myADE7953.getIrmsB();
    Serial.print("IrmsB (mA): ");
    Serial.println(iRMSB);
      
    iRMSA = myADE7953.getIrmsA();  
    Serial.print("IrmsA (mA): ");
    Serial.println(iRMSA);

    apparentPowerA = myADE7953.getInstApparentPowerA();  
    Serial.print("Apparent Power A (mW): ");
    Serial.println(apparentPowerA);

    activePowerA = myADE7953.getInstActivePowerA();  
    Serial.print("Active Power A (mW): ");
    Serial.println(activePowerA);

    reactivePowerA = myADE7953.getInstReactivePowerA();  
    Serial.print("Rective Power A (mW): ");
    Serial.println(reactivePowerA);

    powerFactorA = myADE7953.getPowerFactorA();  
    Serial.print("Power Factor A (x100): ");
    Serial.println(powerFactorA);
    
    activeEnergyA = myADE7953.getActiveEnergyA();  
    Serial.print("Active Energy A (hex): ");
    Serial.println(activeEnergyA);
                               
  }
  // instantaneous supplied current -----  NEEDS TO BE FIXED!!!!!!!!!!!!************
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/INSTCurrent") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    long instcurrent = 0.0;
    #ifdef DEBUG
    Serial.println("Received request for instantaneous supplied current.");    
    Serial.println("Verifying that instcurrent is 0.0: ");
    Serial.println(instcurrent);
    #endif

    char buffer[50];
    instcurrent = myADE7953.getIrmsA(); // assumption made that if no ground fault IRMSA equals IRMSB
    instcurrent = (instcurrent * m_irmsA) + b_irmsA;
     
      #ifdef DEBUG
    Serial.print("Value obtained from ADE is: ");
    Serial.println(instcurrent);
    #endif
    char *p1 = dtostrf(instcurrent, 10, 2, buffer);
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/INSTCurrent", p1);
  }
  // set charging current to be supplied
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/RequestCurrent") == 0) {
    int testlength = 39;
    testlength = length - testlength;
    char ratenum[testlength + 1]="";
    for(int i = 36; i < 36 + testlength; i++){
      ratenum[i - 36] = str[i];
      Serial.print(ratenum[i-36]);
    }
    Serial.println();
    #ifdef DEBUG
    Serial.println("Obtained request to change charging current using new format.");
    #endif
    int rate = 0;
    rate = atoi(ratenum);
    #ifdef DEBUG
    Serial.print("Trying to change the charge rate of the car to: ");
    Serial.println(rate);
    #endif
    if(rate >= 0 && rate <= 4000) {  // charge rate request cannot go below 0 A and above 40 A - set as a safety limit based on electrical specifications of device -- 400 because of fixed decimal point
      requestedCurrentinAMPS= rate/100;//Convert to AMPS from rate which is in 100th of amps
      charge.chargerate = (20*rate) / 60; // multiplied by 20 to map to a range from 0 - 2000
      charge.statechange = true;
      char buffer[10];
      itoa(rate, buffer, 10);
      char * p1 = buffer;
      #ifdef DEBUG
      Serial.println("The value provided is valid and will be used to adjust car charge settings.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/RequestCurrent", "1");
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/RequestCurrentValue", p1);
    } else {
      #ifdef DEBUG
      Serial.println("The value provided is invalid. Disregarding the new charge rate.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/RequestCurrent", "0");
    }
  }
  // delivered current to be supplied
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/RmsCurrent") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Request obtained for current charging rate using new format.");
    #endif
    char charbuf[20];
    int temp = (charge.chargerate * 60) / 20; // This converts the stored value back into its intended value in AMPS - divided by 20 to map to a range from 0 - 2000    
    Serial.println(temp);
    Serial.println(charge.chargerate);
    itoa(temp, charbuf, 10);
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/RmsCurrent", charbuf); 
  }
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/chargeState") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("ChargeState request accepted! Checking status...");
    #endif
    if(charge.state == 'C') {
      #ifdef DEBUG 
      Serial.println("Charger is currently charging and connected! (C)");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "1");
    } else if(charge.state == 'B') {
      #ifdef DEBUG 
      Serial.println("Charger is currently connected but not charging! (B)");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "2");
    } else if(charge.state == 'A') {
      #ifdef DEBUG 
      Serial.println("Charger is not connected! (A)");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "0");
    } else {
      #ifdef DEBUG 
      Serial.println("Diode check failed! (F)");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/ChargeState", "0");
    }    
  }  
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/ChargeState") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    publishChargeState();
  }  
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/InstantaneousDemand") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {    
        
    float instActive = 0.0;
    #ifdef DEBUG
    Serial.println("Received request for instantaneous demand.");    
    Serial.println("Verifying that instActive is 0.0 for test purposes: ");
    Serial.println(instActive);
    #endif
    char buffer[50];
    instActive = myADE7953.getInstActivePowerA();
    
    char *p1 = dtostrf(instActive, 10, 6, buffer);
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/InstantaneousDemand", p1);
  }
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    
    #ifdef DEBUG
    Serial.println("Received request for AccumulatedDemandCharge");
    
    #endif
    double kWh = 0.0;
    kWh = (charge.ADemandCharge * (10.0 * (float)charge.chargeCounter)) / (3600000000.00); // converts watts to kilowatts hours
    char buffer[50];
    char *p1 = dtostrf(kWh, 10, 6, buffer);
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge", p1);
  }
  else if(strcmp (topic, "in/devices/240AC4110540/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Received request for AccumulatedDemandTotal");
    #endif
    double kWh = 0.0;
    kWh = (charge.ADemandTotal * (10.0 * (float)charge.totalCounter)) / (3600000000.00); // converts watts to kilowatts hours
    char buffer[50];
    char *p1 = dtostrf(kWh, 10, 2, buffer);
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal", p1);
  }
  else if(strcmp (topic, "in/devices/240AC4110540/1/SimpleMeteringServer/SaveLevel1Charge") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Saving current charging rate to level1");
    #endif    
    itoa(charge.chargerate, lv1_eeprom, 10);    
    savethedata();
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/SaveLevel1Charge", "1");
  }
  else if(strcmp(topic, "in/devices/240AC4110540/1/SimpleMeteringServer/SaveLevel2Charge") == 0 && strcmp(dest, "{\"method\": \"get\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Saving current charging rate to level1");
    #endif 
    itoa(charge.chargerate, lv2_eeprom, 10);
    savethedata();
    enqueueMessage("out/devices/240AC4110540/1/SimpleMeteringServer/SaveLevel2Charge", "1");
  }
  else if(strcmp (topic, "in/devices/240AC4110540/1/OnOff/Toggle") == 0 && strcmp(dest, "{\"method\": \"post\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Received request to toggle load");
    #endif
    if(charge.lvlfail == false && charge.groundfail == false && charge.GFIfail == false) {
      if(charge.load_on) {
        #ifdef DEBUG
        Serial.println("Load is now off.");
        #endif
        charge.load_on = false;
        charge.statechange = true;
//        charge.state = 'B';
        enqueueMessage("out/devices/240AC4110540/1/OnOff/Toggle", "0");
      } 
      else {
        #ifdef DEBUG
        Serial.println("Load is turned on.");
        #endif
        charge.load_on = true;
        charge.statechange = true;
//        charge.state = 'C';
        enqueueMessage("out/devices/240AC4110540/1/OnOff/Toggle", "0");
      } 
    }
    else {
      #ifdef DEBUG 
      Serial.println("relays cannot be toggled safely because safety checks failed");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/OnOff/Toggle", "2");
    }
  }
  else if(strcmp (topic, "in/devices/240AC4110540/1/OnOff/On") == 0 && strcmp(dest, "{\"method\": \"post\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Device has received request to turn on relays.");
    #endif
    if(charge.state != 'C' || charge.load_on) {
      #ifdef DEBUG 
      Serial.println("Device is not in correct state to turn on relays.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/OnOff/On", "0");
    } else {
      charge.load_on = true;
      charge.statechange = true;
      // charge.state = 'C';
      #ifdef DEBUG
      Serial.println("Device has turned on relays after verifying state.");
      #endif
      enqueueMessage("out/devices/240AC4110540/1/OnOff/On", "1");
    }    
  }
  
  else if(strcmp (topic, "in/devices/240AC4110540/1/OnOff/Off") == 0 && strcmp(dest, "{\"method\": \"post\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Device has received request to turn off relays.");
    #endif    
    charge.load_on = false;
    charge.statechange = true;
//    charge.state = 'B';
    enqueueMessage("out/devices/240AC4110540/1/OnOff/Off", "0");     
  }  
  else if(strcmp (topic, "in/devices/240AC4110540/0/cdo/reset") == 0 && str[36] == 'a' && str[37] == 'l' && str[38] == 'l'){
      enqueueMessage("out/devices/240AC4110540/0/cdo/reset", "resetting all");
      resetFunc();
  }
  else if(strcmp (topic, "in/devices/240AC4110540/0/cdo/reset") == 0 && str[36] == 'w' && str[37] == 'i' && str[38] == 'f' && str[39] == 'i'){
      int i; 
      int save; 
      char wifiname[50] = "";
      char wifipassword[50] = "";
      //{"method":"post","params":{"value":"wifi"}{"wifiname:password"}}
      //{"method":"post","params":{"value":"wifi"}{":"}} -- length: 48
      enqueueMessage("out/devices/0/cdo/reset", "resetting wifi settings of device");
      client.disconnect();
      WiFi.disconnect();
      for(i=44; i<length; i++){
         if(str[i] == ':'){
          save = i+1;
          break;
        }
        Serial.print(str[i]);
        wifiname[i-44] = str[i];
      }
      Serial.print("---------");
      for(i=save; i<length-3; i++){
        Serial.print(str[i]);
        wifipassword[i-save] = str[i];
      }
      Serial.print("---------");
      
      charge.wifiname = wifiname;
      charge.wifipassword = wifipassword;
      Serial.println(charge.wifiname);
      Serial.println("----------");
      Serial.println(charge.wifipassword);
      
      connectToWiFi(charge.wifiname, charge.wifipassword);
      client.setServer(mqtt_server, mqttPort);
      client.setCallback(callback);

     while(!client.connected()) {
      #ifdef DEBUG
      Serial.println("Connecting to MQTT...");
      #endif
      if(client.connect("ESP32Client", mqttUser, mqttPassword))
        #ifdef DEBUG
        Serial.println("Connected");
        #endif
      else {
        #ifdef DEBUG
        Serial.print("Connection failed with state ");
        #endif
        Serial.println(client.state());
        delay(2000);
      }
      topicsSubscription();
    }
  }
  else if(strcmp (topic, "in/devices/240AC4110540/0/cdo/reset") == 0 && str[36] == 'm' && str[37] == 'q' && str[38] == 't' && str[39] == 't'){
    enqueueMessage("out/devices/240AC4110540/0/cdo/reset", "resetting MQTT settings of device");
    client.disconnect();
    int i; 
    int save; 
    char mqttuser[50] = "";
    char mqttpassword[50] = "";
    char mqttserver[50] = "";
    int mqttport = 0;
    char mqttportarr[10] = "";
    //{"method":"post","params":{"value":"mqtt"}{"mqttuser:mqttpassword:mqttserver:mqttport"}}
    //const char * mqttserver = "m10.cloudmqtt.com"; -- shermaine's mqtt
    //const int mqttport = 10355;
    //const char * mqttuser = "zbwdrora";
    //const char * mqttpassword = "sMRvXz5cM6WF";
    for(i=44; i<length; i++){
      if(str[i] == ':'){
        save = i+1;
        break;
      }
      Serial.print(str[i]);
      mqttuser[i-44] = str[i];
    }
    Serial.print("/");
    for(i=save; i<length; i++){
      if(str[i] == ':'){
        save = i+1;
        break;
      }
      Serial.print(str[i]);
      mqttpassword[i-save] = str[i];
    }
    Serial.print("/");
    for(i=save; i<length; i++){
      if(str[i] == ':'){
        save = i+1;
        break;
      }
      Serial.print(str[i]);
      mqttserver[i-save] = str[i];
    }
    Serial.print("/");
    for(i=save; i<length-3; i++){
      Serial.print(str[i]);
      mqttportarr[i-save] = str[i];
      }
    mqttport = atoi(mqttportarr);
    charge.mqttport = mqttport;
    Serial.print("/");
      
    charge.mqttuser = mqttuser;
    charge.mqttpassword = mqttpassword;
    charge.mqttserver = mqttserver;
    charge.mqttport = mqttport;
  
    Serial.println("----------------");
    Serial.println(charge.mqttuser);
    Serial.println("----------------");
    Serial.println(charge.mqttpassword);
    Serial.println("----------------");
    Serial.println(charge.mqttserver);
    Serial.println("----------------");
    Serial.println(charge.mqttport);
    Serial.println("----------------");
        
    client.setServer(charge.mqttserver, charge.mqttport);
    client.setCallback(callback);

    while(!client.connected()) {
      #ifdef DEBUG
      Serial.println("Connecting to MQTT...");
      #endif
      if(client.connect("ESP32Client", charge.mqttuser, charge.mqttpassword))
        #ifdef DEBUG
        Serial.println("Connected");
        #endif
      else {
        #ifdef DEBUG
        Serial.print("Connection failed with state ");
        #endif
        Serial.println(client.state());
        delay(2000);
      }
      topicsSubscription();
    }
  }
  else if(strcmp(topic, "devicename") == 0) {//name device
      int i;
      for (i = 0; i < length; i++){
        Serial.print(str[i]);
        charge.nameofdevice[i] = str[i];
      }
      charge.namelength = length;
      Serial.println("------------------");
      Serial.println(charge.nameofdevice);
      enqueueMessage("out/devices/240AC4110540/0/cdo/devicename", "Test"); 
  }
  
  else if(strcmp (topic, "in/devices/240AC4110540/0/cdo/reset") == 0 && str[36] == 'd' && str[37] == 'e' && str[38] == 'v' && str[39] == 'i' && str[40] == 'c' && str[41] == 'e'){
    enqueueMessage("out/devices/240AC4110540/0/cdo/reset", "deleting information set by user"); 
    //charge.nameofdevice = "";
    int i;
    for(i = 0; i<charge.namelength; i++){
      charge.nameofdevice[i] = ' ';
    }
    Serial.println(charge.nameofdevice);
  }
   
  else if(strcmp (topic, "esp/test") == 0) {
    //changestate function
    //CS state
    if(str[0] == 'C' && str[1] == 'S') {
      charge.state = str[2];
      charge.statechange = true;
      #ifdef DEBUG
      Serial.print("Changing the state of the charger to: ");
      Serial.println(charge.state);
      #endif      
    }
    // This triggers the fault interface interrupt    
    else if(str[0] == 'F' && str[1] == 'I') {
      #ifdef DEBUG
      Serial.println("The device has received commands to trigger the fault interrupt");
      #endif
      //digitalWrite(GFIout, LOW);
      enqueueMessage("esp/response", "OK"); 
    }
    //change chargerate
    // this should be a value between 0 - 100
    // RC #
    else if(str[0] == 'R' && str[1] == 'C' && length >= 3) {
      char temp[length - 2];
      int rate = 0;
      for(int i = 0; i < length - 2; i++) 
        temp[i] = str[i + 2];
      rate = atoi(temp);
      #ifdef DEBUG
      Serial.print("Trying to change the charge rate of the car to: ");
      Serial.println(rate);
      #endif
      if(rate >= 0 && rate <= 100) {
        charge.chargerate = rate;
        charge.statechange = true;
        #ifdef DEBUG
        Serial.println("The value provided is valid and will be used to adjust car charge settings.");
        #endif
      } else {
        #ifdef DEBUG
        Serial.println("The value provided is invalid. Disregarding the new charge rate.");
        #endif
      }
    }    
    else if(str[0] == 'R' && str[1] == 'R' && length == 2) {
      #ifdef DEBUG
      Serial.println("Request obtained for current charging rate");
      #endif
      char charbuf[20];
      charge.statechange = true;
      itoa(charge.chargerate, charbuf, 10);
      enqueueMessage("esp/response", charbuf);
    }
    // request wattmeter information
    // WR
    else if(str[0] == 'W' && str[1] == 'R') {
      #ifdef DEBUG
      Serial.println("Request for wattmeter information received.");
      Serial.println("Returning value for wattmeter.");
      #endif
      // this needs to be modified with the real value
      // for now, this just returns a random number 
      int randomnum = rand();
      char charbuf[20];
      itoa(randomnum, charbuf, 10);
      #ifdef DEBUG
      Serial.print("This is the randomnum value: ");
      Serial.println(randomnum);
      #endif
      enqueueMessage("esp/response", charbuf);
    }
    else if(str[0] == 'C' && str[1] == 'H' && str[2] == 'S'){
      #ifdef DEBUG
      Serial.print("It is in state ");
      Serial.println(charge.state);
      #endif
      enqueueMessage("esp/response", &charge.state); 
    } 
    else{
       enqueueMessage("esp/response", "kjhgfxdcgyuioupo0[0ipiugyghfdx");   
    }
  } else {
         enqueueMessage("esp/response", "Invalid command");   
  }
}

// Loads the data saved on the EEPROM
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

// Saves data obtained from AP mode 
void save_data(char* data)
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
}

// resets parameters to default values
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
}

void savethedata(void) {
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
}

void setup() {

  reconnected = false;
  charge.wifiname = NULL;
  charge.wifipassword = NULL;
  charge.mqttuser = NULL;
  charge.mqttpassword = NULL;
  charge.mqttserver = NULL;
  charge.mqttport = 0;

  mqttQueue = xQueueCreate( 10, sizeof( MqttMessage ) );
  
  Serial.begin(115200);

  // turn off the relays initially for safety reasons. If the device resets for whatever reason
  // the relays could possibly still be on from prior operations.
  #ifdef DEBUG
  Serial.println("Turning on relay enable pin! Setting relays off!");
  #endif
  
  // relays need to be enabled to change their state
  pinMode(relayenable, OUTPUT);
  digitalWrite(relayenable, HIGH);
  digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid  
  pinMode(relay1, OUTPUT);
  digitalWrite(relay1, LOW);
  pinMode(relay2, OUTPUT);
  digitalWrite(relay2, LOW);
  delay(500);
  digitalWrite(relayenable, HIGH); // turn off relay enable pin

  // this function is related to the PWM signal output coming from the charger.
  // the duty cycle on this pin represents the amount of charge going into the EV.
  //ledcAttachPin(dutyout, 4);
  //ledcSetup(4, 1000, pilotresolution); // pilot duty cycle resolution. 1000 Hz
  ledcSetup(0, pilotfreq, pilotresolution);
  ledcAttachPin(pilotout, 0);
 delay(7);
  #ifdef DEBUG
  Serial.println("PWM signal created and initialized");
  #endif  

 // ledcWrite(2, 500);
  
  // Analog to Digital Converter setup
  // ADC1_CHANNEL_0 uses GPIO36 to read the input for the ADC
  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_3, ADC_ATTEN_DB_11);
  
  #ifdef DEBUG
  Serial.println("ADC Pin initialized");
  #endif
  delay(500);

  load_data(); //Loads the data saved on the EEPROM
  #ifdef DEBUG
  Serial.println("Initial data loaded from EEPROM");
  #endif  
  
 /*////// initializes the PWM signals on the leds 
  // can be modified to represent a state in the charger
  ledcAttachPin(LED_PIN_BLUE, 1);
  ledcSetup(1, freq, resolution);
  #ifdef DEBUG
  Serial.println("Blue LED pin initialized");
  #endif  
 
  
   // The following are for debugging and need to be modified later!
  // -------------------------------------
  charge.lvlfail = false;
  charge.lv_1 = true;
  // -------------------------------------
  
  if(charge.lv_1 && !charge.lv_2) {
    charge.chargerate = atoi(lv1_eeprom); 
  } else if(!charge.lv_1 && charge.lv_2) {
    charge.chargerate = atoi(lv2_eeprom); 
  }
  if(charge.GFIfail || charge.lvlfail || charge.groundfail) {
    ledcWrite(1, 0);
    ledcWrite(2, 500);
    ledcWrite(3, 0);    
    int value = newmap();
    ledcWrite(4, value);      
  } else {
    ledcWrite(1, 0);
    ledcWrite(2, 0);
    ledcWrite(3, 500);    
    int value = newmap();
    ledcWrite(4, value);    
  }////*/

  
  charge.groundfail = false;
  #ifdef DEBUG
  Serial.println("In Setup function - ADE7359 initialized");
  #endif  
  
  pinMode(GFIin, INPUT); // define GFI input pin 
  pinMode(NULL_input, INPUT); //hold as an input that is unused
  
  GFItestinterrupt(); //ADD back in after debugging!!!!!!!
  LevelDetection();
  
  charge.state = 'A'; 
  charge.load_on = true;
  charge.statechange = false;
  charge.chargerate = 27 * 20; // to map to 2000 from reference to a value mapped to 0 - 100
  charge.pilotreadError = false;
  charge.pilotError = false;   
  charge.diodecheck = false; 

  // Watt meter values
  charge.ADemandCharge = 0.0;
  charge.ADemandTotal = 0.0;
  charge.watttime = true; //was false before
  charge.chargeCounter = 0;
  charge.totalCounter = 0;

  
 
  //wifiscan();
  
  if(strcmp(ssideeprom, "ssid") == 0  && strcmp(pwdeeprom, "pw123456789") == 0) {  
    dummyAPmode();
    //Should be RTOS
    APmode();
  }
  Wifisetup();
  
  Rp = time(NULL);
  gfifailure = time(NULL);
  
}


void a_task(void *pvParameter){
  //Task manages general EV controller functions related to non-connected elements (offload LED and Pilot control elements to functions called by the other task and update references that are passed to the handler function)
  //only call the ADC and the ADE7953 in this task
  //semiphore lockout updating EEPROM from this and the other tasks
  
  //enter "setup" for the task
  unsigned long intervalGFI = 50; // the time we need to wait
  unsigned long intervalLevelDetection = 1;
  unsigned long intervalMainIF= 1;
  unsigned long intervalreadPilot = 1;
  unsigned long intervalStateChange=1;
  unsigned long previousMillis = 0; // millis() returns an unsigned long.
  unsigned long currentMillis;
  unsigned long MaxMillis = 4294967295;
	
//Blue pin not initialized was causing pilot PWM to act erratically.
//  ledcAttachPin(LED_PIN_BLUE, 1);
//  ledcSetup(1, freq, resolution);
//  #ifdef DEBUG
//  Serial.println("Blue LED pin initialized");
//  #endif  
  
  ledcAttachPin(LED_PIN_RED, 2);
  ledcSetup(2, freq, resolution);
  #ifdef DEBUG
  Serial.println("Red LED pin initialized");
  #endif  

  ledcAttachPin(LED_PIN_GREEN, 3);
  ledcSetup(3, freq, resolution);
  #ifdef DEBUG
  Serial.println("Green LED pin initialized");
  #endif 
  
    ledcWrite(1, 500);
    ledcWrite(2, 500);
    ledcWrite(3, 500); 

  
  Serial.println("Begin task A");
  while(1)  //enter looped part of the task
  {

  if(charge.watttime)
  { 
      lock = 1;
      timeWatts();
      #ifdef DEBUG
      Serial.println("Time Watts function called");
      #endif
      lock = 0;
  }

  currentMillis = millis();
  //GFI TEST CHECK CALLED
  if ((unsigned long)(currentMillis > previousMillis))
  { 
    lock = 1;
    //Serial.println(currentMillis - previousMillis);
    GFItestinterrupt();
    previousMillis = currentMillis - 1;
    #ifdef DEBUG
    Serial.println("Went through first GFI Test");
    #endif
    //Serial.println(currentMillis - previousMillis);
    lock = 0;
  }
  currentMillis = millis();
  //LEVEL DETECTION CHECK CALLED
  if ((unsigned long)(currentMillis > previousMillis))
  {
    lock = 1;
    //LevelDetection();
    charge.GFIfail = false; //hardcode delete after
    charge.lvlfail = false; //hardcode delete after
    previousMillis = currentMillis - 1;
    #ifdef DEBUG
    Serial.println("Went through first Level Detection Test");
    #endif
    lock = 0;
  }

  //Safety check for Millis rollover
  if(currentMillis < previousMillis)
  {    
    previousMillis = (MaxMillis - previousMillis) + currentMillis;
    Serial.println("Fixed Millis roll over");
  }
  
  
  // safety checks. Will not turn on charger if the safety checks fail. LEVEL DETECTION
  currentMillis = millis();
  if ((unsigned long)(currentMillis > previousMillis))
  {
  //MAKES SURE NO GFI ERROR OR LEVEL 1 ERROR
  if(charge.GFIfail == false && charge.lvlfail == false) 
  {
      lock = 1;
      #ifdef DEBUG
      Serial.print(time(NULL));
      Serial.print(" => ");
      Serial.print("ADCmedianValueRead: ");
      Serial.println(ADCmedianValueRead());
      previousMillis = currentMillis - 1;
      #endif
      
    //READS PILOT SIGNAL, DETERMINES WHICH STATE THE CHARGER IS IN
    #ifdef DEBUG
    Serial.println(previousMillis);
    Serial.println(currentMillis);
    #endif
    
    currentMillis = millis();
  // if ((unsigned long)(currentMillis > previousMillis))
   // {
      //Serial.println("In Read Pilot");
      readPilot();
      delay(1000);
      previousMillis = currentMillis - 1;
      Serial.println("State of charge after Read Pilot is:");
      Serial.println(charge.state);
    //}

      //Safety check for Millis rollover
  if(currentMillis < previousMillis)
  {
    previousMillis = (MaxMillis - previousMillis) + currentMillis;
    Serial.println("Fixed Millis roll over");
  }
    //GFI TEST
    currentMillis = millis();
    if ((unsigned long)(currentMillis > previousMillis))
    {
    if(difftime(time(NULL), gfifailure) >= 5.0) 
    { 
      // tests GFI every 5 seconds 
      //GFItestinterrupt(); // GFI test inturrupt is disabled for debugging. Reenable to allow GFI check
      int IrmsA = myADE7953.getIrmsA();
      int IrmsB = myADE7953.getIrmsB();
      IrmsA = (IrmsA*m_irmsA)+b_irmsA;
      IrmsB = (IrmsB*m_irmsB)+b_irmsB;
      Serial.print("GFI leakage current (IrmsA - IrmsB): "); 
      Serial.println(IrmsA - IrmsB);  
      gfifailure = time(NULL);
    }
      previousMillis = currentMillis - 1;
    }
    Serial.println("Went through GFI Test again");
    
    //Serial.println(charge.state);
    currentMillis = millis();
    if ((unsigned long)(currentMillis > previousMillis))
    {
   // charge.statechange = true; //hardcoded delete after
    if(charge.statechange) {
      // enqueueMessage("out/devices/1/SimpleMeteringServer/MQTTtest", "I am on");
      Serial.println("STATE CHANGE HERE");
      switch (charge.state) {
        case 'A': {
          ledcWrite(3, 500); // set value to LED 
          ledcWrite(2, 0); // set value to LED 
          ledcWrite(1, 0); // set value to LED 
          //requestedCurrentinAMPS= 0.0;
          // Non-zero arg to pwmDutyCycleLookup so that we can exit state A
          int value = (pwmDutyCycleLookup(10)*((int)(pow(2.0, (double)pilotresolution)) - 1)); //newmap(); // sets PWM using default value of 20 amps. Can be modified through MQTT or initiliasing the EEPROM 
          ledcWrite(0,value); //ledcWrite(4, value);  // this is the PWM applied to the pilot
          Serial.println("CASE A: Small Duty Cyle");
          }
//          charge.load_on = true;
          break;
        case 'B': {
          ledcWrite(3, 1023); // set value to LED 
          ledcWrite(2, 500); // set value to LED 
          ledcWrite(1, 0); // set value to LED 
          //requestedCurrentinAMPS= 10.0;
          int value = (pwmDutyCycleLookup(10)*((int)(pow(2.0, (double)pilotresolution)) - 1)); //newmap(); // sets PWM using default value of 20 amps. Can be modified through MQTT or initiliasing the EEPROM 
          ledcWrite(0,value); //ledcWrite(4, value);  // this is the PWM applied to the pilot
           Serial.println("CASE B: Small Duty Cyle");
          }
          break;
        case 'C': {
          ledcWrite(3, 1023); // set value to LED 
          ledcWrite(2, 0); // set value to LED 
          ledcWrite(1, 0); // set value to LED 
          //requestedCurrentinAMPS= 40.0;
          int value = (pwmDutyCycleLookup(requestedCurrentinAMPS)*((int)(pow(2.0, (double)pilotresolution)) - 1)); //newmap(); // sets PWM using default value of 20 amps. Can be modified through MQTT or initiliasing the EEPROM
          
          ledcWrite(0,value); //ledcWrite(4, value);  // this is the PWM applied to the pilot//ledcWrite(4, value); // this is the PWM applied to the pilot
          Serial.println("CASE C: Specified Duty Cyle Set related to:");
          Serial.println(requestedCurrentinAMPS);
          }
          break;
        default:{
          ledcWrite(2, 200); // set value to LED 
          ledcWrite(1, 0); // set value to LED 
          ledcWrite(3, 0); // set value to LED 
          
          int value = (pwmDutyCycleLookup(requestedCurrentinAMPS)*((int)(pow(2.0, (double)pilotresolution)) - 1)); //newmap(); // sets PWM using default value of 20 amps. Can be modified through MQTT or initiliasing the EEPROM 
          ledcWrite(0,value); //ledcWrite(4, value);  // this is the PWM applied to the pilot
          }
          break;
      }
        //Serial.println("After charge.statechange");
          //charge.state = 'C';//hardcoded delete after
          // charge.load_on = true;//hardcoded delete after
          // charge.watttime = false;//hardcoded delete after
        //Serial.println(charge.state);
      if(charge.state == 'C' && charge.load_on && !charge.watttime) {
        //#ifdef DEBUG
        Serial.println("The charger is now in charging state! Turning on relays.");
        Serial.println("These are now the values for the relays.");
        Serial.println(digitalRead(relay1));
        Serial.println(digitalRead(relay2));  
        //#endif
        digitalWrite(relayenable, LOW);
        digitalWrite(relay1, HIGH);
        digitalWrite(relay2, HIGH);
        delay(100);
        digitalWrite(relayenable, HIGH);
        Serial.print("Active Power: ");
        Serial.println(myADE7953.getInstActivePowerA());
        charge.watttime = true;
        charge.chargeCounter = 0;
        charge.ADemandCharge = 0.0;
        Wt = time(NULL);
      } else if(charge.state == 'C' && charge.load_on && charge.watttime) {
        //#ifdef DEBUG
        Serial.println("Duty cycle has changed!");
        //#endif
      } else if(charge.state == 'C' && !charge.load_on) {
        //#ifdef DEBUG
        Serial.println("The charger is in state C but was commanded to turn off!");
        //#endif
        if(charge.watttime) {
          Serial.println("Wattmeter time check was on. It has been switched off.");
          Serial.println("Charge cycle information will be saved until the next time the");
          Serial.println("charger goes back into 'C' state");          
        }
//        Serial.print("Current state is: ");
//        Serial.println(charge.state);        
        Serial.println("Relays are now off.");
//        //#endif
        charge.watttime = false;
        digitalWrite(relayenable, LOW);
        digitalWrite(relay1, LOW);
        digitalWrite(relay2, LOW);
        delay(100);
        digitalWrite(relayenable, HIGH);
        
      } 
      else {
        //#ifdef DEBUG 
        Serial.println("The state of the charger changed from previous state based on pilot reading."); // may not actually turn into a physical change
        if(!charge.load_on) {
          Serial.println("The load is turned off.");
        } 
        if(charge.watttime) {
          Serial.println("Wattmeter time check was on. It has been switched off.");
          Serial.println("Charge cycle information will be saved until the next time the");
          Serial.println("charger goes back into 'C' state");          
        }
        Serial.print("Current state is: ");
        Serial.println(charge.state);        
//        Serial.println("Relays are now off.");
//        //#endif
        charge.watttime = false;
        digitalWrite(relayenable, LOW);
        digitalWrite(relay1, LOW);
        digitalWrite(relay2, LOW);
        delay(100);
        digitalWrite(relayenable, HIGH);
      }
      charge.statechange = false;

      // MQTT Notification
      publishChargeState(true);
      publishLoadOn();
    }
      previousMillis = currentMillis - 1;
    }
      previousMillis = currentMillis -1;
         //Safety check for Millis rollover
  if(currentMillis < previousMillis)
  {
    previousMillis = (MaxMillis - previousMillis) + currentMillis;
    Serial.println("Fixed Millis roll over");
  }
      lock = 0;
      }
    }
   Serial.println("End of while loop/end of task A");
  }
}

void b_task(void *pvParameter){
 /* // initializes the PWM signals on the leds 
  // can be modified to represent a state in the charger
  ledcAttachPin(LED_PIN_BLUE, 1);
  ledcSetup(1, freq, resolution);
  #ifdef DEBUG
  Serial.println("Blue LED pin initialized");
  #endif  
  
  ledcAttachPin(LED_PIN_RED, 2);
  ledcSetup(2, freq, resolution);
  #ifdef DEBUG
  Serial.println("Red LED pin initialized");
  #endif  

  ledcAttachPin(LED_PIN_GREEN, 3);
  ledcSetup(3, freq, resolution);
  #ifdef DEBUG
  Serial.println("Green LED pin initialized");
  #endif  
  
   // The following are for debugging and need to be modified later!
  // -------------------------------------
  charge.lvlfail = false;
  charge.lv_1 = true;
  // -------------------------------------
  
  if(charge.lv_1 && !charge.lv_2) {
    charge.chargerate = atoi(lv1_eeprom); 
  } else if(!charge.lv_1 && charge.lv_2) {
    charge.chargerate = atoi(lv2_eeprom); 
  }
  if(charge.GFIfail || charge.lvlfail || charge.groundfail) {
    ledcWrite(1, 0);
    ledcWrite(2, 500);
    ledcWrite(3, 0);    
    int value = newmap();
    ledcWrite(4, value);      
  } else {
    ledcWrite(1, 0);
    ledcWrite(2, 0);
    ledcWrite(3, 500);    
    int value = newmap();
    ledcWrite(4, value);    
  }*/
  
  
  //check button action 
  //button functionality
  pinMode(buttonPin, INPUT);
  attachInterrupt(digitalPinToInterrupt(buttonPin), ButtonPressed, FALLING); //esp32,gpio pin doesn't have pull up capability hardware
  buttonIsPressed = false;
  timeStarted = false;

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

  // the multiplex line shifts the input going into the ADE 
  // this allows us to measure each line through the ADE
  pinMode(multiplex, OUTPUT);
  digitalWrite(multiplex, LOW); // line 2
  delay(1000);

  GFIthreshold = atoi(GFI_eeprom);
  #ifdef DEBUG
  Serial.println("The GFI threshold value is: ");
  Serial.println(GFIthreshold);
  #endif
  
  //enter "setup" for the task
  Serial.println("Begin Task B"); 
	
//Button press constantly checked in task B while task A is running.
//Button functions
// in between the first button press after 10 seconds.
// 1-4: Toggles load on/off
// 5: Resets EEPROM
// 6-8: Changes current 6A, 10A, 20A
// 9-10: Posts test to MQTT broker
// 11-12: Calls AP Mode
// 13+: Resets ESP32
	
  while(1) //enter looped part of the task
  {
	  //semiphore lockout updating EEPROM from this and the other tasks
	  //look for changes and call LED handler functions, also take care of duty cycle adjustments here after setup - these parts need to be implemented here
	  //only handle buttons and call the LEDCWRITE from this task for both the front LEDS and the pilot duty cycle setting, use this to call update functions - only call them from this task
  buttonCheck(); //look for the IRS based flag that the button was pressed, handle buttons in this task only.
          //Serial.println("Insdie while of Task B");  
      if (ButtonPressAction == true)
      {
        //#ifdef DEBUG
        Serial.println("Button Pressed!");
        //#endif
        ButtonPressAction=false;
      }
          if (ButtonPressTimerAction == true)
      {
     //#ifdef DEBUG
     Serial.println("Button Timer started!");
     //#endif
     ButtonPressTimerAction = false;
   
      }
  }
}

void enqueueMessage(const char* topic, const char* payload){
  MqttMessage msg(topic, payload);
  // Repeated here to reduce function call overhead.
  if (xQueueSend( mqttQueue, ( void * ) &msg, ( TickType_t ) 0 ) == pdPASS){
    Serial.println("MQTT ENQUEUE SUCCESS");
    return;
  }

  Serial.println("MQTT ENQUEUE FAIL");
}
void enqueueMessage(const MqttMessage&  msg){
  xQueueSend( mqttQueue, ( void * )&msg, ( TickType_t ) 0 );
}

// KeepAlive MQTT
void mqtt_loop_task(void *pvParameter){
  //wifiscan();
  //Should be RTOS
//  if(strcmp(ssideeprom, "ssid") == 0  && strcmp(pwdeeprom, "pw123456789") == 0) {  
//    dummyAPmode();
//    APmode();
//  }
//  Wifisetup();

  
  int numTries = 0;
  while(1){
//      log_d("Loop called");
      if (WiFi.getMode() == WIFI_STA){
        if (client.state()== 0 && client.loop()){
  //        log_d("Loop succeeded");
          numTries = 0;
          if(difftime(time(NULL), mqtttime) >= 600.0){ //Send ping every 10 minutes
            enqueueMessage("out/devices/240AC4110540/1/Notification/Ping", "1");
            mqtttime = time(NULL);
          }
        } else {
          log_d("Attempting to re-establish connection");
          log_d("Loop FAILED");
          client.disconnect();
            WiFi.disconnect();
            // Might cause watchdog issue
            Wifisetup();
  //        if (++numTries <= 10){
  //          log_d("Attempting to re-establish connection");
  //          client.disconnect();
  //          WiFi.disconnect();
  //          // Might cause watchdog issue
  //          Wifisetup();
  //          if (numTries == 10) wifitime = time(NULL);
  //        } else {
  //          log_d("10 retries exceeded. Will wait 10 minutes.");
  //          if(difftime(time(NULL), wifitime) >= 600.0) { // will try to reconnect to Wi-Fi after ten minutes if connection failed
  //            #ifdef DEBUG
  //            Serial.println("10 minutes have passed since initial disconnect.");
  //            Serial.println("Reconnecting!");
  //            #endif
  //           client.disconnect();
  //            WiFi.disconnect();
  //            reconnected = false;
  //            Wifisetup();
  //          }
          // }
          
        }
      }
     delay(500); 
    }
}

// Done in its own task so network I/O does not block
void mqtt_publish_task(void *pvParameter){
  while(1){
//    Serial.println("MQTT START WHILE");
    MqttMessage msg;
    if( client.state() == 0 && xQueueReceive( mqttQueue, &( msg ), ( TickType_t ) 5000 ) ) {
      Serial.println("MQTT Message Dequeued");
      #ifdef DEBUG
      Serial.print("Topic: ");
      Serial.println(msg.topic);
      Serial.print("Payload: ");
      Serial.println(msg.payload);
      #endif
      if (client.publish(msg.topic, msg.payload)){
        Serial.println("MQTT Task: Successfully published message");
        continue;
      } else {
        log_d("CLIENT NOOOOOOO");
      }

      Serial.println("MQTT Task: Failed to publish message");
    } else if (client.state() != 0){
      delay(5000);
    }
  }
}

void loop() { 
 
//Begin two main tasks for weight measurement and reporting and communication
    
    xTaskCreate(&a_task, "a_task", 4096, NULL, 5, NULL);  //Create Task A              //Details:  http://web.ist.utl.pt/~ist11993/FRTOS-API/group___task_ctrl.html
    xTaskCreate(&b_task, "b_task", 4096, NULL, 5, NULL);  //Create Task B
    //These tasks are created and never end in this application
    printf("A and B Tasks Initialized\n");
    delay (500); //Small delay so the tasks can be initialized before the locked main loop begins, improves read stability with battery sensor reading
    
    xTaskCreate(&mqtt_loop_task, "mqtt_loop_task", 4096, NULL, 5, NULL);  //Create MQTT Loop Keep Alive Task 
    xTaskCreate(&mqtt_publish_task, "mqtt_publish_task", 4096, NULL, 5, NULL);  //Create MQTT Publish Queue Task 
    

    //A third task (separate from Tasks A and B), handle your WiFI and basic MQTT checking in this loop
    while (1)                                                         //Just loop after first run, treat this as a main() function rather than a loop
    {
//     //semiphore lockout updating EEPROM from this and the other tasks
//      // if client loses connection, this will try to reconnect
//      // additionally, it calls a loop function which checks to see if 
//      // there's an available update in the mqtt server
//      if(WiFi.status() != WL_CONNECTED) {
//        WiFiconnectionactive = false;
//        if(!reconnected) {
//          #ifdef DEBUG
//          Serial.println("The device has been disconnected from Wi-Fi!");
//          Serial.println("Will try to reconnect in 10 minutes.");
//          #endif
//          reconnected = true;
//          wifitime = time(NULL);      
//        } else if(difftime(time(NULL), wifitime) >= 600.0) { // will try to reconnect to Wi-Fi after ten minutes if connection failed
//          #ifdef DEBUG
//          Serial.println("10 minutes have passed since initial disconnect.");
//          Serial.println("Reconnecting!");
//          #endif
//          reconnected = false;
//          Wifisetup();
//        }
//      }
    //  if(!client.connected()) 
    //  {
    ////    Serial.println("!!!!!!!!!!");
    //    clientconnectionactive = false; //set semiphore to false for connection
    ////    client.disconnect();
    ////    WiFi.disconnect();
    //  }
  
    }

    /*
    // NEVER REACHES
    ////////////////////////////
    if (relayEnable == 0){
       // #ifdef DEBUG
       
        Serial.println("These are now the values for the relays.");
        Serial.println(digitalRead(relay1));
        Serial.println(digitalRead(relay2));  
        //#endif
        digitalWrite(relayenable, LOW);
        digitalWrite(relay1, HIGH);
        digitalWrite(relay2, HIGH);
        delay(1000);
        digitalWrite(relayenable, HIGH);
        
       // delay(1000);
       // Serial.print("Active Power: ");
       // Serial.println(myADE7953.getInstActivePowerA());
    
        
        //charge.watttime = true;
        //charge.chargeCounter = 0;
        //charge.ADemandCharge = 0.0;
      //  Wt = time(NULL);
      ledcWrite(0, (pwmDutyCycleLookup(requestedCurrentinAMPS)*((int)(pow(2.0, (double)pilotresolution)) - 1)));
 
     Serial.println("DUTY");
     Serial.print(((pwmDutyCycleLookup(requestedCurrentinAMPS))));
      
      relayEnable = 1;

      
  }
  */
}
