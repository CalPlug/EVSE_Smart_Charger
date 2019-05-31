/* ESP32 based EVSE electric vehicle supply equipment charge controller
EEPROM UPDATER/Initializer Program
Project Team: Circuit Banditos (Andy Begey, Luis Contreras, Shermaine Dayot, Brandon Metcalf)
Major Post Project Revisions by: Luis Contreras 
Version 1.0: 5/31/18
Copyright: 
Reagents of Univesity of California, Irvine
Released into public domain
*/
//NOTE: This code is run on a virgin ESP32 module to initialize the EEPROM prior to flashing main code.  Modify value sin this code and re-flash to update default values cached in the EEPROM - this should be a rare thing to do.

#include <EEPROM.h>

#define NUM_ELEMENTS 10
char data2[150];

void save_data(char* data)
{
  Serial.println("Write data to EEPROM");
  EEPROM.begin(512);
  for (int i = 0; i < strlen(data); ++i)
  {
    EEPROM.write(i, (int)data[i]);
    delay(1);
  }
  EEPROM.commit();
  Serial.println("Write data complete");
  delay(1000);
}

void load_data(char* data)
{
  Serial.println("Read data from EEPROM");
  EEPROM.begin(512);
  int count = 0;
  int address = 0;
  while (count < NUM_ELEMENTS)
  {
    char read_char = (char)EEPROM.read(address);
    delay(1);
    strncat(data, &read_char, 1);
    if (read_char == '#')
      ++count;
    ++address;
  }
  Serial.println("Read data complete");
  Serial.println(data);
  delay(1000);
}

void wipe_data() 
{
  Serial.println("Wipe EEPROM");
  char* sep = "#";
  EEPROM.begin(512);
  for (int i = 0; i < NUM_ELEMENTS; ++i)
  {
    EEPROM.write(i, (int)sep);
    delay(1);
    EEPROM.write(i, 50);
    delay(1);
  }
  EEPROM.commit();
  Serial.println("Wipe data complete");
}

void setup() {
  Serial.begin(115200);
  Serial.println();
  Serial.println();
  Serial.println("HELLO PROGRAM");
  const char configured[] = "0";  
  const char ssid[] = "UCInet Mobile Access";
  const char pwd[] = "";
  const char mqtt_server[] = "m11.cloudmqtt.com";
  const char mqtt_port[] = "19355";
  const char mqtt_user[] = "dqgzckqa";
  const char mqtt_pwd[] = "YKyAdXHO9WQw";
  const char GFI[] = "800";
  const char level1[] = "270";
  const char level2[] = "270";

  wipe_data();
  char* sep = "#";
  char data[150] = {};
  strcat(data, configured);
  strcat(data, sep);
  strcat(data, ssid);
  strcat(data, sep);
  strcat(data, pwd);
  strcat(data, sep);
  strcat(data, mqtt_server);
  strcat(data, sep);
  strcat(data, mqtt_port);
  strcat(data, sep);
  strcat(data, mqtt_user);
  strcat(data, sep);
  strcat(data, mqtt_pwd);
  strcat(data, sep);
  strcat(data, GFI);
  strcat(data, sep);
  strcat(data, level1);
  strcat(data, sep);
  strcat(data, level2);
  strcat(data, sep);
  
  Serial.println("This is the final string:");
  Serial.println(data);
  Serial.println("The length is: ");
  Serial.println((unsigned)strlen(data));
  Serial.println();



  save_data(data);

  Serial.println("Second read:");
  
  load_data(data2);
  Serial.println(data2);



Serial.println("Run Complete");
delay (10000);

}


void loop() {
  // No looped code in this sketch
  delay (1000); //restarting waiting loop
  Serial.println();
}
