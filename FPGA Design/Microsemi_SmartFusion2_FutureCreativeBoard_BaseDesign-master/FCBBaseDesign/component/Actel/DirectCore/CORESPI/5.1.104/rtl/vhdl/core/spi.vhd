-- ********************************************************************/ 
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
--
-- spi.v -- top level module for spi core
--
--
-- SVN Revision Information:
-- SVN $Revision: 23983 $
-- SVN $Date: 2014-11-28 23:42:46 +0530 (Fri, 28 Nov 2014) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes: 
--
--
-- *********************************************************************/ 

LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;

ENTITY spi IS		--inputs
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
END spi;

ARCHITECTURE trans OF spi IS
   COMPONENT spi_chanctrl IS
      GENERIC (
        SPH                   : INTEGER := 0;
        SPO                   : INTEGER := 0;
        SPS                   : INTEGER := 0;
        CFG_MODE              : INTEGER := 0;
        CFG_CLKRATE           : INTEGER := 7;
        CFG_FRAME_SIZE        : INTEGER := 4;
        CFG_FIFO_DEPTH        : INTEGER := 4;
        SYNC_RESET            : INTEGER := 0
      );
      PORT (
        pclk                  : IN STD_LOGIC;
        presetn               : IN STD_LOGIC;
        aresetn               : IN STD_LOGIC;
        sresetn               : IN STD_LOGIC;
        spi_clk_in            : IN STD_LOGIC;
        spi_clk_out           : OUT STD_LOGIC;
        spi_ssel_in           : IN STD_LOGIC;
        spi_ssel_out          : OUT STD_LOGIC;
        spi_data_in           : IN STD_LOGIC;
        spi_data_out          : OUT STD_LOGIC;
        spi_data_oen          : OUT STD_LOGIC;
        txfifo_count          : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        txfifo_empty          : IN STD_LOGIC;
        txfifo_read           : OUT STD_LOGIC;
        txfifo_data           : IN STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
        txfifo_last           : IN STD_LOGIC;
        rxfifo_count          : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        rxfifo_write          : OUT STD_LOGIC;
        rxfifo_data           : OUT STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
        rxfifo_first          : OUT STD_LOGIC;
        cfg_enable            : IN STD_LOGIC;
        cfg_master            : IN STD_LOGIC;
        cfg_frameurun         : IN STD_LOGIC;
        cfg_oenoff            : IN STD_LOGIC;
        cfg_cmdsize           : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        tx_alldone            : OUT STD_LOGIC;
        rx_alldone            : OUT STD_LOGIC;
        tx_underrun           : OUT STD_LOGIC;
        rx_pktend             : OUT STD_LOGIC;
        rx_cmdsize            : OUT STD_LOGIC;
        tx_active             : OUT STD_LOGIC
      );
   END COMPONENT;
   
   COMPONENT spi_fifo IS
      GENERIC (
         CFG_FRAME_SIZE        : INTEGER := 4;
         CFG_FIFO_DEPTH        : INTEGER := 4
      );
      PORT (
         pclk                  : IN STD_LOGIC;
         aresetn               : IN STD_LOGIC;
         sresetn               : IN STD_LOGIC;
         fiforst               : IN STD_LOGIC;
         data_in               : IN STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
         flag_in               : IN STD_LOGIC;
         data_out              : OUT STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
         flag_out              : OUT STD_LOGIC;
         read_in               : IN STD_LOGIC;
         write_in              : IN STD_LOGIC;
         full_out              : OUT STD_LOGIC;
         empty_out             : OUT STD_LOGIC;
         full_next_out         : OUT STD_LOGIC;
         empty_next_out        : OUT STD_LOGIC;
         overflow_out          : OUT STD_LOGIC;
         fifo_count            : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
      );
   END COMPONENT;
   
   COMPONENT spi_rf IS
      GENERIC (
         APB_DWIDTH            : INTEGER := 8
      );
      PORT (
         pclk                  : IN STD_LOGIC;
         aresetn               : IN STD_LOGIC;
         sresetn               : IN STD_LOGIC;
         paddr                 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
         psel                  : IN STD_LOGIC;
         pwrite                : IN STD_LOGIC;
         penable               : IN STD_LOGIC;
         wrdata                : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         prdata                : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         interrupt             : OUT STD_LOGIC;
         tx_channel_underflow  : IN STD_LOGIC;
         rx_channel_overflow   : IN STD_LOGIC;
         tx_done               : IN STD_LOGIC;
         rx_done               : IN STD_LOGIC;
         rx_fifo_read          : IN STD_LOGIC;
         tx_fifo_read          : IN STD_LOGIC;
         tx_fifo_write         : IN STD_LOGIC;
         rx_fifo_full          : IN STD_LOGIC;
         rx_fifo_full_next     : IN STD_LOGIC;
         rx_fifo_empty         : IN STD_LOGIC;
         rx_fifo_empty_next    : IN STD_LOGIC;
         tx_fifo_full          : IN STD_LOGIC;
         tx_fifo_full_next     : IN STD_LOGIC;
         tx_fifo_empty         : IN STD_LOGIC;
         tx_fifo_empty_next    : IN STD_LOGIC;
         first_frame           : IN STD_LOGIC;
         ssel                  : IN STD_LOGIC;
         tx_active             : IN STD_LOGIC;
         rx_pktend             : IN STD_LOGIC;
         rx_cmdsize            : IN STD_LOGIC;
         cfg_enable            : OUT STD_LOGIC;
         cfg_master            : OUT STD_LOGIC;
         cfg_ssel              : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         cfg_cmdsize           : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
         cfg_oenoff            : OUT STD_LOGIC;
         clr_txfifo            : OUT STD_LOGIC;
         clr_rxfifo            : OUT STD_LOGIC;
         cfg_frameurun         : OUT STD_LOGIC
      );
   END COMPONENT;
   
   COMPONENT spi_control IS
      GENERIC (
         CFG_FRAME_SIZE        : INTEGER := 4
      );
      PORT (
         psel                  : IN STD_LOGIC;
         penable               : IN STD_LOGIC;
         pwrite                : IN STD_LOGIC;
         paddr                 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
         wr_data_in            : IN STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
         cfg_master            : IN STD_LOGIC;
         rx_fifo_empty         : IN STD_LOGIC;
         tx_fifo_empty         : IN STD_LOGIC;
         tx_fifo_data          : OUT STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
         tx_fifo_write         : OUT STD_LOGIC;
         tx_fifo_last          : OUT STD_LOGIC;
         rx_fifo_read          : OUT STD_LOGIC
      );
   END COMPONENT;
   
   
   -- Do not declare single bit block connections unless required
   
   SIGNAL prdata_regs          : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL cfg_ssel             : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL cfg_master           : STD_LOGIC;
   SIGNAL cfg_enable           : STD_LOGIC;
   SIGNAL cfg_cmdsize          : STD_LOGIC_VECTOR(2 DOWNTO 0);
   
   SIGNAL tx_fifo_data_in      : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   SIGNAL tx_fifo_data_out     : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   SIGNAL rx_fifo_data_in      : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   SIGNAL rx_fifo_data_out     : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   
   SIGNAL rx_fifo_empty        : STD_LOGIC;
   SIGNAL tx_fifo_full         : STD_LOGIC;
   SIGNAL master_ssel_out      : STD_LOGIC;
   SIGNAL rx_fifo_count        : STD_LOGIC_VECTOR(5 DOWNTO 0);
   SIGNAL tx_fifo_count        : STD_LOGIC_VECTOR(5 DOWNTO 0);
   
   --##########################################################################################
   --APB Signals 
   
   SIGNAL PADDR32              : STD_LOGIC_VECTOR(6 DOWNTO 0);
   
   -- ----------------------------------------------------------------------------------
   -- Channel Outputs
   
   --Pass the slave select to the selected devices. If no slave select asserted then everything off
   
   SIGNAL master_ssel_all      : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL ssel_both            : STD_LOGIC;
   
   -------------------------------------------------------------------------------------------
   
   -- The Register Set
   
   SIGNAL tx_channel_underflow : STD_LOGIC;
   SIGNAL rx_channel_overflow  : STD_LOGIC;
   SIGNAL tx_done              : STD_LOGIC;
   SIGNAL rx_done              : STD_LOGIC;
   SIGNAL rx_fifo_read         : STD_LOGIC;
   SIGNAL tx_fifo_write        : STD_LOGIC;
   SIGNAL tx_fifo_read         : STD_LOGIC;
   SIGNAL rx_fifo_full         : STD_LOGIC;
   SIGNAL rx_fifo_full_next    : STD_LOGIC;
   SIGNAL rx_fifo_empty_next   : STD_LOGIC;
   SIGNAL tx_fifo_full_next    : STD_LOGIC;
   SIGNAL tx_fifo_empty        : STD_LOGIC;
   SIGNAL tx_fifo_empty_next   : STD_LOGIC;
   SIGNAL first_frame_out      : STD_LOGIC;             
   SIGNAL rx_pktend            : STD_LOGIC;
   SIGNAL rx_cmdsize           : STD_LOGIC;
   SIGNAL tx_active            : STD_LOGIC;
   SIGNAL fiforsttx            : STD_LOGIC;
   SIGNAL fiforstrx            : STD_LOGIC;
   SIGNAL cfg_frameurun        : STD_LOGIC;
   SIGNAL cfg_oenoff           : STD_LOGIC;
   
   -- APB side of FIFOs Control    
   SIGNAL tx_fifo_last_in      : STD_LOGIC;            
   
   --Transmit Fifo
   SIGNAL tx_fifo_last_out     : STD_LOGIC;
   SIGNAL not_used1            : STD_LOGIC;
   
   --Receive Fifo
   SIGNAL rx_fifo_write        : STD_LOGIC;
   SIGNAL rx_fifo_first_in     : STD_LOGIC;
   
   -- Declare intermediate signals for referenced outputs
   SIGNAL SPIINT_xhdl0         : STD_LOGIC;
   SIGNAL SPISCLKO_xhdl2       : STD_LOGIC;
   SIGNAL SPIOEN_xhdl1         : STD_LOGIC;
   SIGNAL SPISDO_xhdl3         : STD_LOGIC;

   -- Filler for PRDATA (Note that CFG_FRAME_SIZE must be <= APB_DWIDTH)
   CONSTANT ZEROS_PRDATA         : STD_LOGIC_VECTOR(APB_DWIDTH-CFG_FRAME_SIZE-1 DOWNTO 0) := (OTHERS => '0');
