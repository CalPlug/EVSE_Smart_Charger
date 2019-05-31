#include <WiFi.h>
#include <PubSubClient.h>
#include <Time.h>
#include <driver/adc.h>
#include <ADE7953ESP32.h>
#include "esp32-hal-spi.h"
#include <SPI.h>


#define DEBUG
//#define SCHOOLWIFI
//#define HOMEWIFI
//#define SCHOOLWIFI
//#define PHONEWIFI
//#define LOUIGI
//#define MICROSEMI
#define MICROTEST

#define local_SPI_freq 1000000
#define local_SS 5
ADE7953 myADE7953(local_SS, local_SPI_freq);

/*button definitions */
const int buttonPin = 34; 

bool buttonIsPressed;
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
  bool load_on;
  bool statechange;
  int namelength;
  char nameofdevice[50];
  char *mqttuser;
  char *mqttpassword;
  char *mqttserver;
  int mqttport;
  char *wifiname;
  char *wifipassword;
  bool load_on, statechange;
  bool GFIfail, lvlfail, pilotError, pilotreadError;  
<<<<<<< HEAD
  float ADemandCharge;
  float ADemandTotal;
  bool watttime; 
  int chargeCounter, totalCounter;
=======
>>>>>>> a43b2c39e42ef908bb4dc11aa368d9ff801f9199
} ChargeState;

//typedef struct{
//  const char * mqtt_server = "";
//  const int mqttPort = 0;
//  const char * mqttUser = "";
//  const char * mqttPassword = "";
//  bool MqttChange = false;
//}MqttNew;


/* Connection parameters */
#ifdef SCHOOLWIFI
const char * networkName = "UCInet Mobile Access";
const char * networkPswd = "";
#endif

#ifdef HOMEWIFI
const char * networkName = "CHOMPy";
const char * networkPswd = "sandwich57?";
#endif
#ifdef PHONEWIFI
const char * networkName = "SM-N910P181";
const char * networkPswd = "3238302988";
#endif
#ifdef MICROSEMI
const char * networkName = "microsemi";
const char * networkPswd = "microsemicalit212345";
#endif
#ifdef MICROTEST
const char * networkName = "microsemi-test";
const char * networkPswd = "calit2uci123456789";
#endif

const char * mqtt_server = "m11.cloudmqtt.com";
const int mqttPort = 19355;
const char * mqttUser = "dqgzckqa";
const char * mqttPassword = "YKyAdXHO9WQw";


//const char * mqtt_server = "m14.cloudmqtt.com";
//const int mqttPort = 10130;
//const char * mqttUser = "obavbgqt";
//const char * mqttPassword = "ZuJ8oEgNqKCy";

//const char * mqtt_server = "m10.cloudmqtt.com";
//const int mqttPort = 10355;
//const char * mqttUser = "zbwdrora";
//const char * mqttPassword = "sMRvXz5cM6WF";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;

/* LED pin inputs */
const int LED_PIN_BLUE = 2;
const int LED_PIN_GREEN = 4;
const int LED_PIN_RED = 21; // SHERMAINE CHANGE THIS!!!!

//const int BUTTON_PIN = 0;
//const int LED_PIN = 5;
/* sretemarap noitcennoc */

/* pin inputs */
const int GFIpin = 15;
const int relay1 = 35; // SHERMAINE CHANGE THIS!!!!
const int relay2 = 22; // SHERMAINE CHANGE THIS!!!!
const int level1 = 16;
const int level2 = 17;
/* stupni nip */

// PWM output
const int dutyout = 26;

/* pin outputs */
const int GFIout = 12;
const int relay1o = 25;
const int relay2o = 33;
const int level1o = 14;
const int level2o = 27; 

bool contloop = true;

ChargeState charge;

int freq = 1;
int resolution = 10;
int average = 0;
int counter = 0;

