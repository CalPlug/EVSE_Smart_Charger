#include <stdio.h>
#include <stdlib.h>
#include <string.h>


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
int getMQTTData(ESP8266* client);

void sendMQTTData(ESP8266* client);

int Set_State(ChargeState* charge, char state);

void readWattmeterSPI();

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
	int check = Set_State(Charge, 'A');
	//Initialize();
	
	
}

void readPilot(ChargeState* charge);
void readPilot(ChargeState* charge) {
	// do some magic here to read the state from the pilot
	// this will set internal values of the chargestate to 
	// match the values from the pilot. 
	char state = 'A';
	
	switch(state){
		case 'A':
			charge->state = state;
			charge->pwm_high = 12;
			charge->pwm_low = 12;
			break;
		case 'B':
			charge->state = state;
			charge->pwm_high = 9;
			charge->pwm_low = -12;
			break;
		case 'C':
			charge->state = state;
			charge->pwm_high = 6;
			charge->pwm_low = -12;
			break;
		case 'D': 
			charge->state = state;
			charge->pwm_high = 3;
			charge->pwm_low = -12;
			break;
		case 'E':		
			charge->state = state;
			charge->pwm_high = 0;
			charge->pwm_low = 0;
			break;
		case 'F': 
			charge->state = state;
			charge->pwm_high = -12;
			charge->pwm_low = -12;
			break;
		default:
			charge->state = 'F';
			charge->pwm_high = -12;
			charge->pwm_low = -12;
			;
	}
}

int Set_State(ChargeState* charge, char state){
	switch(state){
		case A:
			charge->state = state;
			charge->pwm_high = 12;
			charge->pwm_low = 12;
			break;
		case B:
			charge->state = state;
			charge->pwm_high = 9;
			charge->pwm_low = -12;
			break;
		case C:
			charge->state = state;
			charge->pwm_high = 6;
			charge->pwm_low = -12;
			break;
		case D: 
			charge->state = state;
			charge->pwm_high = 3;
			charge->pwm_low = -12;
			break;
		case E:		
			charge->state = state;
			charge->pwm_high = 0;
			charge->pwm_low = 0;
			break;
		case F: 
			charge->state = state;
			charge->pwm_high = -12;
			charge->pwm_low = -12;
			break;
		default:
			charge->state = 'F';
			charge->pwm_high = -12;
			charge->pwm_low = -12;
			;
	}
}

int Initialize(){
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
	
	return 1;
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