BEGIN
   -- Drive referenced outputs
   SPIINT <= SPIINT_xhdl0;
   SPISCLKO <= SPISCLKO_xhdl2;
   SPIOEN <= SPIOEN_xhdl1;
   SPISDO <= SPISDO_xhdl3;
   PADDR32 <= (PADDR(6 DOWNTO 2) & "00");
   PRDDATA <= prdata_regs WHEN (NOT((PADDR32(6 DOWNTO 0) = "0001000"))) ELSE
              (ZEROS_PRDATA & rx_fifo_data_out);

   SPIMODE <= cfg_master;
   SPIRXAVAIL <= NOT(rx_fifo_empty);
   SPITXRFM <= NOT(tx_fifo_full);
   SPISS <= master_ssel_all;
   PROCESS (cfg_enable, cfg_master, cfg_ssel, master_ssel_out)
   BEGIN
      IF ((cfg_enable AND cfg_master) = '1') THEN
         FOR i IN 0 TO 7 LOOP
            IF ((cfg_ssel(i)) = '1') THEN
               master_ssel_all(i) <= master_ssel_out;
            ELSE
              IF (CFG_MODE = 1) THEN
                master_ssel_all(i) <= '0';
              ELSE
                master_ssel_all(i) <= '1';
              END IF;
            END IF;
         END LOOP;
      ELSE
         FOR i IN 0 TO 7 LOOP
              IF (CFG_MODE = 1) THEN
                master_ssel_all(i) <= '0';
              ELSE
                master_ssel_all(i) <= '1';
              END IF;
         END LOOP;
      END IF;
   END PROCESS;
   
   ssel_both <= master_ssel_out WHEN (cfg_master = '1') ELSE
                SPISSI;
   
   
   URF : spi_rf
      GENERIC MAP (
         APB_DWIDTH  => APB_DWIDTH
      )
      PORT MAP (
         pclk                  => PCLK,
         aresetn               => aresetn,
         sresetn               => sresetn,   
         paddr                 => PADDR32(6 DOWNTO 0),
         psel                  => PSEL,
         penable               => PENABLE,
         pwrite                => PWRITE,
         wrdata                => PWDATA,
         prdata                => prdata_regs,
         interrupt             => SPIINT_xhdl0,
         tx_channel_underflow  => tx_channel_underflow,
         rx_channel_overflow   => rx_channel_overflow,
         tx_done               => tx_done,
         rx_done               => rx_done,
         rx_fifo_read          => rx_fifo_read,
         tx_fifo_write         => tx_fifo_write,
         tx_fifo_read          => tx_fifo_read,
         rx_fifo_full          => rx_fifo_full,
         rx_fifo_full_next     => rx_fifo_full_next,
         rx_fifo_empty         => rx_fifo_empty,
         rx_fifo_empty_next    => rx_fifo_empty_next,
         tx_fifo_full          => tx_fifo_full,
         tx_fifo_full_next     => tx_fifo_full_next,
         tx_fifo_empty         => tx_fifo_empty,
         tx_fifo_empty_next    => tx_fifo_empty_next,
         first_frame           => first_frame_out,
         ssel                  => ssel_both,
         rx_pktend             => rx_pktend,
         rx_cmdsize            => rx_cmdsize,
         tx_active             => tx_active,
         cfg_enable            => cfg_enable,
         cfg_master            => cfg_master,
         cfg_ssel              => cfg_ssel,
         cfg_cmdsize           => cfg_cmdsize,
         clr_txfifo            => fiforsttx,
         clr_rxfifo            => fiforstrx,
         cfg_frameurun         => cfg_frameurun,
         cfg_oenoff            => cfg_oenoff
      );
   
   
   UCON : spi_control
      GENERIC MAP (
         CFG_FRAME_SIZE  => CFG_FRAME_SIZE
      )
      PORT MAP (
         psel           => PSEL,
         penable        => PENABLE,
         pwrite         => PWRITE,
         paddr          => PADDR32(6 DOWNTO 0),
         wr_data_in     => PWDATA(CFG_FRAME_SIZE - 1 DOWNTO 0),
         cfg_master     => cfg_master,
         tx_fifo_data   => tx_fifo_data_in,
         tx_fifo_write  => tx_fifo_write,
         tx_fifo_last   => tx_fifo_last_in,
         tx_fifo_empty  => tx_fifo_empty,
         rx_fifo_read   => rx_fifo_read,
         rx_fifo_empty  => rx_fifo_empty
      );
   
   
   UTXF : spi_fifo
      GENERIC MAP (
         CFG_FRAME_SIZE  => CFG_FRAME_SIZE,
         CFG_FIFO_DEPTH  => CFG_FIFO_DEPTH
      )
      PORT MAP (
         pclk            => PCLK,
         aresetn         => aresetn,
         sresetn         => sresetn, 
         fiforst         => fiforsttx,
         data_in         => tx_fifo_data_in,
         flag_in         => tx_fifo_last_in,
         data_out        => tx_fifo_data_out,
         flag_out        => tx_fifo_last_out,
         read_in         => tx_fifo_read,
         write_in        => tx_fifo_write,
         full_out        => tx_fifo_full,
         empty_out       => tx_fifo_empty,
         full_next_out   => tx_fifo_full_next,
         empty_next_out  => tx_fifo_empty_next,
         overflow_out    => not_used1,
         fifo_count      => tx_fifo_count
      );
   
   
   URXF : spi_fifo
      GENERIC MAP (
         CFG_FRAME_SIZE  => CFG_FRAME_SIZE,
         CFG_FIFO_DEPTH  => CFG_FIFO_DEPTH
      )
      PORT MAP (
         pclk            => PCLK,
         aresetn         => aresetn,
         sresetn         => sresetn, 
         fiforst         => fiforstrx,
         data_in         => rx_fifo_data_in,
         write_in        => rx_fifo_write,
         flag_in         => rx_fifo_first_in,
         data_out        => rx_fifo_data_out,
         read_in         => rx_fifo_read,
         flag_out        => first_frame_out,
         full_out        => rx_fifo_full,
         empty_out       => rx_fifo_empty,
         empty_next_out  => rx_fifo_empty_next,
         full_next_out   => rx_fifo_full_next,
         overflow_out    => rx_channel_overflow,
         fifo_count      => rx_fifo_count
      );
   
   --Channel controll
   UCC : spi_chanctrl
      GENERIC MAP (
         SPH             => SPH,
         SPO             => SPO,
         SPS             => SPS,
         CFG_MODE        => CFG_MODE,
         CFG_CLKRATE     => CFG_CLK,
         CFG_FRAME_SIZE  => CFG_FRAME_SIZE,
         SYNC_RESET      => SYNC_RESET
      )
      PORT MAP (
         pclk           => PCLK,
         presetn        => PRESETN,
         aresetn        => aresetn,
         sresetn        => sresetn,      
         spi_clk_in     => SPICLKI,
         spi_clk_out    => SPISCLKO_xhdl2,
         spi_ssel_in    => SPISSI,
         spi_ssel_out   => master_ssel_out,
         spi_data_in    => SPISDI,
         spi_data_out   => SPISDO_xhdl3,
         spi_data_oen   => SPIOEN_xhdl1,
         txfifo_count   => tx_fifo_count,
         txfifo_empty   => tx_fifo_empty,
         txfifo_read    => tx_fifo_read,
         txfifo_data    => tx_fifo_data_out,
         txfifo_last    => tx_fifo_last_out,
         rxfifo_count   => rx_fifo_count,
         rxfifo_write   => rx_fifo_write,
         rxfifo_data    => rx_fifo_data_in,
         rxfifo_first   => rx_fifo_first_in,
         cfg_enable     => cfg_enable,
         cfg_master     => cfg_master,
         cfg_frameurun  => cfg_frameurun,       
         cfg_cmdsize    => cfg_cmdsize,
         cfg_oenoff     => cfg_oenoff,
         tx_alldone     => tx_done,
         rx_alldone     => rx_done,
         rx_pktend      => rx_pktend,
         rx_cmdsize     => rx_cmdsize,
         tx_underrun    => tx_channel_underflow,
         tx_active         => tx_active
      );
   
END trans;




