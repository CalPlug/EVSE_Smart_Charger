EVSE Desktop Application
=======================
 
This Processing 3.0 Application is made to communicate with the
EVSE Smart Charger. By connecting to the same MQTT broker,
the application can request real-time data from the EVSE
Charger and display it in an interactive GUI. The GUI
provides the ability to switch to other device MQTT topics
and request a current.

##How to Change Device

The device's MAC address is displayed on top of the GUI.
This is the MAC address used in the MQTT topics that the 
application is subscribing and publishing to. By changing
the MAC address and clicking "Change Device" button, the
application will change the topics it is publishing and 
subscribing to.

CAUTION: The application will not notify you if the MAC 
address entered is a valid MQTT topic. You can only 
indirectly infer that when there has been no response
after publishing to that topic.

##How to Request Current

Simply type in an integer into the box from 600 to 3000,
which will be interpreted by the EVSE charger as (6.00 A
to 3000 A)If the number not entered is not within these 
bounds, it the application will automatically clip it.