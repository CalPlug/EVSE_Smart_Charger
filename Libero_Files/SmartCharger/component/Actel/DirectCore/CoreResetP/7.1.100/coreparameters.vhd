----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Mon Feb 13 21:09:17 2017
-- Parameters for CoreResetP
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant DDR_WAIT : integer := 200;
    constant DEVICE_090 : 
    constant DEVICE_VOLTAGE : integer := 2;
    constant ENABLE_SOFT_RESETS : integer := 0;
    constant EXT_RESET_CFG : integer := 0;
    constant FDDR_IN_USE : integer := 0;
    constant MDDR_IN_USE : integer := 0;
    constant SDIF0_IN_USE : integer := 0;
    constant SDIF0_PCIE : integer := 0;
    constant SDIF0_PCIE_HOTRESET : integer := 1;
    constant SDIF0_PCIE_L2P2 : integer := 1;
    constant SDIF1_IN_USE : integer := 0;
    constant SDIF1_PCIE : integer := 0;
    constant SDIF1_PCIE_HOTRESET : integer := 1;
    constant SDIF1_PCIE_L2P2 : integer := 1;
    constant SDIF2_IN_USE : integer := 0;
    constant SDIF2_PCIE : integer := 0;
    constant SDIF2_PCIE_HOTRESET : integer := 1;
    constant SDIF2_PCIE_L2P2 : integer := 1;
    constant SDIF3_IN_USE : integer := 0;
    constant SDIF3_PCIE : integer := 0;
    constant SDIF3_PCIE_HOTRESET : integer := 1;
    constant SDIF3_PCIE_L2P2 : integer := 1;
end coreparameters;
