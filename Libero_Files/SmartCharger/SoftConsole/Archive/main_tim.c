/*******************************************************************************
 *Base Example code (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *Extended application by Tim McCarthy (Microsemi) and Michael Klopfer (Univ. of Calif. Irvine) + UC Irvine student team
 *This example project demonstrates control  control the duty cycle of
 *individual PWM outputs to drive servos for a mechanical arm that sorts test tubes in a rack.  The application is driven by serial commands.
 *Final Build v1.0: March 2017
 *
 * ORIG SVN $Revision: 8042 $
 * ORIGSVN $Date: 2015-10-15 17:55:12 +0530 (Thu, 15 Oct 2015) $
 */
#include "platform.h"
#include "core_pwm.h"
#include "drivers/mss_timer/mss_timer.h"
#include "CMSIS/system_m2sxxx.h"
#include "hal.h"
#include "drivers/CoreUARTapb/core_uart_apb.h"
#include "drivers/CoreGPIO/core_gpio.h"
#include "m2sxxx.h"
#include <stdio.h>  //added by Tim McCarthy for Semihosting (Console Debug)

//**************************************************************************************************
//Debugging Control     NOTE: (Comment out on production eNVM builds to avoid Semihosting errors!!)
//#define VERBOSEDEBUGCONSOLE //Verbose debugging in console using Semihosting, comment out to disable console debug messages - do not go too crazy with semihosting, it will slow down operation if used excessively
//**************************************************************************************************

//Temporary Motion Control
//Motion control to manually activate motions to demonstrate and test functionality (normalled commented out!)
	//#define MOTIONONE  // A to B
	//#define MOTIONTWO  // B to A
	//#define MOTIONTHREE  // C to D
	//#define MOTIONFOUR  // D to C
	//#define MOTIONFIVE //Agitate A
	//#define MOTIONSIX // Agitate B
	//#define MOTIONSEVEN  // Agitate C
	//#define MOTIONEIGHT  // demo test function for calibration checking
	//#define MOTIONNINE  //DemoMotions



/******************************************************************************
 * Function prototype for Semihosting - added Tim McCarthy
 *****************************************************************************/
#ifdef VERBOSEDEBUGCONSOLE
	   extern void initialise_monitor_handles(void); //Semihosting enabled
#endif


/******************************************************************************
 * Sample baud value to achieve UART communication at a 115200 baud rate with a 70MHz system clock.
 * This value is calculated using the following equation:
 *      BAUD_VALUE = (CLOCK / (16 * BAUD_RATE)) - 1
 *      For CoreUART
 *****************************************************************************/
#define BAUD_VALUE    37	   //TM - 37 as calculated baud value for 115200


/******************************************************************************
 * Maximum UART receiver buffer size.
 *****************************************************************************/
#define MAX_RX_DATA_SIZE    32 //RX buffer size - changed from 256 to 32 because only single characters needed, so buffer shrunk


/******************************************************************************
 * CoreGPIO instance data.
 *****************************************************************************/
gpio_instance_t g_gpio;


/******************************************************************************
 * CoreUARTapb instance data.
 *****************************************************************************/
UART_instance_t g_uart;
uint32_t duty_cycle = 1;  //Set PWM initial duty cycle


/******************************************************************************
 * TX Send message (heartbeat)
 *****************************************************************************/
uint8_t g_message[] =
"K\n\r";  //Heartbeat message - send back heartbeat command to tablet link, this is the UART message to reply with, and is used by tablet to assess connection is still active
          //FORMERLY "K";

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

// the next two lines added by Tim McCarthy for debugging 3/7/17
#define DELAY_LOAD_VALUE     0x00200000
#define LED_LOOP_MASK (uint32_t) 0x00000000	// used to write a blinking pattern when SW2 is pressed
volatile uint32_t g_gpio_loop_pattern = LED_LOOP_MASK;

/******************************************************************************
 * CorePWM instance data.
 *****************************************************************************/
pwm_instance_t the_pwm;


/******************************************************************************
/******************************************************************************

/******************************************************************************
 * Servo Control constants
 *****************************************************************************/


/******************************************************************************
 * Delay count used to time the delay between duty cycle updates.  (Unless fabric is changed please do not modify, unless you have an exceedingly good reason to do so)
 *****************************************************************************/
#define DELAY_COUNT     6500  //principle multiplier to set delays in function (changing this changes the length of all delays, modify with caution, should be set so a delay of 1000=1s)

/******************************************************************************
 * PWM prescale and period configuration values.  (Unless fabric is changed please do not modify, unless you have an exceedingly good reason to do so)
 *****************************************************************************/
#define PWM_PRESCALE    49  //Prescale value 4 (formerly set to 39)
#define PWM_PERIOD      399  //full period     (formerly set to 499)

/******************************************************************************
 * Servo Global Operation Parameters  (Project global settings - modify with justification and caution!)
 *****************************************************************************/
#define MAX_DEFLECT 52.0 //max deflection of servo (pwm value) (use whole number with decimal for float calc)
#define MIN_DEFLECT 6.0 //min deflection of servo (pwm value) (use whole number with decimal for float calc)
#define ROTATION_DEGREES 170.0 //Servo physical rotation span (degrees) (use whole number with decimal for float calc)

/******************************************************************************
 * Servo Trim Parameters - Trim Parameters for each servo to correct differences between units for identical performance
 *****************************************************************************/
#define TRIM_ROT_DEG_GAIN_1 1.0
#define TRIM_ROT_DEG_OFFSET_1 0.0
#define TRIM_MIN_1_PWM 6.0
#define TRIM_MAX_1_PWM -8.0

#define TRIM_ROT_DEG_GAIN_2 1.0
#define TRIM_ROT_DEG_OFFSET_2 0.0
#define TRIM_MIN_2_PWM 6.0
#define TRIM_MAX_2_PWM -8.0

#define TRIM_ROT_DEG_GAIN_3 1.0
#define TRIM_ROT_DEG_OFFSET_3 0.0
#define TRIM_MIN_3_PWM 2.0
#define TRIM_MAX_3_PWM -8.0

#define TRIM_ROT_DEG_GAIN_4 1.0
#define TRIM_ROT_DEG_OFFSET_4 0.0
#define TRIM_MIN_4_PWM 6.0
#define TRIM_MAX_4_PWM -8.0

#define TRIM_ROT_DEG_GAIN_5 1.0
#define TRIM_ROT_DEG_OFFSET_5 0.0
#define TRIM_MIN_5_PWM 3.0
#define TRIM_MAX_5_PWM -8.0

#define TRIM_ROT_DEG_GAIN_6 1.0
#define TRIM_ROT_DEG_OFFSET_6 0.0
#define TRIM_MIN_6_PWM 5.0
#define TRIM_MAX_6_PWM -8.0

