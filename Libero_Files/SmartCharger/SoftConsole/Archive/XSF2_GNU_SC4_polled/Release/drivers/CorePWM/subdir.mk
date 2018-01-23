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
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -DNDEBUG -I../hal/CortexM3/GNU -I../hal/CortexM3 -I../hal -I.. -I../drivers_config/sys_config -I../CMSIS -I../drivers/CoreUARTapb -std=gnu11 --specs=cmsis.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


