#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
	int status;
	string MQTT_sub;
} ESP8266;



typedef struct {
	// LEDS??? O_O_O_O_O_O_O_O_O_O_O_O_O_O
} LED;

typedef struct {
	int pwm_high, pwm_low;
	LED led;
	string MQTT_message;
	char state;
	bool relay1, relay2;	
	int lvl_1, lvl_2;
} ChargeState;

int read4relay(); // reads level for charging

int setrelay(int level); // sets the relays
/* 
0 both off
1 level 1
2 level 2
else both off 
to send 

0 failure
1 success
to receive 
*/
int ESP8266setup(ESP8266* client);
/*
1 failure
0 success
*/

int WattmeterSPI();

int groundfaultinterrupt();

int initilizeLED();

void Initialize();

int main(){
	
	ChargeState Charge;
	int Wifi_check;
	ESP8266 client;
	while(ESP8266setup(&client)) {
		printf("Not connecting online. Retrying...");
	}
	Initialize();
	
	
}

int Initialize(){
	
}

void ESP8266setup(ESP8266* client) {
	
}


int Set_State(int Pilot_High, int Pilot_Low)
{
char state; 

switch(state){
	
	case 'A': //not connected 
	Pilot_High = 12;
	Pilot_Low = 12;
	break;
	
	case 'B': //ev connected and ready 
	Pilot_High = 9;
	Pilot_Low = -12;
	break;
	
	case 'C': //ev charge 
	Pilot_High = 6;
	Pilot_Low = -12;
	break;
	 
	case 'D': //ev charge
	Pilot_High = 3;
	Pilot_Low = -12;
	break;
	
	case 'E': //error
	Pilot_High = 0;
	Pilot_Low = 0;
	break;
	
	case 'F': // unknown error
	Pilot_High = -12;
	Pilot_Low = -12;
	break;
	
	default: 
	printf("error");
	
}

if (state == 'A'){
	setrelay();

}