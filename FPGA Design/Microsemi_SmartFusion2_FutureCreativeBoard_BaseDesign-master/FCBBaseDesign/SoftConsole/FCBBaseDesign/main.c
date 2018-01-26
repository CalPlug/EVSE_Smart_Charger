/*******************************************************************************
 *SmartFusion2 Future Creative Board Base Design with SPI and I2C, UART, PWM
 *Application code (c) Copyright 2017 Microsemi SoC Products Group & Calit2 at the University of California, Irvine.
 *Base Example code (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *Extended application by Tim McCarthy (Microsemi) and Yutian Ren, Michael Klopfer (Calit2) + Calit2 student team
 * *
 */

#include "include.h"


//**************************************************************************************************
//Debugging Control     NOTE: Comment out on production eNVM builds to avoid Semihosting errors!!  (There is no target for the debug messages when running without a console)
#define VERBOSEDEBUGCONSOLE //Verbose debugging in console using ARM Semihosting, comment out to disable console debug messages - do not go too crazy with Semihosting, it will slow down operation if used excessively.
//**************************************************************************************************
#ifdef VERBOSEDEBUGCONSOLE
	   extern void initialise_monitor_handles(void); //ARM Semihosting enabled
#endif

/******************************************************************************
 * Sample baud value to achieve UART communication at a 115200 baud rate with a (50MHz Digikeyboard clock source.
 * This value is calculated using the following equation:
 *      BAUD_VALUE = (CLOCK / (16 * BAUD_RATE)) - 1
 *      For CoreUART
 *****************************************************************************/
#define BAUD_VALUE    37	   // 37 as calculated baud value for 115200


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

#define COREI2C_BASE_ADDR         0x30003000UL
i2c_instance_t g_core_I2C0;

/******************************************************************************
 * CoreUARTapb instance data.
 *****************************************************************************/
UART_instance_t g_uart;
uint32_t duty_cycle = 1;  //Set PWM initial duty cycle
#define COREUARTAPB0_BASE_ADDR	0x50002000


/******************************************************************************
 * CoreSPI instance data.
 *****************************************************************************/
#define CORE_SPI0_BASE_ADDR	0x50004000
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


/******************************************************************************
 * Local function prototypes.
 *****************************************************************************/
void delay( int mult );


/******************************************************************************
 * Program MAIN function.
 *****************************************************************************/
