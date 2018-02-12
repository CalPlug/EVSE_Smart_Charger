#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "include.h"
#include <AppHardwareApi.h>

//#define DEBUG
/******************************************************************************
 * Sample baud value to achieve UART communication at a 115200 baud rate with a (50MHz Digikeyboard clock source.
 * This value is calculated using the following equation:
 *      BAUD_VALUE = (CLOCK / (16 * BAUD_RATE)) - 1
 *      For CoreUART
 *****************************************************************************/
#define BAUD_VALUE	37 // calculated as 115200 

/******************************************************************************
 * Maximum UART receiver buffer size.
 *****************************************************************************/
#define MAX_RX_DATA_SIZE    32 //this value can be larger, but 32 is chosen as opposed to the default 256 as only single characters needed

/******************************************************************************
 * CoreGPIO instance data.
 *****************************************************************************/
#define COREGPIO_BASE_ADDR         0x30001000UL
gpio_instance_t g_gpio;


/******************************************************************************
 * CoreI2C instance data.
 *****************************************************************************/

#define COREI2C_BASE_ADDR         0x50003000UL  //0x30003000UL?
i2c_instance_t g_core_I2C0;
#define COREI2C_SER_ADDR   0x10u

   i2c_instance_t g_i2c_inst;

/******************************************************************************
 * CoreUARTapb instance data.
 *****************************************************************************/
UART_instance_t g_uart;
#define COREUARTAPB0_BASE_ADDR	0x50002000


/******************************************************************************
 * CoreSPI instance data.
 *****************************************************************************/
#define CORE_SPI0_BASE_ADDR	0x50004000   //0x30004000?
spi_instance_t g_core_spi0;

/******************************************************************************
 * TX Send message (heartbeat)
 *****************************************************************************/
uint8_t g_message[] ="Hello World";  //Heartbeat message - send back heartbeat command to tablet link, this is the UART message to reply with, and is used by tablet to assess connection is still active  (Note: alternatively "K\n\r" can be used with corresponding parsing on the receive side);

/******************************************************************************
 * Indicator LEDS driven by GPIO Outs
 *****************************************************************************/
/*
 * LEDs masks used to switch on/off LED through GPIOs.
 */
#define LEDS_MASK   (uint32_t)0x00000002		// Defined default LED mask - changed because only GPIO[2:0]are used  (#define LEDS_MASK   (uint32_t)0xAAAAAAAA      // original implementation)

/*
 * LEDs pattern
 */
volatile uint32_t g_gpio_pattern = LEDS_MASK;

/******************************************************************************
 * CorePWM declare base_addr.
 *****************************************************************************/
#define COREPWM_BASE_ADDR 0x50000000

/******************************************************************************
 * CorePWM instance data.
 *****************************************************************************/
pwm_instance_t the_pwm;

/******************************************************************************
 * Delay count used to time the delay between duty cycle updates.  (Unless fabric is changed please do not modify, unless you have an exceedingly good reason to do so)
 *****************************************************************************/
#define DELAY_COUNT     6500  //principle multiplier to set delays in function (changing this changes the length of all delays, modify with caution, should be set so a delay of 1000 = 1 second, hence a unit is equalled approximately to 1 ms)

/******************************************************************************
 * PWM prescale and period configuration values to set PWM frequency and duty cycle. Example Values
 *****************************************************************************/
#define PWM_PRESCALE    4  //Pre-scale value 4
#define PWM_PERIOD      3999  //full period

/******************************************************************************
//Servo Name mapping to PWM Outputs
 ******************************************************************************/
#define LED1 1 //(Creative Board - Pin D5)
#define LED2 2 //(Creative Board - Pin D4)
#define LED3 3 //(Creative Board - Pin D9)
#define LED4 4 //(Creative Board - Pin D8)
#define LED5 5 //(Creative Board - D10)
#define LED6 6 //(Creative Board - LED1 Green)
#define LED7 7 //(Creative Board - (die P12-d12)) extra channel 1  NEWLY ADDED)
#define LED8 8 //(Creative Board - (die P13-d13)) extra channel 2 NEWLY ADDED)   


int main(){
	
	ChargeState Charge;
	int Wifi_check;
	ESP8266 client;
	
	Set_State(&Charge, 'A');
	LevelDetection(&Charge);
	setRelay(&Charge);
	groundfaultinterrupt();
	readWattmeterSPI(&client);
	while(ESP8266setup(&client)) {
		printf("Not connecting online. Retrying...");
	}
	readWattmeterSPI();

	// these can go in initialize function once implemented properly
	
	
	//Initialize();
	int go = 1;
	while(go) {
		getMQTTData(&client);
		
	}	
}



