#include <WiFi.h>
#include <PubSubClient.h>
#include <Time.h>
#include <driver/adc.h>
#include <ADE7953ESP32.h>
#include "esp32-hal-spi.h"
#include <SPI.h>
#include "esp32-hal-adc.h"
#include <string.h>
#include <DNSServer.h>

const byte DNS_PORT = 53;
IPAddress apIP(192, 168, 10, 10);
DNSServer dnsServer;
WiFiServer server(80);

char linebuf[150];
int charcount=0;

char ssid[30] = "";
char pssw[30] = "";
char mqttserver[30] = "";
char port[30] = "";
char username[30] = "";
char mqttpssw[30] = "";


String responseHTML = ""
  "<!DOCTYPE html><html><head><title>CaptivePortal</title></head><body>"
  "<h1>CalPlug Circuit Banditos</h1><p>Welcome to the Smart Charger portal.\n"
  "Please enter your Wi-Fi credentials here.</p></body></html>";

String internetsetup = ""
  "<form>"
  "SSID:<br>"
  "<input type=\"text\" name=\"SSID\"><br>"
  "Password:<br>"
  "<input type=\"text\" name=\"PSSW\"><br>"
  "MQTT Server:<br>"
  "<input type=\"text\" name=\"MQTTServe\" value=\"m11.cloudmqtt.com\"><br>"
  "MQTT Port:<br>"
  "<input type=\"text\" name=\"PORT\" value=\"19355\"><br>"
  "MQTT User Name:<br>"
  "<input type=\"text\" name=\"USRNM\" value=\"dqgzckqa\"><br>"
  "MQTT Password:<br>"
  "<input type=\"text\" name=\"MQTTPSSW\" value=\"YKyAdXHO9WQw\"><br>"
  "<input type=\"Submit\" value=\"Submit\">"
  "</form>";

#define DEBUG
#define SCHOOLWIFI
//#define UCIWIFI
//#define PILOT

// ADE7953 SPI functions 
#define local_SPI_freq 1000000  //Set SPI_Freq at 1MHz (#define, (no = or ;) helps to save memory)
#define local_SS 14  //Set the SS pin for SPI communication as pin 5  (#define, (no = or ;) helps to save memory)
ADE7953 myADE7953(local_SS, local_SPI_freq);


// variables for the button interface
bool buttonIsPressed = false;
int numPressed = 0;
bool timeStarted;
unsigned long  lastDebounceTime = 0;
unsigned long debounceDelay = 300;

// timer variables to keep track of the passage of time
time_t t;  // button presses are tracked for 5 seconds
time_t Wt; // wattmeter checks every 10 seconds
time_t Rp; // pilot averages readings every 1/10 second
time_t wifitime; // disconnected esp32 module reconnects every 10 minutes
time_t gfifailure;

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
/* Connection parameters */
#ifdef UCIWIFI
const char * networkName = "UCInet Mobile Access";
const char * networkPswd = "";
#endif
#ifdef SCHOOLWIFI
const char * networkName = "microsemi";
const char * networkPswd = "microsemicalit212345";
#endif

const char * mqtt_server = "m11.cloudmqtt.com";
int mqttPort = 19355;
const char * mqttUser = "dqgzckqa";
const char * mqttPassword = "YKyAdXHO9WQw";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;


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

// main struct to hold important variables
ChargeState charge;

// parmeters used for PWM output to the LED 
int freq = 1;
int resolution = 10;

// variables to keep track of the data line on ADC
int average = 0;
int counter = 0;

// global variable to track that the Wi-Fi module has disconnected
bool reconnected;

