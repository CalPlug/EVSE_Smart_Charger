-- ********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
--
-- corespi.vhd
--
--
-- SVN Revision Information:
-- SVN $Revision: 23512 $
-- SVN $Date: 2014-10-13 05:00:07 -0700 (Mon, 13 Oct 2014) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
-- Notes:
--
--
-- *********************************************************************/
LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   use work.corespi_pkg.all;

ENTITY corespi IS		--inputs
   GENERIC (
      FAMILY                : INTEGER := 15;
      APB_DWIDTH            : INTEGER := 8;
      CFG_FRAME_SIZE        : INTEGER := 4;
      CFG_FIFO_DEPTH        : INTEGER := 4;
      CFG_CLK               : INTEGER := 7;
      CFG_MODE              : INTEGER := 0;
      CFG_MOT_MODE          : INTEGER := 2;
      CFG_MOT_SSEL          : INTEGER := 0;
      CFG_TI_NSC_CUSTOM     : INTEGER := 0;
      CFG_TI_NSC_FRC        : INTEGER := 0;
      CFG_TI_JMB_FRAMES     : INTEGER := 0;
      CFG_NSC_OPERATION     : INTEGER := 0
   );
   PORT (
      PCLK                  : IN STD_LOGIC;
      PRESETN               : IN STD_LOGIC;
      PADDR                 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      PSEL                  : IN STD_LOGIC;
      PENABLE               : IN STD_LOGIC;
      PWRITE                : IN STD_LOGIC;
      PWDATA                : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      SPISSI                : IN STD_LOGIC;
      SPISDI                : IN STD_LOGIC;
      SPICLKI               : IN STD_LOGIC;
      
      PRDATA                : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      SPIINT                : OUT STD_LOGIC;
      SPISS                 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      SPISCLKO              : OUT STD_LOGIC;
      SPIRXAVAIL            : OUT STD_LOGIC;
      SPITXRFM              : OUT STD_LOGIC;
      SPIOEN                : OUT STD_LOGIC;
      SPISDO                : OUT STD_LOGIC;
      SPIMODE               : OUT STD_LOGIC;
      PREADY                : OUT STD_LOGIC;
      PSLVERR               : OUT STD_LOGIC
   );
END corespi;

ARCHITECTURE trans OF corespi IS
   COMPONENT spi IS
      GENERIC (
         APB_DWIDTH            : INTEGER := 8;
         CFG_FRAME_SIZE        : INTEGER := 4;
         CFG_FIFO_DEPTH        : INTEGER := 4;
         CFG_CLK               : INTEGER := 7;
         SPO                   : INTEGER := 0;
         SPH                   : INTEGER := 0;
         SPS                   : INTEGER := 0;
         CFG_MODE              : INTEGER := 0;
         SYNC_RESET            : INTEGER := 0
      );
      PORT (
         PCLK                  : IN STD_LOGIC;
         PRESETN               : IN STD_LOGIC;
         aresetn               : IN STD_LOGIC;
         sresetn               : IN STD_LOGIC;
         PADDR                 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
         PSEL                  : IN STD_LOGIC;
         PENABLE               : IN STD_LOGIC;
         PWRITE                : IN STD_LOGIC;
         PWDATA                : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         SPISSI                : IN STD_LOGIC;
         SPISDI                : IN STD_LOGIC;
         SPICLKI               : IN STD_LOGIC;
         PRDDATA               : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         SPIINT                : OUT STD_LOGIC;
         SPISS                 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         SPISCLKO              : OUT STD_LOGIC;
         SPIRXAVAIL            : OUT STD_LOGIC;
         SPITXRFM              : OUT STD_LOGIC;
         SPIOEN                : OUT STD_LOGIC;
         SPISDO                : OUT STD_LOGIC;
         SPIMODE               : OUT STD_LOGIC
      );
   END COMPONENT;
   
   CONSTANT SYNC_RESET : INTEGER := SYNC_MODE_SEL(FAMILY);
   
   CONSTANT SPS : INTEGER := SPS_SET(CFG_MODE, CFG_MOT_SSEL, CFG_TI_NSC_CUSTOM, CFG_NSC_OPERATION);
   CONSTANT SPO : INTEGER := SPO_SET(CFG_MODE, CFG_MOT_MODE, CFG_TI_NSC_CUSTOM, CFG_TI_NSC_FRC);
   CONSTANT SPH : INTEGER := SPH_SET(CFG_MODE, CFG_MOT_MODE, CFG_TI_NSC_CUSTOM, CFG_TI_JMB_FRAMES, CFG_NSC_OPERATION);
    
   -- Declare intermediate signals for referenced outputs
   SIGNAL PRDDATA_xhdl0        : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL SPIINT_xhdl1         : STD_LOGIC;
   SIGNAL SPISS_xhdl7          : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL SPISCLKO_xhdl5       : STD_LOGIC;
   SIGNAL SPIRXAVAIL_xhdl4     : STD_LOGIC;
   SIGNAL SPITXRFM_xhdl8       : STD_LOGIC;
   SIGNAL SPIOEN_xhdl3         : STD_LOGIC;
   SIGNAL SPISDO_xhdl6         : STD_LOGIC;
   SIGNAL SPIMODE_xhdl2        : STD_LOGIC;
   
   SIGNAL aresetn          : STD_LOGIC; -- Asynchronous reset signal   
   SIGNAL sresetn          : STD_LOGIC; -- Synchronous reset signal  

BEGIN
   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
   sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';
   
   -- Drive referenced outputs
   PRDATA <= PRDDATA_xhdl0;
   SPIINT <= SPIINT_xhdl1;
   SPISS <= SPISS_xhdl7;
   SPISCLKO <= SPISCLKO_xhdl5;
   SPIRXAVAIL <= SPIRXAVAIL_xhdl4;
   SPITXRFM <= SPITXRFM_xhdl8;
   SPIOEN <= SPIOEN_xhdl3;
   SPISDO <= SPISDO_xhdl6;
   SPIMODE <= SPIMODE_xhdl2;
   
   -- tie off APB3 signals
   PSLVERR <= '0';
   PREADY <= '1';
   
   		--inputs
   
   USPI : spi
      GENERIC MAP (
         APB_DWIDTH      => APB_DWIDTH,
         CFG_FRAME_SIZE  => CFG_FRAME_SIZE,
         CFG_FIFO_DEPTH  => CFG_FIFO_DEPTH,
         CFG_CLK         => CFG_CLK,
         SPO             => SPO,
         SPH             => SPH,
         SPS             => SPS,
         CFG_MODE        => CFG_MODE,
         SYNC_RESET      => SYNC_RESET
      )
      PORT MAP (
         PCLK        => PCLK,
         PRESETN     => PRESETN,
         aresetn     => aresetn,
         sresetn     => sresetn,
         PADDR       => PADDR,
         PSEL        => PSEL,
         PENABLE     => PENABLE,
         PWRITE      => PWRITE,
         PWDATA      => PWDATA,
         SPISSI      => SPISSI,
         SPISDI      => SPISDI,
         SPICLKI     => SPICLKI,
         
         --outputs
         PRDDATA     => PRDDATA_xhdl0,
         SPIINT      => SPIINT_xhdl1,
         SPISS       => SPISS_xhdl7,
         SPISCLKO    => SPISCLKO_xhdl5,
         SPIRXAVAIL  => SPIRXAVAIL_xhdl4,
         SPITXRFM    => SPITXRFM_xhdl8,
         SPIOEN      => SPIOEN_xhdl3,
         SPISDO      => SPISDO_xhdl6,
         SPIMODE     => SPIMODE_xhdl2
      );
   
END trans;


