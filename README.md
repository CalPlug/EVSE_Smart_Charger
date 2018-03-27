# EV_Smart_Charger
---
Example ESP32-WROOM-32 application demo: operation of Electric Vehicle Supply Equipment (EVSE) Smart Charger that connects to the internet and MQTT server which will allow EV owners to control the charging schedules and monitor power consumption. Uses Smartenit MQTT format. 

Example Application note for ESP32-WROOM-32

Created by Andy Begey, Brandon Metcalf, Luis Contreras, Shermaine Dayot 

Project Managers: Dr. Michael Klopfer, Prof. GP Li. 

University of California, Irvine - California Institute for Telecommunications and Information Technology (Calit2)  

Copyright (C) The Regents of the Univeristy of California, 2018

Released into the public domain.

# Installation
---
Required tasks needed for the project: 

1.) Install Arduino ESP32 on Windows using this link: https://github.com/espressif/arduino-esp32/blob/master/docs/arduino-ide/windows.md

2.) Install ADE7953-Wattmeter-master into Arduino library which can be found in the EVSE_Smart_Charger github. 
    Go to: EVSE code->Arduino->libraries->ADE7953-Wattmeter-master for ESP32.

3.) Use the library "esp32-hal-spi.h" for SPI. Can be obtained from doing the first task. 

# Building 
---
After following the steps for installation, you can start by creating an account on your desired MQTT broker for testing purposes. It comes in many types of flavors, but our personal favorite and recommendation is CloudMQTT. Go to this link: https://www.cloudmqtt.com/. After you have created your account, prepare to gather the mqtt user, password, port and server because you need these in order to connect with your server. You also need to prepare your desired network name and password. It is very important to note that the ESP32 is itself an access point initally and that you would need to create its own server where the user can input their own MQTT server and Network for the ESP32 to connect to. In the initial stages of testing your software without implementing the ESP32 as its own access point, you would need to hardcode the information you have gathered in the beginning. 

# Background of Operation 
---
Assuming that the ESP32 was its own access point, the way to get it to connect to the internet is to get on an internet enabled device and type the IP address onto the server. Then the user would provide information that's been asked in the server. After providing the information, it connects to the desired network and MQTT server. There, the user is able to ask for stats about the charging conditions, and the output should be implemented by the developer. 

# Usage
---

# Demo 
---