void setup() {

  reconnected = false;
  charge.wifiname = NULL;
  charge.wifipassword = NULL;
  charge.mqttuser = NULL;
  charge.mqttpassword = NULL;
  charge.mqttserver = NULL;
  charge.mqttport = 0;
  
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
  delay(1000);
  digitalWrite(relayenable, HIGH); // turn off relay enable pin

  // ADE reset pin needs to be disabled to initiate SPI communication
  pinMode(12, OUTPUT);
  digitalWrite(12, LOW);
  digitalWrite(12, HIGH); // this is the reset enable pin for the ADE

  
  charge.groundfail = false;
  #ifdef DEBUG
  Serial.println("Hello! We are on!");
  #endif  
  
  pinMode(GFIin, INPUT); // GFIin 
  
  
  pinMode(35, INPUT); //request from Andy to not modify

  // initializes the PWM signals on the leds 
  // can be modified to represent a state in the charger
  ledcAttachPin(LED_PIN_BLUE, 1);
  ledcSetup(1, freq, resolution);
  #ifdef DEBUG
  Serial.println("Blue pin initialized");
  #endif  
  
  ledcAttachPin(LED_PIN_RED, 2);
  ledcSetup(2, freq, resolution);
  #ifdef DEBUG
  Serial.println("Red pin initialized");
  #endif  

  ledcAttachPin(LED_PIN_GREEN, 3);
  ledcSetup(3, freq, resolution);
  #ifdef DEBUG
  Serial.println("Green pin initialized");
  #endif  

  // this function is related to the PWM signal output coming from the charger.
  // the duty cycle on this pin represents the amount of charge going into the EV.
  ledcAttachPin(dutyout, 4);
  ledcSetup(4, 1000, resolution);
  #ifdef DEBUG
  Serial.println("PWM signal created");
  #endif  

  ledcWrite(2, 500);
  
  // Analog to Digital Converter setup
  // ADC1_CHANNEL_0 uses GPIO36 to read the input for the ADC
  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_3, ADC_ATTEN_DB_11);
  #ifdef DEBUG
  Serial.println("ADC Pin initialized");
  #endif
  delay(500);

  //button functionality
  pinMode(buttonPin, INPUT);
  attachInterrupt(digitalPinToInterrupt(buttonPin), ButtonPressed, HIGH);
  buttonIsPressed = false;
  timeStarted = false;

  attachInterrupt(digitalPinToInterrupt(GFIin), GFIinterrupt, FALLING);  
  delay(500);  

  // establishes the SPI bus on the ESP32 to communicate with the ADE7953
  SPI.begin();
  delay(200);
  myADE7953.initialize();

  #ifdef DEBUG
  Serial.println("ADE initialized");
  #endif

  // the multiplex line shifts the input going into the ADE 
  // this allows us to measure each line through the ADE
  pinMode(multiplex, OUTPUT);
  digitalWrite(multiplex, LOW); // line 2
  delay(1000);
  GFItestinterrupt();
  LevelDetection();
  
  charge.state = 'A'; 
  charge.load_on = true;
  charge.statechange = false;
  charge.chargerate = 27;
  charge.pilotreadError = false;
  charge.pilotError = false;   
  charge.diodecheck = false; 

  // Watt meter values
  charge.ADemandCharge = 0.0;
  charge.ADemandTotal = 0.0;
  charge.watttime = false;
  charge.chargeCounter = 0;
  charge.totalCounter = 0;
    
  // The following are for debugging and need to be modified later!
  charge.lvlfail = false;
  charge.lv_1 = true;
  
  if(charge.GFIfail || charge.lvlfail || charge.groundfail) {
    ledcWrite(1, 0);
    ledcWrite(2, 500);
    ledcWrite(3, 0);    
    int value = map(charge.chargerate, 0, 100, 0, 1023);
    ledcWrite(4, value);      
  } else {
    ledcWrite(1, 0);
    ledcWrite(2, 0);
    ledcWrite(3, 500);    
    int value = map(charge.chargerate, 0, 100, 0, 1023);
    ledcWrite(4, value);    
  }
  wifiscan();
  Wifisetup();
  Rp = time(NULL);
  gfifailure = time(NULL);
  
}

void dummyAPmode(void) {
  client.disconnect();
  WiFi.disconnect();
  ledcWrite(1, 500);
  ledcWrite(2, 500);
  ledcWrite(3, 500);  
  digitalWrite(relayenable, LOW);
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);
  delay(100);
  digitalWrite(relayenable, HIGH);
  APsetupdummy();
}

void APmode(void) {
  client.disconnect();
  WiFi.disconnect();
  ledcWrite(1, 500);
  ledcWrite(2, 500);
  ledcWrite(3, 500);  
  digitalWrite(relayenable, LOW);
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);
  delay(100);
  digitalWrite(relayenable, HIGH);
  APsetup();
  Wifisetup();
}

void APsetupdummy(void) {
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0));
  WiFi.softAP("Smart Charger");
  #ifdef DEBUG
  Serial.println("Server initialized!");
  #endif
  dnsServer.start(DNS_PORT, "*", apIP);  
  server.begin();
  bool clientcomplete = false;
  time_t servertimedout;
  servertimedout = time(NULL);
  while(!clientcomplete) {
    dnsServer.processNextRequest();
    WiFiClient client = server.available();   // listen for incoming clients
    if(difftime(time(NULL), servertimedout) >= 10.0)
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

void APsetup(void) {
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(apIP, apIP, IPAddress(255, 255, 255, 0));
  WiFi.softAP("Smart Charger");
  #ifdef DEBUG
  Serial.println("Server initialized!");
  #endif
  dnsServer.start(DNS_PORT, "*", apIP);  
  server.begin();
  bool clientcomplete = false;
  time_t servertimedout;
  servertimedout = time(NULL);
  while(!clientcomplete) {
    dnsServer.processNextRequest();
    WiFiClient client = server.available();   // listen for incoming clients
    if(difftime(time(NULL), servertimedout) >= 120.0)
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
// untested
void readstring(int offset, char buff[], char dest[]) {
  for(int i = offset; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      dest[i - offset] = ' ';
      continue;
    }
    ssid[i - offset] = buff[i];
  }
}

void SaveCredentials(void) {

//  readstring(5, buff, ssid);
//  strcpy(buff, p2);
//  readstring(5, buff, pssw);
//  strcpy(buff, p3);
//  readstring(10, buff, mqttserver);
//  strcpy(buff, p4);
//  readstring(5, buff, port);
//  strcpy(buff, p5);
//  readstring(6, buff, username);
//  strcpy(buff, p6);
//  readstring(9, buff, mqttpssw);
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
  char buff[130];  
  strcpy(buff, p1);  
  unsigned int stringsize = (unsigned)strlen(linebuf);
  //Serial.println(stringsize);
  for(int i = 5; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      ssid[i - 5] = ' ';
      continue;
    }
      
    ssid[i - 5] = buff[i];
  }
  strcpy(buff, p2);  
  for(int i = 5; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      pssw[i - 5] = ' ';
      continue;
    }
    pssw[i - 5] = buff[i];
  }
  
  strcpy(buff, p3);  
  for(int i = 10; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      mqttserver[i - 10] = ' ';
      continue;
    }
    mqttserver[i - 10] = buff[i];
  }
  strcpy(buff, p4);  
  for(int i = 5; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      port[i - 5] = ' ';
      continue;
    }
    port[i - 5] = buff[i];
  }
  strcpy(buff, p5);  
  for(int i = 6; buff[i] != '&'; i++) {
    if(buff[i] == '+') {
      username[i - 6] = ' ';
      continue;
    }
    username[i - 6] = buff[i];
  }
  delay(100);
  strcpy(buff, p6);  
  for(int i = 9; buff[i] != ' '; i++) {
    if(buff[i] == '+') {
      mqttpssw[i - 9] = ' ';
      continue;
    }
    mqttpssw[i - 9] = buff[i];
  }

  #ifdef DEBUG
  Serial.println(ssid);
  Serial.println(pssw);
  Serial.println(mqttserver);
  Serial.println(port);
  Serial.println(username);
  Serial.println(mqttpssw);
  #endif  
  networkName = ssid;
  networkPswd = pssw;
  mqtt_server = mqttserver;
  mqttPort = atoi(port);
  mqttUser = username;
  mqttPassword = mqttpssw;
}

