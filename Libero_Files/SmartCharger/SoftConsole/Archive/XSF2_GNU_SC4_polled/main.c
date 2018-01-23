/*******************************************************************************
 * (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * CoreUARTapb polled transmit and  receive example.
 *
 * Please refer to the file README.txt for further details about this example.
 * 
 * SVN $Revision: 8013 $
 * SVN $Date: 2015-10-13 13:15:00 +0530 (Tue, 13 Oct 2015) $
 */
#include "hal.h"
#include "platform.h"
#include "core_uart_apb.h"
#include "m2sxxx.h"

/******************************************************************************
 * Baud value to achieve a 57600 baud rate with a 71MHz system clock.
 * This value is calculated using the following equation:
 *      BAUD_VALUE = (CLOCK / (16 * BAUD_RATE)) - 1
 *****************************************************************************/
//#define BAUD_VALUE_57600    76		changed TM - design uses a 70 MHz clock
#define BAUD_VALUE_57600    75			// added TM - BAUD VALUE for 70 MHz clock

/******************************************************************************
 * Maximum receiver buffer size.
 *****************************************************************************/
#define MAX_RX_DATA_SIZE    256

/******************************************************************************
 * CoreUARTapb instance data.
 *****************************************************************************/
UART_instance_t g_uart;

/******************************************************************************
 * Instruction message. This message will be transmitted over the UART to
 * HyperTerminal when the program starts.
 *****************************************************************************/
uint8_t g_message[] =
"\n\r\n\r\n\rCoreUARTapb polled transmitter and receiver example. \n\rAll characters typed \
will be echoed back.\n\r";

/******************************************************************************
 * main function.
 *****************************************************************************/
int main( void )
{
    uint8_t rx_data[MAX_RX_DATA_SIZE];
    size_t rx_size;

    /**************************************************************************
     * Initialize CoreUARTapb with its base address, baud value, and line
     * configuration.
     *************************************************************************/
    UART_init( &g_uart, COREUARTAPB0_BASE_ADDR,
               BAUD_VALUE_57600, (DATA_8_BITS | NO_PARITY) );

    /**************************************************************************
     * Send the instructions message.
     *************************************************************************/
    UART_send( &g_uart, g_message, sizeof(g_message) );

    /**************************************************************************
     * Infinite Loop.
     *************************************************************************/
    while(1)
    {
        /*************************************************************************
         * Check for any errors in communication while receiving data
         ************************************************************************/
        if(UART_APB_NO_ERROR == UART_get_rx_status(&g_uart))
        {
            /**********************************************************************
             * Read data received by the UART.
             *********************************************************************/
            rx_size = UART_get_rx( &g_uart, rx_data, sizeof(rx_data) );

            /**********************************************************************
             * Echo back data received, if any.
             *********************************************************************/
            if ( rx_size > 0 )
            {
                UART_send( &g_uart, rx_data, rx_size );
            }
        }
    }
}
