/*******************************************************************************
 *(c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * CoreGPIO example program.
 *
 * Please refer to the file README.txt for further details about this example.
 * 
 * SVN $Revision: 8017 $
 * SVN $Date: 2015-10-13 13:19:09 +0530 (Tue, 13 Oct 2015) $
 */
#include "hal/hal.h"
#include "platform.h"
#include "drivers/CoreGPIO/core_gpio.h"

gpio_instance_t g_gpio;

//#define INPUT_TO_OUTPUT_BIT_OFFSET      4
#define INPUT_TO_OUTPUT_BIT_OFFSET      0

/******************************************************************************
 * main function.
 *****************************************************************************/ 
int main( void )
{
    uint32_t io_state;
    
    /**************************************************************************
     * Initialize the CoreGPIO driver with the base address of the CoreGPIO
     * instance to use and the initial state of the outputs. 
     *************************************************************************/    
    GPIO_init( &g_gpio,    COREGPIO_BASE_ADDR, GPIO_APB_32_BITS_BUS );
    
    /**************************************************************************
     * Configure the GPIOs.
     *************************************************************************/     
//    GPIO_config( &g_gpio, GPIO_0, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_1, GPIO_OUTPUT_MODE );
    GPIO_config( &g_gpio, GPIO_0, GPIO_INOUT_MODE );
    GPIO_config( &g_gpio, GPIO_1, GPIO_INOUT_MODE );
    GPIO_config( &g_gpio, GPIO_2, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_3, GPIO_OUTPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_4, GPIO_INPUT_MODE );
//    GPIO_config( &g_gpio, GPIO_5, GPIO_INPUT_MODE );

    /**************************************************************************
     * Infinite Loop.
     *************************************************************************/        
    while(1)
    {
        /**********************************************************************
         * Read inputs.
         *********************************************************************/
        io_state = GPIO_get_inputs( &g_gpio );
        
        /**********************************************************************
         * Write state of inputs back to the outputs.
         *********************************************************************/
        io_state = io_state >> INPUT_TO_OUTPUT_BIT_OFFSET;
        GPIO_set_outputs( &g_gpio, io_state );    
    }
}
