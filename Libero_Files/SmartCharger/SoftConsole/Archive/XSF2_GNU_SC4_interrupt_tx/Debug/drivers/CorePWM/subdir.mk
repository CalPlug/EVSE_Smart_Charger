################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/CorePWM/core_pwm.c 

OBJS += \
./drivers/CorePWM/core_pwm.o 

C_DEPS += \
./drivers/CorePWM/core_pwm.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/CorePWM/%.o: ../drivers/CorePWM/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -I../CMSIS -I../hal -I../hal/CortexM3 -I../hal/CortexM3/GNU -I../drivers/CoreUARTapb -I../drivers_config/sys_config -std=gnu11 --specs=cmsis.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