void Wifisetup(void) {
  WiFi.mode(WIFI_STA);
  if(connectToWiFi(networkName, networkPswd)) {
    client.setServer(mqtt_server, mqttPort);
    client.setCallback(callback);
    int timeout = 0;
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
        if(timeout > 5) {
          #ifdef DEBUG
          Serial.println("MQTT connection failed.");
          #endif
          client.disconnect();
          WiFi.disconnect();
          return;
        }
        timeout++;
        
      }
  
      topicsSubscription();
      
    }
  }
}

void topicsSubscription(void) {
  client.publish("esp/test", "Hello from ESP32!");
  client.subscribe("esp/test");
  client.subscribe("test1");
  client.subscribe("switchmux");
  client.subscribe("devicename");

  // Energy monitoring topics
  client.subscribe("in/devices/1/OnOff/OnOff");
  client.subscribe("in/devices/1/SimpleMeteringServer/CurrentSummation/Delivered");
  client.subscribe("in/devices/1/SimpleMeteringServer/InstantaneousDemand");
  client.subscribe("in/devices/1/SimpleMeteringServer/RmsCurrent");
  client.subscribe("in/devices/1/SimpleMeteringServer/Voltage");
  client.subscribe("in/devices/");

  //load control
  client.subscribe("in/devices/1/OnOff/Toggle");
  client.subscribe("in/devices/1/OnOff/On");
  client.subscribe("in/devices/1/OnOff/Off");

  //factory reset
  client.subscribe("in/devices/0/cdo/reset");
  client.subscribe("Reconnect");
  // Mike functions
  
  client.subscribe("in/devices/1/SimpleMeteringServer/GROUNDOK");
  client.subscribe("in/devices/1/SimpleMeteringServer/GeneralFault");
  client.subscribe("in/devices/1/SimpleMeteringServer/GFIState");
  client.subscribe("in/devices/1/SimpleMeteringServer/SUPLevel");
  client.subscribe("in/devices/1/SimpleMeteringServer/LVoltage");
  client.subscribe("in/devices/1/SimpleMeteringServer/RequestCurrent");
  client.subscribe("in/devices/1/SimpleMeteringServer/DeliveredCurrent");
  client.subscribe("in/devices/1/SimpleMeteringServer/ChargeState");
  client.subscribe("in/devices/1/SimpleMeteringServer/INSTCurrent");
  client.subscribe("in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge");
  client.subscribe("in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal");
}

void GFItestinterrupt(void) {

  float IrmsA, IrmsB;
  IrmsA = myADE7953.getIrmsA();
  IrmsB = myADE7953.getIrmsB();
  IrmsA = (IrmsA*12.6)-17.8;
  IrmsB = (IrmsB*12.3)+0.058;
  //Serial.println(IrmsA);
  //Serial.println(IrmsB);
  if(abs(IrmsA - IrmsB) <= 800) {
    charge.GFIfail = false;
    #ifdef DEBUG
    //Serial.println("GFI passed test");
    #endif
  } else {
    #ifdef DEBUG
    //Serial.println("GFI failed test");
    #endif
    charge.GFIfail = true;
    Serial.println("The relays should be modified.");
    digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid  
    digitalWrite(relay1, LOW);
    digitalWrite(relay2, LOW);  
    delay(1000);
    digitalWrite(relayenable, HIGH);
  }
  

//  float Irms1_off, Irms2_off;
//  float AP1_off, AP2_off;
//  uint16_t phase1_off, phase2_off;
//  Irms1_off = myADE7953.getIrmsA();
//  phase1_off = myADE7953.getPhaseCalibA();
//  AP1_off = myADE7953.getInstActivePowerA();
//  digitalWrite(multiplex, LOW);  // SECOND LINE
//  delay(500);
//  Irms2_off = myADE7953.getIrmsA();
//  phase2_off = myADE7953.getPhaseCalibA();
//  AP2_off = myADE7953.getInstActivePowerA();
//  
//  
//  #ifdef DEBUG
//  Serial.println("the relays are turned off");
//  Serial.print("Irms for line 1: ");
//  Serial.println(Irms1_off);
//  Serial.print("Phase for line 1: ");
//  Serial.println(phase1_off);
//  Serial.print("Irms for line 2: ");
//  Serial.println(Irms2_off);
//  Serial.print("Phase for line 2: ");
//  Serial.println(phase2_off);
//  Serial.print("active power for line 1: ");
//  Serial.println(AP1_off);
//  Serial.print("active power for line 2: ");
//  Serial.println(AP2_off);
//  #endif
//  delay(1000);
}
void(* resetFunc)(void) = 0;

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

