#include <dummy.h>
#include "esp32-hal-spi.h"
#include "esp32-hal-adc.h"
#include <WiFi.h>
#include "PubSubClient.h"
#include <Time.h>
#include <driver/adc.h>
#include "ADE7953ESP32.h"
#include <SPI.h>
#include <DNSServer.h>
#include <EEPROM.h>
#include <esp32-hal-gpio.h>

const int relay1 = 32;
const int relay2 = 33;
const int relayenable = 21; // output
//NONLINEAR REGRESSION VALUE
double StateAThresholdLookupBase = 7.7303; 
double StateAThresholdLookupInter = 2367.7; 

double StateBThresholdLookupBase = 17.409; 
double StateBThresholdLookupInter=2120.1;
//double StateBThresholdLookupInter = 2120.1;  

double StateCThresholdLookupBase = 3.3321; //1966.7;
double StateCThresholdLookupInter  = 1401.8; //-0.99;

double ThresholdLookupThresholdBase = 20.021;
double ThresholdLookupLookupInter  = -0.451;


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


// ADE7953 SPI functions 
#define local_SPI_freq 1000000  //Set SPI_Freq at 1MHz (#define, (no = or ;) helps to save memory)
#define local_SS 14  //Set the SS pin for SPI communication as pin 5  (#define, (no = or ;) helps to save memory)
ADE7953 myADE7953(local_SS, local_SPI_freq);

time_t Wt; // wattmeter checks every 10 
time_t Rp; // pilot averages readings every 1/10 second

int relayEnable = 0;
int pilotfreq = 1000;
int resolution = 10; // for LED PWM
int pilotresolution = 13; // for Pilot PWM, be careful range is modified. Changing this value will not propogate everything required. Must update both intermediate value range AND mapping

// variables to keep track of the data line on ADC
int average = 0;
int counter = 0;
const int pilotout = 25;

float requestedCurrentinAMPS= 1.5;

// helper function for read pilot
// is supposed to help obtain consistent values from ADC
// This uses a non-linear median function to remove extraneous values
int ADCmedianValueRead(void) {
  int a, b, c, middle;
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
    //return a; //returns either the first value or the one furthest away from the threshold fail
    return (a+b/2); //The alternative is a quick integer division to average the valid readings
  } 
  else if (bvalid == 1 && cvalid == 1)
  {
    //return b;  //returns either the first value or the one furthest away from the threshold fail
    return (b+c/2); //The alternative is a quick integer division to average the valid readings
  } 
  else if (avalid == 1 && cvalid == 1)
  {
    //return a; //returns either the first value or the one furthest away from the threshold fail
    return (a+c/2); //Likely not a good approach for averaging two sides of a discontinuity - he alternative is a quick integer division to average the valid readings
  } 
  else
  {} //default case that never should be entered because one value is OK
  }
  else
  {
    return 0;  //default case that should never be entered
  }
}

