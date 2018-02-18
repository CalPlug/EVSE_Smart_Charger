#include <WiFi.h>
#include <PubSubClient.h>

#define DEBUG
typedef struct {
  int pwm_high, pwm_low;
  char state;
  bool relay1, relay2;
  bool lv_1, lv_2;
} ChargeState;
/* Connection parameters */
const char * networkName = "CHOMPy";
const char * networkPswd = "sandwich57?";
const char * mqtt_server = "m14.cloudmqtt.com";
const int mqttPort = 10130;
const char * mqttUser = "obavbgqt";
const char * mqttPassword = "ZuJ8oEgNqKCy";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;



/*
const char * hostDomain = "example.com";
const int hostPort = 80;
*/
const int BUTTON_PIN = 0;
const int LED_PIN = 5;
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

void setup() {
  // initialize inputs and outputs
  // conduct a GFI test, stuck relay check, connect to wattmeter
  // connect to zigbee network, get charge level, turn off relays, 
  // adjust LEDS
  connectToWiFi(networkName, networkPswd);

  pinMode(GFIout, OUTPUT);
  pinMode(relay1o, INPUT);
  pinMode(relay2o, INPUT);
  pinMode(level1o, OUTPUT);
  pinMode(level2o, OUTPUT);

  digitalWrite(GFIout, HIGH);
  digitalWrite(level1o, LOW);
  digitalWrite(level2o, HIGH);  
  
  ChargeState charge;
  
  // need to initialize GPIOs fisrt before testing them for inputs. Need to delay after 
  // initilization
  Serial.begin(115200);
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
  LevelDetection(charge);
  
  
  // save for later 
  /*
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  pinMode(LED_PIN ,OUTPUT);
  
  connectToWiFi(networkName, networkPswd);

  digitalWrite(LED_PIN, LOW);
  */
}

void loop() { 
  
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
}

void initiateShutoff(void)
{
  digitalWrite(relay1, LOW);
  digitalWrite(relay2, LOW);
}

void LevelDetection(ChargeState &charge) 
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
  Serial.println("Connecting to WiFi network: " + String(ssid));

  WiFi.begin(ssid, pwd);

  while(WiFi.status() != WL_CONNECTED)
  {
    digitalWrite(LED_PIN, ledState);
    ledState = (ledState + 1) % 2;
    delay(500);
    Serial.print(".");  
  }

  Serial.println();
  Serial.println("WiFi connected!");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
}

void printLine(void)
{
  Serial.println();
  for(int i = 0; i<30; i++)
    Serial.print("-");
  Serial.println();
}
