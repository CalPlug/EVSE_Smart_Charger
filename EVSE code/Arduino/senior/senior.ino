#include <WiFi.h>
#include <PubSubClient.h>
#include <Time.h>

#define DEBUG
//#define SCHOOLWIFI
#define HOMEWIFI
//#define PHONEWIFI

/*button definitions */
const int buttonPin = 34; 
bool buttonIsPressed;
int numPressed = 0;
bool timeStarted;
unsigned long  lastDebounceTime = 0;
unsigned long debounceDelay = 175;
time_t t;

typedef struct {
  int pwm_high, pwm_low;
  char state;
  bool relay1, relay2;
  bool lv_1, lv_2;
  int chargerate, saverate;
  bool load_on;
  bool statechange;
} ChargeState;
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

const char * mqtt_server = "m14.cloudmqtt.com";
const int mqttPort = 10130;
const char * mqttUser = "obavbgqt";
const char * mqttPassword = "ZuJ8oEgNqKCy";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;

/* LED pin inputs */
const int LED_PIN_BLUE = 4;
const int LED_PIN_GREEN = 21;
const int LED_PIN_RED = 5;

//const int BUTTON_PIN = 0;
//const int LED_PIN = 5;
/* sretemarap noitcennoc */

/* pin inputs */
const int GFIpin = 15;
const int relay1 = 18;
const int relay2 = 19;
const int level1 = 16;
const int level2 = 17;
/* stupni nip */

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

void setup() {
  // initialize inputs and outputs
  // conduct a GFI test, stuck relay check, connect to wattmeter
  // connect to zigbee network, get charge level, turn off relays, 
  // adjust LEDS
  
  ledcAttachPin(LED_PIN_BLUE, 1);
  ledcSetup(1, freq, resolution);

  ledcAttachPin(LED_PIN_RED, 2);
  ledcSetup(2, freq, resolution);

  ledcAttachPin(LED_PIN_GREEN, 3);
  ledcSetup(3, freq, resolution);

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
  client.publish("esp/test", "Hello from ESP32!");
  client.subscribe("esp/test");
  client.subscribe("GeneralFault");
  client.subscribe("GFIState");
  client.subscribe("GROUNDOK");
  client.subscribe("SUPLevel");
  client.subscribe("INSTCurrent");
  client.subscribe("L1Voltage");
  client.subscribe("L2Voltage");
  client.subscribe("RequestCurrent");
  client.subscribe("DeliveredCurrent");
  client.subscribe("INSTDemand");
  client.subscribe("AccumulatedDemandCharge");
  client.subscribe("AccumulatedDemandTotal");
  client.subscribe("ChargeState");
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
  
  charge.state = 'A';
  charge.load_on = true;
  charge.statechange = false;
  charge.chargerate = 1;
  
  ledcWrite(2, 0);
  ledcWrite(3, 500);  
  ledcWrite(1, 0);

  // save for later 
  /*
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(LED_PIN ,OUTPUT);
  
  connectToWiFi(networkName, networkPswd);

  digitalWrite(LED_PIN, LOW);
  */
}
void(* resetFunc)(void) = 0;

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

  // button checks
  if(timeStarted == true && (difftime(time(NULL), t) >= 5.0)) {
    #ifdef DEBUG
    Serial.println("5 seconds have passed since initial button push.");
    Serial.print("The button was pressed ");
    Serial.println(numPressed);
    #endif
    if(numPressed >= 1 && numPressed < 6){
      // toggle load on/off
      if(charge.state == 'C' && charge.load_on) {
        charge.load_on = false;
        charge.saverate = charge.chargerate;
        charge.chargerate = 0;
        #ifdef DEBUG
        Serial.println("The load has been shut off from button press.");
        #endif
      }
      else if(charge.state == 'C' && !charge.load_on) {
        charge.load_on = true;
        charge.chargerate = charge.saverate;
        charge.saverate = 0;
        #ifdef DEBUG
        Serial.println("The load has been turned on again from button press.");
        #endif
      }
    }
    else if (numPressed >= 6 && numPressed < 11) {
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
      #ifdef DEBUG;
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
  if(charge.statechange) {
    switch (charge.state) {
      case 'A':
        ledcWrite(3, 500);
        ledcWrite(2, 0);
        ledcWrite(1, 0);
        break;
      case 'B':
        ledcWrite(3, 1023);
        ledcWrite(2, 0);
        ledcWrite(1, 0);
        break;
      case 'C':
        ledcWrite(3, 1023);
        ledcWrite(1, 500);
        ledcWrite(2, 0);
        break;
      default:
        ledcWrite(2, 200);
        ledcWrite(1, 0);
        ledcWrite(3, 0);
        break;
    }
    if(charge.state == 'C') {
      #ifdef DEBUG
      Serial.println("The charger is in charging state! Turning on relays.");  
      #endif
      digitalWrite(relay1, charge.relay1);
      digitalWrite(relay2, charge.relay2);
      #ifdef DEBUG
      Serial.println("These are now the values for the relays.");
      Serial.println(digitalRead(relay1));
      Serial.println(digitalRead(relay2));
      #endif
    } else {
      #ifdef DEBUG
      Serial.println("The state of the charger has changed from C");
      Serial.println("Turning off relays!");
      #endif
      digitalWrite(relay1, LOW);
      digitalWrite(relay2, LOW);
    }
    charge.statechange = false;
  }
  #ifdef GFITEST
  delay(5000);
  Serial.println("Changing output now!");
  bool type = digitalRead(GFIout);
  if(type == LOW)
    digitalWrite(GFIout, HIGH);
  else
    digitalWrite(GFIout, LOW);
  if(contloop == false) {
    Serial.println("Hi, this is false...");
    //exit(0);
    initiateShutoff();
    return;
  }
  #endif
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

void initiateShutoff(void)
{
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);
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
    contloop = false;
  } 
}

void GFIinterrupt(void)
{
  
  Serial.println("The unit has encountered an interrupt from the ground fault interface!");
  Serial.println("Shutting down!");
  contloop = false;
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

  //changestate function
  //CS state 
  if(str[0] == 'C' && str[1] == 'S') {
    charge.state = str[2];
    charge.statechange = true;
    #ifdef DEBUG
    Serial.println("Changing the state of the charger to: ");
    Serial.print(charge.state);
    #endif
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
      client.subscribe("GeneralFault");
      client.subscribe("GFIState");
      client.subscribe("GROUNDOK");
      client.subscribe("SUPLevel");
      client.subscribe("INSTCurrent");
      client.subscribe("L1Voltage");
      client.subscribe("L2Voltage");
      client.subscribe("RequestCurrent");
      client.subscribe("DeliveredCurrent");
      client.subscribe("INSTDemand");
      client.subscribe("AccumulatedDemandCharge");
      client.subscribe("AccumulatedDemandTotal");
      client.subscribe("ChargeState");
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
