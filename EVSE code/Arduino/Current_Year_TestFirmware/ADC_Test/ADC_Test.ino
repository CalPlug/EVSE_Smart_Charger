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

const int dutyout = 25;
int pilotresolution = 13; // for Pilot PWM, be careful range is modified. Changing this value will not propogate everything required. Must update both intermediate value range AND mapping
time_t Rp;

int ADC_A = 5925; // ADC value when not plugged and not charging (center point)
int ADC_Athreshold = 150; // ADC threshold when not plugged and not charging (variance threshold) Plus and minus

int ADC_B = 5242; // ADC value when plugged and not charging (center point)
int ADC_Bthreshold = 150; // ADC threshold value when plugged and not charging (variance threshold)Plus and minus

int ADC_C = 3480; // ADC value when plugged and charging (center point)
int ADC_Cthreshold = 150; // ADC threshold value when plugged and not charging (variance threshold)Plus and minus

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

// main struct to hold important variables
ChargeState charge;

void setup()
{
// this function is related to the PWM signal output coming from the charger.
  // the duty cycle on this pin represents the amount of charge going into the EV.
  ledcAttachPin(dutyout, 4);
  ledcSetup(4, 1000, pilotresolution); // pilot duty cycle resolution. 1000 Hz
  #ifdef DEBUG
  Serial.println("PWM signal created and initialized");
  #endif  

  ledcWrite(2, 500);

// Analog to Digital Converter setup
  // ADC channel uses Sensor_Vn to read the input for the ADC
  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_3, ADC_ATTEN_DB_11);
  #ifdef DEBUG
  Serial.println("ADC Pin initialized");
  #endif
  delay(500);
}

void loop()
{
   // helper function for read pilot
// is supposed to help obtain consistent values from ADC
// This uses a non-linear median function to remove extraneous values

  int a, b, c, middle, counter, average;
  a = adc1_get_raw(ADC1_CHANNEL_3);
  //delayMicroseconds(1); // Must be within the minimum period to pass median filter
  b = adc1_get_raw(ADC1_CHANNEL_3);
  //delayMicroseconds(1); // Must be within the minimum period to pass median filter
  c = adc1_get_raw(ADC1_CHANNEL_3);
  if ((a <= b) && (a <= c)) {
    middle = (b <= c) ? b : c;
  } else if ((b <= a) && (b <= c)) {
    middle = (a <= c) ? a : c;
  } else {
    middle = (a <= b) ? a : b;
  }


// Reads ADC coming the pilot signal on the J1772
// This sets the state on the charger automatically in order to 
// turn off loads, or to determine if the charger is connected to the car
// So far only works for 5 - 40Amps

    //Serial.println("readPilot called");
    Rp = time(NULL);
  if(difftime(time(NULL), Rp) >= .1 && counter !=0){ // this checks the average of pilot every 1/10 of second
    int high = 0;
    int count = 0;
    for(int i = 0; i < 25000; i++) { // sample regularly across periodic pilot signal -- absolute maximum number of loop runs, high number for low duty cycle to make sure pilot read occurs
      
      
      if(high <= 10) { // if reading is at the bottom of the square wave of the pilot throw this out.Assume anything below 0 is the bottom of the square wave.
        continue;
      }
      count++;
      average += high; // this is a running total until the averaging function is run      
      Serial.println("This is average high: ");
      Serial.println(average);
      if(count >= 2000) 
        break; // limit total number of reads if pilot read is good, generally okay for high duty cycles
       
      delayMicroseconds(115); // delay in reading period. Must be shorted than period by Nyquist sampling theorem.
    } 

    if(count == 0) // avoids divide by zero if no readings are taken
      count++;
      Serial.println("This is count:");
      Serial.println(count);
    average /= count; // running total based on total counted reads comprising the running sum. read multiple times to produce average to get stable pilot reading            
    Serial.println("This is average count: ");
    Serial.println(average);
    average = (average * 50) / charge.chargerate; // Used to produce consistent value to determine charging state
    Serial.println("This is average average: ");
    Serial.println(average);
    #ifdef PILOT
    Serial.print(count);    
    Serial.print(" points averaged yielding average with modification: ");    
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

    if(abs(ADC_A - average) <= ADC_Athreshold) { // state not plugged in not charging
      if(charge.state != 'A'){
        charge.state = 'A';
        charge.statechange = true;
        charge.diodecheck = false;
        Serial.println("We are in State A");
      }
    }
    else if (abs(ADC_B - average) <= ADC_Bthreshold ){ // state plugged in not charging
      if(charge.state != 'B') {        
        charge.state = 'B';
        charge.statechange = true;
        charge.diodecheck = false;
        Serial.println("We are in State B");
      } 
    } // 597
    else if(abs(ADC_C - average) <= ADC_Cthreshold) { // state plugged in charging
      if(charge.state != 'C') {
        charge.state = 'C';
        charge.statechange = true;
        charge.diodecheck = false;
        Serial.println("We are in State C");
      }
    } else{
      if(charge.state != 'F'){
        charge.state = 'F';
        charge.statechange = true;
        charge.diodecheck = true;
        Serial.println("We are in State F");
      }
      
    }
    average = 0;
    counter = 0;
    Rp = time(NULL);    
  }
  
  counter++;
  
  

  // if the reading isn't within a given range tolerance of 90, the read will default to 
  // state nine, which signals that we're getting weird voltage values
  // Update: Apparently, you cannot read a negative voltage on Arduino. I'm 
  // sure it applies to ESP32 as well. The problem is that we need to read the 
  // duty cycle of the pin to determine the maximum charge rate of the car that 
  // it can accept. 
 
}
