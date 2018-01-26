/*
 Extended from the Arduino Library for MCP3903 A/D Converter
 * MCP3903 Library
 * Kerry D. Wong
 * http://www.kerrywong.com, http://www.kerrywong.com/2014/05/10/mcp3903-library/, https://github.com/kerrydwong/MCP3903) * 5/2014

Modified for use for the Microsemi Future Creative Board by Yutian Ren and Michael Klopfer, Ph.D.
University of California, Irvine
2018

 */

#include "MCP3903.h"
spi_instance_t g_core_spi0; //Core SPI 0 Instance to interface with the MCP3903 ADC


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
unsigned long MCP3903ReadRegister(byte reg,spi_instance_t * this_spi)
{
	byte cmdByte = DEVICE_ADDR | reg <<1 | 1;
	unsigned long r = 0;
    unsigned long buffer = 0;
	SPI_set_slave_select( this_spi, SPI_SLAVE_0) ;  //Set CS low to start communication (bring low to start)
	buffer = (unsigned long)SPI_transfer_frame(this_spi,cmdByte); //Push data out (register), dummy read in but unused, command byte
	r = (unsigned long) SPI_transfer_frame(this_spi,0x0) << 16;
	r |= (unsigned long) SPI_transfer_frame(this_spi,0x0) << 8;
	r |= (unsigned long) SPI_transfer_frame(this_spi,0x0);
	SPI_clear_slave_select( this_spi, SPI_SLAVE_0 ); //clear slave select line  (intend to bring high to end)

	return r;
}

//write 24 bit data to register
void MCP3903WriteRegister(byte reg, unsigned long data, spi_instance_t * this_spi)
{
	unsigned long buffer;
	byte cmdByte = DEVICE_ADDR | reg <<1;
	byte b2 = (data & 0xff0000) >> 16;
	byte b1 = (data & 0x00ff00) >> 8;
	byte b0 = data & 0x0000ff;

	SPI_set_slave_select( this_spi, SPI_SLAVE_0) ;; //Set CS low to start communication (bring low to start)
	buffer=SPI_transfer_frame(this_spi,cmdByte); //Push data out (register), dummy read in but unused, command byte
	buffer=SPI_transfer_frame(this_spi,b2); // Push data out, dummy read in but unused, byte 2
	buffer=SPI_transfer_frame(this_spi,b1);  // Push data out, dummy read in but unused, byte 1
	buffer=SPI_transfer_frame(this_spi,b0);  // Push data out, dummy read in but unused, byte 0
	SPI_clear_slave_select( this_spi, SPI_SLAVE_0 ); //clear slave select line  (bring high to end)
}

//read from ADC channel (0-5)
double MCP3903ReadADC(byte channel, spi_instance_t * this_spi)
{
	unsigned long r = MCP3903ReadRegister(channel, this_spi);

	if (r > 8388607l) r -= 16777216l;

	return (double) r / 8388608.0 /3.0;
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


