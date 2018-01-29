----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Sat Jan 27 17:12:06 2018
-- Parameters for COREI2C
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant ADD_SLAVE1_ADDRESS_EN : integer := 0;
    constant BAUD_RATE_FIXED : integer := 1;
    constant BAUD_RATE_VALUE : integer := 0;
    constant BCLK_ENABLED : integer := 0;
    constant FIXED_SLAVE0_ADDR_EN : integer := 0;
    constant FIXED_SLAVE0_ADDR_VALUE : std_logic_vector(31 downto 0) := x"0";
    constant FIXED_SLAVE1_ADDR_EN : integer := 0;
    constant FIXED_SLAVE1_ADDR_VALUE : std_logic_vector(31 downto 0) := x"0";
    constant FREQUENCY : integer := 30;
    constant GLITCHREG_NUM : integer := 3;
    constant I2C_NUM : integer := 1;
    constant IPMI_EN : integer := 0;
    constant OPERATING_MODE : integer := 0;
    constant SMB_EN : integer := 0;
    constant testbench : string( 1 to 4 ) := "User";
end coreparameters;