#define TRIM_ROT_DEG_GAIN_7 1.0
#define TRIM_ROT_DEG_OFFSET_7 0.0
#define TRIM_MIN_7_PWM 6.0
#define TRIM_MAX_7_PWM -8.0

#define TRIM_ROT_DEG_GAIN_8 1.0
#define TRIM_ROT_DEG_OFFSET_8 0.0
#define TRIM_MIN_8_PWM 6.0
#define TRIM_MAX_8_PWM -8.0

/******************************************************************************
//Servo Name mapping to PWM Outputs
 ******************************************************************************/
#define JAW 6  //Pincher Jaws (Creative Board - Pin D5)
#define JAWROT 5 //Rotation of the Jaws  (Creative Board - Pin D4)
#define JAWPIVOT 4 //Pivot of Jaws  (Creative Board - Pin D9)
#define ARMEXT 3 //Extension of arm  (Creative Board - Pin D8)
#define ARMROT 2 //Rotation of arm base  (Creative Board - D10)
#define DIAGLED 1 //Diagnostic LED  (Creative Board - LED1 Green)
#define AUX0 7 //Aux channel 0  (Creative Board - (die P12))
#define AUX1 8 //Aux channel 0  (Creative Board - (die P13))



//***********************************************************************
//***********************************************************************

/******************************************************************************
 * Local function prototypes.
 *****************************************************************************/
void delay( int mult );
float set_deg_inc(float deg_new, float deg_old, int dir, float stepsize, int delay_len, int servo_num);
void set_deg_abs(float deg, int pwmnum);
void motionextremes();
void grabtube(int pos);
void motiononeHoldtoA();
void returntohold();
void calmotions();
void motiononeAtoB();
void motiononeBtoHold();
void motiononebheighttransition();
void motiontwoHoldtoB();
void motiontwoBtoA();
void motionotwoaheighttransition();
void motiontwoAtoHold();
void motionthreeHoldtoC();
void motionsevenCtoagitate();
void motionsevenCtoHold();
void motionthreeCtoD();
void motionthreeDtoHold();
void motionfourHoldtoD();
void motionfourDtoC();
void motionfourCtoHold();
void putdownC();
void motionfourCheighttransition();
void motionfiveAtoagitate();
void putdownA();
void Demo();
void AtoB();
void BtoA();
void CtoD();
void DtoC();
void AgitateA();
void AgitateC();
void FabricIrq1_IRQHandler( void );		// GPIO[0:1] interrupts are OR'd and connected to fabric interrupt 1


/******************************************************************************
 * Program MAIN function.
 *****************************************************************************/
