/*******************************************************************************
 *Microsemi Robotic Arm Demo for Sample Sorting for SmartFusion2
 *Application code (c) Copyright 2017 Microsemi SoC Products Group & Calit2 at the University of California, Irvine.
 *Base Example code (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *Extended application by Tim McCarthy (Microsemi) and Michael Klopfer (Calit2) + Calit2 student team
 *This example project demonstrates control  control the duty cycle of
 *individual PWM outputs to drive servos for a mechanical arm that sorts test tubes in a rack.  The application is driven by serial commands.
 *Final Build v1.0: April 2017
 *
 */

#include "platform.h"
#include "core_pwm.h"
#include "drivers/mss_timer/mss_timer.h"
#include "CMSIS/system_m2sxxx.h"
#include "hal.h"
#include "drivers/CoreUARTapb/core_uart_apb.h"
#include "drivers/CoreGPIO/core_gpio.h"
#include "m2sxxx.h"
#include <stdio.h>  //used for ARM Semihosting (Console Debug)

//**************************************************************************************************
//Debugging Control     NOTE: Comment out on production eNVM builds to avoid Semihosting errors!!  (There is no target for the debug messages when running without a console)
//#define VERBOSEDEBUGCONSOLE //Verbose debugging in console using ARM Semihosting, comment out to disable console debug messages - do not go too crazy with Semihosting, it will slow down operation if used excessively.
//**************************************************************************************************

//Demonstration Motion Control
//Motion control routines can be turned on individually to manually activate individual arm motions to demonstrate and test functionality of movement (normally commented out!)
//  #define MOTIONEIGHT  // demo test function for calibration checking
//	#define MOTIONNINE  //"Demo Motions" Routine
//#define MOTIONDEMOS

#ifdef VERBOSEDEBUGCONSOLE
	   extern void initialise_monitor_handles(void); //ARM Semihosting enabled
#endif


/******************************************************************************
 * Sample baud value to achieve UART communication at a 115200 baud rate with a 70MHz system clock.
 * This value is calculated using the following equation:
 *      BAUD_VALUE = (CLOCK / (16 * BAUD_RATE)) - 1
 *      For CoreUART
 *****************************************************************************/
#define BAUD_VALUE    37	   // 37 as calculated baud value for 115200, used for Sparkfun BluetoothMate Gold default baud


/******************************************************************************
 * Maximum UART receiver buffer size.
 *****************************************************************************/
#define MAX_RX_DATA_SIZE    32 //this value can be larger, but 32 is chosen as opposed to the default 256 as only single characters needed in the scheme used.


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
uint8_t g_message[] ="K";  //Heartbeat message - send back heartbeat command to tablet link, this is the UART message to reply with, and is used by tablet to assess connection is still active  (Note: alternatively "K\n\r" can be used with corresponding parsing on the receive side);

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
#define DELAY_COUNT     6500  //principle multiplier to set delays in function (changing this changes the length of all delays, modify with caution, should be set so a delay of 1000 = 1 second, hence a unit is equalled approximately to 1 ms)

/******************************************************************************
 * PWM prescale and period configuration values to set PWM frequency and duty cycle.  (Unless fabric is changed please do not modify, unless you have an exceedingly good reason to do so, these values work for hobby servos)
 *****************************************************************************/
#define PWM_PRESCALE    4  //Prescale value 4 (formerly set to 39)
#define PWM_PERIOD      399  //full period     (formerly set to 499)
//4 & 399 equate to 5us/step - practically this is 400 steps for 180 degrees of roation resolution, not bad!

/******************************************************************************
 * Servo Global Operation Parameters  (Project global settings - modify with justification and caution once set!)
 *****************************************************************************/
#define MAX_DEFLECT 495.0 //max deflection of servo (pwm value) (use whole number with decimal for float calc)
#define MIN_DEFLECT 95.0 //min deflection of servo (pwm value) (use whole number with decimal for float calc)
#define ROTATION_DEGREES 170.0 //Servo physical rotation span (degrees) (use whole number with decimal for float calc)

/******************************************************************************
 * Servo Trim Parameters - Trim Parameters for each servo to correct differences between units for identical performance.  Servos that become locked at aqn extreme or are asked to move beyond an extreme may draw excessive current and burn out rapidly.  ensure all servos are not drawing excessive current in any point of their motion.
 *****************************************************************************/
//SERVO 1 Parameters
#define TRIM_ROT_DEG_GAIN_1 1.0
#define TRIM_ROT_DEG_OFFSET_1 0.0
#define TRIM_MIN_1_PWM 6.0
#define TRIM_MAX_1_PWM -8.0

//SERVO 2 Parameters
#define TRIM_ROT_DEG_GAIN_2 1.0
#define TRIM_ROT_DEG_OFFSET_2 0.0
#define TRIM_MIN_2_PWM 6.0
#define TRIM_MAX_2_PWM -8.0

//SERVO 3 Parameters
#define TRIM_ROT_DEG_GAIN_3 1.0
#define TRIM_ROT_DEG_OFFSET_3 0.0
#define TRIM_MIN_3_PWM 2.0
#define TRIM_MAX_3_PWM -8.0
#define OFFSET 41.0

//SERVO 4 Parameters
#define TRIM_ROT_DEG_GAIN_4 1.0
#define TRIM_ROT_DEG_OFFSET_4 0.0
#define TRIM_MIN_4_PWM 6.0
#define TRIM_MAX_4_PWM -8.0

