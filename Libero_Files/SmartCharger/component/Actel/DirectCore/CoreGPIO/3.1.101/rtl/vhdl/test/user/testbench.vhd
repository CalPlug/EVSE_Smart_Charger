-- ********************************************************************
-- Actel Corporation Proprietary and Confidential
--  Copyright 2009 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	User testbench for CoreAI (Analog Interface)
--
-- Revision Information:
-- Date			Description
-- ----			-----------------------------------------
-- 03Mar09		Initial Version 2.0
--
-- SVN Revision Information:
-- SVN $Revision: $
-- SVN $Date: $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes:
-- 1. best viewed with tabstops set to "4"
-- 2. Most of the behavior is driven from the BFM scripts for the APB master.
--    Consult the Actel AMBA BFM documentation for more information.
--
-- History:		04/22/09  - AS created
--
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.coreparameters.all;
use work.components.all;
use work.bfm_package.all;

entity testbench is
generic (
-- vector file for driving the APB master BFM
-- NOTE: location of the following files can be overridden at run time
APB_MASTER_VECTFILE   : string := "coregpio_usertb_apb_master.vec";
-- propagation delay in ns
TPD                   : integer := 3
);
end entity testbench;

architecture testbench_arch of testbench is

-----------------------------------------------------------------------------
-- components
-----------------------------------------------------------------------------
-- from work.components ...

-------------------------------------------------------------------------------
-- constants
-------------------------------------------------------------------------------
constant APB_MASTER_CLK_CYCLE:			integer := 100;
constant APB_MASTER_CLK_CYCLE_LO_TIME:	integer := (APB_MASTER_CLK_CYCLE/2);
-- add 1 if APB_MASTER_CLK_CYCLE is odd number to compensate for PCLK period
constant APB_MASTER_CLK_CYCLE_HI_TIME:	integer := (APB_MASTER_CLK_CYCLE/2) + 
 to_integer(to_unsigned(APB_MASTER_CLK_CYCLE,10) and to_unsigned(1,10));

constant ADDR_IN    :   std_logic_vector(31 downto 0) :=  X"00000000";
constant ADDR_OUT   :   std_logic_vector(31 downto 0) :=  X"00000001";
constant ADDR_INT   :   std_logic_vector(31 downto 0) :=  X"00000002";
constant ADDR_OE    :   std_logic_vector(31 downto 0) :=  X"00000003";

------------------------------------------------------------------------------
-- signals
-------------------------------------------------------------------------------

-- system
signal SYSRSTN_apb          : std_logic;
signal SYSCLK_apb           : std_logic;

-- APB
signal PCLK                 : std_logic;
signal PRESETN              : std_logic;
signal PADDR_apb_bfm_wide   : std_logic_vector(31 downto 0);
signal PADDR                : std_logic_vector(7 downto 0);
signal PSEL_apb_bfm_wide    : std_logic_vector(15 downto 0);
signal PSEL                 : std_logic;
signal PENABLE              : std_logic;
signal PWRITE               : std_logic;
signal PWDATA_apb_bfm_wide  : std_logic_vector(31 downto 0);
signal PWDATA               : std_logic_vector(APB_WIDTH-1 downto 0);

-- BFM
signal PRDATA_apb_bfm_wide  : std_logic_vector(31 downto 0);
signal PRDATA               : std_logic_vector(APB_WIDTH-1 downto 0);
signal PREADY               : std_logic;
signal PSLVERR              : std_logic;

signal GP_IN_apb_bfm        : std_logic_vector(31 downto 0);
signal GP_OUT_apb_bfm       : std_logic_vector(31 downto 0);
signal FINISHED_apb_bfm     : std_logic;
signal FAILED_apb_bfm       : std_logic;

-- DUT
signal GPIO_IN              : std_logic_vector(IO_NUM-1 downto 0);
signal GPIO_OUT             : std_logic_vector(IO_NUM-1 downto 0);
signal GPIO_OE              : std_logic_vector(IO_NUM-1 downto 0);
signal INT                  : std_logic_vector(IO_NUM-1 downto 0);
signal INT_OR               : std_logic;

