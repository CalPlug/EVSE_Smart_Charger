/*******************************************************************************
 * (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 *  Simple CoreGPIO example program flashing LEDs on the target hardware.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 * SVN $Revision: 8017 $
 * SVN $Date: 2015-10-13 13:19:09 +0530 (Tue, 13 Oct 2015) $
 */
#include "platform.h"
#include "drivers/CoreGPIO/core_gpio.h"

/*
 * Delay loop down counter load value.
 */
#define DELAY_LOAD_VALUE     0x00200000

/*
 * CoreGPIO instance data.
 */
gpio_instance_t g_gpio;

/*-------------------------------------------------------------------------*//**
 * main() function.
 */
int main()
{
    volatile int32_t delay_count = 0;
    
    /**************************************************************************
     * Initialize the CoreGPIO driver with the base address of the CoreGPIO
     * instance to use and the initial state of the outputs. 
     *************************************************************************/ 
    GPIO_init( &g_gpio, COREGPIO_BASE_ADDR, GPIO_APB_32_BITS_BUS );
    
    /**************************************************************************
     * Configure the GPIOs.
     *************************************************************************/     
    GPIO_config( &g_gpio, GPIO_0, GPIO_OUTPUT_MODE );
    GPIO_config( &g_gpio, GPIO_1, GPIO_OUTPUT_MODE );
    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_3, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_4, GPIO_INPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_5, GPIO_INPUT_MODE );
    
    /*
     * Set initial delay used to blink the LED.
     */
    delay_count = DELAY_LOAD_VALUE;
    
    /*
     * Infinite loop.
     */
    for(;;)
    {
        uint32_t gpio_pattern;
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
            gpio_pattern = GPIO_get_outputs( &g_gpio );
//            gpio_pattern ^= 0x0000000F;
            gpio_pattern ^= 0x00000007;
            GPIO_set_outputs( &g_gpio, gpio_pattern );
        }
    }
    
}
