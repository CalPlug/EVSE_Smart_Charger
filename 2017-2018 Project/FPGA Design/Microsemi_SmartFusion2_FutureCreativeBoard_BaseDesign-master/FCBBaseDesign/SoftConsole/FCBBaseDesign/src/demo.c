/*
 * demo.c
 *
 *  Created on: Jan 23, 2018
 *      Author: REN
 */
#include "demo.h"

unsigned int getByte( spi_instance_t * this_spi, uint8_t out)
{
	unsigned long buffer;
	SPI_set_slave_select( this_spi, SPI_SLAVE_0) ;
	buffer=SPI_transfer_frame(this_spi,out);
	SPI_clear_slave_select( this_spi, SPI_SLAVE_0 );
	unsigned int byte=0;
	//byte &=buffer>>24;
	byte = (unsigned int)buffer;
	return byte;
}