-- BFM memory interface
signal BFM_ADDR             : std_logic_vector(31 downto 0);
signal BFM_DATA             : std_logic_vector(31 downto 0);
signal BFM_DATA_i           : std_logic_vector(31 downto 0);
signal BFM_RD               : std_logic;
signal BFM_WR               : std_logic;

-- misc. signals
signal GND256:				        std_logic_vector(255 downto 0)	:=(others=>'0');
signal GND32:				          std_logic_vector(31 downto 0)	:=(others=>'0');
signal GND8:				          std_logic_vector(7 downto 0)	:=(others=>'0');
signal GND5:				          std_logic_vector(4 downto 0)	:=(others=>'0');
signal GND4:				          std_logic_vector(3 downto 0)	:=(others=>'0');
signal GND1:				          std_logic						:='0';
signal stopsim:				        integer range 0 to 1			:= 0;
	
begin

  PADDR				<= PADDR_apb_bfm_wide(7 downto 0);
  PSEL				<= PSEL_apb_bfm_wide(0);
  PWDATA		  <= PWDATA_apb_bfm_wide(APB_WIDTH-1 downto 0);

  rdata_32: if (APB_WIDTH = 32) generate
  begin
    PRDATA_apb_bfm_wide(31 downto 0) <= PRDATA(31 downto 0);
  end generate;
  
  rdata_16: if (APB_WIDTH = 16) generate
  begin
    PRDATA_apb_bfm_wide(31 downto 0) <= X"0000" & PRDATA(15 downto 0);
  end generate;
  
  rdata_8: if (APB_WIDTH = 8) generate
  begin
    PRDATA_apb_bfm_wide(31 downto 0) <= X"000000" & PRDATA(7 downto 0);
  end generate;
  
  -- System clock
  sysclk_apb_proc: process
  begin
  	SYSCLK_apb <= '0';
  	wait for APB_MASTER_CLK_CYCLE_LO_TIME*1 ns;
  	SYSCLK_apb <= '1';
  	wait for APB_MASTER_CLK_CYCLE_HI_TIME*1 ns;
  	if (stopsim=1) then
  		wait;	-- end simulation
  	end if;
  end process sysclk_apb_proc;
  
  -- Main simulation
  process 
  begin
  	SYSRSTN_apb <= '0';
  	wait until rising_edge(SYSCLK_apb); wait for (TPD)*1 ns;
  	SYSRSTN_apb <= '1';
  	wait until rising_edge(SYSCLK_apb); wait for (TPD)*1 ns;
  
  	-- wait until BFM is finished
  	while (not(FINISHED_apb_bfm = '1')) loop
  		wait until rising_edge(SYSCLK_apb); wait for (TPD)*1 ns;
  	end loop;
  	stopsim <= 1;
  	wait;
  end process;
  
-- ------------------------------------------------------
-- BFM register interface

-- store BFM-driven registers
store_bfm_reg: process(PCLK, PRESETN)
begin
  if (PRESETN = '0') then
    GPIO_IN <= (others => '0');
  elsif rising_edge(PCLK) then
    if (BFM_WR = '1' AND BFM_ADDR(31 downto 0) = ADDR_IN) then
      GPIO_IN <= BFM_DATA(IO_NUM-1 downto 0);
    end if;
  end if;
end process;

-- read back data from BFM registers
BFM_DATA_i(IO_NUM-1 downto 0) <=  GPIO_IN   when (BFM_ADDR(31 downto 0) = ADDR_IN) else
                                  GPIO_OUT  when (BFM_ADDR(31 downto 0) = ADDR_OUT) else
                                  INT       when (BFM_ADDR(31 downto 0) = ADDR_INT) else
                                  GPIO_OE   when (BFM_ADDR(31 downto 0) = ADDR_OE) else
                                  (others => 'X');
                                  
