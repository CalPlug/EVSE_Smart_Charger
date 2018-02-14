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

int initializeGFI(void);
void InitializeCharge(ChargeState* charge);
void LevelDetection(ChargeState* charge);
void readPilot(ChargeState* charge);
void setRelay(ChargeState* charge);
void readWattmeterSPI(void);
void save2Flash(void);

int main() {
	// must call this function to initialize the API
	// must be called after every reset and wake-up
	// don't use if we're using the JenOS
	// Only if we're developing ZigBee PRO applications
	u32AHI_Init();

	// Do we need to vary transmission power?
	// eAppApiPlmeSet(PHY_PIB_ATTR_TX_POWER, x);


	// supports only up to three slaves for SPI!
	// DO0 outputs the Clock (SPICLK), DO1 for Data
	// (SPIMISO) and DIO18 for Data Out (SPIMOSI)
	// Three slave select output lines can be used. SPISEL0,
	// SPISEL1, and SPISEL2. These lines can be moved (ch 14.1)

	uint8 SPINUM = 2;
	// wattmeter and flash
	// remember to ask what flash is... o_o - Luis
	uint8 clockdivider = 2;
	vAHI_SpiConfigure(SPINUM, true, false, false, 1, true, false);
	/* # of spi slaves to control, enabled transfer w/
	   least significant bit, clock polarity unchanged, latching
	   data on leading edge of clock, peripheral clock is divided
	   by 2 * clockdivider,  enabled interrupts when SPI transfer
	   is complete, disabled automatic slave selection
	   vAHI_SpiConfigure(SPINUM, true, false, false, 1, true, false);
	*/
	ChargeState charge;
	int check = initializeGFI();
	// checks to see if GFItest failed
	if(check != 0) {
		return 0;
	}
	InitializeCharge(&charge);
	LevelDetection(&charge);
}
int initializeGFI(void) {
	uint32 value = u32AHI_DioReadInput();
	uint32 test = 1;
	/* test needs to be modified so that the input matches up
	with the GPIO being used to send GFI data*/
	test &= value;
	if(test != 1/* number that corresponds to the gpio that needs to be checked. we'll use gpio0 as an example */ ){
		#ifdef DEBUG
		printf("The GFI test failed!\n");
		#endif
		return 1;
	}
	return 0;

}
void save2Flash(void) {

}

void InitializeCharge(ChargeState* charge) {
	charge->pwm_high = 12;
	charge->pwm_low = 12;

}

void readWattmeterSPI(void){
	uint8 slave = 1;
	// slave select works by enabling a single bit in
	// slave variable. Each bit corresponds to a different slave
	// apparently vAHI_SpiSelect(0) clears active slave-select lines
	vAHI_SpiSelect(slave);

	uint8 charlength = 7;
	uint32 DataOut = 1;
	vAHI_SpiStartTransfer(charlength, DataOut);
	uint32 dataread = u32AHI_SpiReadTransfer32();
	vAHI_SpiStop(); // clears any active slave-select lines


	// this should be able to read the wattmeter through the SPI.
	// need to convert this uint32 into an integer
}
void LevelDetection(ChargeState* charge) {
	uint32 value = u32AHI_DioReadInput();
	uint32 test = 10240;
	uint32 result = test & value;

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

void readPilot(ChargeState* charge) {
	char state = 'A';
	Set_State(&charge, state);
}

void setRelay(ChargeState* charge) {
	u32AHI_DioReadInput(void);
	
	bool DC_Relay1, DC_Relay2 = false;

	int P_H = charge->pwm_high;
	int P_L = charge->pwm_low;
	bool lvl1 = charge->lvl_1;
	bool lvl2 = charge->lvl_2;
	uint32 ON;
	uint32 OFF = 0;
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
			ON = 0b0100; //for now where the 3rd bit is DC_Relay1
		}
		else if(lvl1 == true && lvl2 == true){
			DC_Relay1 = true;
			DC_Relay2 = true;
			ON = 0b0101; //for now where 3rd bit is DC_Relay1 and 1st is DC_Relay2
		}
		else if(lvl1 == false && lvl2 == true){
			DC_Relay1 = false;
			DC_Relay2 = false;
			ON = 0;
			
		}
	
	vAHI_DioSetOutput(uint32 ON, uint32 OFF);
	}

	#ifdef DEBUG
		printf("P_H is: %d\nP_L is: %d\n", P_H, P_L);
	#endif
	charge->relay1 = DC_Relay1;
	charge->relay2 = DC_Relay2;
	return;
}
