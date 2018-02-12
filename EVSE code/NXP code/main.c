#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <AppHardwareApi.h>
#include <AppApi.h>

//#define DEBUG

typedef struct {
	int pwm_high, pwm_low;
	char state;
	bool relay1, relay2;
	bool lvl_1, lvl_2;
} ChargeState;

typedef int bool;
enum {false, true};

void LevelDetection(ChargeState* charge);

int main() {
	// must call this function to initialize the API
	// must be called after every reset and wake-up
	// don't use if we're using the JenOS
	// Only if we're developing ZigBee PRO applications
	u32AHI_Init();

	// Do we need to vary transmission power?
	// eAppApiPlmeSet(PHY_PIB_ATTR_TX_POWER, x);


	ChargeState charge;
	LevelDetection(&charge);
}

void LevelDetection(ChargeState* charge) {
	uint32_t value = u32AHI_DioReadInput();
	uint32_t test = 10240;
	uint32_t result = test & value;

	if(result == 8192){
			charge->lvl_1 = true;
			charge->lvl_2 = false;
			#ifdef DEBUG
			printf("Level 1 charge\n");
			#endif
		}
		else if(result == 0){
			charge->lvl_1 = false;
			charge->lvl_2 = true;
			#ifdef DEBUG
			printf("Level 2 charge\n");
			#endif
		}
		else {
			charge->lvl_1 = false;
			charge->lvl_2 = false;
			#ifdef DEBUG
			printf("No level charge detected\n");
			#endif

		}
}

void setRelay(ChargeState* charge) {
	bool DC_Relay1, DC_Relay2;

	int P_H = charge->pwm_high;
	int P_L = charge->pwm_low;
	bool lvl1 = charge->lvl_1;
	bool lvl2 = charge->lvl_2;

	if ((P_H == 12 &&  P_L == 12) || (P_H == 0 &&  P_L == 0) || (P_H == -12 &&  P_L == -12)){
		/*not connected*/
		DC_Relay1 = false;
		DC_Relay2 = false;

	}

	else if ((P_H == 9 && P_L == -12) || (P_H == 6 && P_L == -12) || (P_H == 3 && P_L == -12)){
		/*EV connected (ready)*/
		if(lvl1 == true && lvl2 == false){
			DC_Relay1 = true;
			DC_Relay2 = false;
		}
		else if(lvl1 == true && lvl2 == true){
			DC_Relay1 = true;
			DC_Relay2 = true;
		}
		else if(lvl1 == false && lvl2 == true){
			DC_Relay1 = false;
			DC_Relay2 = false;
		}

	}

	#ifdef DEBUG
		printf("P_H is: %d\nP_L is: %d\n", P_H, P_L);
	#endif
	charge->relay1 = DC_Relay1;
	charge->relay2 = DC_Relay2;
	return;
}
