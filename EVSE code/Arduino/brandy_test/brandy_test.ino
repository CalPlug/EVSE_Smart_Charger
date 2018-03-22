#include <WiFi.h>
#include <PubSubClient.h>
#include <Time.h>
#include <driver/adc.h>
#include <ADE7953ESP32.h>
#include "esp32-hal-spi.h"
#include <SPI.h>
#include "esp32-hal-adc.h"

#define DEBUG
//#define SCHOOLWIFI
#define UCIWIFI
//#define PHONEWIFI
#define local_SPI_freq 1000000  //Set SPI_Freq at 1MHz (#define, (no = or ;) helps to save memory)
#define local_SS 14  //Set the SS pin for SPI communication as pin 5  (#define, (no = or ;) helps to save memory)
ADE7953 myADE7953(local_SS, local_SPI_freq);
bool teston = true;
bool buttonIsPressed = false;
int numPressed = 0;
bool timeStarted;
unsigned long  lastDebounceTime = 0;
unsigned long debounceDelay = 300;
time_t t;
time_t Wt;
time_t Rp; 

typedef struct {     
  char state;
  bool relay1, relay2, lv_1, lv_2;
  int chargerate, saverate;
  bool load_on, statechange;
  bool GFIfail, lvlfail, pilotError, pilotreadError, groundfail;  
  float ADemandCharge;
  float ADemandTotal;
  bool watttime; 
  int chargeCounter, totalCounter;
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
#ifdef PHONEWIFI
const char * networkName = "SM-N910P181";
const char * networkPswd = "3238302988";
#endif

const char * mqtt_server = "m11.cloudmqtt.com";
const int mqttPort = 19355;
const char * mqttUser = "dqgzckqa";
const char * mqttPassword = "YKyAdXHO9WQw";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;

// reset pin for ade chip pin 14 gpio 12
// Slave select is 13 GPIO 14
// pin 30 green
// pin 31 red
// pin 36 blue
// pin 37 button
// pin 12 multiplex (binary selection) to choose the level 
// pin 9 & 8 relays
// pin 7 GFI 

//const int LED_PIN_BLUE = 22;
//const int LED_PIN_GREEN = 34;
//const int LED_PIN_RED = 19;
//const int buttonPin = 23;
//const int multiplex = 27;
//const int relay1 = 32;
//const int relay2 = 33;
//const int GFIpin = 35;
//const int dutyout = 25;


const int LED_PIN_BLUE = 2;
const int LED_PIN_GREEN = 4;
const int LED_PIN_RED = 16;
const int buttonPin = 34;
const int multiplex = 27;
const int relay1 = 32;
const int relay2 = 33;
const int GFIpin = 21; // output
const int dutyout = 25;
const int GFIin = 26;
//const int GFIin = ; // input

//bool contloop = true;
volatile bool GFItestoccurred = false; 

ChargeState charge;

int freq = 1;
int resolution = 10;
int average = 0;
int counter = 0;

void setup() {
  Serial.begin(115200);

  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
  for(int i = 0; i < 20; i++){
    digitalWrite(relay1, LOW);
    digitalWrite(relay2, LOW);
    Serial.println("We're low");
    delay(3000);
    digitalWrite(relay1, HIGH);
    digitalWrite(relay2, HIGH);
    Serial.println("We're high");
    delay(3000);  
    Serial.println();
  }
  
  pinMode(12, OUTPUT);
  digitalWrite(12, LOW);
  digitalWrite(12, HIGH); // this is the reset enable pin

  charge.groundfail = false;
  #ifdef DEBUG
  Serial.println("Hello! We are on!");
  #endif  
  
  pinMode(GFIin, INPUT); // GFIin 
  // this needs to be the GFI interrupt pin. Modify later please Luis. :) 
  
  pinMode(35, INPUT); //request from Andy do not modify
  // the following are functions related to the internet connection between
  // the device and the MQTT server
  //wifiscan();

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

  ledcAttachPin(dutyout, 4);
  ledcSetup(4, 1000, resolution);
  #ifdef DEBUG
  Serial.println("PWM signal created");
  #endif  

  ledcWrite(2, 500);
  
  connectToWiFi(networkName, networkPswd);
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
    client.publish("esp/test", "Hello from ESP32!");
    client.subscribe("esp/test");
  
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
  
    // Mike functions
    client.subscribe("test1");
    client.subscribe("in/devices/1/SimpleMeteringServer/GeneralFault");
    client.subscribe("in/devices/1/SimpleMeteringServer/GFIState");
    client.subscribe("in/devices/1/SimpleMeteringServer/SUPLevel");
    client.subscribe("in/devices/1/SimpleMeteringServer/L1Voltage");
    client.subscribe("in/devices/1/SimpleMeteringServer/L2Voltage");
    client.subscribe("in/devices/1/SimpleMeteringServer/RequestCurrent");
    client.subscribe("in/devices/1/SimpleMeteringServer/DeliveredCurrent");
    client.subscribe("in/devices/1/SimpleMeteringServer/ChargeState");
    client.subscribe("in/devices/1/SimpleMeteringServer/INSTCurrent");
    client.subscribe("in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge");
    client.subscribe("in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal");
  }

  
  
  

  // Analog to Digital Converter setup
  // ADC1_CHANNEL_0 uses GPIO36 to read the input for the ADC
  // make sure that this input is used correctly.
  //adcAttachPin(36);
  //adcStart(36);
//  adc1_config_width(ADC_WIDTH_BIT_12);
//  adc1_config_channel_atten(ADC1_CHANNEL_0, ADC_ATTEN_DB_11);
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
  
  pinMode(GFIpin, OUTPUT);
  
  //digitalWrite(GFIpin, LOW);
  
  delay(500);
  //GFItestinterrupt();
  
/*
  attachInterrupt(digitalPinToInterrupt(GFIpin), GFIinterrupt, FALLING);
  charge.GFIfail = initializeGFI();
*/
  // GPIO pins for the relays.
  // Initially off until the charger itself is in state C
/*
  pinMode(relay1, OUTPUT);
  digitalWrite(relay1, LOW);
  pinMode(relay2, OUTPUT);
  digitalWrite(relay2, LOW);
*/
  //change later!!!!!!!!!!!!!!!!!!!!!!!!
  //--------------------------------------
  charge.GFIfail = false;
  //--------------------------------------
  SPI.begin();
  delay(200);
  myADE7953.initialize();
  #ifdef DEBUG
  Serial.println("ADE initialized");
  #endif

  pinMode(multiplex, OUTPUT);
  digitalWrite(multiplex, LOW);
  delay(1000);
  LevelDetection();
  
  
  charge.state = 'A'; 
  charge.load_on = true;
  charge.statechange = false;
  charge.chargerate = 67;
  charge.pilotreadError = false;
  charge.pilotError = false;    

  // Watt meter values
  charge.ADemandCharge = 0.0;
  charge.ADemandTotal = 0.0;
  charge.watttime = false;
  charge.chargeCounter = 0;
  charge.totalCounter = 0;
  
  if(charge.lv_1) {
    charge.relay1 = true;
    charge.relay2 = false;
  } else if(charge.lv_2) {
    charge.relay1 = true;
    charge.relay2 = true;
  } else {
    Serial.println("Something went wrong with the level detection. Fix please.");
  }
  if(GFItestoccurred == false){
    charge.GFIfail = true;
    #ifdef DEBUG
    Serial.println("GFI test failed! Device did not obtain interrupt for GFI.");
    #endif
  }
  if(charge.GFIfail || charge.lvlfail || charge.groundfail) {
    ledcWrite(1, 0);
    ledcWrite(2, 500);
    ledcWrite(3, 0);    
    ledcWrite(4, 0);
  } else {
    ledcWrite(1, 0);
    ledcWrite(2, 0);
    ledcWrite(3, 500);    
    int value = map(charge.chargerate, 0, 100, 0, 1023);
    ledcWrite(4, value);    
  }
  Rp = time(NULL);
}

