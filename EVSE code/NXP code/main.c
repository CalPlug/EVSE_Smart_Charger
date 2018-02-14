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
void initializeGPIO(void);
void relaysOff(void);
void InitializePilotOutput(void);
int checkInterrupts(uint32 interrupt);
int checkGFI(uint32 interrupt);
int checkButtons(uint32 interrupt);
int checkCable(uint32 interrupt);

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
	initializeGPIO();
	int check = initializeGFI();
	// checks to see if GFItest failed
	if(check != 0) {
		return 0;
	}
	relaysOff();
	InitializeCharge(&charge);
	LevelDetection(&charge);

	InitializePilotOutput();
	// add connection to the zigbee network
	// if GFItest is successful and Zigbee connection is complete
	// we move onto inner while loop.
	bool go = true;
	uint32 interrupt = 0;

	while (go){
		readPilot(&charge);
		interrupt = u32AHI_DioInterruptStatus();
		if(interrupt != 0) {
			checkInterrupts(interrupt);
		}
	}
}


void readPilot(ChargeState* charge) {
	char state = 'A';
	Set_State(&charge, state);
}

// we'll determine if an interrupt has caused change within the program
int checkInterrupts(uint32 interrupt) {
	/* Ok so we're going to get an interrupt of 32 bits, but we
	 * don't know which one got triggered. So since we know which
	 * inputs should cause interrupts, we can create bitwise functions
	 * that manipulate the output. So, lets say we get
	 * 00001010 as an example. Pins 1 and 3 were triggered but we
	 * know it's possible for pin 4 to get triggered as well. Test
	 * for them all and call the appropriate function.
	 */
	/*
	 * uint32 test = 1;
	 * uint32 save = 0;
	 * save = (interrupt >>> 2) & test;
	 * if(save) {
	 * 	call respective function; :)
	 * }
	 *
	 */
	return 0;
}


void InitializePilotOutput() {
	// enables a pwm signal. Needs to be modified to match 1kHz
	// dio17
	uint8 u8Timer = 0b000100000; // dunno if this correctly selects timer 4
	vAHI_TimerEnable(u8Timer, 0b00000100, false, false, true);
	vAHI_TimerConfigureOutputs(u8Timer, false, true);
	vAHI_TimerStartRepeat(u8Timer, 30000, 60000);
}


// this function declares a gpio pin as either an input or an
// output.
void initializeGPIO(void) {
	uint32 inputs =  0b00000000000000000000000000000000;
	uint32 outputs = 0b00000000000000000000000000000000;
	vAHI_DioSetDirection(inputs, outputs);
	return;
}

int checkCable(uint32 interrupt) {
	uint32 test = 0b00000000000000000000000000000000;
	uint32 save = 0b00000000000000000000000000000000;
	test &= interrupt;
	if(test == save) {
		#ifdef DEBUG
		printf("The J1771 Cable has been unplugged!\n");
		printf("What do we do now?\n");
		#endif
		return 0;
	}
	return 1;
}

int checkButtons(uint32 interrupt) {
	uint32 test = 0b00000000000000000000000000000000;
	uint32 save = 0b00000000000000000000000000000000;
	test &= interrupt;
	if(test != save) {
		// returns to caller if button interrupt was not triggered.
		return 0;
	}
	// this should cause some modifications to the program.

	return 1;
}
int checkGFI(uint32 interrupt) {
	uint32 test = 0b00000000000000000000000000000000;
	uint32 save = 0b00000000000000000000000000000000;
	// ^ needs to match the GPIO of GFI
	test &= interrupt;
	if(test == save) {
		#ifdef DEBUG
		printf("GFI test failed!");
		#endif
		return 1;
	}
	return 0;
}

int initializeGFI(void) {
	uint32 value = u32AHI_DioReadInput();
	uint32 test = 1;
	/* test needs to be modified so that the input matches up
	with the GPIO being used to send GFI data*/
	test &= value;
	uint16 OFF = 0b0000000000000000;
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
	// these values have to be adjusted to reflect where the inputs are within the board.
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


// relays are off until charger reaches state C
void relaysOff(void){
	uint32 save = u32AHI_DioReadInput();
	// off should correspond to the correct outputs for the
	// relays. Modify this later
	uint32 off = 0b000000000000000000000000000000011;
	vAHI_DioSetOutput(save, off);
}

// call this function once charger is in state C "Charging"
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