int main( void )
{
#ifdef VERBOSEDEBUGCONSOLE
	    initialise_monitor_handles();  //Add in semihosting
		iprintf("Debug messages via ARM Semihosting initialized\n");  //Notification of Semihosting enabled
#endif


	    /**************************************************************************
	     * Initialize the CorePWM instance setting the prescale and period values.
	     *************************************************************************/
	    PWM_init( &the_pwm, COREPWM_BASE_ADDR, PWM_PRESCALE, PWM_PERIOD );
	    delay (200);  //add ~200ms delay to prevent HAL HAL assertion issue
	    /**************************************************************************
	     * Set the initial duty cycle for CorePWM output 1.
	     *************************************************************************/

	    //Initialize into save SERVO DOF holding positions:
	    //Initial position
	    	set_deg_abs(100.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(130.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(30.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(90.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(35.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(90.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
	    	set_deg_abs(25.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point
	    	delay (500);//Pause at initial HOLD position before setting final hold position

	    	//Initial HOLD Point
	    	set_deg_abs(110.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(160.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(38.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(92.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(30.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(100.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
	    	set_deg_abs(100.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point
	    	delay (500);//Pause at final HOLD position then run initialization a third time to make sure PWMs set properly for first run (then run initialization a second time to make sure PWMs set properly for first run)

	    	//Initial HOLD Point
	    	set_deg_abs(110.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(160.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(38.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(92.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(30.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(100.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
	    	set_deg_abs(100.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point

//For Quick Reference:
	     // JAW 6  //Pincher jaws (Creative Board - Pin D5)
	     // JAWROT 5 //Rotation of the jaws  (Creative Board - Pin D4)
	     // JAWPIVOT 4 //Pivot of jaws  (Creative Board - Pin D9)
	     // ARMEXT 3 //Extension of arm  (Creative Board - Pin D8)
	     // ARMROT 2 //Rotation of arm base  (Creative Board - D10)
	     // DIAGLED 1 //AUX Channel, Diagnostic LED  (Creative Board - LED1 Green)
	     // AUX0 7 //Aux channel 0  (Creative Board - (die P12))
	     // AUX1 8 //Aux channel 0  (Creative Board - (die P13))

	#ifdef VERBOSEDEBUGCONSOLE
	        iprintf("Complete PWM Initialization and initial position start\n");
	#endif
	    	delay (500); //Pause at HOLD position then continue operation


/**************************************************************************
* Initialize communication components of application
*************************************************************************/

		//Initialize UART RX buffer
		uint8_t rx_data[MAX_RX_DATA_SIZE]={0}; //initialize buffer as all 0's
	    size_t rx_size;

	    /**************************************************************************
	     * Initialize CoreUARTapb with its base address, baud value, and line
	     * configuration.
	     *************************************************************************/
	    UART_init( &g_uart, COREUARTAPB0_BASE_ADDR,
	    BAUD_VALUE, (DATA_8_BITS | NO_PARITY) ); //set to communicate with 115200/8/N/1
		#ifdef VERBOSEDEBUGCONSOLE
		iprintf("CoreUARTapb initialized\n");
		#endif


		/**************************************************************************
	     * Send initial heartbeat signal
	     *************************************************************************/
	    UART_send( &g_uart, g_message, sizeof(g_message) ); //prepare UART for message sending, send first heartbeat

    /*--------------------------------------------------------------------------
     * Ensure the CMSIS-PAL provided g_FrequencyPCLK0 global variable contains
     * the correct frequency of the APB bus connecting the MSS timer to the
     * rest of the system.
     */
    SystemCoreClockUpdate();

    /**************************************************************************
     * Initialize the CoreGPIO driver with the base address of the CoreGPIO
     * instance to use and the initial state of the outputs.
     *************************************************************************/
    GPIO_init( &g_gpio,    COREGPIO_BASE_ADDR, GPIO_APB_32_BITS_BUS );

    /**************************************************************************
     * Configure the GPIOs for the indicator LEDs - Removed TM 3/7/17
     *************************************************************************/
//    GPIO_config( &g_gpio, GPIO_0, GPIO_OUTPUT_MODE );  //Led #1 (Physically the red element of the LED 1 bi-color LED on the Future Creative board) - the green element of this bi-color LED is the PWM demo output
//    GPIO_config( &g_gpio, GPIO_1, GPIO_OUTPUT_MODE );  //Led #2 (Physically the green element of the LED 2 bi-color LED on the Future Creative board)
//    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE );  //Led #3 (Physically the red element of the LED 2 bi-color LED on the Future Creative board)
//    GPIO_set_outputs(&g_gpio, g_gpio_pattern); //Write default pattern to LEDs

    /**************************************************************************
     * Configure the GPIOs for Inputs and Outputs - changed TM 3/7/17
     *************************************************************************/
    GPIO_config( &g_gpio, GPIO_0, GPIO_INOUT_MODE | GPIO_IRQ_EDGE_POSITIVE  );  //Button 1
    GPIO_config( &g_gpio, GPIO_1, GPIO_INOUT_MODE | GPIO_IRQ_EDGE_POSITIVE  ); //Button 2
    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE ); //Spare input button, currently disabled

    // The line below was moved from it's original location (line 338)
    GPIO_set_outputs(&g_gpio, g_gpio_pattern); //Write default pattern to LEDs

#ifdef VERBOSEDEBUGCONSOLE
    iprintf("CoreGPIO configured\n");
#endif
    /*
     * Enable individual GPIO interrupts. The interrupts must be enabled both at
     * the GPIO peripheral and Cortex-M3 interrupt controller levels.
     */
    GPIO_enable_irq( &g_gpio, GPIO_0 ); //enable IRQ for button 1
    GPIO_enable_irq( &g_gpio, GPIO_1 ); //enable IRQ for button 2
    NVIC_EnableIRQ(FabricIrq1_IRQn);


    /**************************************************************************
     * Configure Timer1
     * Use the timer input frequency as load value to achieve a one second
     * periodic interrupt.
     */
    //*************************************************************************/
	uint32_t timer1_load_value;
    timer1_load_value = g_FrequencyPCLK0 *10;		// modify for 10 second delay TM
    MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
    MSS_TIM1_load_immediate(timer1_load_value);
    MSS_TIM1_start();
    MSS_TIM1_enable_irq();

    #ifdef VERBOSEDEBUGCONSOLE
	iprintf("Timer initialized and started\n");
    #endif


    /*--------------------------------------------------------------------------
     * Foreground loop to check for command control of the device.
     */

for(;;)
    {
		GPIO_set_outputs(&g_gpio, g_gpio_pattern); //update GPIO pattern for indicator LEDs (default pattern)
    	if(UART_APB_NO_ERROR == UART_get_rx_status(&g_uart)) //Verify if UART can be opened, then UPEN uart to receive control command
		        {
		            /**********************************************************************
		             * Read data received by the UART.
		             *********************************************************************/
		            rx_size = UART_get_rx( &g_uart, rx_data, sizeof(rx_data) );
		        }
    //This group of IF statements checks for incoming commands and initiates motions if they are received
		           //Buttons are handled thru interrupts when these are enabled, the interrupts are OR'ed, the sorting out of what happens with the interrupts happens in the control function that is called when the interrupt is received.  Example:
    					//Enable Interrupt for Button 1 - GPIO_disable_irq( &g_gpio, GPIO_0 ); is changed to GPIO_enable_irq( &g_gpio, GPIO_0 );
        				//Enable Interrupt for Button 2 - GPIO_disable_irq( &g_gpio, GPIO_1 ); is changed to GPIO_enable_irq( &g_gpio, GPIO_1 );
    	    				  //If button 1 Press (manual demo activation), run the function "Demo();"
    	           	   	   	  //If button 2 press, (ESTOP) - hold and catch fire (HCF), zero all PWMS and put program into infinite null loop that is reset only by resetting the board, this should ideally be interrupt driven and zero the CorePWM outputs then when this catches in the main loop, the Cortex hits the infinite locked loop after finishing the paces for the function (there will be no outputs because the PWM outputs are already zero-ed

    			if ( rx_size > 0 && rx_data[0]=='A' )
		             	{
						#ifdef VERBOSEDEBUGCONSOLE
		             	iprintf("Character 'A' Received - move from A to B initiated\n"); //Identify operation via semihosting debug print
						#endif
		             	rx_data[0]=0; //flush first position in the buffer before next check with null character
		             	GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		             	AtoB(); //Execute A to B motion function
		             	}
		             else if ( rx_size > 0 && rx_data[0]=='B' )
		             	{
						#ifdef VERBOSEDEBUGCONSOLE
		                iprintf("Character 'B' Received - move from B to A initiated\n"); //Identify operation via semihosting debug print
						#endif
		                rx_data[0]=0; //flush first position in the buffer before next check with null character
		                GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		                BtoA(); //Execute B to A motion function
		             	}
		             else if ( rx_size > 0 && rx_data[0]=='C' )
		             	{
						#ifdef VERBOSEDEBUGCONSOLE
		                iprintf("Character 'C' Received - move from C to D initiated\n"); //Identify operation via semihosting debug print
						#endif
		                rx_data[0]=0; //flush first position in the buffer before next check with null character
		                GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		                CtoD();  //Execute C to D motion function
		             	}
		             else if ( rx_size > 0 && rx_data[0]=='D' )
		                {
						 #ifdef VERBOSEDEBUGCONSOLE
		                 iprintf("Character 'D' Received - move from D to C initiated\n"); //Identify operation via semihosting debug print
						 #endif
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		                 DtoC(); //Execute D to C motion function
		                }
		             //Continue checks for the other characters - this code goes here
		             else if ( rx_size > 0 && rx_data[0]=='E' )
		                {
						 #ifdef VERBOSEDEBUGCONSOLE
		            	 iprintf("Character 'E' Received - Agitate A\n"); //Identify operation via semihosting debug print
						 #endif
		            	 GPIO_set_outputs(&g_gpio, 0x00000001); //update GPIO pattern 1 for indicator LEDs
		            	 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 AgitateA(); //Agitate tube A
		                }
		             //Continue checks for the other characters - this code goes here
		             else if ( rx_size > 0 && rx_data[0]=='G' )
		                {
						 #ifdef VERBOSEDEBUGCONSOLE
		                 iprintf("Character 'G' Received - Agitate C\n"); //Identify operation via semihosting debug print
                         #endif
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 GPIO_set_outputs(&g_gpio, 0x00000001); //update GPIO pattern 1 for indicator LEDs
		                 AgitateC(); //Agitate Tube C
		                }
		             else if ( rx_size > 0 && rx_data[0]=='I' )
		                {
                         #ifdef VERBOSEDEBUGCONSOLE
		                 iprintf("Character 'I' Received - Demo Motions Routine\n"); //Identify operation via semihosting debug print
                         #endif
		                 GPIO_set_outputs(&g_gpio, 0x00000006); //update GPIO pattern 0 for indicator LEDs
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 Demo();
		                }
		             else if ( rx_size > 0 && rx_data[0]=='J' )
		                {
		                 #ifdef VERBOSEDEBUGCONSOLE
		             	 iprintf("Character 'J' Received - Calibrations Motions Routine\n"); //Identify operation via semihosting debug print
		                 #endif
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 GPIO_set_outputs(&g_gpio, 0x00000005); //update GPIO pattern 1 for indicator LEDs
		                 calmotions(); //Function to test if calibration is OK
		                }
    	           //Move functions into here to test, will be executed everytime loop runs, remove before testing communication

    	else {}  //Null Case (rounding out the IF statement)

/******************************************************************************
 * This code is for debug testing motions by manually activating the individual actuations - if the "MOTIONS" are not #define -ed, this is skipped as it should be in normal operation
 *************************************************************************/
    	#ifdef MOTIONDEMOS
    	//Motion Demos
    		//Function is a demo to move between extremes of motion on each DoF for the arm sequentially
    			motionextremes(); //demo motion for DoF extremes  (function written

    	    //Function to demo motion of arm as a continuously running demo (motion with more "sense of purpose" and smoother than DoF Demo)
    			calmotions(); //demo motion (needs to be written)
    	#endif

    	#ifdef MOTIONONE
    		//Motion "one" to bring arm from hold to pick up tube in position A, then place in position b, then release tube in position b and return arm to HOLD - then pick up tube, bring to position B, then release and return to hold, continue with similar function, driven structure
    			AtoB();
     	#endif

    	#ifdef MOTIONTWO
    	    //Motion "two" to bring arm from hold to pick up tube in position B, then place in position A, then release tube in position A and return arm to HOLD
    			BtoA();
    	#endif

    	#ifdef MOTIONTHREE
    			//Motion "three" to bring arm from hold to pick up tube in position C, then place in position D, then release tube in position C and return arm to HOLD
    			CtoD();
    	#endif

    	#ifdef MOTIONFOUR
    		//Motion "four" to bring arm from hold to pick up tube in position C, then place in position D, then release tube in position C and return arm to HOLD
    			DtoC();
    	#endif

//Tube Invert demos
    	#ifdef MOTIONFIVE
    			//Motion "five" - Pick up tube in position A, rotate tube (rock side to side), flip back, then return to position A (this is a demo simulation of mixing, there will be glitter solution inside tube)
    			AgitateA();
    	#endif


    	#ifdef MOTIONSEVEN
    			//Motion "seven" - Pick up tube in position C, rotate tube, flip back (rock side to side), then return to position C (this is a demo simulation of mixing, there will be glitter solution inside tube)
    			AgitateC();
    	#endif

//Arm motion and calibration and motion demos

    	#ifdef MOTIONEIGHT
    			//Motion "eight" - the calibration check function
    			calmotions();
		#endif

    	#ifdef MOTIONNINE
    			//Motion "nine" - Demonstration motions for arm motion
    			Demo();
    	#endif

     delay (10); //delay before recycling loop
    }
}


/*==============================================================================
 * Toggle LEDs and send message via UART on TIM1 interrupt.
 */
void Timer1_IRQHandler(void)
{
    /*
     * Toggle GPIO output pattern by doing an exclusive OR of all
     * pattern bits with ones.
     */
    g_gpio_pattern = GPIO_get_outputs( &g_gpio ); //lookup current state of LEDs
    g_gpio_pattern ^= 0x00000007; //Inversion of previous state
    //g_gpio_pattern ^= 0x00000007u; //Inversion of previous state (previously)
    GPIO_set_outputs( &g_gpio, g_gpio_pattern);//Update LEDs to inversion of previous state

     UART_send( &g_uart, g_message, sizeof(g_message) ); //send the hearbeat message to let the tablet know the link is still active

    /* Clear TIM1 interrupt */
    MSS_TIM1_clear_irq();
}


/*-------------------------------------------------------------------------*//**
 * GPIO 0 and  GPIO 1  interrupt service routine is FabricIrq1 ISR.
 *
 * GPIO 0: This interrupt service routine function will be called when the SW1
 * button is pressed. It will keep getting called as long as the SW1 button
 * is pressed because the GPIO 0 input is configured as a level interrupt source.
 *
 * GPIO 1 : This interrupt service routine function will be called when the SW2
 * button is pressed. It will only be called once even if the SW2 button is
 * kept pressed because the GPIO 1 input is configured as a rising edge interrupt
 * source. The SW2 button needs to be released and pressed again in order create
 * a new rising edge on the GPIO 1 input and this function to be called again.
 */
void FabricIrq1_IRQHandler( void )
{
//	The following added by Tim McCarthy 3/7/17
    volatile int32_t delay_count = 0;

	uint32_t io_state = 0; //initialize the variable that holds the button state
    /*
      * Disable GPIO interrupts while updating the delay counter and
      * GPIO pattern since these can also be modified within the GPIO
      * interrupt service routines.
      */
	GPIO_disable_irq( &g_gpio, GPIO_0 );
    GPIO_disable_irq( &g_gpio, GPIO_1 );
    /*
      * Read GPIO input register to determine the interrupt source
      * 0x01 = GPIO_0 interrupt (SW1)
      * 0x02 = GPIO_1 interrupt (SW2)
      */
     io_state = GPIO_get_inputs( &g_gpio );

    /******************************************************************************
     * Write a message to the SoftConsole host via OpenOCD and the debugger - added TM
     *****************************************************************************/
	#ifdef VERBOSEDEBUGCONSOLE
		initialise_monitor_handles();
		iprintf("Switch interrupt received\n");
	#endif

      // Determine which switch was pressed
      if ( io_state == 0x00000001 )
      	{
			#ifdef VERBOSEDEBUGCONSOLE
    	    iprintf("Switch 1 pressed - Manual Demo Trigger\n");
    	    //Start "Demo();" Function to run demo motions, repeat 3X
			#endif
      	}
      else if ( io_state == 0x00000002 )
      	{
			#ifdef VERBOSEDEBUGCONSOLE
    	  	iprintf("Switch 2 pressed - ESTOP Actuated (Reset SF2 to restore operation)\n");
    	  	//Disable interrupt to button 1 (//GPIO_disable_irq( &g_gpio, GPIO_0 );)
    	  	//disable CorePWM
    	  	//lock in infinite loop
            #endif
    	  	//	The following (to 664) added by Tim McCarthy 3/7/17
    	    /*
    	     * Set initial delay used to blink the LED.
    	     */
    	    delay_count = DELAY_LOAD_VALUE;

    	    /*
    	     * Infinite loop.
    	     */
    	    for(;;)
    	    {
    	    	uint32_t gpio_loop_pattern;

    	    	/*
    	         * Decrement delay counter.
    	         */
    	        --delay_count;

    	        /*
    	         * Check if delay expired.
    	         */
    	        if ( delay_count <= 0 )
    	        {
    	            /*
    	             * Reload delay counter.
    	             */
    	            delay_count = DELAY_LOAD_VALUE;

    	            /*
    	             * Toggle GPIO output pattern by doing an exclusive OR of all
    	             * pattern bits with ones.
    	             */
    	            gpio_loop_pattern = GPIO_get_outputs( &g_gpio );
    	            gpio_loop_pattern ^= 0x00000007;	// changed TM
    	            GPIO_set_outputs( &g_gpio, gpio_loop_pattern );
    	        }
    	    }

      	}
      else if ( io_state == 0x00000003 )
      	{
			#ifdef VERBOSEDEBUGCONSOLE
    	    iprintf("Switch 1 and Switch 2 pressed\n"); //this is a abnormal situation, left in here as example
    	    //this is a abnormal situation!  This is just left in as an example
            #endif
        }
      else {} //null statement


    /*
     * Clear interrupt both at the GPIO levels.
     */
    GPIO_clear_irq( &g_gpio, GPIO_0 );
    GPIO_clear_irq( &g_gpio, GPIO_1 );
    /*
     * Clear the interrupt in the Cortex-M3 NVIC.
     */

    NVIC_ClearPendingIRQ(FabricIrq1_IRQn);
    GPIO_enable_irq( &g_gpio, GPIO_0 ); //re-enable IRQ for Button 1
    GPIO_enable_irq( &g_gpio, GPIO_1 );  //re-enable IRQ for Button 2

    #ifdef VERBOSEDEBUGCONSOLE
    iprintf("Interrupt Action Routine Complete - Returning to Main Function\n"); //this is a abnormal situation, left in here as example
    //this is a abnormal situation!  This is just left in as an example
	#endif
    // The next line removed by TM for testing 3/7/17
    //main(); //restart the MAIN function, or preferably return to the input loop where the interrupt was called from
}


/******************************************************************************
 * Delay function.
 *****************************************************************************/
void delay( int mult )
{
    volatile int counter = 0;

    while ( counter < (DELAY_COUNT*mult) )
    {
        counter++;
    }
}


/******************************************************************************
 * ABS Motion Function.
 *****************************************************************************/

void set_deg_abs(float deg, int pwmnum)
{
	    float deg_position_duty;

		//Drive Servo with PWM value after calculation with requested degree and trim parameters for each servo
		if (pwmnum==1)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_1_PWM)-(MIN_DEFLECT+TRIM_MIN_1_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_1)*deg)+TRIM_ROT_DEG_OFFSET_1))+(MIN_DEFLECT+TRIM_MIN_1_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_1, (int)deg_position_duty);//Set position of servo 1
		}

		else if (pwmnum==2)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_2_PWM)-(MIN_DEFLECT+TRIM_MIN_2_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_2)*deg)+TRIM_ROT_DEG_OFFSET_2))+(MIN_DEFLECT+TRIM_MIN_2_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_2, (int)deg_position_duty);//Set position of servo 2
		}

		else if (pwmnum==3)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_3_PWM)-(MIN_DEFLECT+TRIM_MIN_3_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_3)*deg)+TRIM_ROT_DEG_OFFSET_3))+(MIN_DEFLECT+TRIM_MIN_3_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_3, (int)deg_position_duty);//Set position of servo 3
		}

		else if (pwmnum==4)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_4_PWM)-(MIN_DEFLECT+TRIM_MIN_4_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_4)*deg)+TRIM_ROT_DEG_OFFSET_4))+(MIN_DEFLECT+TRIM_MIN_4_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_4, (int)deg_position_duty);//Set position of servo 4
		}

		else if (pwmnum==5)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_5_PWM)-(MIN_DEFLECT+TRIM_MIN_5_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_5)*deg)+TRIM_ROT_DEG_OFFSET_5))+(MIN_DEFLECT+TRIM_MIN_5_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_5, (int)deg_position_duty);//Set position of servo 5
		}

		else if (pwmnum==6)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_6_PWM)-(MIN_DEFLECT+TRIM_MIN_6_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_6)*deg)+TRIM_ROT_DEG_OFFSET_6))+(MIN_DEFLECT+TRIM_MIN_6_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_6, (int)deg_position_duty);//Set position of servo 6
		}
		else if (pwmnum==6)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_7_PWM)-(MIN_DEFLECT+TRIM_MIN_7_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_7)*deg)+TRIM_ROT_DEG_OFFSET_7))+(MIN_DEFLECT+TRIM_MIN_7_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_7, (int)deg_position_duty);//Set position of servo 7
		}
		else if (pwmnum==6)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_8_PWM)-(MIN_DEFLECT+TRIM_MIN_8_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_8)*deg)+TRIM_ROT_DEG_OFFSET_8))+(MIN_DEFLECT+TRIM_MIN_8_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_8, (int)deg_position_duty);//Set position of servo 8
		}
		else
		{}  //end if statement

}
/******************************************************************************
	Return to Hold Function
 *****************************************************************************/
