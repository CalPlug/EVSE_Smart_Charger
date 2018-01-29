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
use work.SF2_MSS_sys_sb_CoreUARTapb_0_bfM_packAGE.all;

entity testbench is
generic (
-- vector file for driving the APB master BFM
-- NOTE: location of the following files can be overridden at run time
APB_MASTER_VECTFILE   : string := "coreuart_usertb_apb_master.vec";
-- propagation delay in ns
TPD                   : integer := 3
);
end entity testbench;

architecture testbench_arch of testbench is

-----------------------------------------------------------------------------
-- components
-----------------------------------------------------------------------------
component SF2_MSS_sys_sb_CoreUARTapb_0_COREUARTAPB 
   GENERIC (
      RX_LEGACY_MODE                 :  integer := 0;
      -- DEVICE FAMILY 
      FAMILY                         :  integer := 15;    
      -- UART configuration parameters
      TX_FIFO                        :  integer := 0;    --  1 = with tx fifo, 0 = without tx fifo
      RX_FIFO                        :  integer := 0;    --  1 = with rx fifo, 0 = without rx fifo
      BAUD_VALUE                     :  integer := 0;    --  Baud value is set only when fixed buad rate is selected 
      FIXEDMODE                      :  integer := 0;    --  fixed or programmable mode, 0: programmable; 1:fixed
      PRG_BIT8                       :  integer := 0;    --  This bit value is selected only when FIXEDMODE is set to 1 
      PRG_PARITY                     :  integer := 0;    --  This bit value is selected only when FIXEDMODE is set to 1 
      BAUD_VAL_FRCTN                 :  integer := 0;    --  0 = +0.0, 1 = +0.125, 2 = +0.25, 3 = +0.375, 4 = +0.5, 5 = +0.625, 6 = +0.75, 7 = +0.875,
      BAUD_VAL_FRCTN_EN              :  integer := 0    --  1 = enable baud fraction, 0 = disable baud fraction
);    
   PORT (
      -- Inputs and Outputs
-- APB signals

      PCLK                    : IN std_logic;   --  APB system clock
      PRESETN                 : IN std_logic;   --  APB system reset
      PADDR                   : IN std_logic_vector(4 DOWNTO 0);   --  Address
      PSEL                    : IN std_logic;   --  Peripheral select signal
      PENABLE                 : IN std_logic;   --  Enable (data valid strobe)
      PWRITE                  : IN std_logic;   --  Write/nRead signal
      PWDATA                  : IN std_logic_vector(7 DOWNTO 0);   --  8 bit write data
      PRDATA                  : OUT std_logic_vector(7 DOWNTO 0);   --  8 bit read data
      
      -- AS: Added PREADY and PSLVERR
      PREADY                  : OUT std_logic;   -- APB READY signal (tied to 1)
      PSLVERR                 : OUT std_logic;  -- APB slave error signal (tied to 0)

      -- transmit ready and receive full indicators

      TXRDY                   : OUT std_logic;   
      RXRDY                   : OUT std_logic;   
      -- FLAGS 

      FRAMING_ERR             : OUT std_logic;
      PARITY_ERR              : OUT std_logic;   
      OVERFLOW                : OUT std_logic;   
      -- Serial receive and transmit data

      RX                      : IN std_logic;   
      TX                      : OUT std_logic
);   
end component;

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
signal PADDR                : std_logic_vector(4 downto 0);
signal PSEL_apb_bfm_wide    : std_logic_vector(15 downto 0);
signal PSEL1                : std_logic; -- DUT1 PSEL
signal PSEL2                : std_logic; -- DUT2 PSEL
signal PENABLE              : std_logic;
signal PWRITE               : std_logic;
signal PWDATA_apb_bfm_wide  : std_logic_vector(31 downto 0);
signal PWDATA               : std_logic_vector(7 downto 0);

-- BFM
signal PRDATA_apb_bfm_wide  : std_logic_vector(31 downto 0);
signal PRDATA               : std_logic_vector(7 downto 0);
signal PRDATA1              : std_logic_vector(7 downto 0);
signal PRDATA2              : std_logic_vector(7 downto 0);
signal PREADY               : std_logic;
signal PSLVERR              : std_logic;

signal GP_IN_apb_bfm        : std_logic_vector(31 downto 0);
signal GP_OUT_apb_bfm       : std_logic_vector(31 downto 0);
signal FINISHED_apb_bfm     : std_logic;
signal FAILED_apb_bfm       : std_logic;

-- DUT1
signal TXRDY1               : std_logic;
signal RXRDY1               : std_logic;
signal TX1                  : std_logic;
signal RX1                  : std_logic;
signal PARITY_ERR1          : std_logic;
signal OVERFLOW1            : std_logic;
signal FRAMING_ERR1         : std_logic;

-- DUT2
signal TXRDY2               : std_logic;
signal RXRDY2               : std_logic;
signal TX2                  : std_logic;
signal RX2                  : std_logic;
signal PARITY_ERR2          : std_logic;
signal OVERFLOW2            : std_logic;
signal FRAMING_ERR2         : std_logic;

signal RX_SEL               : std_logic;