void GFItestinterrupt(void) {
  #ifdef DEBUG
  Serial.println("Testing the GFI interrupt.");
  #endif
  digitalWrite(GFIpin, HIGH);
  delay(100);
  digitalWrite(GFIpin, LOW);
  
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
  if(timeStarted == true && (difftime(time(NULL), t) >= 5.0)) {
    #ifdef DEBUG
    Serial.println("5 seconds have passed since initial button push.");
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

void readPilot(void) {
  //uint16_t x = analogRead(36);
  //int x = adc1_get_raw(ADC1_CHANNEL_0); //ADC1_CHANNEL0 IS GPIO 36
  int x = adc1_get_raw(ADC1_CHANNEL_3);
//  #ifdef DEBUG
//  Serial.print("ADC Read: ");
//  Serial.println(x);
//  Serial.print("Counter Read: ");
//  Serial.println(counter);
//  #endif  
  
  if(difftime(time(NULL), Rp) >= .1){
//    int y = 0;
//    for(int i = 0; i < 150; i++) {
//      y += adc1_get_raw(ADC1_CHANNEL_3);
//    }
//    y /= 150;
//    #ifdef DEBUG
//    Serial.print("new average without mods: ");
//    Serial.println(y);
//    #endif
//    y = (y * 50) / charge.chargerate;
//    #ifdef DEBUG
//    Serial.print("new average with modification: ");    
//    Serial.println(y);
//    #endif
    
    average = average / counter;
    #ifdef DEBUG
    Serial.print("average without modifications: ");
    Serial.println(average);    
    #endif
    average = (average * 50) / charge.chargerate;
    #ifdef DEBUG
    Serial.print("average with modification: ");    
    Serial.println(average);
    #endif
    if(abs(1185 - average) <= 15) {
      if(charge.state != 'A'){
        charge.state = 'A';
        charge.statechange = true;
      }
    } 
    else if (abs(1095 - average) <= 15 ){
      if(charge.state != 'B') {        
        charge.state = 'B';
        charge.statechange = true;
      } 
    } 
    else if(abs(163 - average) <= 15) {
      if(charge.state != 'C') {
        charge.state = 'C';
        charge.statechange = true;
      }
    } else{
      if(charge.state != 'F'){
        charge.state = 'F';
        charge.statechange = true;
      }
    }

    
//    if(abs(313 - average) <= 10) {
//      if(charge.state != 'A'){
//        charge.state = 'A';
//        charge.statechange = true;
//      }
//    } 
//    else if (abs(283 - average) <= 10 ){
//      if(charge.state != 'B') {        
//        charge.state = 'B';
//        charge.statechange = true;
//      } 
//    } 
//    else if(abs(163 - average) <= 10) {
//      if(charge.state != 'C') {
//        charge.state = 'C';
//        charge.statechange = true;
//      }
//    } else{
//      if(charge.state != 'A'){
//        charge.state = 'A';
//        charge.statechange = true;
//      }
//    }
    average = 0;
    counter = 0;
    Rp = time(NULL);    
  }
  average +=x;
  counter++;
  //actual readings
  

  // if the reading isn't within a given range tolerance of 90, the read will default to 
  // state nine, which signals that we're getting weird voltage values
  // Update: Apparently, you cannot read a negative voltage on Arduino. I'm 
  // sure it applies to ESP32 as well. The problem is that we need to read the 
  // duty cycle of the pin to determine the maximum charge rate of the car that 
  // it can accept. 
}

void timeWatts(void) {
  if(difftime(time(NULL), Wt) >= 10.0) {
    #ifdef DEBUG
    Serial.println("10 seconds have passed. Saving watt meter information.");
    #endif
    Wt = time(NULL);
    charge.chargeCounter++;
    charge.totalCounter++;
    float activePower = 1500.0;
    //float activePower = myADE7953.getInstActivePowerA();
    charge.ADemandCharge += activePower;
    charge.ADemandTotal += activePower;
  }  
}

void loop() { 
  // if client loses connection, this will try to reconnect
  // additionally, it calls a loop function which checks to see if 
  // there's an available update in the mqtt server
  if(!client.connected()) {
    ledcWrite(3, 0);
    ledcWrite(2, 500);
    ledcWrite(1, 0);
    reconnect();    
  }
  client.loop();

  if(charge.watttime) 
    timeWatts();
    
  buttonCheck();
  if(charge.GFIfail == false && charge.lvlfail == false) {
    readPilot();

    if(charge.statechange) {
      switch (charge.state) {
        case 'A': {
          ledcWrite(3, 500);
          ledcWrite(2, 0);
          ledcWrite(1, 0);
          int value = map(charge.chargerate, 0, 100, 0, 1023); 
          ledcWrite(4, value);                  
          }
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
      if(charge.state == 'B' && charge.load_on && !charge.watttime) {
        #ifdef DEBUG
        Serial.println("The charger is ready to be in charging state! (B->C) Turning on relays.");
        Serial.println("These are now the values for the relays.");
        Serial.println(digitalRead(relay1));
        Serial.println(digitalRead(relay2));  
        #endif
        digitalWrite(relay1, charge.relay1);
        digitalWrite(relay2, charge.relay2);
      } else if(charge.state == 'B' && charge.load_on && charge.watttime) {
        #ifdef DEBUG
        Serial.println("The charger was previously in charging state but has now completed?");
        Serial.println("Will turn the load off. Button press or MQTT command required to ");
        Serial.println("Turn load back on again.");
        #endif
        charge.load_on = false;
        charge.statechange = true;
      } else if(charge.state == 'C' && charge.load_on) {
        #ifdef DEBUG
        Serial.print("The charger is now in charging state (C)");
        #endif
        if(!charge.watttime) {
          #ifdef DEBUG
          Serial.println("Wattmeter time has now been started.");
          Serial.println("Charge cycle charging has been reset.");
          #endif
          Wt = time(NULL);
          charge.watttime = true;
          charge.chargeCounter = 0;
          charge.ADemandCharge = 0.0;
        }
      }  
      else {
        #ifdef DEBUG 
        if(!charge.load_on) {
          Serial.println("The load is turned off.");
        } else {
          Serial.println("Charger load was previously on. Switching it back off.");
          Serial.println("Button press and charging state B required to turn on ");
          Serial.println("charger.");
        }
        if(charge.state != 'C') {
          Serial.println("The current state is not C.");
          Serial.print("Current state is: ");
          Serial.println(charge.state);
        }
        if(charge.watttime) {
          Serial.println("Wattmeter time check was on. It has been switched off.");
          Serial.println("Charge cycle information will be saved until the next time the");
          Serial.println("charger goes back into 'C' state");          
        }
        Serial.println("The state of the charger changed!");
        Serial.println("Relays are now off.");
        #endif
        charge.watttime = false;
        charge.load_on = false;    
        digitalWrite(relay1, LOW);
        digitalWrite(relay2, LOW);
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
  // level detection bit needs to be low for it to register as "on" 
  // weird right?
//  for(int i = 0; i < 
//  bool lvl = digitalRead(multiplex);
//  #ifdef DEBUG
//  Serial.print("The multiplex reading is ");
//  Serial.print(lvl);
//  #endif

 // #ifdef COMPLETE
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


  // just for testing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  charge.groundfail = false;
  charge.lvlfail = false;
}

void GFIinterrupt(void)
{
  if(GFItestoccurred == false) {
    GFItestoccurred = true;
    #ifdef DEBUG
    Serial.println("GFI interrupt has occurred for the first time!");
    Serial.println("Setting internal flag to true.");
    #endif
  } else {
    digitalWrite(relay1, LOW);
    digitalWrite(relay2, LOW);  
    charge.load_on = false;
    charge.GFIfail = true;
  
    ledcWrite(3, 500);
    ledcWrite(2, 200);
    ledcWrite(1, 700);
    ledcWrite(4, 0);
    Serial.println("The unit has encountered an interrupt from the ground fault interface!");
    Serial.println("The load has been shut off permanently.");
    Serial.println("Device needs to be reset to be functional again!");
    Serial.println("MQTT connection is still operational to communicate with server");
    Serial.println("and the device can be reset by pushing the button 11 times.");  
  }
}

bool initializeGFI(void) {
  boolean GFIstate = digitalRead(GFIpin);
  if(GFIstate == HIGH) {
    #ifdef DEBUG
    Serial.println("GFI test found no error. Continuing processes as directed");
    #endif
    return false;
  }
  #ifdef DEBUG
  Serial.println("GFI test error found! This input should not be low! Exiting the program...");
  #endif
  return true;
}

void connectToWiFi(const char * ssid, const char * pwd) 
{
  int ledState = 0;
  printLine();
  #ifdef DEBUG
  Serial.println("Connecting to WiFi network: " + String(ssid));
  #endif
  WiFi.begin(ssid, pwd);

  while(WiFi.status() != WL_CONNECTED)
  {    
    delay(500);
    #ifdef DEBUG
    Serial.print(".");  
    #endif
  }
  #ifdef DEBUG
  Serial.println();
  Serial.println("WiFi connected!");
  Serial.print("IP address: ");
  #endif
  Serial.println(WiFi.localIP());
}

void printLine(void)
{
  Serial.println();
  for(int i = 0; i<30; i++)
    Serial.print("-");
  Serial.println();
}

void callback(char * topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.println("] ");
  char str[length]; 
  Serial.print("The length is: ");
  Serial.println(length);
  for(int i = 0; i < length; i++) {
    //Serial.print((char)payload[i]);   
    str[i] = (char)payload[i];
    Serial.print(str[i]);
  }
  //Serial.print(str);
  Serial.println();
  Serial.println("----------------"); 

  // determines whether or not the load is on or off
  if(strcmp(topic, "in/devices/1/OnOff/OnOff") == 0) {
    #ifdef DEBUG 
    Serial.println("Device received OnOff message from broker!");
    #endif
    if(charge.state == 'C' && charge.load_on == true) {
      #ifdef DEBUG
      Serial.println("Device is on! Sending status to broker!");
      #endif
      client.publish("out/devices/1/OnOff/OnOff", "On");
    } else {
      #ifdef DEBUG
      Serial.println("Device is off! Sending status to broker!");
      #endif
      client.publish("out/devices/1/OnOff/OnOff", "Off");
    }
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/GeneralFault") == 0) {
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
      client.publish("out/devices/1/SimpleMeteringServer/GeneralFault", "OK");
    }   
  }
  // checks status of ground and wiring
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/GROUNDOK") == 0) {
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
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/SUPLevel") == 0) {
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
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/GFIState") == 0) {
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
  // checks level1 voltage
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/L1Voltage") == 0) {
    client.publish("out/devices/1/SimpleMeteringServer/L1Voltage", "I dunno");
  }
  // checks level2 voltage
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/L2Voltage") == 0) {
    client.publish("out/devices/1/SimpleMeteringServer/L2Voltage", "I dunno");
  }
  else if(strcmp(topic, "test1") == 0) {
    long apnoload, activeEnergyA;
    float vRMS, iRMSA, powerFactorA, apparentPowerA, reactivePowerA, activePowerA;    
    #ifdef DEBUG
    Serial.println("Received request for test 1");    
    Serial.println("Verifying that instcurrent is 0.0: ");
    #endif

    char buffer[50];
    vRMS = myADE7953.getVrms();
    Serial.print("Vrms (V): ");
    Serial.println(vRMS);

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
  // instantaneous supplied current
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/INSTCurrent") == 0) {
    long instcurrent = 0.0;
    #ifdef DEBUG
    Serial.println("Received request for instantaneous supplied current.");    
    Serial.println("Verifying that instcurrent is 0.0: ");
    Serial.println(instcurrent);
    #endif

    char buffer[50];
    instcurrent = myADE7953.getInstCurrentA();
    char *p1 = dtostrf(instcurrent, 10, 2, buffer);
    client.publish("out/devices/1/SimpleMeteringServer/INSTCurrent", p1);
  }
  // set charging current to be supplied
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/RequestCurrent") == 0) {
    #ifdef DEBUG
    Serial.println("Obtained request to change charging current using new format.");
    #endif
    int rate = 0;
    rate = atoi(str);
    #ifdef DEBUG
    Serial.print("Trying to change the charge rate of the car to: ");
    Serial.println(rate);
    #endif
    if(rate >= 6 && rate <= 40) {
      if(rate < 51) {
        charge.chargerate = rate / .6;
      } else {
        charge.chargerate = (rate / 2.5) + 64;
      }      
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
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/RmsCurrent") == 0) {
    #ifdef DEBUG
    Serial.println("Request obtained for current charging rate using new format.");
    #endif
    char charbuf[20];
    itoa(charge.chargerate, charbuf, 10);
    client.publish("out/devices/1/SimpleMeteringServer/DeliveredCurrent", charbuf); 
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/ChargeState") == 0) {
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
      Serial.println("Charger is not connected! (D, E, F)");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/ChargeState", "0");
    }    
  }  
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/InstantaneousDemand") == 0) {    
        
    float instActive = 0.12;
    #ifdef DEBUG
    Serial.println("Received request for instantaneous demand.");    
    Serial.println("Verifying that instActive is 0.12: ");
    Serial.println(instActive);
    #endif
    char buffer[50];
    instActive = myADE7953.getInstActivePowerA();
    char *p1 = dtostrf(instActive, 10, 6, buffer);        
    client.publish("out/devices/1/SimpleMeteringServer/InstantaneousDemand", p1);
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge") == 0) {
    
    #ifdef DEBUG
    Serial.println("Received request for AccumulatedDemandCharge");
    
    #endif
    double kWh = 0.0;
    kWh = (charge.ADemandCharge * (10.0 * (float)charge.chargeCounter)) / (3600000000.00);
    char buffer[50];
    char *p1 = dtostrf(kWh, 10, 6, buffer);
    client.publish("out/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge", p1);
  }
  else if(strcmp (topic, "in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal") == 0) {
    #ifdef DEBUG
    Serial.println("Received request for AccumulatedDemandTotal");
    #endif
    double kWh = 0.0;
    kWh = (charge.ADemandTotal * (10.0 * (float)charge.totalCounter)) / (3600000000.00);
    char buffer[50];
    char *p1 = dtostrf(kWh, 10, 2, buffer);
    client.publish("out/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal", p1);
  }
  else if(strcmp (topic, "in/devices/1/OnOff/Toggle") == 0){
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
  else if(strcmp (topic, "in/devices/1/OnOff/On") == 0){
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
  
  else if(strcmp (topic, "in/devices/1/OnOff/Off") == 0){
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
      client.publish("out/devices/0/cdo/reset", "resetting wifi settings of device");
  }
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'm' && str[37] == 'q' && str[38] == 't' && str[39] == 't'){
      client.publish("out/devices/0/cdo/reset", "resetting MQTT settings of device");
  }
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'd' && str[37] == 'e' && str[38] == 'v' && str[39] == 'i' && str[40] == 'c' && str[41] == 'e'){
      client.publish("out/devices/0/cdo/reset", "deleting information set by user");
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
    else if(str[0] == 'O' && str[1] == 'F' && length == 2) {
      if(teston) {
        ledcWrite(5, 0);  
        teston = false;
      } else {
        ledcWrite(5, 1023);
        teston = true;
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
      // Once connected, publish an announcement...
      client.publish("esp/test", "hello world");
      // ... and resubscribe
      client.subscribe("esp/test");
      
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
    
      // Mike functions
      client.subscribe("in/devices/1/SimpleMeteringServer/GeneralFault");
      client.subscribe("in/devices/1/SimpleMeteringServer/GFIState");
      client.subscribe("in/devices/1/SimpleMeteringServer/SUPLevel");
      client.subscribe("in/devices/1/SimpleMeteringServer/L1Voltage");
      client.subscribe("in/devices/1/SimpleMeteringServer/L2Voltage");
      client.subscribe("in/devices/1/SimpleMeteringServer/RequestCurrent");
      client.subscribe("in/devices/1/SimpleMeteringServer/DeliveredCurrent");
      client.subscribe("in/devices/1/SimpleMeteringServer/ChargeState");
      client.subscribe("in/devices/1/SimpleMeteringServer/INSTCurrent");
      client.subscribe("in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandCharge");
      client.subscribe("in/devices/1/SimpleMeteringServer/CurrentSummation/AccumulatedDemandTotal");
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
