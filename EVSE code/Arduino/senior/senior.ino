#include <WiFi.h>
#include <PubSubClient.h>

#define DEBUG
//define HOMEWIFI
//define PHONEWIFI
#define UCIWIFI
//define SHERMAINE
typedef struct {
  int pwm_high, pwm_low;
  char state;
  bool relay1, relay2;
  bool lv_1, lv_2;
  int chargerate;
} ChargeState;
/* Connection parameters */
#ifdef HOMEWIFI
const char * networkName = "CHOMPy";
const char * networkPswd = "sandwich57?";
#endif
#ifdef PHONEWIFI
const char * networkName = "SM-N910P181";
const char * networkPswd = "3238302988";
#endif
#ifdef UCIWIFI
const char * networkName = "UCInet Mobile Access";
const char * networkPswd = ""; 
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


const int BUTTON_PIN = 2;
const int LED_PIN_BLUE = 4;
const int LED_PIN_GREEN = 21;
const int LED_PIN_RED = 5;

int buttonstate = 0; 
int ledstate = 0;
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


/* pwm for LEDS */
int freq = 1000;
uint8_t ledArray[3] = {1, 2, 3};
int resolution = 10;

int timer;


void setup() {
  // initialize inputs and outputs
  // conduct a GFI test, stuck relay check, connect to wattmeter
  // connect to zigbee network, get charge level, turn off relays, 
  // adjust LEDS

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
  }


  
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

  //led and button 
  pinMode(LED_PIN_RED, OUTPUT);
  pinMode(LED_PIN_GREEN, OUTPUT);
  pinMode(LED_PIN_BLUE, OUTPUT);
  digitalWrite(LED_PIN_RED,LOW);
  digitalWrite(LED_PIN_GREEN,LOW);
  digitalWrite(LED_PIN_BLUE,LOW);
  pinMode(BUTTON_PIN, INPUT);
  delay(500);
  attachInterrupt(digitalPinToInterrupt(BUTTON_PIN), BUTTON_INTERRUPT, RISING);
  charge.state = 'A';

  // PWM functions for LEDs
  ledcAttachPin(2, 1);
  ledcAttachPin(3, 2);
  ledcAttachPin(4, 3);

  ledcSetup(1, 1, 10);
  ledcSetup(2, 1, 10);
  ledsSetup(3, 1, 10);

  
  timer = 0;

  // save for later 
  /*
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(LED_PIN ,OUTPUT);
  
  connectToWiFi(networkName, networkPswd);

  digitalWrite(LED_PIN, LOW);
  */
}

void loop() { 
  // if client loses connection, this will try to reconnect
  // additionally, it calls a loop function which checks to see if 
  // there's an available update in the mqtt server

  if(!client.connected()) {
    digitalWrite(LED_PIN_RED, HIGH);
    delay(1000);
    digitalWrite(LED_PIN_RED, LOW);
    delay(1000);
    reconnect();
  }
  client.loop();
  timer++;
  if(charge.state == 'A'){
   if(timer == 1000){
     digitalWrite(LED_PIN_GREEN,!digitalRead(LED_PIN_GREEN));
   }
  }
  else if(charge.state == 'B'){
    digitalWrite(LED_PIN_GREEN,HIGH);
  }
  else if(charge.state == 'C'){
    digitalWrite(LED_PIN_GREEN,HIGH);
    digitalWrite(LED_PIN_BLUE,HIGH);
    delay(2000);
    digitalWrite(LED_PIN_BLUE,LOW);
    delay(2000);
    }
  else if(charge.state == 'D'){
    digitalWrite(LED_PIN_GREEN, LOW);
    digitalWrite(LED_PIN_BLUE, LOW);
    digitalWrite(LED_PIN_RED, HIGH);
  }
if(timer == 1000){
  timer = 0;
}
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

void BUTTON_INTERRUPT(void){
   charge.state = 'A';
   Serial.print("the charge state is: ");
   Serial.println(charge.state);
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

//void chargeinit(void)
//{
  //char chargestate = 'A';
  //Serial.println(chargestate);
//}

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
    #ifdef DEBUG
    Serial.print("Changing the state of the charger to: ");
    Serial.println(charge.state);
    #endif
  }
  //SAVE FOR LATER

  
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
  //checkstate
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
