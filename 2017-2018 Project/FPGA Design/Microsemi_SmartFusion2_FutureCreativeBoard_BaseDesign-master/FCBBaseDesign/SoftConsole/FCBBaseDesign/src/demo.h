/*
 * demo.h
 *
 *  Created on: Jan 23, 2018
 *      Author: REN
 */

#ifndef SRC_DEMO_H_
#define SRC_DEMO_H_

#include "drivers/CoreSPI/core_spi.h"
#include "drivers/CoreI2C/core_i2c.h"

unsigned int getByte( spi_instance_t * this_spi, uint8_t out);

#endif /* SRC_DEMO_H_ */
