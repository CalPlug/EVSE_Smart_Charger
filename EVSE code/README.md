# EVSESmartApp_Hardware
CalPlugEVSE

Senior Design Project 2018-2019

Alex Ramirez, Emon Sahaba, Omair Farooqui, Krishan Solanki

## Key Developments:
- Hardware firmware has the ability to perform level detection, ground fault interrupt and state detection. 
- Level Detection and ground fault interrupt was made possible after proper calibration of voltage and current. The excel sheets
that was used to perform these calibration can be found in documents. 
- State detection was calibrated by taking ADC values at different currents then regressed to find a model function. This is
done in readPilot() as it is continuously called in RTOS task A. ReadPilot calibration excel can also be found in documents
folder.
- Pilot Sampling issue was fixed by using non-linear regression and not using a median filter when reading pilot at current under 3.5A. 

## Flashing Firmware:
1. Download Arduino
2. Download EVChargerESP32RTOS folder and open in Arduino with proper libraries
3. Put ESP32 in upload mode by holding right button, pressing left(reset) button, then letting go of right button.
4. Compile and upload.
5. Press Reset button after upload completes

## Debugging:
- Use files found in DevelopmentTestFirmware folder to test different parts of the charger as needed. 
- If charger acts up first unplug from laptop, replug then reflash. If it continues to act up unplug from wall and replug.

## Urgent Items:
- ***WiFI disconnects are notorious for causing watchdog timer related crashes.***

## Remaining Items:
- Implement MQTT over websockets or SSL/TLS
