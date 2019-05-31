/*
 Extended from the Arduino Library for MCP3903 A/D Converter
 * MCP3903 Library
 * Kerry D. Wong
 * http://www.kerrywong.com, http://www.kerrywong.com/2014/05/10/mcp3903-library/, https://github.com/kerrydwong/MCP3903) * 5/2014

Modified for use for the Microsemi Future Creative Board by Yutian Ren and Michael Klopfer, Ph.D.
University of California, Irvine
2018


The max linear range of the MCP3903 is +/1 0.5V, but it is tolerant up to 5V.
 */

#include "MCP3903.h"
//call spi_instance_t g_core_spi0 in main function before use //Core SPI 0 Instance to interface with the MCP3903 ADC


//set to 24 bit mode
void MCP3903Reset24(spi_instance_t * this_spi)
{
    MCP3903ResetOSR(OSR_256, this_spi);
}

//set to resolution specified by OSR
//OSR_32  11 = 256
//OSR_64  10 = 128
//OSR_128 01 = 64 (POR default)
//OSR_256 00 = 32
void MCP3903ResetOSR(byte osr, spi_instance_t * this_spi)
{
	unsigned long cmd1 = 0xfc0fd0;
	unsigned long cmd2 = 0x000fc0 | osr << 4;
	byte cmdByte = 	DEVICE_ADDR | REG_CONFIG << 1;

	MCP3903WriteRegister(REG_CONFIG, cmd1, this_spi);
	MCP3903WriteRegister(REG_CONFIG, cmd2, this_spi);
}

//read from specified register
//returns 24 bit data
unsigned long MCP3903ReadRegister(byte reg, spi_instance_t * this_spi)
{
	unsigned long r = 0;
	byte cmdBytetemp = DEVICE_ADDR | reg <<1 | 1; //set up bit order for the command, this is a single byte
	unsigned long cmdByte = 0x00000000;  //Start with 32 bit blank address (4 bytes), then leave the last 4 as 0's, the first one will be the command when shifted in.  the last 3 are used for the readout
	cmdByte	= cmdByte | cmdBytetemp << 24; 	//shift bits in to the proper order, putting the 8 bit command first to set up the whole 4 byte frame.

	SPI_set_slave_select( this_spi, SPI_SLAVE_0) ;
	r = SPI_transfer_frame(this_spi,cmdByte); //read whole 32 bit frame (first 8 bits is sent out as commend, next 24 bits is the return)
	SPI_clear_slave_select( this_spi, SPI_SLAVE_0 ); //clear slave select line  (intend to bring high to end)*/

	//Return approach 1
	//unsigned long mask = 0xfff;
	//unsigned long mask = ~(0xff000000);  //create mask to block the top byte of the 4 (the command byte)
    //r = (unsigned long)r & mask; //mask out (to 0's) the first of the 4 bytes, and return all 4, but the first is masked as 0's as the return is only 24 bit.
   // return r; //return the 4 byte sequence with the first byte 0'ed out with the last 3 bytes of the 4 byte sequence in place

	//Return approach 2
	//separate all component bytes and arrange for final return value
	byte b3 = (r & 0xff000000) >> 24; //b2 of the data separated out (blank where command was sent)
	byte b2 = (r & 0x00ff0000) >> 16; //b2 of the data separated out
	byte b1 = (r & 0x0000ff00) >> 8;  //b1 of the data separated out
	byte b0 = (r & 0x000000ff);  //b0 of the data separated out
	unsigned long rcvdbyte = 0x00000000;  //Start with 32 bit blank address (4 bytes), then leave the last 4 as 0's, the first one will be the command when shifted in.  the last 3 are used for the readout
    rcvdbyte = ((uint8_t)b2 << 16) + ((uint8_t)b1 << 8) + ((uint8_t)b0); //Assemble the bytes in the proper order for the 4 byte frame returned, assume blank from command byte leading, ignore the period where the command byte was sent, invert bits so the SPI null returns are returned as 0's instead of 1's
    return rcvdbyte; //return the 4 byte sequence with the first byte 0'ed out with the last 3 bytes of the 4 byte sequence in place

    //remember value return for reading uses signed byte, not 2's compliment for OSR 256, refer to datasheet!!
}

//write 24 bit data to register
void MCP3903WriteRegister(byte reg, unsigned long data, spi_instance_t * this_spi)
{
	unsigned long r = 0;  //this is a holding variable for the null return from the SPI transfer, not needed to be returned to calling function.
	byte cmdByte = DEVICE_ADDR | reg <<1; //set up bit order for the command, this is a single byte, the last value is 0 for a write operation
	byte b2 = (data & 0xff0000) >> 16; //b2 of the data separated out
	byte b1 = (data & 0x00ff00) >> 8;  //b1 of the data separated out
	byte b0 = data & 0x0000ff;  //b0 of the data separated out

	unsigned long sentbyte = 0x00000000; //value to be sent initialized with all 0's
	sentbyte = (((uint8_t)cmdByte << 24) + ((uint8_t)b2 << 16) + ((uint8_t)b1 << 8) + ((uint8_t)b0)); //Assemble the bytes in the proper order for the 4 byte frame with the command byte leading

	SPI_set_slave_select( this_spi, SPI_SLAVE_0) ;
	r = SPI_transfer_frame(this_spi, sentbyte); //read whole 32 bit frame (first 8 bits is sent out as commend, next 24 bits is the return)
	SPI_clear_slave_select( this_spi, SPI_SLAVE_0 ); //clear slave select line  (intend to bring high to end)*/
}

//read from ADC channel (0-5)
double MCP3903ReadADC(byte channel, spi_instance_t * this_spi)
{
	double ReturnedVal = 0;
	unsigned long r = MCP3903ReadRegister(channel, this_spi);

	ReturnedVal = (double)r; //Return the 'R' value without negation in the else case (overwrite when if is true).
	if (r > 8388607l)
	{
		ReturnedVal = (double)r - 16777216l; //convert the unsigned byte value for negatives
	}

	return ((ReturnedVal / 8388608.0) /3.0);
}

//set channel gain
//channel (0-5)
//valid gain settings:
//GAIN_1
//GAIN_2
//GAIN_4
//GAIN_8
//GAIN_16
//GAIN_32
void MCP3903SetGain(byte channel, byte gain, spi_instance_t * this_spi)
{
	MCP3903SetGainCB(channel, gain, 0, this_spi);
}

//overloaded setGain
//the boost parameter indicates the current boost setting for channel
void MCP3903SetGainCB(byte channel, byte gain, byte boost, spi_instance_t * this_spi)
{
	unsigned long r = MCP3903ReadRegister(REG_GAIN, this_spi);

	byte idx = channel * 4;
	unsigned long chGain = 0;

	if (channel % 2 == 0) //0, 2, 4
	{
		chGain = (boost << 3) | gain;
	}
	else //1, 3, 5
	{
		chGain = boost | (gain << 1);
	}

	r &= ~(0xf << idx);
	r |= chGain << idx;

	MCP3903WriteRegister(REG_GAIN, r, this_spi);
}


