#include <stdio.h>
#include <stdlib.h>

int main(void) {
	int PilotHigh, PilotLow;
	int lvl1, lvl2;
	int DC_Relay1, DC_Relay2;

	printf("lvl1: \n");
	scanf("%d", &lvl1);
	printf("lvl2: \n");
	scanf("%d", &lvl2);
	printf("pilot high: \n");
	scanf("%d", &PilotHigh);
	printf("pilot low: \n");
	scanf("%d", &PilotLow);

	if (PilotHigh == 12 && PilotLow == 12){
		/*not connected*/
		DC_Relay1 = 0;
		DC_Relay2 = 0;
	}

	if (PilotHigh == 9 && PilotLow == -12){
		/*EV connected (ready)*/
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
	}

	if (PilotHigh == 6 && PilotLow == -12){
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

	}

	if (PilotHigh == 3 && PilotLow == -12){
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
	}

	if (PilotHigh == 0 && PilotLow == 0){
		/*ERROR*/
		DC_Relay1 = 0;
		DC_Relay2 = 0;
	}

	if (PilotHigh == -12 && PilotLow == -12){
		/*ERROR*/
		DC_Relay1 = 0;
		DC_Relay2 = 0;
	}

  printf("dc relay 1 is %d and dc relay 2 is %d\n", DC_Relay1, DC_Relay2);

	return 0;
}