void setup() {
  // initialize inputs and outputs
  // conduct a GFI test,*stuck relay check*, connect to wattmeter SPI
  // connect to zigbee network, get charge level, turn off relays, 
  // adjust LEDS, PWM for the charger. 
  SPI.begin();
  delay(200);
  myADE7953.initialize();
  
  charge.wifiname = "";
  charge.wifipassword = "";
  charge.mqttuser = "";
  charge.mqttpassword = "";
  charge.mqttserver = "";
  charge.mqttport = 0;
  
  ledcAttachPin(LED_PIN_BLUE, 1);
  ledcSetup(1, freq, resolution);

  ledcAttachPin(LED_PIN_RED, 2);
  ledcSetup(2, freq, resolution);

  ledcAttachPin(LED_PIN_GREEN, 3);
  ledcSetup(3, freq, resolution);

  ledcAttachPin(dutyout, 4);
  ledcSetup(4, 1000, resolution);

  

  // Analog to Digital Converter setup
  // ADC1_CHANNEL_0 uses GPIO36 to read the input for the ADC
  // make sure that this input is used correctly.

  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_4, ADC_ATTEN_DB_11);

  delay(500);
  ledcWrite(2, 500);

  // the following are functions related to the internet connection between
  // the device and the MQTT server
  Serial.begin(115200);
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
<<<<<<< HEAD
    client.publish("esp/test", "Hello from ESP32!");
    client.subscribe("esp/test");
    client.subscribe("test1");
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
=======
  client.publish("esp/test", "Hello from ESP32!");
  client.subscribe("esp/test");
  client.subscribe("devicename");
  client.subscribe("wifireset");

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
>>>>>>> a43b2c39e42ef908bb4dc11aa368d9ff801f9199
  }


  //button functionality
  pinMode(buttonPin, INPUT);
  attachInterrupt(digitalPinToInterrupt(buttonPin), ButtonPressed, HIGH);
  buttonIsPressed = false;
  timeStarted = false;
  
  pinMode(GFIout, OUTPUT);
  pinMode(relay1o, INPUT);
  pinMode(relay2o, INPUT);
  pinMode(level1o, OUTPUT);
  pinMode(level2o, OUTPUT);
    
  digitalWrite(GFIout, HIGH);
  digitalWrite(level1o, LOW);
  digitalWrite(level2o, LOW);  
  
  //ChargeState charge;
  
  // need to initialize GPIOs fisrt before testing them for inputs. Need to delay after 
  // initilization
  
  pinMode(GFIpin, INPUT);
  delay(500);
  attachInterrupt(digitalPinToInterrupt(GFIpin), GFIinterrupt, FALLING);
  contloop = initializeGFI();

  // GPIO pins for the relays.
  // Initially off until the charger itself is in state C
  pinMode(relay1, OUTPUT);
  digitalWrite(relay1, LOW);
  pinMode(relay2, OUTPUT);
  digitalWrite(relay2, LOW);

  // leveldetection functions
  // this determinues if this is in level 1 or level 2 charging
  pinMode(level1, INPUT);
  pinMode(level2, INPUT);
  delay(1000);
  LevelDetection();
  
  charge.state = 'A'; // this is just for testing purposes needs to be modified later
  charge.load_on = true;
  charge.statechange = false;
  charge.chargerate = 50;
  charge.GFIfail = false;
  charge.lvlfail = false;
  charge.pilotreadError = false;
  charge.pilotError = false;    
  
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
  ledcWrite(1, 0);
  ledcWrite(2, 0);
  ledcWrite(3, 500);    
  ledcWrite(4, 0);
  Rp = time(NULL);
}

