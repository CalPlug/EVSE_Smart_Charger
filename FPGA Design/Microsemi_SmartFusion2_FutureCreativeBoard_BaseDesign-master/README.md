# Microsemi_SmartFusion2_FutureCreativeBoard_BaseDesign
Base design project for the Future Creative Board with the Microsemi SmartFusion 2 FPGA.  This project includes the use of CoreGPIO, CorePWM, CoreSPI, and CoreI2C to provide basic connectivity for a variety of applications.  This design enables the use of the Microchip MCP3903 Sigma-delta ADC that is on this board.  The design also breaks out SPI and I2C consistant with conventional Arduino headers.

The following design was constructed using Libero SoC 11.8 SP2 and SoftConsole 5.1.  It is implemented for a SmartFusion 2 FPGA.

In the current design, the I2c, SPI are broen out to the Mikrobus header.  These can be moved as needed by modifying the constraints file for pin assignments.  The onboard sigma-delta ADC is implemented.  THis ADC allows -0.5 to +0.5V measurement but is tollerant to +5V.  The MISO bus for the ADC is Or'ed as an input and the other side of this is broken out to a header.  Pull low in operation using a jumper if unused.  If this is allowd to arbritrarially drift high in tri-state condition, the SPI bus will not work properly.
