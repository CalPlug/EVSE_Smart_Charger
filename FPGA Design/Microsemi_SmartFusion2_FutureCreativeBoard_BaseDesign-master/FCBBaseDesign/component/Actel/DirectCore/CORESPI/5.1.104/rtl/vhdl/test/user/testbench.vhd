LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
-- ********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
--
-- CoreSPI User Testbench
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
library ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;
   USE work.coreparameters.all;

ENTITY testbench IS

END testbench;

ARCHITECTURE trans OF testbench IS
   component BFM_APB is
    generic ( 
            VECTFILE         : STRING  := "TEST.VEC"                 
            );                                                   
  PORT ( SYSCLK      : in    STD_LOGIC;                     
         SYSRSTN     : in    STD_LOGIC;                     
         -- APB Interface                                       
         PCLK        : out   STD_LOGIC;                     
         PRESETN     : out   STD_LOGIC;                     
         PADDR       : out   STD_LOGIC_VECTOR(31 DOWNTO 0); 
         PENABLE     : out   STD_LOGIC;                     
         PWRITE      : out   STD_LOGIC;                     
         PWDATA      : out   STD_LOGIC_VECTOR(31 DOWNTO 0); 
         PRDATA      : in    STD_LOGIC_VECTOR(31 DOWNTO 0); 
         PREADY      : in    STD_LOGIC;                     
         PSLVERR     : in    STD_LOGIC;                     
         PSEL        : out   STD_LOGIC_VECTOR(15 DOWNTO 0); 
         --Control etc                                      
         INTERRUPT   : in    STD_LOGIC_VECTOR(255 DOWNTO 0);
         GP_OUT      : out   STD_LOGIC_VECTOR(31 DOWNTO 0); 
         GP_IN       : in    STD_LOGIC_VECTOR(31 DOWNTO 0); 
         EXT_WR      : out   STD_LOGIC;                     
         EXT_RD      : out   STD_LOGIC;                     
         EXT_ADDR    : out   STD_LOGIC_VECTOR(31 DOWNTO 0); 
         EXT_DATA    : inout STD_LOGIC_VECTOR(31 DOWNTO 0); 
         EXT_WAIT    : in    STD_LOGIC;                     
         FINISHED    : out   STD_LOGIC;                     
         FAILED      : out   STD_LOGIC                      
       );
END COMPONENT;

COMPONENT CORESPI IS		--inputs
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
      -- AP3
      PREADY                : OUT STD_LOGIC;
      PSLVERR               : OUT STD_LOGIC
   );
END COMPONENT;

   SIGNAL SYSCLK     : STD_LOGIC;
   SIGNAL SYSRSTN    : STD_LOGIC;
   SIGNAL PCLK       : STD_LOGIC;
   SIGNAL PRESETN    : STD_LOGIC;
   SIGNAL PADDR      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL PENABLE    : STD_LOGIC;
   SIGNAL PWRITE     : STD_LOGIC;
   SIGNAL PWDATA     : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL PRDATA     : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL PRDATA_0   : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL PRDATA_1   : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL PSEL       : STD_LOGIC_VECTOR(15 DOWNTO 0);
   
   SIGNAL GP_IN      : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL INTERRUPT  : STD_LOGIC_VECTOR(255 DOWNTO 0);
   SIGNAL FINISHED   : STD_LOGIC;
   
   SIGNAL M_SPISS    : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL M_SPISCLKO : STD_LOGIC;
   SIGNAL M_SPISDO   : STD_LOGIC;
   SIGNAL S_SPISDO   : STD_LOGIC;

   SIGNAL stopsim    : STD_LOGIC;