// Reads ADC coming the pilot signal on the J1772
// This sets the state on the charger automatically in order to 
// turn off loads, or to determine if the charger is connected to the car
// So far only works for 5 - 40Amps
void readPilot(void) {
     int lowernoisethreshold = 10;
  if(difftime(time(NULL), Rp) >= .1 && counter !=0){ // this checks the average of pilot every 1/10 of second
    int high = 0;
    int count = 0;
    int success_count=0;
    
    if (requestedCurrentinAMPS<=0.99){
       Serial.print("WARNING REQUESTD CURRENT UNDER SPEC OF 1A, MIGHT RESULT IN IRREGULAR STATE CHANGE ");  

     }
            
    for(int i = 0; i < 25000; i++) { // sample regularly across periodic pilot signal -- absolute maximum number of loop runs, high number for low duty cycle to make sure pilot read occurs
     if (requestedCurrentinAMPS>=0.9){
        high = adc1_get_raw(ADC1_CHANNEL_3);//non-median filter single read.

     }
     if (requestedCurrentinAMPS>3.5){
        high = ADCmedianValueRead(); //ThresholdedADCmedianValueRead(lowernoisethreshold);
      }
     if (requestedCurrentinAMPS<=3.5){
      high = adc1_get_raw(ADC1_CHANNEL_3);//non-median filter single read.
     }
      //high = adc1_get_raw(ADC1_CHANNEL_3);//non-median filter single read.
      //high = ADCmedianValueRead(); // median value of ADC value is return 
      //high=ThresholdedADCmedianValueRead(lowernoisethreshold);
      
      if(high <= lowernoisethreshold) { // if reading is at the bottom of the square wave of the pilot throw this out.Assume anything below 0 is the bottom of the square wave.
        success_count++;
        
        continue;
      }
      count++;
      average += high; // this is a running total until the averaging function is run      
      if(count >= 10000) 
        break; // limit total number of reads if pilot read is good, generally okay for high duty cycles
       
      //delayMicroseconds(1); // delay in reading period. Must be shorted than period by Nyquist sampling theorem.
    } 

    if(count == 0) // avoids divide by zero if no readings are taken
      count++;
      //save_div--> int x, int y. if int y =0 return 0, else do x/y.
    average /= count; // running total based on total counted reads comprising the running sum. read multiple times to produce average to get stable pilot reading            
    
    //average = (average * 50) / requestedCurrentinAMPS; // Used to produce consistent value to determine charging state

    Serial.print(count);    
    Serial.print(" points averaged yielding average with modification: ");    
    Serial.println(average);

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
    
    float ADC_A_nonlinear = StateAThresholdLookupBase*log(requestedCurrentinAMPS) + StateAThresholdLookupInter;//StateAThresholdLookupBase*pow(reqcurrentA,StateAThresholdLookupInter);
    float ADC_B_nonlinear = StateBThresholdLookupBase*log(requestedCurrentinAMPS) + StateBThresholdLookupInter;//StateBThresholdLookupBase*pow(reqcurrentA,StateBThresholdLookupInter);
    float ADC_C_nonlinear = StateCThresholdLookupBase*log(requestedCurrentinAMPS) + StateCThresholdLookupInter;//StateCThresholdLookupBase*pow(reqcurrentA,StateCThresholdLookupInter);
    Serial.print("ADC_A_nonlinear: ");    
    Serial.println(ADC_A_nonlinear);
    Serial.print("ADC_A: ");    
    Serial.println(ADC_A);
    Serial.println("--------------------------- ");    
    Serial.print("ADC_B_nonlinear: ");    
    Serial.println(ADC_B_nonlinear);
    Serial.print("ADC_B: ");    
    Serial.println(ADC_A);
     Serial.println("--------------------------- ");  
    Serial.print("ADC_C_nonlinear: ");    
    Serial.println(ADC_C_nonlinear);
    Serial.print("ADC_C: ");    
    Serial.println(ADC_C);
    if(average >= (ADC_A-ADC_Athreshold)) { // state not plugged in not charging
      if(average<=ADC_A_nonlinear){
        if(average>=ADC_B){
             Serial.println(" STATE A "); 
         }
        }
      }
      

     if(average <= ADC_B) { // state plugged in not charging
      if(average<=ADC_B_nonlinear){
         if(average>=(ADC_C+ADC_Bthreshold)){
             Serial.println(" STATE B "); 
         }
        }
      }

      if(average >= (ADC_E+ADC_Ethreshold)) { // state plugged in charging
      if((ADC_C + ADC_Ethreshold)>=average && average<=ADC_C_nonlinear+ADC_Ethreshold){
        Serial.println(" STATE C "); 
        }
      }
  
  }
  
  counter++;
  
  

  // if the reading isn't within a given range tolerance of 90, the read will default to 
  // state nine, which signals that we're getting weird voltage values
  // Update: Apparently, you cannot read a negative voltage on Arduino. I'm 
  // sure it applies to ESP32 as well. The problem is that we need to read the 
  // duty cycle of the pin to determine the maximum charge rate of the car that 
  // it can accept. 
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  // turn off the relays initially for safety reasons. If the device resets for whatever reason
  // the relays could possibly still be on from prior operations.
  #ifdef DEBUG
  Serial.println("Turning on relay enable pin! Setting relays off!");
  #endif
  //RELAYS ARE LATCHING-ENABLE SET TO LOW ACTIVATES WRITING OF OTHER TWO PINS OF RELAY.
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

  ledcSetup(0, pilotfreq, pilotresolution);
  ledcAttachPin(pilotout, 0);
 
  
    delay(7);
  
  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_3, ADC_ATTEN_DB_11);
  
   Serial.println("ADC Pin initialized");
  
 
}

float pwmDutyCycleLookup(float requestedCurrent) { //Map requested current (in Amps) to duty cucle in decimal percent using the J1772 standard, top off at 80A, anything above this is returned to the PWM value for 80A.
  float calculatedPWMValue = 0;
  #ifdef DEBUG
  Serial.println("J1772 Current Lookup Function Called");
  Serial.print("Input Requested Current: ");
  Serial.println(requestedCurrent);
  #endif
  //NEED AMPS
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
void loop() {
  // put your main code here, to run repeatedly:
  readPilot();
  
  if (relayEnable == 0){
       // #ifdef DEBUG
        Serial.println("The charger is now in charging state! Turning on relays.");
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
//      int adc_val= adc1_get_voltage(ADC1_CHANNEL_3);
//        Serial.println("adc_val");
//        Serial.println(adc_val);
//        delay(1000);

}
