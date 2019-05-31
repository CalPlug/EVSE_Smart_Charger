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
const int multiplex = 27;
const int relay1 = 32;
const int relay2 = 33;
const int relayenable = 21; // output
const int ADE795_reset = 12;

// main struct to hold important variables
ChargeState charge;

#define local_SPI_freq 1000000  //Set SPI_Freq at 1MHz (#define, (no = or ;) helps to save memory)
#define local_SS 14  //Set the SS pin for SPI communication as pin 5  (#define, (no = or ;) helps to save memory)
ADE7953 myADE7953(local_SS, local_SPI_freq);

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
  
 

  charge.groundfail = false;
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
}
  
void loop()
{
  // level detection safety check
// voltage levels need to either be
// ~120V and ~0V for level 1 charging
// ~120V and ~120V for level 2 charging
// safety check fails otherwise
 
  
  char buffer[50];
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
  
  //char buffer[50];
  
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
  
  if(Vrms_chA_cal > v1_threshmin && Vrms_chA_cal < v1_threshmax) {
    test1 = true;
    //#ifdef DEBUG
    Serial.println("L1 voltage reading is within valid range for 120 volt phase line.");
    //#endif
  } else if(Vrms_chA_cal >= v1_neutralmin && Vrms_chA_cal < v1_neutralmax) {
    //#ifdef DEBUG
    Serial.println("L1 voltage reading is within valid range for neutral.");
    //#endif
  } else if(Vrms_chA_cal > v1_threshmax) {
    //#ifdef DEBUG
    Serial.println("L1 voltage reading is too high.");    
    //#endif
    test1high = true;
    charge.lvlfail = true;
  } else {
    //#ifdef DEBUG
    Serial.println("L1 voltage is in between 10 and 115 V. It's too low for valid voltage");
    Serial.println("L1 voltage is a fail.");
    //#endif
    test1low = true;
    charge.lvlfail = true;
  } 

  bool test2high = false;
  bool test2low = false;

   
  if(Vrms_chB_cal > v2_threshmin && Vrms_chB_cal < v2_threshmax) 
  {
    test2 = true;
    //#ifdef DEBUG
    Serial.println("L2 voltage reading is within valid range for 120 volt phase line.");
    //#endif
  } 
  else if(Vrms_chB_cal >= v2_neutralmin && Vrms_chB_cal < v2_neutralmax) 
  {    
    //#ifdef DEBUG
    Serial.println("L2 voltage reading is within valid range for neutral.");
    //#endif
  } 
  else if(Vrms_chB_cal > v2_threshmax) 
  {    
    //#ifdef DEBUG
    Serial.println("L2 voltage reading is too high.");    
    Serial.println("L2 voltage is a fail");
    //#endif
    test2high = true;
    charge.lvlfail = true;
  } 
  else 
  {    
    //#ifdef DEBUG
    Serial.println("L2 voltage is below threshold and too high for a neutral.");
    Serial.println("L2 voltage is a fail.");
    //#endif
    test2low = true;
    charge.lvlfail = true;
  } 
 
  //test1 = true; test2 = true; //made test1 and test2 variables 1
  if(test1 && test2) 
  {
    charge.lv_2 = true;    
    //#ifdef DEBUG
    Serial.println("Level 2 voltage set for charger.");    
    //#endif
  } 
  else if(test1 && !test2) 
  {
   // #ifdef DEBUG
    Serial.println("Level 1 voltage set for charger.");    
    //#endif
    charge.lv_1 = true;
  } 
  else if(!test1 && test2) 
  {
    //#ifdef DEBUG
    Serial.println("Voltage is detected but they are backwards. Charger failed test.");    
   // #endif    
    charge.lvlfail = true;
  } 
  else 
  {
    charge.lvlfail = true;
    charge.groundfail = true;
   // #ifdef DEBUG
    Serial.println("Charge level detection has failed. GROUNDOK test failed.");
    //#endif
  }

  
}
/*digitalWrite(relayenable, LOW); // when this is low, the enable pin is valid   
  digitalWrite(relay1, LOW); //change relay state 
  digitalWrite(relay2, LOW); //change relay state
  delay(1000);
  digitalWrite(relayenable, HIGH); // turn off relay enable pin*/
  