void readWattmeterSPI(ESP8266* client){
	// reads from wattmeter over SPI
	// 
	// SPI_transfer_block();	
	// figure out what the buffer size is
	uint8_t master_rx_buffer[MAX_RX_DATA_SIZE] = {0};
	SPI_set_slave_select(&g_spi0, SPI_SLAVE_0);
	SPI_transfer_block(&g_spi0, 0, 0, master_rx_buffer, sizeof(master_rx_buffer));
	SPI_clear_slave_select(&g_spi0, SPI_SLAVE_0);
	// = master_rx_buffer[0] | (master_rx_buffer[1] << 8) ; 
	uint64_t result = 0;
	for(int x = 0; x < 8 ; x++) {
		result = (master_rx_buffer[x] << (8*x)) | result;
	}
	client->watts = result;	
	return;
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
		else if(i == true && j == true){
			DC_Relay1 = true;
			DC_Relay2 = true;
		}
		else if(i == false && j == true){
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

// Implement an interrupt to stop the charging unit
// in event of emergency
void groundfaultinterrupt(void){
	// find out which pin is the input pin for the GFI
	// using GPIO_5 as placeholder
	// GPIO_IRQ_EDGE_POSITIVE defined in core_gpio.h
	
	GPIO_config(&g_gpio, GPIO_5, GPIO_INPUT_MODE | GPIO_IRQ_EDGE_POSITIVE);	
	
	// this function enables an interrupt to be generated based on the state
	// of the input ID as parameter
	
	GPIO_enable_irq(&g_gpio, GPIO_5);
	return;
}

// complete but needs to be tested to verify
void LevelDetection(ChargeState* charge){
		
	
	// 8192 lvl 1
	// 0 lvl 2
	// 10240 both off
	// else error
	
	
	uint32_t AC1 = GPIO_get_inputs(g_gpio);
	uint32_t test = 10240;
	uint32_t result = test & AC1;	
 	
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


void Set_State(ChargeState* charge, char state){
	switch(state){
		case A:
			charge->state = state;
			charge->pwm_high = 12;
			charge->pwm_low = 12;
			#ifdef DEBUG 
			printf("Case A\n");
			#endif
			break;
		case B:
			charge->state = state;
			charge->pwm_high = 9;
			charge->pwm_low = -12;
			#ifdef DEBUG 
			printf("Case B\n");
			#endif
			break;
		case C:
			charge->state = state;
			charge->pwm_high = 6;
			charge->pwm_low = -12;
			#ifdef DEBUG 
			printf("Case C\n");
			#endif
			break;
		case D: 
			charge->state = state;
			charge->pwm_high = 3;
			charge->pwm_low = -12;
			#ifdef DEBUG 
			printf("Case D\n");
			#endif
			break;
		case E:		
			charge->state = state;
			charge->pwm_high = 0;
			charge->pwm_low = 0;
			#ifdef DEBUG 
			printf("Case E\n");
			#endif
			break;
		case F: 
			charge->state = state;
			charge->pwm_high = -12;
			charge->pwm_low = -12;
			#ifdef DEBUG 
			printf("Case F\n");
			#endif
			break;
		default:
			charge->state = 'F';
			charge->pwm_high = -12;
			charge->pwm_low = -12;
			#ifdef DEBUG 
			printf("Case not found\n");
			#endif
	}
	return;
}

void readPilot(ChargeState* charge) {
	// do some magic here to read the state from the pilot
	// this will set internal values of the chargestate to 
	// match the values from the pilot. 
	// andy says this will read the voltage level to determine state
	// don't know if this is a GPIO 
	
	char state = 'A';
	Set_State(&charge, state);
		
}

int Initialize(){
	spi_instance_t g_spi0;
	
	// Initialize CorePWM instance setting prescale and period values
	PWM_init(&the_pwm, COREPWM_BASE_ADDR, PWM_PRESCALE, PWM_PERIOD );
	delay(200);  //add ~200ms delay to prevent HAL assertion issue
		
	//Initialize CoreSPI
	SPI_init(&g_core_spi0, CORE_SPI0_BASE_ADDR,8); //Initialize SPI (CoreSPI)
	SPI_configure_master_mode(&g_core_spi0); //Initialize SPI as master (CoreSPI)
	
	// Initialize MCP3903 Communication 
	MCP3903ResetOSR(OSR_256, &g_core_spi0);   //MCP3903 Send with OSR256 (oversampling ratio) constant (value of 0x3, see library), changing this can change output value formatting for signed values, be careful, these may not work with current signed-bit read structure!  OSR_256 known working, it look like it's sign bit, but gets shifted over as OSR decreases
	MCP3903SetGain(1, GAIN_1, &g_core_spi0);   //MCP3903 Set ADC channel 1 with gain of 1 (gain of 8 is value of 0x3, see library)

	//Initialize UART RX buffer
	uint8_t rx_data[MAX_RX_DATA_SIZE]={0}; //initialize buffer as all 0's
	size_t rx_size;
	
	UART_init( &g_uart, COREUARTAPB0_BASE_ADDR,
	BAUD_VALUE, (DATA_8_BITS | NO_PARITY) ); //set to communicate with 115200/8/N/1
	
	SystemCoreClockUpdate();
}

int ESP8266setup(ESP8266* client) {
	string ssid = "CHOMPy";
	string password = "sandwich57?";
	string mqtt_server = "m14.cloudmqtt.com";
	int mqqt_Port = 10130;
	string mqtt_user = "obavbgqt";
	string mqtt_password = "ZuJ8oEgNqKCy";
	// this should subscribe to and publish to a topic.
	// each command will have a special function
	/*
	StartCharge = "$FE*AF"; //what we get from mqtt
	StopCharge = "$FS*BD";
	ReadCurrent= "$GG*B2";
	SetCurrent = "$SC 6"; // ??? What are we expecting?
	SetCurrentA = "$SC 7";  
	ReadStatus = "$GS*BE";
	LevelCheck = "$GU*CO";
	*/
	return 1;
}



void initialize(ChargeState *charge){
	ChargeState charger;
	charger.pwm_high = 12;
	charger.pwm_low = 12;
	gpio_set();
	LevelDetection();
	Set_State(&charger);		
}



