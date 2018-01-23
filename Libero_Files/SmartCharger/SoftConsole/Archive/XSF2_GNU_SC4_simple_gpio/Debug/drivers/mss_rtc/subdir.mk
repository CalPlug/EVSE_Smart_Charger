################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/mss_rtc/mss_rtc.c 

OBJS += \
./drivers/mss_rtc/mss_rtc.o 

C_DEPS += \
./drivers/mss_rtc/mss_rtc.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/mss_rtc/%.o: ../drivers/mss_rtc/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -O0 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -g3 -I../drivers_config/sys_config -I../CMSIS -I../hal/CortexM3/GNU -I../hal/CortexM3 -I.. -I../hal -I../drivers/CoreGPIO -std=gnu11 --specs=cmsis.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