FILL_REGS: if (IO_NUM < 32) generate
begin
  BFM_DATA_i(31 downto IO_NUM) <= (others => '0');
end generate;

-- tristate during a write
BFM_DATA <= BFM_DATA_i when (BFM_WR = '0') else (others => 'Z');

-- End BFM register interface RTL
-- ------------------------------------------------------
  
  -- BFM instantiation
  u_apb_master: BFM_APB 
  generic map (  
	VECTFILE   =>   APB_MASTER_VECTFILE,
	TPD   =>   TPD,
	-- passing testbench parameters to BFM ARGVALUE* parameters
	ARGVALUE0   =>   IO_NUM,
  ARGVALUE1   =>   APB_WIDTH,
  ARGVALUE2   =>   OE_TYPE,
  ARGVALUE3   =>   INT_BUS,
  ARGVALUE4   =>   FIXED_CONFIG_0,
  ARGVALUE5   =>   FIXED_CONFIG_1,
  ARGVALUE6   =>   FIXED_CONFIG_2,
  ARGVALUE7   =>   FIXED_CONFIG_3,
  ARGVALUE8   =>   FIXED_CONFIG_4,
  ARGVALUE9   =>   FIXED_CONFIG_5,
  ARGVALUE10   =>   FIXED_CONFIG_6,
  ARGVALUE11   =>   FIXED_CONFIG_7,
  ARGVALUE12   =>   FIXED_CONFIG_8,
  ARGVALUE13   =>   FIXED_CONFIG_9,
  ARGVALUE14   =>   FIXED_CONFIG_10,
  ARGVALUE15   =>   FIXED_CONFIG_11,
  ARGVALUE16   =>   FIXED_CONFIG_12,
  ARGVALUE17   =>   FIXED_CONFIG_13,
  ARGVALUE18   =>   FIXED_CONFIG_14,
  ARGVALUE19   =>   FIXED_CONFIG_15,
  ARGVALUE20   =>   FIXED_CONFIG_16,
  ARGVALUE21   =>   FIXED_CONFIG_17,
  ARGVALUE22   =>   FIXED_CONFIG_18,
  ARGVALUE23   =>   FIXED_CONFIG_19,
  ARGVALUE24   =>   FIXED_CONFIG_20,
  ARGVALUE25   =>   FIXED_CONFIG_21,
  ARGVALUE26   =>   FIXED_CONFIG_22,
  ARGVALUE27   =>   FIXED_CONFIG_23,
  ARGVALUE28   =>   FIXED_CONFIG_24,
  ARGVALUE29   =>   FIXED_CONFIG_25,
  ARGVALUE30   =>   FIXED_CONFIG_26,
  ARGVALUE31   =>   FIXED_CONFIG_27,
  ARGVALUE32   =>   FIXED_CONFIG_28,
  ARGVALUE33   =>   FIXED_CONFIG_29,
  ARGVALUE34   =>   FIXED_CONFIG_30,
  ARGVALUE35   =>   FIXED_CONFIG_31,
  ARGVALUE36   =>   IO_TYPE_0,
  ARGVALUE37   =>   IO_TYPE_1,
  ARGVALUE38   =>   IO_TYPE_2,
  ARGVALUE39   =>   IO_TYPE_3,
  ARGVALUE40   =>   IO_TYPE_4,
  ARGVALUE41   =>   IO_TYPE_5,
  ARGVALUE42   =>   IO_TYPE_6,
  ARGVALUE43   =>   IO_TYPE_7,
  ARGVALUE44   =>   IO_TYPE_8,
  ARGVALUE45   =>   IO_TYPE_9,
  ARGVALUE46   =>   IO_TYPE_10,
  ARGVALUE47   =>   IO_TYPE_11,
  ARGVALUE48   =>   IO_TYPE_12,
  ARGVALUE49   =>   IO_TYPE_13,
  ARGVALUE50   =>   IO_TYPE_14,
  ARGVALUE51   =>   IO_TYPE_15,
  ARGVALUE52   =>   IO_TYPE_16,
  ARGVALUE53   =>   IO_TYPE_17,
  ARGVALUE54   =>   IO_TYPE_18,
  ARGVALUE55   =>   IO_TYPE_19,
  ARGVALUE56   =>   IO_TYPE_20,
  ARGVALUE57   =>   IO_TYPE_21,
  ARGVALUE58   =>   IO_TYPE_22,
  ARGVALUE59   =>   IO_TYPE_23,
  ARGVALUE60   =>   IO_TYPE_24,
  ARGVALUE61   =>   IO_TYPE_25,
  ARGVALUE62   =>   IO_TYPE_26,
  ARGVALUE63   =>   IO_TYPE_27,
  ARGVALUE64   =>   IO_TYPE_28,
  ARGVALUE65   =>   IO_TYPE_29,
  ARGVALUE66   =>   IO_TYPE_30,
  ARGVALUE67   =>   IO_TYPE_31,
  ARGVALUE68   =>   IO_INT_TYPE_0,
  ARGVALUE69   =>   IO_INT_TYPE_1,
  ARGVALUE70   =>   IO_INT_TYPE_2,
  ARGVALUE71   =>   IO_INT_TYPE_3,
  ARGVALUE72   =>   IO_INT_TYPE_4,
  ARGVALUE73   =>   IO_INT_TYPE_5,
  ARGVALUE74   =>   IO_INT_TYPE_6,
  ARGVALUE75   =>   IO_INT_TYPE_7,
  ARGVALUE76   =>   IO_INT_TYPE_8,
  ARGVALUE77   =>   IO_INT_TYPE_9,
  ARGVALUE78   =>   IO_INT_TYPE_10,
  ARGVALUE79   =>   IO_INT_TYPE_11,
  ARGVALUE80   =>   IO_INT_TYPE_12,
  ARGVALUE81   =>   IO_INT_TYPE_13,
  ARGVALUE82   =>   IO_INT_TYPE_14,
  ARGVALUE83   =>   IO_INT_TYPE_15,
  ARGVALUE84   =>   IO_INT_TYPE_16,
  ARGVALUE85   =>   IO_INT_TYPE_17,
  ARGVALUE86   =>   IO_INT_TYPE_18,
  ARGVALUE87   =>   IO_INT_TYPE_19,
  ARGVALUE88   =>   IO_INT_TYPE_20,
  ARGVALUE89   =>   IO_INT_TYPE_21,
  ARGVALUE90   =>   IO_INT_TYPE_22,
  ARGVALUE91   =>   IO_INT_TYPE_23,
  ARGVALUE92   =>   IO_INT_TYPE_24,
  ARGVALUE93   =>   IO_INT_TYPE_25,
  ARGVALUE94   =>   IO_INT_TYPE_26,
  ARGVALUE95   =>   IO_INT_TYPE_27,
  ARGVALUE96   =>   IO_INT_TYPE_28,
  ARGVALUE97   =>   IO_INT_TYPE_29,
  ARGVALUE98   =>   IO_INT_TYPE_30,
  ARGVALUE99   =>   IO_INT_TYPE_31
) 
port map (
	SYSCLK   =>   SYSCLK_apb,
	SYSRSTN   =>   SYSRSTN_apb,
	PCLK   =>   PCLK,
	PRESETN   =>   PRESETN,
	PADDR   =>   PADDR_apb_bfm_wide,
	PSEL   =>   PSEL_apb_bfm_wide,
	PENABLE   =>   PENABLE,
	PWRITE   =>   PWRITE,
	PWDATA   =>   PWDATA_apb_bfm_wide,
	PRDATA   =>   PRDATA_apb_bfm_wide,
	PREADY   =>   PREADY,
	PSLVERR   =>   PSLVERR,
	INTERRUPT   =>   GND256,
	-- Not using GPIO interface, only
	-- external memory interface
	GP_OUT   =>   GP_OUT_apb_bfm,
	GP_IN   =>   GND32,
	EXT_WR   =>   BFM_WR,
	EXT_RD   =>   BFM_RD,
	EXT_ADDR   =>   BFM_ADDR,
	EXT_DATA   =>   BFM_DATA,
	EXT_WAIT   =>   GND1,
	FINISHED   =>   FINISHED_apb_bfm,
	FAILED   =>   FAILED_apb_bfm
);

