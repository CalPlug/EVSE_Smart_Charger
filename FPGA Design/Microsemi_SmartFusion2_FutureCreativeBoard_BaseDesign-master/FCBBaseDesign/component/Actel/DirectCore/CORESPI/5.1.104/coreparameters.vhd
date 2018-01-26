----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Wed Jan 24 22:41:04 2018
-- Parameters for CORESPI
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant APB_DWIDTH : integer := 32;
    constant CFG_CLK : integer := 33;
    constant CFG_FIFO_DEPTH : integer := 32;
    constant CFG_FRAME_SIZE : integer := 8;
    constant CFG_MODE : integer := 0;
    constant CFG_MOT_MODE : integer := 0;
    constant CFG_MOT_SSEL : integer := 0;
    constant CFG_NSC_OPERATION : integer := 0;
    constant CFG_TI_JMB_FRAMES : integer := 0;
    constant CFG_TI_NSC_CUSTOM : integer := 0;
    constant CFG_TI_NSC_FRC : integer := 0;
    constant FAMILY : integer := 19;
    constant HDL_license : string( 1 to 1 ) := "U";
    constant testbench : string( 1 to 4 ) := "User";
end coreparameters;
