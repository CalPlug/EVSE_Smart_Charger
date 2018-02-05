#include <stdio.h>
#include <stdlib.h>

typedef struct {
	int pwm_high, pwm_low;
	/*string MQTT_message;*/
	char state;
	//bool relay1, relay2;
	int lvl_1, lvl_2;
} ChargeState;

void setrelay(ChargeState *charge);
int main(){
	ChargeState charger;
	charger.pwm_high = 9;
	charger.pwm_low = -12;
	charger.lvl_1 = 1;
	charger.lvl_2 = 0;
	setrelay(&charger);

}
void setrelay(ChargeState *charge) {
	int DC_Relay1, DC_Relay2;

	int P_H = charge->pwm_high;
	int P_L = charge->pwm_low;
	int lvl1 = charge->lvl_1;
	int lvl2 = charge->lvl_2;

	if (P_H == 12 && P_L == 12){
		/*not connected*/
		DC_Relay1 = 0;
		DC_Relay2 = 0;
		charge->state ='A';
		printf("blah");
	}

	if (P_H == 9 && P_L == -12){
		/*EV connected (ready)*/
		if(lvl1 == 1 && lvl2 == 0){
			DC_Relay1 = 1;
			DC_Relay2 = 0;
			printf("LOL LOL LOL");
		}
		else if(lvl1 == 1 && lvl2 == 1){
			DC_Relay1 = 1;
			DC_Relay2 = 1;
		}
		else if(lvl1 == 0 && lvl2 == 1){
			DC_Relay1 = 0;
			DC_Relay2 = 0;
		}
		charge->state ='B';
		printf("state = %c", charge->state);
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