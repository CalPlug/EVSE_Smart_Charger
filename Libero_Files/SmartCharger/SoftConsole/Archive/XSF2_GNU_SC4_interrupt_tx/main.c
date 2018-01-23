/*******************************************************************************
 * (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * CoreUARTapb interrupt driven transmit example.
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

#define TX_IN_PROGRESS	0
#define TX_COMPLETE		1

/******************************************************************************
 * Baud value to achieve a 57600 baud rate with a 71MHz system clock.
 * This value is calculated using the following equation:
 *      BAUD_VALUE = (CLOCK / (16 * BAUD_RATE)) - 1
 *****************************************************************************/
//#define BAUD_VALUE_57600    76		Removed TM - does not match hardware design
#define BAUD_VALUE_57600    75			// Added TM to match hardware design (70 MHz clock)
#define BAUD_VALUE_115200 37			//Added CL to match hardware design(70MHz clock)

/******************************************************************************
 * CoreUARTapb instance data.
 *****************************************************************************/
UART_instance_t g_uart;

/******************************************************************************
 * Global variable used to hold a pointer to the next block of data to transmit.
 *****************************************************************************/
volatile uint8_t* g_tx_buffer = 0;

/******************************************************************************
 * Global variable used to hold the number of characters left to be sent in the
 * data buffer pointed to by g_tx_buffer.
 *****************************************************************************/
volatile size_t g_tx_size = 0;

/******************************************************************************
 * This message will be transmitted over the UART to HyperTerminal.
 *****************************************************************************/
uint8_t g_message[] =
"\n\r\n\r\n\rHello world using interrupt generated on assertion of the UART TXRDY signal. \
This message has to be longer than 256 characters in order to ensure that at \
least some part of this text gets loaded into the UART FIFO as a result of an \
interrupt. Please remember that the CoreUARTapb transmitter FIFO is 256 bytes long \
when enabled. Have a nice day and please remember: Power Matters!";

void uart_tx_isr( void );
/******************************************************************************
 * Cortex-M3 interrupt handler for external interrupt 3.
 * This function is called when the Cortex-M3 IRQ3 signal is asserted.
 *****************************************************************************/
//void FabricIrq3_IRQHandler( void )	//Removed TM - does not match hardware design
void FabricIrq0_IRQHandler( void )		// Added TM to match hardware design; CoreUARTapb connected to fabric interrupt 0
{
	uart_tx_isr();
}

/******************************************************************************
 * UART transmitter interrupt service routine.
 * This function is called by FabricIrq3_IRQHandler when the FabricIRQ3
 * signal is asserted.
 *****************************************************************************/
void uart_tx_isr( void )
{
    size_t size_in_fifo;

    if ( g_tx_size > 0 )
    {
        size_in_fifo = UART_fill_tx_fifo( &g_uart, g_tx_buffer, g_tx_size );
        if ( size_in_fifo < g_tx_size )
        {
            g_tx_buffer = &g_tx_buffer[size_in_fifo];
            g_tx_size = g_tx_size - size_in_fifo;
        }
        else
        {
            g_tx_buffer = 0;
            g_tx_size = 0;
//            NVIC_DisableIRQ(FabricIrq3_IRQn);	//Removed TM - does not match hardware design
            NVIC_DisableIRQ(FabricIrq0_IRQn);	// Added TM to match hardware design; CoreUARTapb connected to fabric interrupt 0
        }
    }
    else
    {
//        NVIC_DisableIRQ(FabricIrq3_IRQn);	//Removed TM - does not match hardware design
    	NVIC_DisableIRQ(FabricIrq0_IRQn);	// Added TM to match hardware design; CoreUARTapb connected to fabric interrupt 0
    }
}

/******************************************************************************
 * is_tx_complete() is used to check if interrupt-driven transmission is
 * complete.
 *****************************************************************************/
int is_tx_complete( void )
{
    int complete = TX_COMPLETE;

    if ( g_tx_size > 0 )
    {
        complete = TX_IN_PROGRESS;
    }

    return complete;
}

/******************************************************************************
 * send_using_interrupt() is used to initiate interrupt-driven transmission.
 * It fills the UART FIFO and enable the TXRDY interrupt if there is data
 * remaining to be sent.
 *****************************************************************************/
void send_using_interrupt
(
    uint8_t * pbuff,
    size_t tx_size
)
{
    size_t size_in_fifo;

    size_in_fifo = UART_fill_tx_fifo( &g_uart, pbuff, tx_size );
    if ( size_in_fifo < tx_size )
    {
        g_tx_buffer = &pbuff[size_in_fifo];
        g_tx_size = tx_size - size_in_fifo;
//        NVIC_EnableIRQ(FabricIrq3_IRQn);	//Removed TM - does not match hardware design
        NVIC_EnableIRQ(FabricIrq0_IRQn);	// Added TM to match hardware design; CoreUARTapb connected to fabric interrupt 0
    }
    else
    {
        g_tx_buffer = 0;
        g_tx_size = 0;
//        NVIC_DisableIRQ(FabricIrq3_IRQn);	//Removed TM - does not match hardware design
        NVIC_DisableIRQ(FabricIrq0_IRQn);	// Added TM to match hardware design; CoreUARTapb connected to fabric interrupt 0
    }

}

/******************************************************************************
 * main function.
 *****************************************************************************/
int main( void )
{
	/**************************************************************************
	 * Initialize CoreUARTapb with its base address, baud value, and line
     * configuration.
	 *************************************************************************/
    UART_init( &g_uart, COREUARTAPB0_BASE_ADDR, BAUD_VALUE_115200, (DATA_8_BITS | NO_PARITY) );

	/**************************************************************************
	 * Enable interrupts at the processor level
	 *************************************************************************/
//    NVIC_EnableIRQ(FabricIrq3_IRQn);	//Removed TM - does not match hardware design
    NVIC_EnableIRQ(FabricIrq0_IRQn);	// Added TM to match hardware design; CoreUARTapb connected to fabric interrupt 0
	/**************************************************************************
	 * Infinite Loop.
	 *************************************************************************/
    while(1)
    {
        /**********************************************************************
	     * Initiate message transmit.
	     *********************************************************************/
        send_using_interrupt( g_message, sizeof(g_message) );

        /**********************************************************************
	     * Wait for full message to be sent by the interrupt service routine.
	     *********************************************************************/
        while( is_tx_complete() == TX_IN_PROGRESS )
        {
            ;
        }
    }
}