void returntohold()
	{
	set_deg_abs(110.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(160.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(38.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(92.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(30.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(100.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
	set_deg_abs(100.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point

#ifdef VERBOSEDEBUGCONSOLE
   	   /******************************************************************************
        * Write a message to the SoftConsole host via OpenOCD and the debugger - added by TM
        *****************************************************************************/
   	    initialise_monitor_handles();
   	    iprintf("Set to HOLD Point\n");
#endif
	}

/******************************************************************************
	Grabbing Tubes Functions
 *****************************************************************************/
void grabtube(int pos) //set position of jaws for grabbing objects - because of the short distance this is simply implemented in absolute motion, this will not work for all drive motions!
{
	if (pos==0)
		{
		set_deg_abs(120.0, JAW); //safe resting position (nearly full closed)
		}
	else if (pos==1)
		{
		set_deg_abs(130.0, JAW);//Jaws full closed (this is with small continued force, do not leave in this position grabbing tube for more than aprox 15 sec. because servo will heat up!)
		}

	else if (pos==2)
		{
		set_deg_abs(50.0, JAW); //Open jaws (release tube)
		}
	else if (pos==3)
		{
			set_deg_abs(110.0, JAW);//Jaws to grab conical plastic tube  (release tube)
		}
	else
	{} //end of IF statements
	delay (50);
}


/******************************************************************************
	Demo motions - this is a calibration function to verify the motion is properly
 *****************************************************************************/

void calmotions()
{

	set_deg_inc(91.0, 92.0, 0, 1, 5, ARMROT); //rotate arm from point A to point B
	delay(1000);

	grabtube(2);

	set_deg_inc(80.0, 30.0, 1, 1, 10, ARMEXT); //placing tube into position B
	delay (1000);
	set_deg_inc(48.0, 160.0, 0, 1, 10, JAWPIVOT); // moves jaw down to align tube to hole B
	delay(10000);

	//set_deg_inc(55.,0 38.0, 1, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	grabtube(3);
	delay(8000);
	set_deg_inc(65.0, 80.0, 0, 1, 10, ARMEXT); //lifting tube out of hole
	delay(1000);
	set_deg_inc(80.0, 65.0, 1, 1, 10, ARMEXT);//putting tube back into hole
	delay(500);
	grabtube(2);

	delay(500);
	set_deg_inc(30.0, 80.0, 0, 1, 10, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	//set_deg_inc(38.0, 55.0, 1, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(160.0, 48.0, 1, 1, 10, JAWPIVOT); // moves jaw down to align tube to hole B
	set_deg_inc(92.0, 91.0, 1, 1, 10, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(100.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
	set_deg_abs(100.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point
	delay(500);

	returntohold();
}


float set_deg_inc(float deg_new, float deg_old, int dir, float stepsize, int delay_len, int servo_num)
{
	float holder;
	if (dir==1)
	{
	for (float i = deg_old; i <= (float)deg_new; i = (float)i + (float)stepsize)
		{
		set_deg_abs(i, servo_num);
		delay(delay_len);
		holder=i;
		}
	}
	else if (dir==0)
	{
		for (float i = deg_old; i >= (float)deg_new; i = (float)i - (float)stepsize)
			{
			set_deg_abs(i, servo_num);
			delay(delay_len);
			holder=i;
			}
	}
	return holder; //keep track of position to prevent loss of location
}
/******************************************************************************
	Motion One
 *****************************************************************************/
void motiononeHoldtoA ()
{

		set_deg_inc(115.0,92.0,1,.5,10,ARMROT); //pivot arm from hold to Point A
		set_deg_inc(92.0,30.0,1,1,10,ARMEXT); //brings arm down to test tube
		delay(500);
		set_deg_inc(84.0,160.0,0,1,10,JAWPIVOT); //adjusting jaw down
		delay(1000);
		grabtube (3);
		delay(500);
		set_deg_inc(75.0, 84.0, 1 ,0.5,10,JAWPIVOT); //adjusting jaw down
		delay(300);
		set_deg_inc(60.0, 93.0, 0, 1, 10, ARMEXT); // moves arm up to lift test tube
		delay(500);
}


void motiononeAtoB()
{
	set_deg_inc(62.0, 115.0, 0, .5, 5, ARMROT); //rotate arm from point A to point B
	set_deg_inc(50.0, 38.0, 1, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	delay(500);
	//set_deg_inc(74.0, 75.0, 0, 0.5, 10, JAWPIVOT); // moves jaw down to align tube to hole B
	delay(1000);
	set_deg_inc(78.0, 60.0, 1, 1, 10, ARMEXT); //placing tube into position B
	delay (500);
}


void motiononebheighttransition()
{

	set_deg_inc(50.0, 80.0, 0, 1, 10, ARMEXT); // move arm up after dropping tube to hole B
	delay(500);
	set_deg_inc(38.0, 50.0, 0, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	delay (500);
}

void motiononeBtoHold()
{
	set_deg_inc(110.0, 110.0, 1, 1, 10, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(160.0, 74.0, 1, 1, 10, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(38.0, 38.0, 1, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(92.0, 62.0, 1, 1, 10, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(30.0, 50.0, 0, 1, 10, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(100.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
	set_deg_abs(100.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point
	delay(500);
}

/******************************************************************************
	Motion Two
 *****************************************************************************/
void motiontwoHoldtoB()
{

	set_deg_inc(64.0, 91.5, 0, .5 , 10, ARMROT); //pivot arm from hold to Point B
	delay(100);
	set_deg_inc(108.0, 30.0, 1, 1, 10, ARMEXT); //bring arm down to tube at Point B
	delay(500);
	set_deg_inc(96.0 , 160.0, 0, 1, 10, JAWPIVOT); //adjust jaw down
	delay(700);
	grabtube(3);
	delay(700);
	set_deg_inc(94.0, 96.0, 0, 1, 10, JAWPIVOT); //adjust jaw down
	delay(500);
	set_deg_inc(70.0, 110.0, 0, 1, 10, ARMEXT); //moves arm to lift tube
	delay(1000);
}

void motiontwoBtoA()
{

	set_deg_inc(112.0, 63.5, 1, .5, 5, ARMROT);
	delay(1000);
	set_deg_inc(28.0,38.0, 0, 1, 10, JAWROT); //rotates jaw to align into hole A
	delay(500);
	set_deg_inc(88.0, 94.0, 0, 1, 10, JAWPIVOT); //moves jaw down to align tube to hole A
	delay(500);
	set_deg_inc(87.0, 70.0, 1, 1, 10, ARMEXT); //place tube in point A
	delay(1000);
	set_deg_inc(78.0, 88.0, 0, 1, 10, JAWPIVOT); //moves jaw down to align tube to hole A
	delay(500);

}

void motionotwoaheighttransition()
{
	set_deg_inc(50.0, 87.0, 0, 1, 10, ARMEXT); // move arm up after dropping tube to hole A
	delay(500);
}

void motiontwoAtoHold()
{
	set_deg_inc(110.0, 110.0, 1, 1, 10, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(160.0, 83.0, 1, 1, 10, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(38.0, 28.0, 0, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(92.0, 112.0, 1, .5, 10, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(30.0, 50.0, 0, 1, 10, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(100.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
	set_deg_abs(100.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point
	delay(500);
}

/******************************************************************************
	Motion Three
 *****************************************************************************/

void motionthreeHoldtoC() //Hold to C
{

    set_deg_inc(85.0,92.0,0,.5,10,ARMROT); //pivot arm from hold to Point C
    delay(600);
    set_deg_inc(103,30.0,1,0.5,10,ARMEXT); //brings arm down to test tube
    delay(300);
    set_deg_inc(92.0,160.0,0,0.5,10,JAWPIVOT); //adjusting jaw down
    delay(300);
	grabtube(3);
	delay(500);
	set_deg_inc(88.0, 92.0,0,0.5,10,JAWPIVOT);
	delay(300);
	set_deg_inc(75.0, 103.0, 0, 1, 15, ARMEXT); //moves arm to lift tube
	delay(1000);
}


void motionthreeCtoD()
{
	set_deg_inc(53.0, 85.0, 0, 1, 10, ARMROT);
	delay(500);
	set_deg_inc(80.0, 88.0, 0, 1, 10, JAWPIVOT);
	delay(800);
	set_deg_inc(25.0, 38.0, 0, 1, 10, JAWROT);
	set_deg_inc(87.0, 75.0, 1, 1, 10, ARMEXT);
	delay(500);

}
void motionthreeDtoHold()
{
	set_deg_inc(30.0, 87.0, 0, 1, 10, ARMEXT);
	set_deg_inc(160.0, 80.0, 1, 1, 10, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(38.0, 30.0, 1, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_inc(92.0, 53.0, 1, 1, 10, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	delay(500);
}

/******************************************************************************
	Motion Four // Tube D to C
 *****************************************************************************/

void motionfourHoldtoD()
{
	set_deg_inc(53.0, 92.0, 0, 1, 10, ARMROT);
	delay(500);
	set_deg_inc(78.5, 160.0, 0, .5, 10, JAWPIVOT);
	delay(200);
	set_deg_inc(90.0, 30.0, 1, 1, 10, ARMEXT);
	delay(500);
	grabtube(3);
	delay(500);
	set_deg_inc(75.0, 78.5, 0, 0.5, 10,JAWPIVOT); //adjusting tube within hole
	delay(500);
	set_deg_inc(70.0, 90.0, 0, 1, 10, ARMEXT); //lifting tube out of hole
	delay(1000);

}

void motionfourDtoC()
{
	set_deg_inc(90.0, 53.0, 1, 1, 10, ARMROT); // move tube from D to C
	delay(1000);
	set_deg_inc(55.0, 38.0, 1, 1, 10, JAWROT); // Align tube to D
	delay(200);
	set_deg_inc(70.0, 75.0, 0, 1, 10, JAWPIVOT); // Aligns tube to D
	delay(700);
	set_deg_inc(84.0, 70.0, 1, 1, 10, ARMEXT); //puts tube into C
	delay(500);

}


void motionfourCheighttransition()
{

	set_deg_inc(87.0, 84.0, 1, 1, 10, ARMEXT); // move arm down wiggle off tube
	delay(500);
	set_deg_inc(91.0, 90.0, 1, .5, 5, ARMROT); //rotate arm from point A to point B
	delay(200);
}
void motionfourCtoHold()
{
	set_deg_inc(38.0, 55.0, 0, 1, 10, JAWROT);
	set_deg_inc(160.0, 73.0,1,1,10,JAWPIVOT); //adjusting tube within hole
	delay(500);
	set_deg_inc(30.0, 87.0, 0, 1, 10, ARMEXT); //lifting tube out of hole
	delay(500);
	set_deg_inc(92.0, 91.0, 1, 1, 10, ARMROT); // move tube from D to C
	delay(1000);

}


/******************************************************************************
	Motion Five
 *****************************************************************************/
void motionfiveAtoagitate()
{

		set_deg_inc(115.0, 75.0, 1, 0.5, 10, JAWPIVOT);
		set_deg_inc(180.0, 38.0, 1, 1, 5, JAWROT); //rotate tube
        delay(600);
        set_deg_inc(5.0, 180.0, 0, 1, 5, JAWROT); //rotate tube back
        delay(500);
        set_deg_inc(180.0, 5.0, 1, 1, 5, JAWROT);
        delay(500);
        set_deg_inc(38.0, 180.0, 0, 1, 5, JAWROT);
        delay(600);

}
void putdownA()
{

		set_deg_inc(30.0 ,38.0, 0, 1, 10, JAWROT); //rotates jaw to align into hole A
		delay(500);
		set_deg_inc(90.0, 115.0, 0, 1, 10, JAWPIVOT); //moves jaw down to align tube to hole A
		delay(1000);
		set_deg_inc(85.0, 60.0, 1, 1, 10, ARMEXT); //place tube in point A
		delay(1500);
		set_deg_inc(83.0, 90.0, 0, 1, 10, JAWPIVOT); //moves jaw down to align tube to hole A
		delay(500);
		grabtube(2);
		delay(500);
		set_deg_inc(50.0, 85.0, 0, 1, 10, ARMEXT); // move arm up after dropping tube to hole A
		delay(1000);
		set_deg_inc(83.0, 83.0, 1, 1, 10, JAWPIVOT);  //adjusted for INTERMEDIATE position using incremental motion for safe holding
		delay(500);
}

/******************************************************************************
	Motion Six
 *****************************************************************************/

/******************************************************************************
	Motion Seven //C to agitate
 *****************************************************************************/

void motionsevenCtoagitate()
{
		set_deg_inc(120.0,88.0,1,1,10,JAWPIVOT);
        set_deg_inc(180.0, 38.0, 1, 1, 5, JAWROT); //rotate tube
        delay(600);
        set_deg_inc(5.0, 180.0, 0, 1, 5, JAWROT); //rotate tube back
        delay(500);
        set_deg_inc(180.0, 5.0, 1, 1, 5, JAWROT);
        delay(500);
        set_deg_inc(38.0, 180.0, 0, 1, 5, JAWROT);
        delay(600);


}
void putdownC()
{
		set_deg_inc(89.0 ,120.0, 0, 1, 10, JAWPIVOT); //adjust jaw pivot
		delay(500);
        set_deg_inc(85.0, 75.0, 1, 1, 15, ARMEXT); //place tube back in C
        delay(1000);
        grabtube(2);
        delay(500);
        set_deg_inc(88.0, 85.0, 1, 1, 10, ARMEXT); // move arm down wiggle off tube
        delay(500);
        set_deg_inc(86.0, 85.0, 1, .5, 5, ARMROT); //rotate arm from point A to point B
        delay(200);
}
void motionsevenCtoHold()
{
       //set_deg_inc(110.0, 55.0, 1, 1, 10, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
        set_deg_inc(160.0, 89.0, 1, 1, 10, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
        //set_deg_inc(38.0, 38.0, 1, 1, 10, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
        //set_deg_inc(92.0, 80.0, 1, 1, 10, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
        set_deg_inc(30.0, 88.0, 0, 1, 10, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
        set_deg_abs(100.0, AUX0);  //Set AUX0 to 100 - just a number to initialize, no use at this point
        set_deg_abs(100.0, AUX1);  //Set AUX1 to 100 - just a number to initialize, no use at this point
        delay(500);
}

void Demo()
{
		set_deg_abs(110.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	    set_deg_inc(50.0,160.0,0,1,5,JAWPIVOT); //move from hold
	    set_deg_inc(100.0,92.0, 1 , 1, 10,ARMROT);//move from hold
	    set_deg_inc(190.0,38.0,1,1,5,JAWROT);//move from hold
	    grabtube(2);
	    delay(200);
		set_deg_inc(160.0,100.0,1,1,10,ARMROT);  //Send ARM ROTATION to new position
		set_deg_inc(80.0,30.0,1,1,8,ARMEXT);  //Send ARMEXT to new position
		set_deg_inc(120.0,50.0,1,1,5,JAWPIVOT);  //Send JAW PIVOT to new position
		delay (200);
		grabtube(3);
		set_deg_inc(0.0,190.0,1,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(190.0,0.0,0,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(30.0,80.0,0,1,8 ,ARMEXT);  //Send ARM to extreme position using incremental motion algorithm, this second step is used to prevent arm falling over apex of motion
		set_deg_inc(150.0,120.0,0,1,5,JAWPIVOT);  //Send JAW PIVOT to extreme position using incremental motion algorithm
		grabtube(2);
		delay (200);
		set_deg_inc(0.0,160.0,0,1,10,ARMROT);  //Send ARM ROTATION to extreme position using incremental motion algorithm
		delay (200);
		grabtube(3);
		set_deg_inc(190.0,0.0,1,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(0.0,190.0,0,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		grabtube(2);
		set_deg_inc(160.0, 150.0,1,1,5,JAWPIVOT); //back to holds
		set_deg_inc(38.0,0.0,0,1,5,JAWROT);//back to holds
		set_deg_inc(92.0,0.0,1,1,10,ARMROT);//back to holds
		returntohold();
		delay(1000);
}

void AtoB()
{
	returntohold(); //careful, this can be fast! place arm in the HOLD position if not there already, it should be there, this is really a redundant safety check
	grabtube (2);	//Open jaws to accept tube (pos=0 safe resting position, pos=1 full closed(caution!!), pos=3 open jaws, pos=4 grab conical tube)
	delay (500);
	motiononeHoldtoA();  //  move the arm from the hold position to position A and pick up tube
	delay (500);
	motiononeAtoB(); // move the arm from position A to position B and drop into B
	delay(1000);
	grabtube (2);
	delay (1000);
	motiononebheighttransition(); // move arm up after dropping tube to hole B
	motiononeBtoHold(); //incremental movement to hold position
	delay(200);
	returntohold(); // make sure its in hold
	delay(500);
	returntohold();
	delay (1000);
}

void BtoA()
{
	returntohold(); //careful, this can be fast! place arm in the HOLD position if not there already, it should be there, this is really a redundant safety check
	grabtube (2);	//Open jaws to accept tube (pos=0 safe resting position, pos=1 full closed(caution!!), pos=3 open jaws, pos=4 grab conical tube)
	delay (1000);
	motiontwoHoldtoB(); //move arm from hold position to hole B
	delay(500);
	motiontwoBtoA(); //Move arm from position B to A
	delay(1000);
	grabtube (2); // Open jaws to drop tube into A
	delay(1000);
	motionotwoaheighttransition(); // move arm up after dropping tube to hole A
	motiontwoAtoHold(); //incremental movement to hold position
	delay(200);
	returntohold();
	delay(500);
	returntohold();
	delay (1000);
}

void CtoD()
{
	grabtube(2);
	motionthreeHoldtoC();
	delay(500);
	motionthreeCtoD();
	delay(500);
	grabtube(2);
	delay(500);
	motionthreeDtoHold();
	delay(500);
	returntohold();
	delay(1000);
}

void DtoC()
{
	grabtube(2);
	motionfourHoldtoD();
	delay(500);
	motionfourDtoC();
	delay(500);
	grabtube(2);
	delay(1000);
	motionfourCheighttransition();
	delay(500);
	motionfourCtoHold();
	delay(500);
	returntohold();
	delay(1000);
}

void AgitateA()
{
	grabtube(2);
	motiononeHoldtoA();
	delay(1000);
	motionfiveAtoagitate();
	delay(500);
	putdownA();
	delay(1000);
	motiontwoAtoHold();
	delay(1000);
	returntohold();
	delay(1000);
}

void AgitateC()
{
	grabtube(2);
	motionthreeHoldtoC();
	delay(1000);
	motionsevenCtoagitate ();
	delay(500);
	putdownC();
	delay(1000);
	motionsevenCtoHold();
	returntohold();
	delay(1000);
}


/******************************************************************************
	Motion Extremes - this is a test function that individually tests the extreme motion of each DoF for each controlled servo
 *****************************************************************************/
void motionextremes()
	{
	//SERVO DOF holding positions - demo limit Sweep for each arm degree of Freedom (DOF)

	//JAW MOTION
		set_deg_inc(134.0,50.0,1,1,3,JAW);  //Send JAW to FULL CLOSED position using incremental motion algorithm (positive direction)
		delay (200);
		set_deg_inc(50.0,134.0,0,1,3,JAW);  //Send JAW to FULL OPEN position using incremental motion algorithm (negative direction)
		delay (200);
		set_deg_abs(110, JAW);//Return to safe hold
		delay (200);

	//JAW PIVOT MOTION
		set_deg_inc(179.0,8.0,1,1,5,JAWPIVOT);  //Send JAW PIVOT to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(8.0,179.0,0,1,5,JAWPIVOT);  //Send JAW PIVOT to extreme position using incremental motion algorithm
		delay (200);
		set_deg_abs(160, JAWPIVOT); //Return to safe hold
		delay (200);

  //JAW ROATATION MOTION
		set_deg_inc(190.0,0.0,1,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(0.0,190.0,0,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_abs(33, JAWROT);  //Return to safe hold
		delay (200);

 //ARM ROATATION MOTION
	   set_deg_inc(190.0,0.0,1,1,10,ARMROT);  //Send ARM ROTATION to extreme position using incremental motion algorithm
	   delay (200);
	   set_deg_inc(0.0,190.0,0,1,10,ARMROT);  //Send ARM ROTATION to extreme position using incremental motion algorithm
	   delay (200);
	   set_deg_abs(92, ARMROT);  //Return to safe hold
	   delay (200);

//ARM EXTENSION MOTION
	    set_deg_inc(145.0,30.0,1,1,8,ARMEXT);  //Send ARM to extreme position using incremental motion algorithm
	    delay (200);
	    set_deg_inc(30.0,145.0,0,1,8 ,ARMEXT);  //Send ARM to extreme position using incremental motion algorithm, this second step is used to prevent arm falling over apex of motion
	    delay (200);
	    set_deg_inc(3.0,30.0,0,.5,11,ARMEXT);  //Send ARM to extreme position using incremental motion algorithm
	    delay (200);
		set_deg_abs(30, ARMEXT);  //Return to safe hold
		delay (200);


		delay(1000); //Wait before return to top of cycle
}
