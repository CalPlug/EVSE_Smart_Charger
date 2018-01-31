----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Tue Jan 30 17:22:34 2018
-- Parameters for CoreAPB3
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant APB_DWIDTH : integer := 32;
    constant APBSLOT0ENABLE : integer := 1;
    constant APBSLOT1ENABLE : integer := 1;
    constant APBSLOT2ENABLE : integer := 1;
    constant APBSLOT3ENABLE : integer := 1;
    constant APBSLOT4ENABLE : integer := 1;
    constant APBSLOT5ENABLE : integer := 0;
    constant APBSLOT6ENABLE : integer := 0;
    constant APBSLOT7ENABLE : integer := 0;
    constant APBSLOT8ENABLE : integer := 0;
    constant APBSLOT9ENABLE : integer := 0;
    constant APBSLOT10ENABLE : integer := 0;
    constant APBSLOT11ENABLE : integer := 0;
    constant APBSLOT12ENABLE : integer := 0;
    constant APBSLOT13ENABLE : integer := 0;
    constant APBSLOT14ENABLE : integer := 0;
    constant APBSLOT15ENABLE : integer := 0;
    constant FAMILY : integer := 19;
    constant HDL_license : string( 1 to 1 ) := "U";
    constant IADDR_OPTION : integer := 0;
    constant MADDR_BITS : integer := 16;
    constant SC_0 : integer := 0;
    constant SC_1 : integer := 0;
    constant SC_2 : integer := 0;
    constant SC_3 : integer := 0;
    constant SC_4 : integer := 0;
    constant SC_5 : integer := 0;
    constant SC_6 : integer := 0;
    constant SC_7 : integer := 0;
    constant SC_8 : integer := 0;
    constant SC_9 : integer := 0;
    constant SC_10 : integer := 0;
    constant SC_11 : integer := 0;
    constant SC_12 : integer := 0;
    constant SC_13 : integer := 0;
    constant SC_14 : integer := 0;
    constant SC_15 : integer := 0;
    constant testbench : string( 1 to 4 ) := "User";
    constant UPR_NIBBLE_POSN : integer := 3;
end coreparameters;
