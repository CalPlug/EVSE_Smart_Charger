/*
 * include.h
 *
 *      Created on: Jan 24, 2018
 *      Author: Michael Klopfer, Ph.D.
 */

//dialog_settings.xml may need to be updated for new project paths
#ifndef INCLUDE_H_
#define INCLUDE_H_

#include "platform.h" //there may be double definitions for memory location constants to text in the code, be mindful of this
#include "drivers/CorePWM/core_pwm.h"
#include "drivers/mss_timer/mss_timer.h"
#include "CMSIS/system_m2sxxx.h"
#include "hal.h"
#include "drivers/CoreUARTapb/core_uart_apb.h"
#include "drivers/CoreI2C/core_i2c.h"
#include "drivers/CoreGPIO/core_gpio.h"
#include "m2sxxx.h"
#include <stdio.h>  //used for ARM Semihosting (Console Debug)
#include "src/MCP3903.h"//Used for ADC on-board Future Creative Board

//MCP3903 Registers
	#define REG_GAIN 0x08
	#define GAIN_1 0x0
	#define GAIN_2 0x1
	#define GAIN_4 0x2
	#define GAIN_8 0x3
	#define GAIN_16 0x4
	#define GAIN_32 0x5

	#define OSR_32 0x0
	#define OSR_64 0x1
	#define OSR_128 0x2
	#define OSR_256 0x3


#endif /* INCLUDE_H_ */