void buttonCheck(void) {
  if(timeStarted == true && (difftime(time(NULL), t) >= 10.0)) {
    #ifdef DEBUG
    Serial.println("10 seconds have passed since initial button push.");
    Serial.print("The button was pressed ");
    Serial.println(numPressed);
    #endif
    if(numPressed >= 1 && numPressed < 6){
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
    else if (numPressed == 6) {
      charge.chargerate = 17;
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("The load has been changed to 10A");
      #endif
    }
    else if (numPressed == 7) {
      charge.chargerate = 33;
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("The load has been changed to 20A");
      #endif
    }
    else if (numPressed == 8) {
      charge.chargerate = 66;
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

void readPilot(void) {
 
  //int x = adc1_get_raw(ADC1_CHANNEL_3); 
  
  if(difftime(time(NULL), Rp) >= .1 && counter !=0){
    int high = 0;
    for(int i = 0; i < 1200; i++) {
      high = adc1_get_raw(ADC1_CHANNEL_3);
      average += high;
      
      delayMicroseconds(50);      
    } 
    average /= 1200;
    
    
    
    //average = average / counter; removed this D:
    #ifdef PILOT
    Serial.println();
    Serial.print("average without modifications: ");
    Serial.println(average);    
    #endif
    average = (average * 50) / charge.chargerate;
    #ifdef PILOT
    Serial.print("average with modification: ");    
    Serial.println(average);
    #endif
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
    
    if(abs(1192 - average) <= 40) {
      if(charge.state != 'A'){
        charge.state = 'A';
        charge.diodecheck = false;
      }
    }
    else if (abs(1065 - average) <= 35 ){
      if(charge.state != 'B') {        
        charge.state = 'B';
        charge.statechange = true;
        charge.diodecheck = false;
      } 
    } 
    else if(abs(785 - average) <= 100) {
      if(charge.state != 'C') {
        charge.state = 'C';
        charge.statechange = true;
        charge.diodecheck = false;
      }
    } else{
      if(charge.state != 'F'){
        charge.state = 'F';
        charge.statechange = true;
        charge.diodecheck = true;
      }
      
    }
    average = 0;
    counter = 0;
    Rp = time(NULL);    
  }
  //average +=x; // removed this! D:
  counter++;
  //actual readings
  

  // if the reading isn't within a given range tolerance of 90, the read will default to 
  // state nine, which signals that we're getting weird voltage values
  // Update: Apparently, you cannot read a negative voltage on Arduino. I'm 
  // sure it applies to ESP32 as well. The problem is that we need to read the 
  // duty cycle of the pin to determine the maximum charge rate of the car that 
  // it can accept. 
}

// this function tallys the amount of power for the current and total cycle
void timeWatts(void) {
  if(difftime(time(NULL), Wt) >= 10.0) {
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

void loop() { 
  // if client loses connection, this will try to reconnect
  // additionally, it calls a loop function which checks to see if 
  // there's an available update in the mqtt server
  if(WiFi.status() != WL_CONNECTED) {
    if(!reconnected) {
      #ifdef DEBUG
      Serial.println("The device has been disconnected from Wi-Fi!");
      Serial.println("Will try to reconnect in 10 minutes.");
      #endif
      reconnected = true;
      wifitime = time(NULL);      
    } else if(difftime(time(NULL), wifitime) >= 600.0) {      
      #ifdef DEBUG
      Serial.println("10 minutes have passed since initial disconnect.");
      Serial.println("Reconnecting!");
      #endif
      reconnected = false;
      Wifisetup();
    }
  }
  if(!client.connected()) {
    client.disconnect();
    WiFi.disconnect();
  }
  client.loop();
  if(charge.watttime) 
    timeWatts();
  
  buttonCheck();
  if(charge.GFIfail == false && charge.lvlfail == false) {
    readPilot();
    if(difftime(time(NULL), gfifailure) >= 5.0) {
      GFItestinterrupt();
      gfifailure = time(NULL);
    }

    if(charge.statechange) {
      switch (charge.state) {
        case 'A': {
          ledcWrite(3, 500);
          ledcWrite(2, 0);
          ledcWrite(1, 0);
          int value = map(charge.chargerate, 0, 100, 0, 1023); 
          ledcWrite(4, value);                  
          }
          charge.load_on = true;
          break;
        case 'B': {
          ledcWrite(3, 1023);
          ledcWrite(2, 0);
          ledcWrite(1, 0);
          int value = map(charge.chargerate, 0, 100, 0, 1023);
          ledcWrite(4, value);
          }
          break;
        case 'C': {
          ledcWrite(3, 1023);        
          ledcWrite(2, 0);
          int value = map(charge.chargerate, 0, 100, 0, 1023);
          ledcWrite(1, value);
          ledcWrite(4, value);
          }
          break;
        default:{
          ledcWrite(2, 200);
          ledcWrite(1, 0);
          ledcWrite(3, 0);
          int value = map(charge.chargerate, 0, 100, 0, 1023);
          ledcWrite(4, value);
          }
          break;
      }
      if(charge.state == 'C' && charge.load_on && !charge.watttime) {
        #ifdef DEBUG
        Serial.println("The charger is now in charging state! Turning on relays.");
        Serial.println("These are now the values for the relays.");
        Serial.println(digitalRead(relay1));
        Serial.println(digitalRead(relay2));  
        #endif
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
        #ifdef DEBUG
        Serial.println("Duty cycle has changed!");
        #endif
      }        
      else {
        #ifdef DEBUG 
        Serial.println("The state of the charger changed!");
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
        Serial.println("Relays are now off.");
        #endif
        charge.watttime = false;
        digitalWrite(relayenable, LOW);
        digitalWrite(relay1, LOW);
        digitalWrite(relay2, LOW);
        delay(100);
        digitalWrite(relayenable, HIGH);
      }
      charge.statechange = false;
    }
  }
}

void ButtonPressed(void) {
  if(!buttonIsPressed){
    lastDebounceTime = millis();
    buttonIsPressed = true;
    numPressed++;
    #ifdef DEBUG
    Serial.println("Button pressed!");
    #endif
    if(timeStarted == false) {
      timeStarted = true;
      t = time(NULL);      
      #ifdef DEBUG
      Serial.println("Timer has started!");
      #endif
    }
  }
}

void LevelDetection(void) 
{
//  
//  unsigned long testvalue = 0.0;
//  unsigned long testvalue2 = 0.0;   
//  bool test1 = false;
//  bool test2 = false;
//  
//  digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid
//  pinMode(relay1, OUTPUT);
//  digitalWrite(relay1, HIGH);
//  pinMode(relay2, OUTPUT);
//  digitalWrite(relay2, HIGH);
//  delay(1000);
//  digitalWrite(relayenable, HIGH);
//  Serial.println("Testing values for level detection. relays are on");  
//  for(int i = 0; i < 40; i++) {
//    digitalWrite(multiplex, HIGH);
//    delay(100);
//    Serial.println("Multiplex is high (Line 1)");
//    Serial.print("Vrms: ");
//    Serial.println(myADE7953.getVrms());
//    Serial.println("Active power: ");
//    Serial.println(myADE7953.getInstActivePowerA());
//    delay(1000);
//    digitalWrite(multiplex, LOW);
//    delay(100);
//    Serial.println("Multiplex is low (Line 2)");
//    Serial.print("Vrms: ");
//    Serial.println(myADE7953.getVrms());
//    Serial.println("Active power: ");
//    Serial.println(myADE7953.getInstActivePowerA());
//    delay(1000);
//
//  }
//  digitalWrite(multiplex, HIGH); // line 1
//  delay(500);
//  float AP1, AP2;
//  testvalue = myADE7953.getVrms();
//  AP1 = myADE7953.getInstActivePowerA();
//  digitalWrite(multiplex, LOW); // line 2
//  delay(500);
//  testvalue2 = myADE7953.getVrms();
//  AP2 = myADE7953.getInstActivePowerA();
//  Serial.print("active power for line 1: ");
//  Serial.println(AP1);
//  Serial.print("active power for line 2: ");
//  Serial.println(AP2);
//  Serial.print("VRMS for line 1: ");
//  Serial.println(testvalue);
//  Serial.print("active power for line 2: ");
//  Serial.println(testvalue2);
//
//  digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid
//  pinMode(relay1, OUTPUT);
//  digitalWrite(relay1, LOW);
//  pinMode(relay2, OUTPUT);
//  digitalWrite(relay2, LOW);
//  delay(1000);
//  digitalWrite(relayenable, HIGH);
//  Serial.println("Testing values for level detection. relays are off");  
//  digitalWrite(multiplex, HIGH); // line 1
//  delay(500);
//  testvalue = myADE7953.getVrms();
//  AP1 = myADE7953.getInstActivePowerA();
//  digitalWrite(multiplex, LOW); // line 2
//  delay(500);
//  testvalue2 = myADE7953.getVrms();
//  AP2 = myADE7953.getInstActivePowerA();
//  Serial.print("active power for line 1: ");
//  Serial.println(AP1);
//  Serial.print("active power for line 2: ");
//  Serial.println(AP2);
//  Serial.print("VRMS for line 1: ");
//  Serial.println(testvalue);
//  Serial.print("VRMS power for line 2: ");
//  Serial.println(testvalue2);
  unsigned long testvalue = 0.0;
  unsigned long testvalue2 = 0.0;   
  bool test1 = false;
  bool test2 = false;
  #ifdef DEBUG
  Serial.println("Hi this is the VRMS for multiplex LOW:");
  Serial.println(myADE7953.getVrms());  
  #endif
  for(int i = 0; i < 150; i++){ 
    testvalue += myADE7953.getVrms();    
  } 
  testvalue = testvalue / 150.0;
  digitalWrite(multiplex, HIGH);  
  delay(500);
  #ifdef DEBUG
  Serial.println("Hi this is the VRMS for multiplex HIGH:");
  Serial.println(myADE7953.getVrms());
  #endif
  for(int i = 0; i < 150; i++){ 
    testvalue2 += myADE7953.getVrms();    
  } 
  testvalue2 = testvalue2 / 150.0;

  char buffer[50];
  
  char *p1 = dtostrf(testvalue, 10, 6, buffer);
  #ifdef DEBUG
  Serial.print("testvalue voltage average reading: ");
  Serial.println(p1);
  char *p2 = dtostrf(testvalue2, 10, 6, buffer);
  Serial.print("testvalue2 voltage average reading: ");
  Serial.println(p2);
  #endif
  bool test1high = false;
  bool test1low = false;
  if(testvalue > 115.00 && testvalue < 125.00) {
    test1 = true;
    #ifdef DEBUG
    Serial.println("L1 voltage reading is within valid range for on.");
    #endif
  } else if(testvalue >= 0.0 && testvalue < 10.0) {
    #ifdef DEBUG
    Serial.println("L1 voltage reading is within valid range for off.");
    #endif
  } else if(testvalue > 125) {
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
  if(testvalue2 > 115.00 && testvalue2 < 125.00) {
    test2 = true;
    #ifdef DEBUG
    Serial.println("L2 voltage reading is within valid range for on.");
    #endif
  } else if(testvalue2 >= 0.0 && testvalue2 < 10.0) {    
    #ifdef DEBUG
    Serial.println("L2 voltage reading is within valid range for off.");
    #endif
  } else if(testvalue2 > 125) {    
    #ifdef DEBUG
    Serial.println("L2 voltage reading is too high.");    
    Serial.println("L2 voltage is a fail");
    #endif
    test2high = true;
    charge.lvlfail = true;
  } else {    
    #ifdef DEBUG
    Serial.println("L2 voltage is in between 10 and 115 V. It's too low for valid voltage");
    Serial.println("L2 voltage is a fail.");
    #endif
    test2low = true;
    charge.lvlfail = true;
  } 
 
  if(test1 && test2) {
    charge.lv_2 = true;    
    #ifdef DEBUG
    Serial.println("Lv 2 voltage set for charger.");    
    #endif
  } else if(test1 && !test2) {
    #ifdef DEBUG
    Serial.println("Lv 1 voltage set for charger.");    
    #endif
    charge.lv_1 = true;
  } else if(!test1 && test2) {
    #ifdef DEBUG
    Serial.println("Voltage is detected but they are backwards. Charger failed test.");    
    #endif    
    charge.lvlfail = true;
  } else {
    charge.lvlfail = true;
    charge.groundfail = true;
    #ifdef DEBUG
    Serial.println("Charge level detection has failed. GROUNDOK test failed.");
    #endif
  }
}

void GFIinterrupt(void)
{
  digitalWrite(relayenable, LOW);
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);  
  delay(1000);
  digitalWrite(relayenable, HIGH);
  charge.load_on = false;
  charge.GFIfail = true;
  
  ledcWrite(3, 500);
  ledcWrite(2, 200);
  ledcWrite(1, 700);
  int value = map(charge.chargerate, 0, 100, 0, 1023);
  ledcWrite(4, value);
  Serial.println("The unit has encountered an interrupt from the ground fault interface!");
  Serial.println("The load has been shut off permanently.");
  Serial.println("Device needs to be reset to be functional again!");
  Serial.println("MQTT connection is still operational to communicate with server");
  Serial.println("and the device can be reset by pushing the button 11 times.");  
  
}

bool connectToWiFi(const char * ssid, const char * pwd) 
{
  printLine();
  #ifdef DEBUG
  Serial.println("Connecting to WiFi network: " + String(ssid));
  #endif
  WiFi.begin(ssid, pwd);  
  int timeout = 0;
  while(WiFi.status() != WL_CONNECTED)
  {    
    delay(500);
    #ifdef DEBUG
    Serial.print(".");  
    #endif
    if(timeout >= 60) {
      #ifdef DEBUG
      Serial.println("Wi-Fi connection timeout.");
      Serial.println("Disconnecting!");
      #endif
      WiFi.disconnect();
      return false;
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

void callback(char * topic, byte* payload, unsigned int length) {
  #ifdef DEBUG
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.println("] ");
  #endif
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
  if(strcmp(topic, "in/devices/1/OnOff/OnOff") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG 
    Serial.println("Device received OnOff message from broker!");
    #endif
    if(charge.state == 'C' && charge.load_on == true) {
      #ifdef DEBUG
      Serial.println("Device is on! Sending status to broker!");
      #endif
      client.publish("out/devices/1/OnOff/OnOff", "1");
    } else {
      #ifdef DEBUG
      Serial.println("Device is off! Sending status to broker!");
      #endif
      client.publish("out/devices/1/OnOff/OnOff", "0");
    }
  }
  else if(strcmp(topic, "Reconnect") == 0) {
    Wifisetup();    
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/GeneralFault") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Obtained request to check status of GFI in charger.");
    #endif
    if(str[36] != '0') {      
      if(charge.GFIfail) {
        #ifdef DEBUG
        Serial.println("Failure with GFI. Sending data to server.");
        #endif
        client.publish("out/devices/1/SimpleMeteringServer/GeneralFault", "1");        
      } 
      if(charge.lvlfail) {
        #ifdef DEBUG
        Serial.println("Failure with level detection. Sending data to server.");
        #endif
        client.publish("out/devices/1/SimpleMeteringServer/GeneralFault", "2");
      }
      if(charge.diodecheck){
        #ifdef DEBUG
        Serial.println("Failure with pilot read. Sending data to server.");
        #endif
        client.publish("out/devices/1/SimpleMeteringServer/GeneralFault", "4");
      }
      if(charge.groundfail) {
        #ifdef DEBUG
        Serial.println("Ground test failed. Sending data to server.");
        #endif
        client.publish("out/devices/1/SimpleMeteringServer/GeneralFault", "3");
      }
      if(!charge.GFIfail && !charge.lvlfail) {        
        #ifdef DEBUG
        Serial.println("No fault is in place. Sending results to server.");
        #endif
        client.publish("out/devices/1/SimpleMeteringServer/GeneralFault", "0"); 
      }
    } else {
      #ifdef DEBUG
      Serial.println("Request for recovery obtained.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/GeneralFault", "0");
    }   
  }
  // checks status of ground and wiring
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/GROUNDOK") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Request for ground check receieved.");
    #endif
    if(charge.groundfail) {
      #ifdef DEBUG
      Serial.println("The device failed the ground check. Sending status to broker..");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/GROUNDOK", "0");   
    } else {
      #ifdef DEBUG 
      Serial.println("The device passed the ground check. Sending status to broker..");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/GROUNDOK", "1");   
    }
  }
  // checks to see if either in level 1 or level 2 charging
  // returns error otherwise
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/SUPLevel") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("SUPLevel request! Checking status...");
    #endif
    if(charge.lv_1 == true && charge.lv_2 == false) {
      #ifdef DEBUG
      Serial.println("The device is in level one charge. Sending status to broker...");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/SUPLevel", "1");
    } else if (charge.lv_1 == false && charge.lv_2 == true) {
      #ifdef DEBUG
      Serial.println("The device is in level two charge. Sending status to broker...");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/SUPLevel", "2");
    } else {
      #ifdef DEBUG 
      Serial.println("The device has not determined level charging. Returning ERROR. Please reboot");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/SUPLevel", "0");
    }
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/GFIState") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Obtained request for GFIState!");
    #endif
    if(charge.GFIfail) {
      #ifdef DEBUG
      Serial.println("There is a failure in the device. Sending back data to server.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/GFIState", "0");      
    } else {
      #ifdef DEBUG
      Serial.println("Device is ok! Sending status to server.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/GFIState", "1");
    }
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/LVoltage") == 0) {
    if(strcmp(dest, "{\"method\":\"get\",\"params\":{\"value\":\"L1\"}}") == 0) {
      client.publish("out/devices/1/SimpleMeteringServer/LVoltage", "I dunno");
    } 
    else if (strcmp(dest, "{\"method\":\"get\",\"params\":{\"value\":\"L2\"}}") == 0) {
      client.publish("out/devices/1/SimpleMeteringServer/LVoltage", "I dunno");
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
    
    
    iRMSA = (iRMSA*13.634)-19.4219;
    
    Serial.print("Function value iRMSA: ");
    Serial.println(iRMSA);

    iRMSB = (iRMSB*12.669)+0.06514;
    
    Serial.print("Function value iRMSB: ");
    Serial.println(iRMSB);

    if(digitalRead(multiplex) == HIGH) {
      
      vRMS = (vRMS * 1.24) -51.8;
      Serial.print("Function value for level2 vRMS: ");
      Serial.println(vRMS);
      activePowerA = vRMS*iRMSA;
      Serial.print("Actual Active Power (mW): ");
      Serial.println(activePowerA);
    } else {
      
      vRMS = (vRMS*0.818)-2.32;
      Serial.print("Function value for level1 vRMS: ");
      Serial.println(vRMS);
      activePowerA = vRMS*iRMSA;
      Serial.print("Actual Active Power (mW): ");
      Serial.println(activePowerA);
    }
    
  }
  // instantaneous supplied current
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/INSTCurrent") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    long instcurrent = 0.0;
    #ifdef DEBUG
    Serial.println("Received request for instantaneous supplied current.");    
    Serial.println("Verifying that instcurrent is 0.0: ");
    Serial.println(instcurrent);
    #endif

    char buffer[50];
    instcurrent = myADE7953.getInstCurrentA();
    #ifdef DEBUG
    Serial.print("Value obtained from ADE is: ");
    Serial.println(instcurrent);
    #endif
    char *p1 = dtostrf(instcurrent, 10, 2, buffer);
    client.publish("out/devices/1/SimpleMeteringServer/INSTCurrent", p1);
  }
  // set charging current to be supplied
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/RequestCurrent") == 0) {
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

    if(rate >= 6 && rate <= 40) {      
      charge.chargerate = rate / .6;      
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("The value provided is valid and will be used to adjust car charge settings.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/RequestCurrent", "1");
    } else {
      #ifdef DEBUG
      Serial.println("The value provided is invalid. Disregarding the new charge rate.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/RequestCurrent", "0");
    }
  }
  // delivered current to be supplied
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/RmsCurrent") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Request obtained for current charging rate using new format.");
    #endif
    char charbuf[20];
    itoa(charge.chargerate, charbuf, 10);
    client.publish("out/devices/1/SimpleMeteringServer/DeliveredCurrent", charbuf); 
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/ChargeState") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("ChargeState request accepted! Checking status...");
    #endif
    if(charge.state == 'C') {
      #ifdef DEBUG 
      Serial.println("Charger is currently charging and connected! (C)");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/ChargeState", "1");
    } else if(charge.state == 'B') {
      #ifdef DEBUG 
      Serial.println("Charger is currently connected but not charging! (B)");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/ChargeState", "2");
    } else if(charge.state == 'A') {
      #ifdef DEBUG 
      Serial.println("Charger is not connected! (A)");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/ChargeState", "3");
    } else {
      #ifdef DEBUG 
      Serial.println("Diode check failed! (F)");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/ChargeState", "0");
    }    
  }  
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/InstantaneousDemand") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {    
        
    float instActive = 0.12;
    #ifdef DEBUG
    Serial.println("Received request for instantaneous demand.");    
    Serial.println("Verifying that instActive is 0.12 for test purposes: ");
    Serial.println(instActive);
    #endif
    char buffer[50];
    instActive = myADE7953.getInstActivePowerA();
    char *p1 = dtostrf(instActive, 10, 6, buffer);        
    client.publish("out/devices/1/SimpleMeteringServer/InstantaneousDemand", p1);
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    
    #ifdef DEBUG
    Serial.println("Received request for AccumulatedDemandCharge");
    
    #endif
    double kWh = 0.0;
    kWh = (charge.ADemandCharge * (10.0 * (float)charge.chargeCounter)) / (3600000000.00);
    char buffer[50];
    char *p1 = dtostrf(kWh, 10, 6, buffer);
    client.publish("out/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge", p1);
  }
  else if(strcmp (topic, "in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal") == 0 && strcmp(dest, "{\"method\":\"get\",\"params\":{}}") == 0) {
    #ifdef DEBUG
    Serial.println("Received request for AccumulatedDemandTotal");
    #endif
    double kWh = 0.0;
    kWh = (charge.ADemandTotal * (10.0 * (float)charge.totalCounter)) / (3600000000.00);
    char buffer[50];
    char *p1 = dtostrf(kWh, 10, 2, buffer);
    client.publish("out/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal", p1);
  }
  else if(strcmp (topic, "in/devices/1/OnOff/Toggle") == 0 && strcmp(dest, "{\"method\":\"post\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Received request to toggle load");
    #endif
    if(charge.lvlfail == false && charge.groundfail == false && charge.GFIfail == false) {
      if(charge.load_on) {
        #ifdef DEBUG
        Serial.println("Load is now off.");
        #endif
        charge.load_on = false;
        client.publish("out/devices/1/OnOff/Toggle", "0");
      } 
      else {
        #ifdef DEBUG
        Serial.println("Load is turned on.");
        #endif
        charge.load_on = true;
        client.publish("out/devices/1/OnOff/Toggle", "0");
      } 
    }
    else {
      #ifdef DEBUG 
      Serial.println("relays cannot be toggled safely because safety checks failed");
      #endif
      client.publish("out/devices/1/OnOff/Toggle", "2");
    }
  }
  else if(strcmp (topic, "in/devices/1/OnOff/On") == 0 && strcmp(dest, "{\"method\":\"post\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Device has received request to turn on relays.");
    #endif
    if(charge.state != 'B') {
      #ifdef DEBUG 
      Serial.println("Device is not in correct state to turn on relays.");
      #endif
      client.publish("out/devices/1/OnOff/On", "0");
    } else {
      charge.load_on = true;
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("Device has turned on relays after verifying state.");
      #endif
      client.publish("out/devices/1/OnOff/On", "1");
    }    
  }
  
  else if(strcmp (topic, "in/devices/1/OnOff/Off") == 0 && strcmp(dest, "{\"method\":\"post\",\"params\":{}}") == 0){
    #ifdef DEBUG
    Serial.println("Device has received request to turn off relays.");
    #endif    
    charge.load_on = false;
    charge.statechange = true;
    client.publish("out/devices/1/OnOff/Off", "0");     
  }  
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'a' && str[37] == 'l' && str[38] == 'l'){
      client.publish("out/devices/0/cdo/reset", "resetting all");
      resetFunc();
  }
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'w' && str[37] == 'i' && str[38] == 'f' && str[39] == 'i'){
      int i; 
      int save; 
      char wifiname[50] = "";
      char wifipassword[50] = "";
      //{"method":"post","params":{"value":"wifi"}{"wifiname:password"}}
      //{"method":"post","params":{"value":"wifi"}{":"}} -- length: 48
      client.publish("out/devices/0/cdo/reset", "resetting wifi settings of device");
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
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'm' && str[37] == 'q' && str[38] == 't' && str[39] == 't'){
    client.publish("out/devices/0/cdo/reset", "resetting MQTT settings of device");
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
  }
  
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'd' && str[37] == 'e' && str[38] == 'v' && str[39] == 'i' && str[40] == 'c' && str[41] == 'e'){
    client.publish("out/devices/0/cdo/reset", "deleting information set by user"); 
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
      Serial.println("The device has received commands to trigger the fault interrupt.");
      #endif
      //digitalWrite(GFIout, LOW);
      client.publish("esp/response", "OK"); 
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
      client.publish("esp/response", charbuf);
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
      client.publish("esp/response", charbuf);
    }
    else if(str[0] == 'C' && str[1] == 'H' && str[2] == 'S'){
      #ifdef DEBUG
      Serial.print("It is in state ");
      Serial.println(charge.state);
      #endif
      client.publish("esp/response", &charge.state); 
    }    
  }         
}


/*
void reconnect(void) {
  // Loop until we reconnect to server
  ledcWrite(1, 0);
  ledcWrite(2, 500);
  ledcWrite(3, 0);
  ledcWrite(4, 0);
  while(!client.connected()) {
    #ifdef DEBUG
    Serial.print("Reestablishing MQTT connection to ");
    #endif
    Serial.println(mqtt_server);
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
    if (client.connect(clientId.c_str())) {
      #ifdef DEBUG
      Serial.println("connected");
      #endif
      topicsSubscription();
    } else {
      #ifdef DEBUG
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      #endif
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}
*/