BEGIN

   PROCESS 
   BEGIN
      stopsim <= '0';
      SYSRSTN <= '0';
      WAIT FOR 100 ns;
      SYSRSTN <= '1';
      WHILE (not(FINISHED = '1')) LOOP
        wait until rising_edge(SYSCLK);
      END LOOP;
      stopsim <= '1';
      wait;
   END PROCESS;
   
   PROCESS 
   BEGIN
      SYSCLK <= '0';
      WAIT FOR 5 ns;
      SYSCLK <= '1';
      WAIT FOR 5 ns;
      if (stopsim='1') then
        wait; -- end simulation
      end if;
   END PROCESS;
   
   
   
   UBFM : BFM_APB
      GENERIC MAP (
         vectfile  => "user_tb.vec"
      )
      PORT MAP (
         sysclk     => SYSCLK,
         sysrstn    => SYSRSTN,
         pclk       => PCLK,
         presetn    => PRESETN,
         paddr      => PADDR,
         penable    => PENABLE,
         pwrite     => PWRITE,
         pwdata     => PWDATA,
         prdata     => PRDATA,
         pready     => '1',
         pslverr    => '0',
         psel       => PSEL,
         interrupt  => INTERRUPT,
         gp_out     => OPEN,
         gp_in      => GP_IN,
         ext_wr     => OPEN,
         ext_rd     => OPEN,
         ext_addr   => OPEN,
         ext_data   => OPEN,
         ext_wait   => '0',
         finished   => FINISHED,
         failed     => OPEN
      );
    
   PRDATA <= PRDATA_1 WHEN (PSEL(1) = '1') ELSE PRDATA_0 ;     
   
   USPIM : CORESPI
      GENERIC MAP (
        FAMILY                => FAMILY,
        APB_DWIDTH            => 32,
        CFG_FRAME_SIZE        => 32,
        CFG_FIFO_DEPTH        => 4,
        CFG_CLK               => 3,
        CFG_MODE              => 0,
        CFG_MOT_MODE          => 1,
        CFG_MOT_SSEL          => 0,
        CFG_TI_NSC_CUSTOM     => 0,
        CFG_TI_NSC_FRC        => 0,
        CFG_TI_JMB_FRAMES     => 0,
        CFG_NSC_OPERATION     => 0
      )
      PORT MAP (
         pclk        => PCLK,
         presetn     => PRESETN,
         paddr       => PADDR(6 DOWNTO 0),
         psel        => PSEL(0),
         penable     => PENABLE,
         pwrite      => PWRITE,
         pwdata      => PWDATA,
         prdata      => PRDATA_0,
         spissi      => '1',
         spisdi      => S_SPISDO,
         spiclki     => '1',
         spiss       => M_SPISS,
         spisclko    => M_SPISCLKO,
         spioen      => OPEN,
         spisdo      => M_SPISDO,
         spiint      => GP_IN(0),
         spirxavail  => OPEN,
         spitxrfm    => OPEN,
         spimode     => OPEN,
         pready      => OPEN,
         pslverr     => OPEN
      );
   
   
   USPIS : CORESPI
       GENERIC MAP (
        FAMILY                => FAMILY,
        APB_DWIDTH            => 32,
        CFG_FRAME_SIZE        => 32,
        CFG_FIFO_DEPTH        => 4,
        CFG_CLK               => 3,
        CFG_MODE              => 0,
        CFG_MOT_MODE          => 1,
        CFG_MOT_SSEL          => 0,
        CFG_TI_NSC_CUSTOM     => 0,
        CFG_TI_NSC_FRC        => 0,
        CFG_TI_JMB_FRAMES     => 0,
        CFG_NSC_OPERATION     => 0
      )
      PORT MAP (
         pclk        => PCLK,
         presetn     => PRESETN,
         paddr       => PADDR(6 DOWNTO 0),
         psel        => PSEL(1),
         penable     => PENABLE,
         pwrite      => PWRITE,
         pwdata      => PWDATA,
         prdata      => PRDATA_1,
         spissi      => M_SPISS(0),
         spisdi      => M_SPISDO,
         spiclki     => M_SPISCLKO,
         spiss       => OPEN,
         spisclko    => OPEN,
         spioen      => OPEN,
         spisdo      => S_SPISDO,
         spiint      => GP_IN(1),
         spirxavail  => OPEN,
         spitxrfm    => OPEN,
         spimode     => OPEN,
         pready      => OPEN,
         pslverr     => OPEN
      );
END trans;