//SERVO 5 Parameters
#define TRIM_ROT_DEG_GAIN_5 1.0
#define TRIM_ROT_DEG_OFFSET_5 0.0
#define TRIM_MIN_5_PWM 3.0
#define TRIM_MAX_5_PWM -8.0

//SERVO 6 Parameters
#define TRIM_ROT_DEG_GAIN_6 1.0
#define TRIM_ROT_DEG_OFFSET_6 0.0
#define TRIM_MIN_6_PWM 5.0
#define TRIM_MAX_6_PWM -8.0

//SERVO 7 Parameters
#define TRIM_ROT_DEG_GAIN_7 1.0
#define TRIM_ROT_DEG_OFFSET_7 0.0
#define TRIM_MIN_7_PWM 6.0
#define TRIM_MAX_7_PWM -8.0

//SERVO 8 Parameters
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
#define ARMEXT 3 //Extension of Arm  (Creative Board - Pin D8)
#define ARMROT 2 //Rotation of arm base  (Creative Board - D10)
#define DIAGLED 1 //Diagnostic LED  (Creative Board - LED1 Green)
#define ARMPIVOT 7 //(Creative Board - (die P12-d12))Rotation of Jaw Arm  NEWLY ADDED
#define ARMREACH 8 //(Creative Board - (die P13-d13)) Second Extension of Arm NEWLY ADDED



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
void returntohold();
void calmotions();
void Demo();
void Timer1_IRQHandler(void);
void FabricIrq1_IRQHandler( void );
void FabricIrq2_IRQHandler( void );
void AtoB();
void BtoA();
void CtoD();
void DtoC();
void AgitateA();
void AgitateB();
void AgitateC();
void AgitateD();



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
	    delay (200);  //add ~200ms delay to prevent HAL assertion issue
	    /**************************************************************************
	     * Set the initial duty cycle for CorePWM output 1.
	     *************************************************************************/

	    //Initialize into save SERVO DOF holding positions:
	    //Initial position
	        set_deg_abs(70.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(80.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(100.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(90.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(0.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	    	set_deg_abs(65.0, ARMPIVOT);  //Send ARMPIVOT
	    	set_deg_abs(100.0, ARMREACH);  //Send ARMREACH
	    	delay (1000);//Pause at initial HOLD position before setting final hold position

	    	//Initial HOLD Point
	    	set_deg_abs(71.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(81.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(101.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(91.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(1.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(66.0, ARMPIVOT);  //Send ARMPIVOT
			set_deg_abs(101.0, ARMREACH);  //Send ARMREACH
			delay (1000);//Pause at initial HOLD position before setting final hold position


			//Initial HOLD Point
	    	set_deg_abs(70.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(80.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(100.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(90.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(0.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
			set_deg_abs(65.0, ARMPIVOT);  //Send ARMPIVOT
			set_deg_abs(100.0, ARMREACH);  //Send ARMREACH
			delay (1000);//Pause at initial HOLD position before setting final hold position

			calmotions();

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
		#ifdef VERBOSEDEBUGCONSOLE
				iprintf("first heartbeat\n");
		#endif
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
* Configure the GPIOs for the indicator LEDs
*************************************************************************/
    GPIO_config( &g_gpio, GPIO_0, GPIO_OUTPUT_MODE );  //Led #1 (Physically the red element of the LED 1 bi-color LED on the Future Creative board) - the green element of this bi-color LED is the PWM demo output
    GPIO_config( &g_gpio, GPIO_1, GPIO_OUTPUT_MODE );  //Led #2 (Physically the green element of the LED 2 bi-color LED on the Future Creative board)
    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE );  //Led #3 (Physically the red element of the LED 2 bi-color LED on the Future Creative board)
    GPIO_set_outputs(&g_gpio, g_gpio_pattern); //Write default pattern to LEDs

    /**************************************************************************
     * Configure the GPIOs for Inputs.
     *************************************************************************/
    GPIO_config( &g_gpio, GPIO_0, GPIO_INOUT_MODE | GPIO_IRQ_EDGE_POSITIVE  );  //Button 1
    GPIO_config( &g_gpio, GPIO_1, GPIO_INOUT_MODE | GPIO_IRQ_EDGE_POSITIVE  ); //Button 2
    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE ); //Spare input button, currently disabled

#ifdef VERBOSEDEBUGCONSOLE
    iprintf("CoreGPIO configured\n");
#endif
    /*
     * Enable individual GPIO interrupts. The interrupts must be enabled both at
     * the GPIO peripheral and Cortex-M3 interrupt controller levels.
     */
    GPIO_enable_irq( &g_gpio, GPIO_0 ); //enable IRQ for button 1
    GPIO_enable_irq( &g_gpio, GPIO_1 ); //enable IRQ for button 2
    /*
     * The following section was modified by TM on 4/18/17
     */
      NVIC_EnableIRQ(FabricIrq1_IRQn);
      NVIC_EnableIRQ(FabricIrq2_IRQn);

      // FabricIrq1 is from GPIN[0] which is connected to SW1; FabricIrq2 is from GPIN[1] which is connected to SW2
	  NVIC_SetPriority(FabricIrq1_IRQn, 6u);
	  NVIC_SetPriority(FabricIrq2_IRQn, 5u);	// set IRQ2 to a higher level than IRQ1; If SW2 is pressed while SW1 is depresses SW2 IRQ2 ISR will be executed

    /**************************************************************************
     * Configure Timer1
     * Use the timer input frequency as load value to achieve a one second
     * periodic interrupt.
    /*************************************************************************/
	uint32_t timer1_load_value;
    timer1_load_value = g_FrequencyPCLK0 *5;		// modify for 10 second delay TM
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
    	if(UART_APB_NO_ERROR == UART_get_rx_status(&g_uart)) //Verify if UART can be opened, then open UART to receive control command
		        {
		            /**********************************************************************
		             * Read data received by the UART.
		             *********************************************************************/
		            rx_size = UART_get_rx( &g_uart, rx_data, sizeof(rx_data) ); //Read UART buffer and get size
		        }
    //This group of IF statements checks for incoming commands and initiates motions if they are received, single ASCII characters are used to trigger subroutines for motion.
		        	if ( rx_size > 0 && rx_data[0]=='A' )
		             	{
						#ifdef VERBOSEDEBUGCONSOLE
		             	iprintf("Routine 'A' Received - move from A to B initiated\n"); //Identify operation via semihosting debug print
						#endif
		             	rx_data[0]=0; //flush first position in the buffer before next check with null character
		             	GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		             	AtoB();
		             	}
		             else if ( rx_size > 0 && rx_data[0]=='B' )
		             	{
						#ifdef VERBOSEDEBUGCONSOLE
		                iprintf("Routine 'B' Received - move from B to A initiated\n"); //Identify operation via semihosting debug print
						#endif
		                rx_data[0]=0; //flush first position in the buffer before next check with null character
		                GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		                BtoA();
		             	}
		             else if ( rx_size > 0 && rx_data[0]=='C' )
		             	{
						#ifdef VERBOSEDEBUGCONSOLE
		                iprintf("Routine 'C' Received - move from C to D initiated\n"); //Identify operation via semihosting debug print
						#endif
		                rx_data[0]=0; //flush first position in the buffer before next check with null character
		                GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		                CtoD();
		             	}
		             else if ( rx_size > 0 && rx_data[0]=='D' )
		                {
						 #ifdef VERBOSEDEBUGCONSOLE
		                 iprintf("Routine 'D' Received - move from D to C Operation initiated\n"); //Identify operation via semihosting debug print
						 #endif
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 GPIO_set_outputs(&g_gpio, 0x00000003); //update GPIO pattern 1 for indicator LEDs
		                 DtoC();
		                }
		             //Continue checks for the other characters - this code goes here
		             else if ( rx_size > 0 && rx_data[0]=='E' )
		                {
						 #ifdef VERBOSEDEBUGCONSOLE
		            	 iprintf("Routine 'E' Received - Agitate A Operation initiated\n"); //Identify operation via semihosting debug print
						 #endif
		            	 GPIO_set_outputs(&g_gpio, 0x00000001); //update GPIO pattern 1 for indicator LEDs
		            	 rx_data[0]=0; //flush first position in the buffer before next check with null character
		            	 AgitateA();
		                }
		             //Continue checks for the other characters - this code goes here
		             else if ( rx_size > 0 && rx_data[0]=='G' )
		                {
						 #ifdef VERBOSEDEBUGCONSOLE
		                 iprintf("Routine 'G' Received - Agitate C Operation initiated\n"); //Identify operation via semihosting debug print
                         #endif
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 GPIO_set_outputs(&g_gpio, 0x00000001); //update GPIO pattern 1 for indicator LEDs
		                 AgitateC();
		                }
		             else if ( rx_size > 0 && rx_data[0]=='I' )
		                {
                         #ifdef VERBOSEDEBUGCONSOLE
		                 iprintf("Routine 'I' Received - Demo Motions Operation initiated\n"); //Identify operation via semihosting debug print
                         #endif
		                 GPIO_set_outputs(&g_gpio, 0x00000006); //update GPIO pattern 0 for indicator LEDs
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                motionextremes();
		                }
		             else if ( rx_size > 0 && rx_data[0]== 'J' )
		                {
		                 #ifdef VERBOSEDEBUGCONSOLE
		             	 iprintf("Routine 'J' Received - Calibrations Motions Operation initiated\n"); //Identify operation via semihosting debug print
		                 #endif
		                 rx_data[0]=0; //flush first position in the buffer before next check with null character
		                 GPIO_set_outputs(&g_gpio, 0x00000005); //update GPIO pattern 1 for indicator LEDs
		                 calmotions(); //Function to test if calibration is OK

		                }
    	           //Just a helpful tip!  Move function calls for motion into here to test.  They will be executed every time loop runs, remove before testing communication and real functionality of the program.

    	else {}  //Null Case (rounding out the IF statement)


/******************************************************************************
 * This section of code is for debug testing motions by manually activating the individual actuations - if the "MOTIONS" are not "#define -ed", this is skipped as it should be in normal operation
 *************************************************************************/
    	#ifdef MOTIONDEMOS
    	//Motion Demos
    		//Function is a demo to move between extremes of motion on each DoF for the arm sequentially
    			motionextremes(); //demo motion for DoF extremes  (function written


    	#endif

	#ifdef MOTIONEIGHT
    			 //Function to demo motion of arm as a continuously running demo (motion with more "sense of purpose" and smoother than DoF Demo)
    			    calmotions(); //demo motion (needs to be written)*/

	#endif

    	#ifdef MOTIONNINE
    			//Motion "nine" - Demonstration motions for arm motion
    			/*Demo();*/

    	#endif
    			  // calmotions();

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
    GPIO_set_outputs( &g_gpio, g_gpio_pattern);//Update LEDs to inversion of previous state

     UART_send( &g_uart, g_message, sizeof(g_message) ); //send the hearbeat message to let the tablet know the link is still active
	#ifdef VERBOSEDEBUGCONSOLE
     iprintf("heartbeat\n");
	#endif
    /* Clear TIM1 interrupt */
    MSS_TIM1_clear_irq();
}


/**********************************************************************
* Interrupt driven control of function execution.
*********************************************************************/
//Buttons are handled through interrupts.  GPIO 0 interrupt service routine is FabricIrq1 ISR.  GPIO 0: This interrupt service routine function will be called when the SW1.  It will keep getting called as long as the SW1 button is pressed because the GPIO 0 input is configured as a level interrupt source.

 //Example:
    					//Enable Interrupt for Button 1 - GPIO_disable_irq( &g_gpio, GPIO_0 ); is changed to GPIO_enable_irq( &g_gpio, GPIO_0 );
        				//Enable Interrupt for Button 2 - GPIO_disable_irq( &g_gpio, GPIO_1 ); is changed to GPIO_enable_irq( &g_gpio, GPIO_1 );
    	    				  //If button 1 Press (manual demo activation), run the function "Demo();"
    	           	   	   	  //If button 2 press, (ESTOP) - hold and catch fire (HCF), disable all PWMS and put program into infinite null loop that is reset only by resetting the board.

void FabricIrq1_IRQHandler( void )
{
    /*
      * Disable GPIO interrupts while updating the delay counter and
      * GPIO pattern since these can also be modified within the GPIO
      * interrupt service routines.
      */
	GPIO_disable_irq( &g_gpio, GPIO_0 );
    GPIO_disable_irq( &g_gpio, GPIO_1 );

    /******************************************************************************
     * Write a message to the SoftConsole host via OpenOCD and the debugger
     *****************************************************************************/
	#ifdef VERBOSEDEBUGCONSOLE
		initialise_monitor_handles();
		iprintf("Switch 1 pressed - Manual Demo Trigger\n");
	#endif
		GPIO_set_outputs(&g_gpio, 0x00000004);  //Change LEDS to indicate this is run

    	    GPIO_clear_irq( &g_gpio, GPIO_0 );  //clear IRQ - Button 1
    	    GPIO_clear_irq( &g_gpio, GPIO_1 ); //clear IRQ - Button 2
    	    GPIO_enable_irq( &g_gpio, GPIO_0 );//Enable interrupt to button 1 (//GPIO_disable_irq( &g_gpio, GPIO_0 );)
    	    GPIO_enable_irq( &g_gpio, GPIO_1 );//Enable interrupt to button 2 (//GPIO_disable_irq( &g_gpio, GPIO_0 );)
    	    while (1==1) //infinite loop for demo - only stopped by resetting
    	    {
				#ifdef VERBOSEDEBUGCONSOLE
    	    	iprintf("Execution of ""Demo Motion"" routine - Push and hold ""Stop & Lock"" button to stop demo\n"); //this is an E-STOP
				#endif
    	    	Demo(); //Demo motion routine - Start "Demo();" in infinite loop
    	    	delay (4000); //delay before repeating function
    	    }

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
    iprintf("Interrupt Action Routine Complete - Returning to Main Function\n"); //Just a notation that the interrupt routine has finished
	#endif
}



//GPIO 1 interrupt service routine is FabricIrq2 ISR.
//GPIO 1 : This interrupt service routine function will be called when the SW2 button is pressed. It will only be called once even if the SW2 button is kept pressed because the GPIO 1 input is configured as a rising edge interrupt source. This ISR loops forever after the SW2 button is pressed.  The debugger must be terminated and re-launched or the board reset (if running without the debugger) to run the application again.

void FabricIrq2_IRQHandler( void )
{
    /*
      * If SW2 (stop switch) is pressed, disable PWM outputs and halt until board is reset or debugger is re-launched, this is an effective E-STOP
      */
	MSS_TIM1_disable_irq();					// disable the MSS timer interrupt
	GPIO_disable_irq( &g_gpio, GPIO_0 );	// disable the GPIO_0 (SW1) interrupt
    //GPIO_disable_irq( &g_gpio, GPIO_1 );	// keep the GPIO_1 (SW2) interrupt enabled

    /******************************************************************************
     * Write a message to the SoftConsole host via OpenOCD and the debugger
     *****************************************************************************/
	#ifdef VERBOSEDEBUGCONSOLE
		initialise_monitor_handles();
		iprintf("Switch 2 pressed - FabricIRq2; Restart the debugger to run the application\n");  //Print message that SW2 was pressed
	#endif

		GPIO_set_outputs(&g_gpio, 0x00000005);  //Turn both LEDs RED to indicate ESTOP condition

	//Disabl`	e PWM Outputs to halt Servo
		PWM_disable (&the_pwm, PWM_1);
		PWM_disable (&the_pwm, PWM_2);
		PWM_disable (&the_pwm, PWM_3);
		PWM_disable (&the_pwm, PWM_4);
		PWM_disable (&the_pwm, PWM_5);
		PWM_disable (&the_pwm, PWM_6);
		PWM_disable (&the_pwm, PWM_7);
		PWM_disable (&the_pwm, PWM_8);

	#ifdef VERBOSEDEBUGCONSOLE
		initialise_monitor_handles();
		iprintf("PWM outputs disabled\n");  //Print message that PWM outputs were disabled
	#endif

		for (;;)
		{
		//lock in infinite loop until board is reset - where the ESTOP ends
		}

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
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_3_PWM)-(MIN_DEFLECT+TRIM_MIN_3_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_3)*(deg+OFFSET))+TRIM_ROT_DEG_OFFSET_3))+(MIN_DEFLECT+TRIM_MIN_3_PWM);
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
		else if (pwmnum==7)
		{
			deg_position_duty=((((MAX_DEFLECT+TRIM_MAX_7_PWM)-(MIN_DEFLECT+TRIM_MIN_7_PWM))/(ROTATION_DEGREES))*(((TRIM_ROT_DEG_GAIN_7)*deg)+TRIM_ROT_DEG_OFFSET_7))+(MIN_DEFLECT+TRIM_MIN_7_PWM);
			PWM_set_duty_cycle( &the_pwm, PWM_7, (int)deg_position_duty);//Set position of servo 7
		}
		else if (pwmnum==8)
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
	set_deg_abs(70.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(80.0, JAWPIVOT);  //Send JAWPIVOT (JAW PIVOTING)to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(100.0, JAWROT);  //Send JAWROT (JAW ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(90.0, ARMROT);  //Send ARMROT (ARM ROTATION) to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(0.0, ARMEXT);  //Send JAWPIVOT to an INTERMEDIATE position using incremental motion for safe holding
	set_deg_abs(65.0, ARMPIVOT);  //Send ARMPIVOT
	set_deg_abs(100.0, ARMREACH);  //Send ARMREACH
#ifdef VERBOSEDEBUGCONSOLE
   	   /******************************************************************************
        * Write a message to the SoftConsole host via OpenOCD and the debugger
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
		set_deg_abs(70.0, JAW); //safe resting position (nearly full closed)
		}
	else if (pos==1)
		{
		set_deg_abs(110.0, JAW);//Jaws full closed (this is with small continued force, do not leave in this position grabbing tube for more than aprox 15 sec. because servo will heat up!)
		}

	else if (pos==2)
		{
		set_deg_abs(60.0, JAW); //Open jaws (release tube)
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
	Demo motions - this is a calibration function to verify the position is repeatable.  Arm moves back and forth between specific points
 *****************************************************************************/

void calmotions()
{
			set_deg_inc(90.0,90.0,1, 1,10,ARMROT);
			set_deg_inc(40.0, 0.0, 1, 1, 10, ARMEXT);
			delay(1000);
			set_deg_inc(40.0, 80.0, 0, 1, 10, JAWPIVOT);
			delay(1000);
			set_deg_inc(60.0, 100.0, 0, 1, 10, ARMREACH);
			delay(1000);
			grabtube(1);
			delay(1000);
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


void Demo()
{
		set_deg_abs(110.0, JAW);  //Send JAW (JAW CLOSURE POSITION) to INTERMEDIATE position using incremental motion for safe holding
	    set_deg_inc(50.0,80.0,0,1,5,JAWPIVOT); //move from hold
	    set_deg_inc(100.0,90.0, 1 , 1, 10,ARMROT);//move from hold
	    set_deg_inc(150.0,100.0,1,1,5,JAWROT);//move from hold
	    grabtube(2); //release tube
	    delay(200);
		set_deg_inc(140.0,100.0,1,1,10,ARMROT);  //Send ARM ROTATION to new position
		set_deg_inc(80.0,0.0,1,1,8,ARMEXT);  //Send ARMEXT to new position
		set_deg_inc(120.0,50.0,1,1,5,JAWPIVOT);  //Send JAW PIVOT to new position
		delay (200);
		grabtube(3);
		set_deg_inc(0.0,150.0,0,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(150.0,0.0,1,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(30.0,80.0,0,1,8 ,ARMEXT);  //Send ARM to extreme position using incremental motion algorithm, this second step is used to prevent arm falling over apex of motion
		set_deg_inc(150.0,120.0,1,1,5,JAWPIVOT);  //Send JAW PIVOT to extreme position using incremental motion algorithm
		grabtube(2);
		delay (200);
		set_deg_inc(0.0,160.0,0,1,10,ARMROT);  //Send ARM ROTATION to extreme position using incremental motion algorithm
		delay (200);
		grabtube(3);
		set_deg_inc(180.0,0.0,1,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(0.0,180.0,0,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		grabtube(2);
		set_deg_inc(80.0, 130.0,0,1,5,JAWPIVOT); //back to hold
		set_deg_inc(100.0,0.0,1,1,5,JAWROT);//back to hold
		set_deg_inc(90.0,0.0,1,1,10,ARMROT);//back to hold
		set_deg_inc(80.0,30.0,1,1,8 ,ARMEXT);
		returntohold();
		delay(500);
}


/******************************************************************************
	Motion Extremes - this is a test function that individually tests the extreme motion of each DoF for each controlled servo
 *****************************************************************************/
void motionextremes()
	{
	//SERVO DOF holding positions - demo limit Sweep for each arm degree of Freedom (DOF)
	//JAW MOTION
	#ifdef VERBOSEDEBUGCONSOLE
	iprintf("a\n");
	#endif
		set_deg_inc(40.0,70.0,0,1,3,JAW);
		set_deg_inc(110.0,40.0,1,1,3,JAW);  //Send JAW to FULL CLOSED position using incremental motion algorithm (positive direction)
		delay (200);
		set_deg_inc(40.0,110.0,0,1,3,JAW);  //Send JAW to FULL OPEN position using incremental motion algorithm (negative direction)
		delay (200);
		set_deg_inc(70.0,40.0,1,1,3,JAW);
		delay (200);
		set_deg_abs(100.0, ARMREACH);
	//JAW PIVOT MOTION
	#ifdef VERBOSEDEBUGCONSOLE
		iprintf("b\n");
	#endif
		set_deg_inc(30.0,80.0,0,1,3,JAWPIVOT);
		set_deg_inc(120.0,30.0,1,1,5,JAWPIVOT);  //Send JAW PIVOT to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(80.0,120.0,0,1,5,JAWPIVOT);  //Send JAW PIVOT to extreme position using incremental motion algorithm
		delay (200);
		set_deg_abs(100.0, ARMREACH);
 //JAW ROATATION MOTION
	#ifdef VERBOSEDEBUGCONSOLE
		iprintf("c\n");
	#endif
		set_deg_inc(50.0,100.0,0,1,3,JAWROT);
		set_deg_inc(160.0,100.0,1,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_inc(100.0,160.0,0,1,5,JAWROT);  //Send JAW ROTATION to extreme position using incremental motion algorithm
		delay (200);
		set_deg_abs(100, JAWROT);  //Return to safe hold
		delay (200);
		set_deg_abs(100.0, ARMREACH);
	//ARM ROT MOTION
	#ifdef VERBOSEDEBUGCONSOLE
			iprintf("d\n");
	#endif
	   set_deg_inc(10.0,90.0,0,1,3,ARMROT);
	   set_deg_inc(170.0,10.0,1,1,10,ARMROT);  //Send ARM ROTATION to extreme position using incremental motion algorithm
	   delay (200);
	   set_deg_inc(90.0,170.0,0,1,10,ARMROT);  //Send ARM ROTATION to extreme position using incremental motion algorithm
	   delay (200);
	   set_deg_abs(90, ARMROT);  //Return to safe hold
	   delay (200);

	   set_deg_abs(100.0, ARMREACH);
	//ARM EXTENSION MOTION
	#ifdef VERBOSEDEBUGCONSOLE
		   iprintf("e\n");
	#endif
	    set_deg_inc(80.0,0.0,1,1,8, ARMEXT);  //Send ARM to extreme position using incremental motion algorithm
	    delay (200);
	    set_deg_inc(0.0,80.0,0,1,8 ,ARMEXT);  //Send ARM to extreme position using incremental motion algorithm, this second step is used to prevent arm falling over apex of motion
	    delay (200);
		set_deg_abs(0, ARMEXT);  //Return to safe hold
		delay (200);

	//ARM REACH
	#ifdef VERBOSEDEBUGCONSOLE
			iprintf("f\n");
	#endif
		set_deg_inc(160.0,100.0,1,1,8 ,ARMREACH);  //Send ARM to extreme position using incremental motion algorithm, this second step is used to prevent arm falling over apex of motion
		delay (500);
		set_deg_inc(100.0,160.0,0,.5,11,ARMREACH);  //Send ARM to extreme position using incremental motion algorithm
		delay (500);


		delay(1000); //Wait before return to top of cycle
}

void AtoB(){
	//Move Test Tube A to B --------------------

	//Pick up tube
		set_deg_inc(90.0,90.0,1, 1,10,ARMROT);
		set_deg_inc(40.0, 0.0, 1, 1, 10, ARMEXT);
		delay(1000);
		set_deg_inc(40.0, 80.0, 0, 1, 10, JAWPIVOT);
		delay(1000);
		set_deg_inc(60.0, 100.0, 0, 1, 10, ARMREACH);
		delay(1000);
		grabtube(1);
		delay(1000);
	// Raise test tube to be moved
		set_deg_inc(80.0, 60.0, 1, 1, 10, ARMREACH);
		set_deg_inc(30.0, 40.0, 0, 1, 10, ARMEXT);
		delay(1000);

		//move tube
		set_deg_inc(60.0,90.0,0, 1,10,ARMROT);
		delay(500);
		set_deg_inc(60.0, 80.0, 0, 1, 10, ARMREACH);
		delay(500);
		set_deg_inc(40.0, 30.0, 1, 1, 10, ARMEXT);
		delay(500);
		grabtube(2);
		delay(1000);

		// Back to Hold
		grabtube(0);
		set_deg_inc(100.0, 60.0, 1, 1, 10, ARMREACH);
		delay(500);
		set_deg_inc(0.0, 40.0, 0, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(90.0,60.0,1, 1,10,ARMROT);
		delay(500);
		set_deg_inc(80.0, 40.0, 1, 1, 10, JAWPIVOT);
		delay(3000);


}

void BtoA(){
//Move Test Tube B to A --------------------

	//Pick up tube
	set_deg_inc(60.0,90.0,0, 1,10,ARMROT);
	delay(500);
	set_deg_inc(40.0, 80.0, 0, 1, 10, JAWPIVOT);
	delay(500);
	set_deg_inc(40.0, 0.0, 1, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(60.0, 100.0, 0, 1, 10, ARMREACH);
	delay(1000);
	grabtube(1);
	delay(1000);

	//Rise test tube to be moved
	set_deg_inc(80.0, 60.0, 1, 1, 10, ARMREACH);
	set_deg_inc(30.0, 40.0, 0, 1, 10, ARMEXT);
	delay(500);


	//move tube
	set_deg_inc(90.0,60.0,1, 1,10,ARMROT);
	delay(500);
	set_deg_inc(60.0, 80.0, 0, 1, 10, ARMREACH);
	delay(500);
	set_deg_inc(40.0, 30.0, 1, 1, 10, ARMEXT);
	delay(500);
	grabtube(2);
	delay(1000);

	// Back to Hold
	grabtube(0);
	set_deg_inc(100.0, 60.0, 1, 1, 10, ARMREACH);
	delay(500);
	set_deg_inc(0.0, 40.0, 0, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(90.0,90.0,1, 1,10,ARMROT);
	delay(500);
	set_deg_inc(80.0, 40.0, 1, 1, 10, JAWPIVOT);
	delay(3000);
}

void CtoD(){
	//Move Test Tube C to D --------------------

		//Pick up tube
		set_deg_inc(55.0,90.0,0, 1,10,ARMROT);
		delay(500);
		set_deg_inc(85.0, 80.0, 1, 1, 10, JAWPIVOT);
		delay(500);
		set_deg_inc(60.0, 0.0, 1, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(70.0, 100.0, 0, 1, 10, ARMREACH);
		delay(1000);
		grabtube(1);
		delay(1000);

		//Raise tube to be moved
		set_deg_inc(100.0, 70.0, 1, 1, 10, ARMREACH);
		set_deg_inc(30.0, 60.0, 0, 1, 10, ARMEXT);
		delay(500);


		//move tube
		set_deg_inc(100.0,55.0,1, 1,10,ARMROT);
		delay(500);
		set_deg_inc(80.0, 100.0, 0, 1, 10, ARMREACH);
		delay(500);
		set_deg_inc(40.0, 30.0, 1, 1, 10, ARMEXT);
		delay(500);
		grabtube(2);
		delay(1000);

		// Back to Hold
		grabtube(0);
		set_deg_inc(100.0, 80.0, 1, 1, 10, ARMREACH);
		delay(500);
		set_deg_inc(0.0, 40.0, 0, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(90.0,100.0,0, 1,10,ARMROT);
		delay(500);
		set_deg_inc(80.0, 85.0, 0, 1, 10, JAWPIVOT);
		delay(3000);
	}


void DtoC(){
	//Pick up tube
	set_deg_inc(100.0, 90.0, 1, 1,10,ARMROT);
	delay(500);
	set_deg_inc(85.0, 80.0, 1, 1, 10, JAWPIVOT);
	delay(500);
	set_deg_inc(40.0, 0.0, 1, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(80.0, 100.0, 0, 1, 10, ARMREACH);
	delay(1000);
	grabtube(1);
	delay(1000);

	//Raise tube to be moved
	set_deg_inc(100.0, 80.0, 1, 1, 10, ARMREACH);
	delay(500);
	set_deg_inc(30.0, 40.0, 0, 1, 10, ARMEXT);
	delay(500);

	//move tube
	set_deg_inc(55.0, 100.0, 0, 1,10,ARMROT);
	delay(500);
	set_deg_inc(40.0, 30.0, 1, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(80.0, 100.0, 0, 1, 10, ARMREACH);
	delay(500);
	grabtube(2);
	delay(1000);

	// Back to Hold
	grabtube(0);
	set_deg_inc(100.0, 80.0, 1, 1, 10, ARMREACH);
	delay(1000);
	set_deg_inc(0.0, 40.0, 0, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(90.0,55.0,1, 1,10,ARMROT);
	delay(500);
	set_deg_inc(80.0, 85.0, 0, 1, 10, JAWPIVOT);
	delay(3000);

}
void AgitateA(){
	// Agitate A ------------------------------

	// Pick up Tube
		set_deg_inc(90.0,90.0,1, 1,10,ARMROT);
		set_deg_inc(40.0, 0.0, 1, 1, 10, ARMEXT);
		delay(1000);
		set_deg_inc(40.0, 80.0, 0, 1, 10, JAWPIVOT);
		delay(1000);
		set_deg_inc(60.0, 100.0, 0, 1, 10, ARMREACH);
		delay(1000);
		grabtube(1);
		delay(1000);

		//Raised tube to be moved
		set_deg_inc(90.0, 60.0, 1, 1, 10, ARMREACH);
		set_deg_inc(20.0, 40.0, 0, 1, 10, ARMEXT);
		delay(1000);

		//Agitate
		set_deg_inc(50.0, 100.0, 0, 1, 10,JAWROT);
		delay(500);
		set_deg_inc(160.0, 50.0, 1, 1, 10,JAWROT);
		delay(500);
		set_deg_inc(50.0, 160.0, 0, 1, 10,JAWROT);
		delay(500);
		set_deg_inc(100.0, 50.0, 1, 1, 10,JAWROT);
		delay(500);

		//Put down Tube
		set_deg_inc(40.0, 20.0, 1, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(60.0, 90.0, 0, 1, 10, ARMREACH);
		delay(500);
		grabtube(2);
		delay(500);

		//Return to Hold
		grabtube(0);
		set_deg_inc(100.0, 60.0, 1, 1, 10, ARMREACH);
		delay(1000);
		set_deg_inc(0.0, 40.0, 0, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(80.0, 40.0, 1, 1, 10, JAWPIVOT);
		delay(3000);



}

void AgitateB(){
// Agitate B ------------------------------

	// Pick up Tube
	set_deg_inc(60.0,90.0,0, 1,10,ARMROT);
		delay(500);
		set_deg_inc(40.0, 80.0, 0, 1, 10, JAWPIVOT);
		delay(500);
		set_deg_inc(40.0, 0.0, 1, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(60.0, 100.0, 0, 1, 10, ARMREACH);
		delay(1000);
		grabtube(1);
		delay(1000);

		//Raised tube to be moved
		set_deg_inc(80.0, 60.0, 1, 1, 10, ARMREACH);
		set_deg_inc(30.0, 40.0, 0, 1, 10, ARMEXT);
		delay(1000);

		//Agitate
		set_deg_inc(50.0, 100.0, 0, 1, 10,JAWROT);
		delay(500);
		set_deg_inc(160.0, 50.0, 1, 1, 10,JAWROT);
		delay(500);
		set_deg_inc(50.0, 160.0, 0, 1, 10,JAWROT);
		delay(500);
		set_deg_inc(100.0, 50.0, 1, 1, 10,JAWROT);
		delay(500);

		//Put down Tube
		set_deg_inc(40.0, 30.0, 1, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(60.0, 90.0, 0, 1, 10, ARMREACH);
		delay(500);
		grabtube(2);
		delay(500);

		//Return to Hold
		grabtube(0);
		set_deg_inc(100.0, 60.0, 1, 1, 10, ARMREACH);
		delay(1000);
		set_deg_inc(0.0, 40.0, 0, 1, 10, ARMEXT);
		delay(500);
		set_deg_inc(80.0, 40.0, 1, 1, 10, JAWPIVOT);
		delay(500);
		set_deg_inc(90.0,60.0,1, 1,10,ARMROT);

		delay(3000);




}

void AgitateC(){
// Agitate C ------------------------------

// Pick up Tube
	set_deg_inc(55.0,90.0,0, 1,10,ARMROT);
	delay(500);
	set_deg_inc(85.0, 80.0, 1, 1, 10, JAWPIVOT);
	delay(500);
	set_deg_inc(60.0, 0.0, 1, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(70.0, 100.0, 0, 1, 10, ARMREACH);
	delay(1000);
	grabtube(1);
	delay(1000);
	set_deg_inc(100.0, 70.0, 1, 1, 10, ARMREACH);
	set_deg_inc(30.0, 60.0, 0, 1, 10, ARMEXT);
	delay(500);

	//Agitate
	set_deg_inc(50.0, 100.0, 0, 1, 10,JAWROT);
	delay(500);
	set_deg_inc(160.0, 50.0, 1, 1, 10,JAWROT);
	delay(500);
	set_deg_inc(50.0, 160.0, 0, 1, 10,JAWROT);
	delay(500);
	set_deg_inc(100.0, 50.0, 1, 1, 10,JAWROT);
	delay(500);

	//Put down Tube
	set_deg_inc(60.0, 30.0, 1, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(70.0, 100.0, 0, 1, 10, ARMREACH);
	delay(500);
	grabtube(2);
	delay(500);

	//Return to Hold
	grabtube(0);
	set_deg_inc(100.0, 70.0, 1, 1, 10, ARMREACH);
	delay(1000);
	set_deg_inc(0.0, 60.0, 0, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(80.0, 85.0, 0, 1, 10, JAWPIVOT);
	delay(500);
	set_deg_inc(90.0, 55.0, 0, 1,10,ARMROT);
	delay(3000);



}

void AgitateD(){
// Agitate D ------------------------------

//Pick up tube
	set_deg_inc(100.0, 90.0, 1, 1,10,ARMROT);
	delay(500);
	set_deg_inc(85.0, 80.0, 1, 1, 10, JAWPIVOT);
	delay(500);
	set_deg_inc(40.0, 0.0, 1, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(80.0, 100.0, 0, 1, 10, ARMREACH);
	delay(1000);
	grabtube(1);
	delay(1000);
	set_deg_inc(100.0, 80.0, 1, 1, 10, ARMREACH);
	delay(500);
	set_deg_inc(30.0, 40.0, 0, 1, 10, ARMEXT);
	delay(500);

	//Agitate
	set_deg_inc(50.0, 100.0, 0, 1, 10,JAWROT);
	delay(500);
	set_deg_inc(160.0, 50.0, 1, 1, 10,JAWROT);
	delay(500);
	set_deg_inc(50.0, 160.0, 0, 1, 10,JAWROT);
	delay(500);
	set_deg_inc(100.0, 50.0, 1, 1, 10,JAWROT);
	delay(500);

	//Put down Tube
	set_deg_inc(40.0, 30.0, 1, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(80.0, 100.0, 0, 1, 10, ARMREACH);
	delay(500);
	grabtube(2);
	delay(500);

	//Return to Hold
	grabtube(0);
	set_deg_inc(100.0, 80.0, 1, 1, 10, ARMREACH);
	delay(1000);
	set_deg_inc(0.0, 40.0, 0, 1, 10, ARMEXT);
	delay(500);
	set_deg_inc(80.0, 85.0, 1, 1, 10, JAWPIVOT);
	delay(3000);



}