void(* resetFunc)(void) = 0;

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
      Serial.println("I dunno what to do with this function.");
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
  
  int x = adc1_get_raw(ADC1_CHANNEL_4); //ADC1_CHANNEL4 IS GPIO 32
  //Serial.println(x);
  // Pilot reads on the ADC can only handle reads up to 2.6V so
  // the parameters to drive the pilot will be adjusted accordingly

  
  if(difftime(time(NULL), Rp) >= .1){
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
    if(abs(313 - average) <= 10) {
      if(charge.state != 'A'){
        charge.state = 'A';
        charge.statechange = true;
      }
    } 
    else if (abs(283 - average) <= 10 ){
      if(charge.state != 'B') {        
        charge.state = 'B';
        charge.statechange = true;
      } 
    } 
    else if(abs(163 - average) <= 10) {
      if(charge.state != 'C') {
        charge.state = 'C';
        charge.statechange = true;
      }
    }
    average = 0;
    counter = 0;
    Rp = time(NULL);    
  }
  average +=x;
  counter++;
   
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
  
  if(!charge.GFIfail && !charge.lvlfail) {
    readPilot();
    if(charge.statechange) {
      switch (charge.state) {
        case 'A':
          ledcWrite(3, 500);
          ledcWrite(2, 0);
          ledcWrite(1, 0); 
          ledcWrite(4, 1023);                  
          break;
        case 'B':{
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
        default:
          ledcWrite(2, 200);
          ledcWrite(1, 0);
          ledcWrite(3, 0);
          ledcWrite(4, 0);
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
        Serial.println("Relays are off.");
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

void LevelDetection() 
{
  // level detection bit needs to be low for it to register as "on" 
  // weird right?
  bool lvl1 = digitalRead(level1);
  bool lvl2 = digitalRead(level2);
  if(lvl1 == false && lvl2 == true) {
    #ifdef DEBUG 
    Serial.println("Only one relay needs to be turned on!");
    #endif
    charge.lv_1 = true;
    charge.lv_2 = false;
  }
  else if(lvl1 == false && lvl2 == false) {
    #ifdef DEBUG 
    Serial.println("Both relays need to be turned on!");
    #endif
    charge.lv_1 = false;
    charge.lv_2 = true;
  }
  else {
    #ifdef DEBUG 
    Serial.println("Something wrong occured with the level detection check!");
    #endif
    charge.lv_1 = false;
    charge.lv_2 = false;
    charge.lvlfail = true;
  } 
}

void GFIinterrupt(void)
{
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);
  digitalWrite(GFIout, HIGH);
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

bool initializeGFI(void) {
  boolean GFIstate = digitalRead(GFIpin);
  if(GFIstate == HIGH) {
    #ifdef DEBUG
    Serial.println("GFI test found no error. Continuing processes as directed");
    #endif
    return true;
  }
  #ifdef DEBUG
  Serial.println("GFI test error found! This input should not be low! Exiting the program...");
  #endif
  return false;
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
    client.publish("out/devices/1/OnOff/OnOff", &charge.state);
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/CurrentSummation/Delivered") == 0) {
    client.publish("out/devices/1/SimpleMeteringServer/CurrentSummation/Delivered", "I dunno");
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/InstantaneousDemand") == 0) {
    client.publish("out/devices/1/SimpleMeteringServer/InstantaneousDemand", "I dunno");
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/RmsCurrent") == 0) {
    client.publish("out/devices/1/SimpleMeteringServer/RmsCurrent", "I dunno");
  }
  else if(strcmp(topic, "in/devices/1/SimpleMeteringServer/Voltage") == 0) {
    client.publish("out/devices/1/SimpleMeteringServer/Voltage", "U dunno");
  }
  else if(strcmp(topic, "in/devices/") == 0) {
    client.publish("out/devices/", "We dunno");
  }
  //changestate function
  //CS state 
  else if(strcmp (topic, "in/devices/1/OnOff/OnOff") == 0){
    client.publish("out/devices/1/OnOff/OnOff", &charge.state);
  }

  else if(strcmp (topic, "in/devices/1/OnOff/Toggle") == 0){
    client.publish("out/devices/1/OnOff/Toggle", &charge.state);
  }

 else if(strcmp (topic, "in/devices/1/OnOff/On") == 0){
    client.publish("out/devices/1/OnOff/On", &charge.state);
  }

 else if(strcmp (topic, "in/devices/1/OnOff/Off") == 0){
    client.publish("out/devices/1/OnOff/Off", &charge.state);
  }
  
 else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'a' && str[37] == 'l' && str[38] == 'l'){
      client.publish("out/devices/0/cdo/reset", "resetting all");
      resetFunc();
    }
 else if(strcmp(topic, "wifireset") == 0){
      int i; 
      int save; 
      char wifiname[50] = "";
      char wifipassword[50] = "";
      client.publish("out/devices/0/cdo/reset", "resetting wifi settings of device");
      client.disconnect();
      WiFi.disconnect();
      for(i=0; i<length; i++){
        if(str[i] == ' '){
          save = i+1;
          break;
        }
        Serial.print(str[i]);
        wifiname[i] = str[i];
      }
      Serial.println("---------------");
      for(i=save; i<length; i++){
        Serial.print(str[i]);
        wifipassword[i-save] = str[i];
      }
      Serial.println("---------------");
      
      charge.wifiname = wifiname;
      charge.wifipassword = wifipassword;
      Serial.println(charge.wifiname);
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
  }
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
  }
  }
  
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'm' && str[37] == 'q' && str[38] == 't' && str[39] == 't'){
    //client.publish("out/devices/0/cdo/reset", &charge.state);
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
  }
  }
      
  
  else if(strcmp (topic, "in/devices/0/cdo/reset") == 0 && str[36] == 'd' && str[37] == 'e' && str[38] == 'v' && str[39] == 'i' && str[40] == 'c' && str[41] == 'e'){
      client.publish("out/devices/0/cdo/reset", "deleting information set by user"); 
      //charge.nameofdevice = "";
      int i;
      for(i = 0; i<charge.namelength; i++){
        charge.nameofdevice[i] = NULL;
      }
      Serial.println(charge.nameofdevice);
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
  
  else if(str[0] == 'C' && str[1] == 'S') {
    charge.state = str[2];
    charge.statechange = true;
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
      client.publish("out/devices/1/SimpleMeteringServer/SUPLevel", "L1");
    } else if (charge.lv_1 == false && charge.lv_2 == true) {
      #ifdef DEBUG
      Serial.println("The device is in level two charge. Sending status to broker...");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/SUPLevel", "L2");
    } else {
      #ifdef DEBUG 
      Serial.println("The device has not determined level charging. Returning ERROR. Please reboot");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/SUPLevel", "ERROR");
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
      client.publish("out/devices/1/SimpleMeteringServer/GFIState", "FAIL");      
    } else {
      #ifdef DEBUG
      Serial.println("Device is ok! Sending status to server.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/GFIState", "OK");
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
    #ifdef DEBUG
    Serial.println(instcurrent);
    #endif
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
    if(rate >= 6 && rate <= 80) {
      if(rate < 51) {
        charge.chargerate = rate / .6;
      } else {
        charge.chargerate = (rate / 2.5) + 64;
      }      
      charge.statechange = true;
      #ifdef DEBUG
      Serial.println("The value provided is valid and will be used to adjust car charge settings.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/RequestCurrent", "Success");
    } else {
      #ifdef DEBUG
      Serial.println("The value provided is invalid. Disregarding the new charge rate.");
      #endif
      client.publish("out/devices/1/SimpleMeteringServer/RequestCurrent", "Failure");
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
    } else {
      #ifdef DEBUG 
      Serial.println("Charger is not connected! (A, D, E, F)");
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
    if(charge.load_on) {
      #ifdef DEBUG
      Serial.println("Load is now off.");
      #endif
      charge.load_on = false;
      client.publish("out/devices/1/OnOff/Toggle", "0");
    } else {
      #ifdef DEBUG
      Serial.println("Load is turned on.");
      #endif
      charge.load_on = true;
      client.publish("out/devices/1/OnOff/Toggle", "1");
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
<<<<<<< HEAD
    #endif    
=======
    #endif
    client.publish("esp/response", &charge.state); 
  }
  else if(str[0] == 'C' && str[1] == 'H' && str[2] == 'N'){
    #ifdef DEBUG
    Serial.print("Its name: ");
    Serial.println(charge.nameofdevice);
    client.publish("esp/response", charge.nameofdevice);
    #endif 
  }          

>>>>>>> a43b2c39e42ef908bb4dc11aa368d9ff801f9199
    if(charge.state != 'C') {
      #ifdef DEBUG 
      Serial.println("Device is not in correct state to turn off relays.");
      #endif
      client.publish("out/devices/1/OnOff/On", "0");
    } else {
      #ifdef DEBUG 
      Serial.println("Device is in correct state to turn off relays.");
      #endif      
      charge.load_on = false;
      charge.statechange = true;
      client.publish("out/devices/1/OnOff/Off", "1"); 
    }
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
      digitalWrite(GFIout, LOW);
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

void reconnect(void) {
  // Loop until we reconnect to server
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
