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

// ADE7953 SPI functions 
#define local_SPI_freq 1000000  //Set SPI_Freq at 1MHz (#define, (no = or ;) helps to save memory)
#define local_SS 14  //Set the SS pin for SPI communication as pin 5  (#define, (no = or ;) helps to save memory)
ADE7953 myADE7953(local_SS, local_SPI_freq);

time_t Wt; // wattmeter checks every 10 

int relayEnable = 0;

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
}

void loop() {
  // put your main code here, to run repeatedly:
  
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
        Serial.print("Active Power: ");
        Serial.println(myADE7953.getInstActivePowerA());
        //charge.watttime = true;
        //charge.chargeCounter = 0;
        //charge.ADemandCharge = 0.0;
      //  Wt = time(NULL);
      relayEnable = 1;
  }

}
