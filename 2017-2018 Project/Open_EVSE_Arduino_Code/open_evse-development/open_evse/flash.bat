avrdude -c USBasp -p m328p -U lfuse:w:0xFF:m -U hfuse:w:0xDF:m -U efuse:w:0x05:m
avrdude -c USBasp -p m328p -U flash:w:open_evse-390.hex
pause