-- DUT
DUT: COREGPIO 
  generic map (
  IO_NUM                 => IO_NUM,
  APB_WIDTH              => APB_WIDTH,
  OE_TYPE                => OE_TYPE,
  INT_BUS                => INT_BUS,
  FIXED_CONFIG_0         => FIXED_CONFIG_0,
  FIXED_CONFIG_1         => FIXED_CONFIG_1,
  FIXED_CONFIG_2         => FIXED_CONFIG_2,
  FIXED_CONFIG_3         => FIXED_CONFIG_3,
  FIXED_CONFIG_4         => FIXED_CONFIG_4,
  FIXED_CONFIG_5         => FIXED_CONFIG_5,
  FIXED_CONFIG_6         => FIXED_CONFIG_6,
  FIXED_CONFIG_7         => FIXED_CONFIG_7,
  FIXED_CONFIG_8         => FIXED_CONFIG_8,
  FIXED_CONFIG_9         => FIXED_CONFIG_9,
  FIXED_CONFIG_10        => FIXED_CONFIG_10,
  FIXED_CONFIG_11        => FIXED_CONFIG_11,
  FIXED_CONFIG_12        => FIXED_CONFIG_12,
  FIXED_CONFIG_13        => FIXED_CONFIG_13,
  FIXED_CONFIG_14        => FIXED_CONFIG_14,
  FIXED_CONFIG_15        => FIXED_CONFIG_15,
  FIXED_CONFIG_16        => FIXED_CONFIG_16,
  FIXED_CONFIG_17        => FIXED_CONFIG_17,
  FIXED_CONFIG_18        => FIXED_CONFIG_18,
  FIXED_CONFIG_19        => FIXED_CONFIG_19,
  FIXED_CONFIG_20        => FIXED_CONFIG_20,
  FIXED_CONFIG_21        => FIXED_CONFIG_21,
  FIXED_CONFIG_22        => FIXED_CONFIG_22,
  FIXED_CONFIG_23        => FIXED_CONFIG_23,
  FIXED_CONFIG_24        => FIXED_CONFIG_24,
  FIXED_CONFIG_25        => FIXED_CONFIG_25,
  FIXED_CONFIG_26        => FIXED_CONFIG_26,
  FIXED_CONFIG_27        => FIXED_CONFIG_27,
  FIXED_CONFIG_28        => FIXED_CONFIG_28,
  FIXED_CONFIG_29        => FIXED_CONFIG_29,
  FIXED_CONFIG_30        => FIXED_CONFIG_30,
  FIXED_CONFIG_31        => FIXED_CONFIG_31,
  IO_TYPE_0              => IO_TYPE_0,
  IO_TYPE_1              => IO_TYPE_1,
  IO_TYPE_2              => IO_TYPE_2,
  IO_TYPE_3              => IO_TYPE_3,
  IO_TYPE_4              => IO_TYPE_4,
  IO_TYPE_5              => IO_TYPE_5,
  IO_TYPE_6              => IO_TYPE_6,
  IO_TYPE_7              => IO_TYPE_7,
  IO_TYPE_8              => IO_TYPE_8,
  IO_TYPE_9              => IO_TYPE_9,
  IO_TYPE_10             => IO_TYPE_10,
  IO_TYPE_11             => IO_TYPE_11,
  IO_TYPE_12             => IO_TYPE_12,
  IO_TYPE_13             => IO_TYPE_13,
  IO_TYPE_14             => IO_TYPE_14,
  IO_TYPE_15             => IO_TYPE_15,
  IO_TYPE_16             => IO_TYPE_16,
  IO_TYPE_17             => IO_TYPE_17,
  IO_TYPE_18             => IO_TYPE_18,
  IO_TYPE_19             => IO_TYPE_19,
  IO_TYPE_20             => IO_TYPE_20,
  IO_TYPE_21             => IO_TYPE_21,
  IO_TYPE_22             => IO_TYPE_22,
  IO_TYPE_23             => IO_TYPE_23,
  IO_TYPE_24             => IO_TYPE_24,
  IO_TYPE_25             => IO_TYPE_25,
  IO_TYPE_26             => IO_TYPE_26,
  IO_TYPE_27             => IO_TYPE_27,
  IO_TYPE_28             => IO_TYPE_28,
  IO_TYPE_29             => IO_TYPE_29,
  IO_TYPE_30             => IO_TYPE_30,
  IO_TYPE_31             => IO_TYPE_31,
  IO_INT_TYPE_0          => IO_INT_TYPE_0,
  IO_INT_TYPE_1          => IO_INT_TYPE_1,
  IO_INT_TYPE_2          => IO_INT_TYPE_2,
  IO_INT_TYPE_3          => IO_INT_TYPE_3,
  IO_INT_TYPE_4          => IO_INT_TYPE_4,
  IO_INT_TYPE_5          => IO_INT_TYPE_5,
  IO_INT_TYPE_6          => IO_INT_TYPE_6,
  IO_INT_TYPE_7          => IO_INT_TYPE_7,
  IO_INT_TYPE_8          => IO_INT_TYPE_8,
  IO_INT_TYPE_9          => IO_INT_TYPE_9,
  IO_INT_TYPE_10         => IO_INT_TYPE_10,
  IO_INT_TYPE_11         => IO_INT_TYPE_11,
  IO_INT_TYPE_12         => IO_INT_TYPE_12,
  IO_INT_TYPE_13         => IO_INT_TYPE_13,
  IO_INT_TYPE_14         => IO_INT_TYPE_14,
  IO_INT_TYPE_15         => IO_INT_TYPE_15,
  IO_INT_TYPE_16         => IO_INT_TYPE_16,
  IO_INT_TYPE_17         => IO_INT_TYPE_17,
  IO_INT_TYPE_18         => IO_INT_TYPE_18,
  IO_INT_TYPE_19         => IO_INT_TYPE_19,
  IO_INT_TYPE_20         => IO_INT_TYPE_20,
  IO_INT_TYPE_21         => IO_INT_TYPE_21,
  IO_INT_TYPE_22         => IO_INT_TYPE_22,
  IO_INT_TYPE_23         => IO_INT_TYPE_23,
  IO_INT_TYPE_24         => IO_INT_TYPE_24,
  IO_INT_TYPE_25         => IO_INT_TYPE_25,
  IO_INT_TYPE_26         => IO_INT_TYPE_26,
  IO_INT_TYPE_27         => IO_INT_TYPE_27,
  IO_INT_TYPE_28         => IO_INT_TYPE_28,
  IO_INT_TYPE_29         => IO_INT_TYPE_29,
  IO_INT_TYPE_30         => IO_INT_TYPE_30,
  IO_INT_TYPE_31         => IO_INT_TYPE_31
  -- DO NOT ASSIGN IO_VAL FOR USER TESTBENCH
) 
port map (
  PRESETN     => PRESETN,
  PCLK        => PCLK,
  PSEL        => PSEL,
  PENABLE     => PENABLE,
  PWRITE      => PWRITE,
  PADDR       => PADDR,
  PWDATA      => PWDATA,
  PRDATA      => PRDATA,
  PREADY      => PREADY,
  PSLVERR     => PSLVERR,
  INT         => INT,
  INT_OR      => INT_OR,
  GPIO_IN     => GPIO_IN,
  GPIO_OUT    => GPIO_OUT,
  GPIO_OE     => GPIO_OE
);
  
end testbench_arch; -- testbench