1. Introduction

In order to run the main program script on the Circuit Banditos EVSE Smart Charger,
certain steps must be followed before attempting to run the program. It is suggested 
that the user have access to an internet connection to fully appreciate the complete functionality 
of the smart charger. I have compiled a list of requirements that are needed to use the
internet capabilities:

	1. Internet Connection
	
	2. Access to a MQTT broker-
		Free accounts can be made on CloudMQTT. Access to an MQTT broker is required to 
		control the smart charger over the internet.

	3. Access to the initialize_EEPROM script- 
		This script should come in conjunction with the main programming script. If not
		it can be found at the following repository 
		https://github.com/CalPlug/EVSE_Smart_Charger/tree/master/EVSE%20code/Arduino
	
	4. Access to the brandy_testEEPROM script-
		This is the main program script and the most recent available script as of 
		5/24/18. This can also be found with the initialize_EEPROM script using the same 
		link listed above.	

	4. Bootloader and smart charger itself

	5. Arduino IDE 

2. Procedures

In order to use the internet capabilities of the smart charger, the microcontroller's EEPROM must 
be initialized with MQTT broker credentials in addition to Wi-Fi credentials. These can be uploaded
manually using the initialize_EEPROM script. This will require the following credentials to use with the
smart charger:

	-Wi-Fi SSID
	-Wi-Fi password
	-MQTT server name
	-MQTT Port number
	-MQTT Username
	-MQTT Password
	
WARNING!: 
If the main script is running on the smart charger it will not be able to 
get pass the initialization phase because it will be unable to find your credentials
stored on the EEPROM!
Make sure that this script is run first on a virgin board before attemping to run 
the main program script!

Attach the bootloader to the Smart Charger and plug the other end to your computer
USB port. 
Open the initialize_EEPROM script on the Arduino IDE. 

Press Ctl+L to open up the "Go to line" function on the Arduino IDE. 
Type in 62 in the "Line Number" text box and hit "OK" to continue. 

You should see the following lines:

  const char ssid[] = "microsemi";
  const char pwd[] = "microsemicalit212345";
  const char mqtt_server[] = "m11.cloudmqtt.com";
  const char mqtt_port[] = "19355";
  const char mqtt_user[] = "dqgzckqa";
  const char mqtt_pwd[] = "YKyAdXHO9WQw";
  const char GFI[] = "800";
  const char level1[] = "20";
  const char level2[] = "20";

Here is where you will make your modifications to use with the smart charger. It is
also possible to adjust the parameters for GFI and Level 1/2 charger.
When completed, save the script and upload the program to the smart charger. 
Once the program is done compiling, you will see that the Arduino IDE is attempting 
to communicate with the Microcontroller designated by a pattern of underscores and periods. 

You'll need to hold down the reset button and the boot button at the same time, and release 
the reset button after 1 second.

Verify that the credentials are saved onto the EEPROM by checking the serial monitor 
button on the top right corner. It may be possible that the microcontroller will need
to be reset first before seeing any activity on the serial monitor. 

You will see the script saving and loading your credentials onto the EEPROM if done 
correctly.

Once complete, you can run the main program script on the smart charger. Open up the 
brandytest_EEPROM script and upload the program using the same procedures listed above. 
Nothing needs to be modified on the brandytest_EEPROM to use your new credentials. 

Verify through the serial monitor that the program is reading your credentials correctly.

Congratulations! You are now ready to use the board!


