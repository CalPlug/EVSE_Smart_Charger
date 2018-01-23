/*******************************************************************************
 * (c) Copyright 2015 Microsemi SoC Products Group.  All rights reserved.
 *
 * This example project demonstrates control the positive and negative edges of
 * individual PWM outputs.
 *
 * Please refer to the file README.txt for further details about this example.
 *
 * SVN $Revision: 8042 $
 * SVN $Date: 2015-10-15 17:55:12 +0530 (Thu, 15 Oct 2015) $
 */

#include "platform.h"
#include "core_pwm.h"

/******************************************************************************
 * PWM prescale and period configuration values.
 *****************************************************************************/
#define PWM_PRESCALE    1
#define PWM_PERIOD      13

/******************************************************************************
 * PWM positive and negative edges configuration values.
 *****************************************************************************/
#define PWM1_POSEDGE    2
#define PWM1_NEGEDGE    8
#define PWM2_POSEDGE    8
#define PWM2_NEGEDGE    2
#define PWM3_POSEDGE    0
#define PWM3_NEGEDGE    1
#define PWM4_POSEDGE    1
#define PWM4_NEGEDGE    1

/******************************************************************************
 * CorePWM instance data.
 *****************************************************************************/
pwm_instance_t the_pwm;

/******************************************************************************
 * main function.
 *****************************************************************************/
int main( void )
{
    /**************************************************************************
     * Initialize the CorePWM instance setting the prescale and period values.
     *************************************************************************/
    PWM_init( &the_pwm, COREPWM_BASE_ADDR, PWM_PRESCALE, PWM_PERIOD) ;

    /**************************************************************************
     * Configure the positive and negative edges of PWMs 1, 2, 3 and 4.
     *************************************************************************/
    PWM_set_edges( &the_pwm, PWM_1, PWM1_POSEDGE, PWM1_NEGEDGE );
    PWM_set_edges( &the_pwm, PWM_2, PWM2_POSEDGE, PWM2_NEGEDGE );
    PWM_set_edges( &the_pwm, PWM_3, PWM3_POSEDGE, PWM3_NEGEDGE );
    PWM_set_edges( &the_pwm, PWM_4, PWM4_POSEDGE, PWM4_NEGEDGE );

    /**************************************************************************
     * Enable PWMs 1, 2, 3 and 4.
     *************************************************************************/
    PWM_enable( &the_pwm, PWM_1 );
    PWM_enable( &the_pwm, PWM_2 );
    PWM_enable( &the_pwm, PWM_3 );
    PWM_enable( &the_pwm, PWM_4 );

    /**************************************************************************
     * Infinite Loop.
     *************************************************************************/
    while ( 1 )
    {
        ;
    }

}