-- BFM memory interface
-- not used
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

  -- APB ASSIGNS
  PADDR				<= PADDR_apb_bfm_wide(4 downto 0);
  PSEL1				<= PSEL_apb_bfm_wide(0);
  PSEL2				<= PSEL_apb_bfm_wide(1);
  PWDATA		  <= PWDATA_apb_bfm_wide(7 downto 0);
  PRDATA      <= PRDATA1 when (PSEL1 = '1') else
                 PRDATA2 when (PSEL2 = '1') else
                 X"00";
  PRDATA_apb_bfm_wide(31 downto 0) <= X"000000" & PRDATA(7 downto 0);
  -- PREADY and PSLVERR not used, tie off
  PREADY      <= '1';
  PSLVERR     <= '0';

  -- DUT
  -- pull-down for Framing Error Test
  RX2         <= TX1 when (RX_SEL = '0') else '0';

  -- monitor flags / select signals in BFM
  GP_IN_apb_bfm <= X"000000" & 
                   OVERFLOW2 & PARITY_ERR2 & TXRDY2 & RXRDY2 & 
                   OVERFLOW1 & PARITY_ERR1 & TXRDY1 & RXRDY1;
  RX_SEL        <= GP_OUT_apb_bfm(0);

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
  	while (not(FINISHED_apb_bfm = '1') and not(FAILED_apb_bfm = '1')) loop
  		wait until rising_edge(SYSCLK_apb); wait for (TPD)*1 ns;
  	end loop;
  	stopsim <= 1;
  	wait;
  end process;
  
-- ------------------------------------------------------
-- BFM register interface

-- not used for this core

-- End BFM register interface RTL
-- ------------------------------------------------------
  
  -- BFM instantiation
  u_apb_master: SF2_MSS_sys_sb_CoreUARTapb_0_BFM_APB 
  generic map (  
	VECTFILE   =>   APB_MASTER_VECTFILE,
	TPD   =>   TPD,
	-- passing testbench parameters to BFM ARGVALUE* parameters
	ARGVALUE0   =>   FAMILY,
  ARGVALUE1   =>   TX_FIFO,
  ARGVALUE2   =>   RX_FIFO,
  ARGVALUE3   =>   FIXEDMODE,
  ARGVALUE4   =>   BAUD_VALUE,
  ARGVALUE5   =>   PRG_BIT8,
  ARGVALUE6   =>   PRG_PARITY,
  ARGVALUE7   =>   RX_LEGACY_MODE,
  ARGVALUE8   =>   USE_SOFT_FIFO
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
  -- NEED TO ADD GPIN
	GP_OUT   =>   GP_OUT_apb_bfm,
	GP_IN   =>   GP_IN_apb_bfm,
	EXT_WR   =>   BFM_WR,
	EXT_RD   =>   BFM_RD,
	EXT_ADDR   =>   BFM_ADDR,
	EXT_DATA   =>   BFM_DATA,
	EXT_WAIT   =>   GND1,
	FINISHED   =>   FINISHED_apb_bfm,
	FAILED   =>   FAILED_apb_bfm
);

-- DUT1 (TX)
DUT1: SF2_MSS_sys_sb_CoreUARTapb_0_COREUARTAPB
  generic map (
  FAMILY      => FAMILY,
  TX_FIFO     => TX_FIFO,
  RX_FIFO     => RX_FIFO,
  FIXEDMODE   => FIXEDMODE,
  BAUD_VALUE  => BAUD_VALUE,
  PRG_BIT8    => PRG_BIT8,
  PRG_PARITY  => PRG_PARITY,
  RX_LEGACY_MODE => RX_LEGACY_MODE,
  BAUD_VAL_FRCTN => BAUD_VAL_FRCTN,
  BAUD_VAL_FRCTN_EN => BAUD_VAL_FRCTN_EN  
) 
port map (
  PRESETN     => PRESETN,
  PCLK        => PCLK,
  PSEL        => PSEL1,
  PENABLE     => PENABLE,
  PWRITE      => PWRITE,
  PADDR       => PADDR,
  PWDATA      => PWDATA,
  PRDATA      => PRDATA1,
-- other signals
  TXRDY       => TXRDY1,
  RXRDY       => RXRDY1,
  PARITY_ERR  => PARITY_ERR1,
  FRAMING_ERR => FRAMING_ERR1,
  OVERFLOW    => OVERFLOW1,
  RX          => RX1,
  TX          => TX1
);
  

-- DUT2 (RX)
DUT2: SF2_MSS_sys_sb_CoreUARTapb_0_COREUARTAPB
  generic map (
  FAMILY      => FAMILY,
  TX_FIFO     => TX_FIFO,
  RX_FIFO     => RX_FIFO,
  FIXEDMODE   => FIXEDMODE,
  BAUD_VALUE  => BAUD_VALUE,
  PRG_BIT8    => PRG_BIT8,
  PRG_PARITY  => PRG_PARITY,
  RX_LEGACY_MODE => RX_LEGACY_MODE,
  BAUD_VAL_FRCTN => BAUD_VAL_FRCTN,
  BAUD_VAL_FRCTN_EN => BAUD_VAL_FRCTN_EN 
) 
port map (
  PRESETN     => PRESETN,
  PCLK        => PCLK,
  PSEL        => PSEL2,
  PENABLE     => PENABLE,
  PWRITE      => PWRITE,
  PADDR       => PADDR,
  PWDATA      => PWDATA,
  PRDATA      => PRDATA2,
-- other signals
  TXRDY       => TXRDY2,
  RXRDY       => RXRDY2,
  PARITY_ERR  => PARITY_ERR2,
  FRAMING_ERR => FRAMING_ERR2,
  OVERFLOW    => OVERFLOW2,
  RX          => RX2,
  TX          => TX2
);

end testbench_arch; -- testbench
