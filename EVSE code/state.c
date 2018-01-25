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

}

void setrelay(ChargeState *charge) {
	int DC_Relay1, DC_Relay2;
	
	int P_H = charge->pwm_high;
	int P_L = charge->pwm_low;
	int lvl1 = charge->lvl_1;
	int lvl2 = charge->lvl_2;
	
	if (x == 12 && y == 12){
		/*not connected*/
		DC_Relay1 = 0;
		DC_Relay2 = 0;
		charge->state ='A';
	}

	if (P_H == 9 && P_L == -12){
		/*EV connected (ready)*/
		if(lvl1 == 1 && lvl2 == 0){
			DC_Relay1 = 1;
			DC_Relay2 = 0;
		}
		else if(i == 1 && j == 1){
			DC_Relay1 = 1;
			DC_Relay2 = 1;
		}
		else if(i == 0 && j == 1){
			DC_Relay1 = 0;
			DC_Relay2 = 0;
		}
		charge->state ='B';
	}

	if (P_H == 6 && P_L == -12){
		/*EV charge*/
		if(lvl1 == 1 && lvl2 == 0){
			DC_Relay1 = 1;
			DC_Relay2 = 0;
		}
		if(lvl1 == 1 && lvl2 == 1){
			DC_Relay1 = 1;
			DC_Relay2 = 1;
		}
		if(lvl1 == 0 && lvl2 == 1){
			DC_Relay1 = 0;
			DC_Relay2 = 0;
		}
		charge->state='C';
	}

	if (P_H == 3 && P_L == -12){
		if(lvl1 == 1 && lvl2 == 0){
			DC_Relay1 = 1;
			DC_Relay2 = 0;
		}
		if(lvl1 == 1 && lvl2 == 1){
			DC_Relay1 = 1;
			DC_Relay2 = 1;
		}
		if(lvl1 == 0 && lvl2 == 1){
			DC_Relay1 = 0;
			DC_Relay2 = 0;
		}
		charge->state='D';
	}

	if (P_H == 0 && P_L == 0){
		/*ERROR*/
		DC_Relay1 = 0;
		DC_Relay2 = 0;
		charge->state='E';
	}
		

	if (P_H == -12 && P_L == -12){
		/*ERROR*/
		DC_Relay1 = 0;
		DC_Relay2 = 0;
		charge->state='F';
	}
	return 0;
}