int main( void )
{
	#ifdef VERBOSEDEBUGCONSOLE
		initialise_monitor_handles();
		iprintf("Debug messages via ARM Semihosting initialized\n");  //Notification of Semihosting enabled
	#endif
	    /**************************************************************************
	     * Initialize the CorePWM instance setting the prescale and period values.
	     *************************************************************************/
	    PWM_init( &the_pwm, COREPWM_BASE_ADDR, PWM_PRESCALE, PWM_PERIOD );
	    delay(200);  //add ~200ms delay to prevent HAL assertion issue
	    /**************************************************************************
	     * Set the initial duty cycle for CorePWM output 1.
	     *************************************************************************/



	    #ifdef VERBOSEDEBUGCONSOLE
	        iprintf("Complete PWM Initialization and initial position start\n");
	    #endif
	    	delay (500); //Pause at HOLD position then continue operation


/**************************************************************************
* Initialize communication components of application
*************************************************************************/
        //Initialize SPI for MCP3903
	    	SPI_init(&g_core_spi0, CORE_SPI0_BASE_ADDR,8); //Initialize SPI
	    	SPI_configure_master_mode(&g_core_spi0);  //Initialize SPI

	    //Initialize MCP3903 Communication
	    	MCP3903ResetOSR(OSR_256, &g_core_spi0);   //Send with OSR256 constant (value of 0x3, see library)
	        MCP3903SetGain(1,GAIN_8, &g_core_spi0);   //Set ADC channel 1 with gain of 8 (value of 0x3, see library)

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
    GPIO_config( &g_gpio, GPIO_0, GPIO_OUTPUT_MODE );  //BUTTON1 (Physically the red element of the LED 1 bi-color LED on the Future Creative board) - the green element of this bi-color LED is the PWM demo output
    GPIO_config( &g_gpio, GPIO_1, GPIO_OUTPUT_MODE );  //BUTTON2 (Physically the green element of the LED 2 bi-color LED on the Future Creative board)
    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE );  // (Physically the red element of the LED 2 bi-color LED on the Future Creative board)
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
    timer1_load_value = g_FrequencyPCLK0 *5;		// modify for 10 second delay
    MSS_TIM1_init(MSS_TIMER_PERIODIC_MODE);
    MSS_TIM1_load_immediate(timer1_load_value);
    MSS_TIM1_start();
    MSS_TIM1_enable_irq();

    #ifdef VERBOSEDEBUGCONSOLE
	iprintf("Timer initialized and started\n");
    #endif


    /*--------------------------------------------------------------------------
     * For-loop to check for command control of the device.
     */
	for(;;) //Start Main loop
		{
			if(UART_APB_NO_ERROR == UART_get_rx_status(&g_uart)) //Verify if UART can be opened, then open UART to receive control command
					{
						/**********************************************************************
						 * Read data received by the UART.
						 *********************************************************************/
						rx_size = UART_get_rx( &g_uart, rx_data, sizeof(rx_data) ); //Read UART buffer and get size
					}
		//This example IF statement checks for incoming commands and can be used to drive functions.  This is a single example.
						if ( rx_size > 0 && rx_data[0]=='A' )
							{
							#ifdef VERBOSEDEBUGCONSOLE
							iprintf("Routine 'A' Received - LED1\n"); //Identify operation via semihosting debug print
							#endif
							rx_data[0]=0; //flush first position in the buffer before next check with null character
							PWM_set_duty_cycle(&the_pwm, PWM_1, 1); //turn on LED1
							PWM_set_duty_cycle(&the_pwm, PWM_1, 0); //turn off
							}
			else {}  //Null Case (rounding out the IF statement)
#ifdef VERBOSEDEBUGCONSOLE
 printf("ADC Value for Ch 1: %f \n", (MCP3903ReadADC(1, &g_core_spi0) * 2.36));  //Periodically read out ADC value, use printf versus iprintf because of floating point values,use linker flag (--specs=rdimon.specs -u_printf_float)
#endif
	}
	return 0;
}

/*==============================================================================
 * Toggle LEDs and send message via UART on TIM1 interrupt.
 */
void Timer1_IRQHandler(void)
{

    //UART_send( &g_uart, g_message, sizeof(g_message) ); //Periodically send out heartbeat signal
	#ifdef VERBOSEDEBUGCONSOLE
     initialise_monitor_handles();
     iprintf("Timer Ran");  //Periodically print message when timer runs
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
		iprintf("Switch 1 pressed - \n");
	#endif
		// GPIO_set_outputs(&g_gpio, 0x00000004);  //Change LEDS to indicate this is run

    	    GPIO_clear_irq( &g_gpio, GPIO_0 );  //clear IRQ - Button 1
    	    GPIO_clear_irq( &g_gpio, GPIO_1 ); //clear IRQ - Button 2
    	    GPIO_enable_irq( &g_gpio, GPIO_0 );//Enable interrupt to button 1 (//GPIO_disable_irq( &g_gpio, GPIO_0 );)
    	    GPIO_enable_irq( &g_gpio, GPIO_1 );//Enable interrupt to button 2 (//GPIO_disable_irq( &g_gpio, GPIO_0 );)
    	    while (1==1) //infinite loop for demo - only stopped by resetting
    	    {
				#ifdef VERBOSEDEBUGCONSOLE
    	    	iprintf("Button 1 Pressed\n"); //Button 1
				#endif

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

		// GPIO_set_outputs(&g_gpio, 0x00000005);  //Button 2 Pressed




	#ifdef VERBOSEDEBUGCONSOLE

		iprintf("Button 2 pressed\n");  //Print message that PWM outputs were disabled
	#endif


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
