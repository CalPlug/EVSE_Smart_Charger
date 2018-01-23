/*******************************************************************************
 * (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 *  This sample program demonstrates the use of interrupts that can be generated
 *  by CoreGPIO ports configured as inputs.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 *  SVN $Revision: 8017 $
 *  SVN $Date: 2015-10-13 13:19:09 +0530 (Tue, 13 Oct 2015) $
 */
#include "platform.h"
#include "hal/hal.h"
#include "drivers/CoreGPIO/core_gpio.h"
#include "m2sxxx.h"

/*The following added by Tim McCarthy for Semihosting*/
#include <stdio.h>

/*
 * Delay loop down counter load value.
 */
#define DELAY_LOAD_VALUE     0x00020000

/*
 * Value written to the GPIO outputs in order to switch on the LEDs attached to
 * the CoreGPIO outputs.
 */
//#define LEDS_ON   0x00000000
#define LEDS_ON   0x00000003	// changed to match Future Creative board TM

//void FabricIrq4_IRQHandler( void );	removed TM to match hardware design

// the following added by TM to match the hardware design
void FabricIrq1_IRQHandler( void );

/******************************************************************************
 * Function prototype for Semihosting - added Tim McCarthy
 *****************************************************************************/
extern void initialise_monitor_handles(void);

gpio_instance_t g_gpio;


/*
 * Delay down counter used to time the blinking rate of the LED. This delay
 * counter is decremented in the program's foreground loop. It is reloaded in
 * the foreground loop when it reaches 0. It is also be reloaded within the
 * GPIO interrupt serive routines to affect the LED blinking rate.
 */
volatile int32_t g_delay_count = 0;

/*-------------------------------------------------------------------------*//**
 * main() function.
 */
int main()
{
	   /******************************************************************************
	     * Write a message to the SoftConsole host via OpenOCD and the debugger - added TM
	     *****************************************************************************/
	    initialise_monitor_handles();
	    iprintf("SF2_GNU_SC4_interrupt_blink_project\n");

	//    NVIC_SetPriority(FabricIrq4_IRQn, 5u);		removed TM to match hardware design
//
//    NVIC_ClearPendingIRQ(FabricIrq4_IRQn);		removed TM to match hardware design

	// the following added by TM to match the hardware design
    NVIC_SetPriority(FabricIrq1_IRQn, 5u);

    NVIC_ClearPendingIRQ(FabricIrq1_IRQn);

    /*
     * Initialize the CoreGPIO driver with the base address of the CoreGPIO
     * instance to use and the initial state of the outputs. 
     */
    GPIO_init( &g_gpio, COREGPIO_BASE_ADDR, GPIO_APB_32_BITS_BUS );
    
    /*
     * Configure the GPIOs.
     */     
//    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_3, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_4, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_5, GPIO_OUTPUT_MODE );

//    GPIO_config( &g_gpio, GPIO_0, GPIO_INPUT_MODE | GPIO_IRQ_LEVEL_LOW  );
//    GPIO_config( &g_gpio, GPIO_1, GPIO_INPUT_MODE | GPIO_IRQ_EDGE_NEGATIVE  );

    // The following changed by TM to match the PWM_8ch_16b design - GPIO_0, GPIO_1 and GPIO_2 are INOUTS
    GPIO_config( &g_gpio, GPIO_0, GPIO_INOUT_MODE | GPIO_IRQ_LEVEL_HIGH  );
    GPIO_config( &g_gpio, GPIO_1, GPIO_INOUT_MODE | GPIO_IRQ_EDGE_NEGATIVE  );
    
    /******************************************************************************
     * Write a message to the SoftConsole host via OpenOCD and the debugger - added TM
     *****************************************************************************/
    initialise_monitor_handles();
    iprintf("CoreGPIO Initialized\n");

    /*
     * Enable individual GPIO interrupts. The interrupts must be enabled both at
     * the GPIO peripheral and Cortex-M3 interrupt controller levels.
     */
    GPIO_enable_irq( &g_gpio, GPIO_0 );
    GPIO_enable_irq( &g_gpio, GPIO_1 );

//    NVIC_EnableIRQ(FabricIrq4_IRQn);		removed TM to match hardware design
    NVIC_EnableIRQ(FabricIrq1_IRQn);

    /*
     * Set initial delay used to blink the LED.
     */
    g_delay_count = DELAY_LOAD_VALUE;
    
    /*
     * Infinite loop.
     */
    for(;;)
    {
        /*
         * Decrement delay counter.
         */
        --g_delay_count;
        
        /*
         * Check if delay expired.
         */
        if ( g_delay_count <= 0 )
        {
            uint32_t gpio_pattern;
            
            /*
             * Disable GPIO interrupts while updating the delay counter and 
             * GPIO pattern since these can also be modified within the GPIO
             * interrupt service routines.
             */
            GPIO_disable_irq( &g_gpio, GPIO_0 );
            GPIO_disable_irq( &g_gpio, GPIO_1 );
            /*
             * Reload delay counter.
             */
            g_delay_count = DELAY_LOAD_VALUE;
            
            /*
             * Toggle GPIO output pattern by doing an exclusive OR of all
             * pattern bits with ones.
             */
            gpio_pattern = GPIO_get_outputs( &g_gpio );
//            gpio_pattern ^= 0x0000000F;
            gpio_pattern ^= 0x00000007;	// changed TM
            GPIO_set_outputs( &g_gpio, gpio_pattern );
            
            /*
             * Re-enable GPIO interrupts.
             */
            GPIO_enable_irq( &g_gpio, GPIO_0 );
            GPIO_enable_irq( &g_gpio, GPIO_1 );
        }
    }
    
}

/*-------------------------------------------------------------------------*//**
 * GPIO 0 and  GPIO 1  interrupt service routine is FabricIrq4 ISR.
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
//void FabricIrq4_IRQHandler( void )	removed TM to match hardware design
void FabricIrq1_IRQHandler( void )
{

    /******************************************************************************
     * Write a message to the SoftConsole host via OpenOCD and the debugger - added TM
     *****************************************************************************/
    initialise_monitor_handles();
    iprintf("Switch pressed - FabricIRq1\n");

	/*
     * Turn on LED and set blink counter to 8 times the normal delay to cause
     * the LED to be on for 8 times slower than usual.
     */
//    g_delay_count = DELAY_LOAD_VALUE * 8;
    g_delay_count = DELAY_LOAD_VALUE * 16;		// changed TM
    GPIO_set_outputs( &g_gpio, LEDS_ON );

    /*
     * Clear interrupt both at the GPIO levels.
     */
    GPIO_clear_irq( &g_gpio, GPIO_0 );
    GPIO_clear_irq( &g_gpio, GPIO_1 );
    /*
     * Clear the interrupt in the Cortex-M3 NVIC.
     */
//    NVIC_ClearPendingIRQ(FabricIrq4_IRQn);	removed to match the target hardware
    // the following added TM to match the target hardware
    NVIC_ClearPendingIRQ(FabricIrq1_IRQn);
}
