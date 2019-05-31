-- ********************************************************************/ 
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
--
-- SPI Transmit/Receive control logic for channel
--
--
-- SVN Revision Information:
-- SVN $Revision: 28017 $
-- SVN $Date: 2016-11-24 20:49:04 +0530 (Thu, 24 Nov 2016) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes: 
-- -----
--
-- ********************************************************************/ 
LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

LIBRARY work;
   USE work.corespi_pkg.all;


ENTITY spi_chanctrl IS
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
END spi_chanctrl;

ARCHITECTURE trans OF spi_chanctrl IS
   COMPONENT spi_clockmux IS
      PORT (
         sel                   : IN STD_LOGIC;
         clka                  : IN STD_LOGIC;
         clkb                  : IN STD_LOGIC;
         clkout                : OUT STD_LOGIC
      );
   END COMPONENT;
   
   SIGNAL spi_clk_count        : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL spi_clk_next         : STD_LOGIC;
   SIGNAL spi_clk_nextd        : STD_LOGIC;
   SIGNAL spi_clk_tick         : STD_LOGIC;
   SIGNAL cfg_enable_P1        : STD_LOGIC;
   SIGNAL cfg_enableON         : STD_LOGIC;
   SIGNAL mtx_bitsel           : STD_LOGIC_VECTOR(4 DOWNTO 0);
   SIGNAL mtx_fiforead         : STD_LOGIC;
   SIGNAL mtx_bitcnt           : STD_LOGIC_VECTOR(4 DOWNTO 0);
   SIGNAL mtx_ssel             : STD_LOGIC;
   SIGNAL mtx_lastframe        : STD_LOGIC;
   SIGNAL mtx_consecutive      : STD_LOGIC;
   SIGNAL mtx_datahold         : STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL mtx_oen              : STD_LOGIC;
   SIGNAL mtx_spi_data_out     : STD_LOGIC;
   SIGNAL mtx_spi_data_oen     : STD_LOGIC;
   SIGNAL mtx_busy             : STD_LOGIC;
   SIGNAL mtx_rxbusy           : STD_LOGIC;
   SIGNAL mtx_holdsel          : STD_LOGIC;
   SIGNAL mtx_first            : STD_LOGIC;
   SIGNAL mtx_pktsel           : STD_LOGIC;
   SIGNAL mtx_lastbit          : STD_LOGIC;
   SIGNAL mtx_firstrx          : STD_LOGIC;
   SIGNAL mtx_midbit           : STD_LOGIC;
   SIGNAL mtx_alldone          : STD_LOGIC;
   SIGNAL mtx_re               : STD_LOGIC;
   SIGNAL mtx_re_q1            : STD_LOGIC;
   SIGNAL mtx_re_q2            : STD_LOGIC;
   SIGNAL mtx_re_d             : STD_LOGIC;
   SIGNAL msrxs_strobe         : STD_LOGIC;
   SIGNAL msrxs_shiftreg       : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 2 DOWNTO 0);
   SIGNAL msrxs_datain         : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   SIGNAL msrxs_pktsel         : STD_LOGIC;
   SIGNAL msrxs_ssel           : STD_LOGIC;
   SIGNAL msrxp_strobe         : STD_LOGIC;
   SIGNAL msrxp_frames         : STD_LOGIC_VECTOR(5 DOWNTO 0);
   SIGNAL msrxs_first          : STD_LOGIC;
   SIGNAL msrxp_pktend         : STD_LOGIC;
   SIGNAL msrxp_alldone        : STD_LOGIC;
   SIGNAL SYNC1_msrxp_strobe   : STD_LOGIC;
   SIGNAL SYNC2_msrxp_strobe   : STD_LOGIC;
   SIGNAL SYNC3_msrxp_strobe   : STD_LOGIC;
   SIGNAL SYNC1_msrxp_pktsel   : STD_LOGIC;
   SIGNAL SYNC2_msrxp_pktsel   : STD_LOGIC;
   SIGNAL SYNC3_msrxp_pktsel   : STD_LOGIC;
   SIGNAL cfg_clk_idle1        : STD_LOGIC;
   SIGNAL cfg_clk_idle2        : STD_LOGIC;
   SIGNAL cfg_clk_ph1          : STD_LOGIC;
   SIGNAL cfg_clk_ph2          : STD_LOGIC;
   SIGNAL cfg_clk_cap          : STD_LOGIC;
   SIGNAL cfg_clk_end1         : STD_LOGIC;
   SIGNAL clock_rx             : STD_LOGIC;
   SIGNAL resetn_rx            : STD_LOGIC;
   SIGNAL resetn_tx            : STD_LOGIC;
   SIGNAL stxs_strobetx        : STD_LOGIC;
   SIGNAL stxs_midbit          : STD_LOGIC;
   SIGNAL stxs_direct          : STD_LOGIC;
   SIGNAL stxs_datareg         : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   SIGNAL stxs_bitsel          : STD_LOGIC_VECTOR(4 DOWNTO 0);
   SIGNAL stxs_bitcnt          : STD_LOGIC_VECTOR(4 DOWNTO 0);
   SIGNAL stxp_fiforead        : STD_LOGIC;
   SIGNAL stxs_dataerr         : STD_LOGIC;
   SIGNAL stxs_checkorun       : STD_LOGIC;
   SIGNAL stxs_oen             : STD_LOGIC;
   SIGNAL stxs_spi_data_out    : STD_LOGIC;
   SIGNAL stxs_spi_data_oen    : STD_LOGIC;
   SIGNAL stxp_strobe          : STD_LOGIC;
   SIGNAL stxp_underrun        : STD_LOGIC;
   SIGNAL stxp_lastframe       : STD_LOGIC;
   SIGNAL stxs_txzeros         : STD_LOGIC;
   SIGNAL stxs_first           : STD_LOGIC;
   SIGNAL stxs_pktsel          : STD_LOGIC;
   SIGNAL stxs_txready         : STD_LOGIC;
   SIGNAL stxs_txready_at_ssel : STD_LOGIC;
   SIGNAL stxs_lastbit         : STD_LOGIC;
   SIGNAL txfifo_davailable    : STD_LOGIC;
   SIGNAL SYNC1_stxp_strobetx  : STD_LOGIC;
   SIGNAL SYNC1_stxp_dataerr   : STD_LOGIC;
   SIGNAL SYNC2_stxp_strobetx  : STD_LOGIC;
   SIGNAL SYNC2_stxp_dataerr   : STD_LOGIC;
   SIGNAL SYNC3_stxp_strobetx  : STD_LOGIC;
   SIGNAL SYNC3_stxp_dataerr   : STD_LOGIC;
   SIGNAL SYNC1_stxs_txready   : STD_LOGIC;
   SIGNAL spi_ssel_pos         : STD_LOGIC;
   SIGNAL spi_ssel_neg         : STD_LOGIC;
   SIGNAL txfifo_datadelay     : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   SIGNAL txfifo_dhold         : STD_LOGIC_VECTOR(CFG_FRAME_SIZE - 1 DOWNTO 0);
   SIGNAL busy                 : STD_LOGIC;
   SIGNAL msrx_async_reset_ok  : STD_LOGIC;
   SIGNAL stx_async_reset_ok   : STD_LOGIC;
   SIGNAL mtx_state            : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL stxs_state           : STD_LOGIC;
   
   SIGNAL spi_ssel_mux         : STD_LOGIC;
   
   SIGNAL cfg_slave            : STD_LOGIC;

   CONSTANT   MTX_IDLE1             : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
   CONSTANT   MTX_IDLE2             : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
   CONSTANT   MTX_MOTSTART          : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
   CONSTANT   MTX_TISTART1          : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
   CONSTANT   MTX_TISTART2          : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
   CONSTANT   MTX_NSCSTART1         : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
   CONSTANT   MTX_NSCSTART2         : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";
   CONSTANT   MTX_SHIFT1            : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";
   CONSTANT   MTX_SHIFT2            : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1000";
   CONSTANT   MTX_END               : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001";
      
   CONSTANT   STXS_IDLE             : STD_LOGIC := '0';
   CONSTANT   STXS_SHIFT            : STD_LOGIC := '1';
   CONSTANT   cfg_framesizeM1     : INTEGER := CFG_FRAME_SIZE - 1;      

    -- Simple Stuff
   SIGNAL   MOTMODE               : STD_LOGIC; -- := (CFG_MODE = 0);
   SIGNAL   TIMODE                : STD_LOGIC; -- := (CFG_MODE = 1);
   SIGNAL   NSCMODE               : STD_LOGIC; -- := (CFG_MODE = 2);
   SIGNAL   MOTNOSSEL             : STD_LOGIC; -- := MOTMODE AND (SPH OR SPS);
   SIGNAL   NSCNOSSEL             : STD_LOGIC; -- := NSCMODE AND NOT(SPH);
   
   --####################################################
   -- Select Outputs based on mode
   SIGNAL spi_data_oex         : STD_LOGIC;
   SIGNAL clock_rx_mux1        : STD_LOGIC;
   SIGNAL clock_rx_mux2        : STD_LOGIC;		-- Clock inversion when needed
   SIGNAL msrxp_pktsel         : STD_LOGIC;
   SIGNAL tmp                  : STD_LOGIC_VECTOR(2 DOWNTO 0);

   -- Register as this feeds into lots of logic
   SIGNAL queued               : STD_LOGIC_VECTOR(5 DOWNTO 0);
   
   -- Declare intermediate signals for referenced outputs
   SIGNAL spi_clk_out_xhdl0    : STD_LOGIC;
   SIGNAL spi_ssel_out_xhdl1   : STD_LOGIC;

   SIGNAL clock_rx_q1          : STD_LOGIC;
   SIGNAL clock_rx_q2          : STD_LOGIC;
   SIGNAL clock_rx_q3          : STD_LOGIC;
   SIGNAL data_rx_q1           : STD_LOGIC;
   SIGNAL data_rx_q2           : STD_LOGIC;
   SIGNAL ssel_rx_q1           : STD_LOGIC;
   SIGNAL ssel_rx_q2           : STD_LOGIC;

   SIGNAL spi_di_mux           : STD_LOGIC;
   SIGNAL clock_rx_re_slave    : STD_LOGIC; 
   SIGNAL clock_rx_re          : STD_LOGIC; 
   SIGNAL clock_rx_fe          : STD_LOGIC;
   SIGNAL stxs_txready_re      : STD_LOGIC;
   
   SIGNAL aresetn_tx          : STD_LOGIC; -- Asynchronous reset signal   
   SIGNAL sresetn_tx          : STD_LOGIC; -- Synchronous reset signal  

BEGIN

  -- assign flags
  MOTMODE <= '1' WHEN (CFG_MODE = 0) ELSE '0';
  TIMODE <= '1' WHEN (CFG_MODE = 1) ELSE '0';
  NSCMODE <= '1' WHEN (CFG_MODE = 2) ELSE '0';
  MOTNOSSEL <= '1' WHEN ((MOTMODE = '1') AND ((SPH = 1) OR (SPS = 1))) ELSE '0';
  NSCNOSSEL <= '1' WHEN ((NSCMODE = '1') AND NOT(SPH = 1)) ELSE '0';

   -- Drive referenced outputs
   spi_clk_out <= spi_clk_out_xhdl0;
   spi_ssel_out <= spi_ssel_out_xhdl1;
   cfg_slave <= NOT(cfg_master);
   mtx_re_d <= mtx_re_q1 AND (NOT(mtx_re_q2));
   stxs_txready_re <= (txfifo_davailable AND (NOT(SYNC1_stxs_txready)));
   
   spi_ssel_mux  <= spi_ssel_out_xhdl1 WHEN (cfg_master = '1') ELSE ssel_rx_q2;
   spi_di_mux    <= spi_data_in WHEN (cfg_master = '1') ELSE data_rx_q2; 
   clock_rx_re_slave <= clock_rx_q2 AND (NOT(clock_rx_q3));
   clock_rx_re       <= mtx_re_d WHEN (cfg_master = '1') ELSE clock_rx_re_slave;
   clock_rx_fe       <= (NOT(clock_rx_q2)) AND clock_rx_q3;

   -------------------------------------------------------------

   spi_clk_nextd <= NOT(spi_clk_next) WHEN (spi_clk_count(7 DOWNTO 0) = int2slv(CFG_CLKRATE, 8)) ELSE
                    spi_clk_next;

    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            spi_clk_count <= "0000000000000000";
            spi_clk_next <= '0';
            spi_clk_tick <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                spi_clk_count <= "0000000000000000";
                spi_clk_next <= '0';
                spi_clk_tick <= '0';
            ELSE
                IF (NOT(cfg_enable = '1' AND cfg_master = '1')) THEN
                    spi_clk_tick <= '0';
                    spi_clk_count <= "0000000000000000";
                ELSE
                    IF (spi_clk_count(7 DOWNTO 0) = int2slv(CFG_CLKRATE, 8)) THEN
                        spi_clk_count <= "0000000000000000";
                        --spi_clk_nextd <= (NOT(spi_clk_next));
                    ELSE
                        --spi_clk_nextd <= spi_clk_next;
                        spi_clk_count <= spi_clk_count + "0000000000000001";
                    END IF;
                    spi_clk_next <= spi_clk_nextd;
                    spi_clk_tick <= spi_clk_nextd XOR spi_clk_next;
                END IF;
            END IF;
        END IF;
    END PROCESS;
   
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            cfg_enable_P1 <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                cfg_enable_P1 <= '0';
            ELSE
                cfg_enable_P1 <= cfg_enable;
            END IF;
        END IF;
    END PROCESS;
   
    cfg_enableON <= cfg_enable AND cfg_enable_P1;
    
    -- Added by mahesh
    -------------------------------------
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            mtx_re_q1 <= '0';
            mtx_re_q2 <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                mtx_re_q1 <= '0';
                mtx_re_q2 <= '0';
            ELSE
                mtx_re_q1 <= mtx_re;
                mtx_re_q2 <= mtx_re_q1;
            END IF;
        END IF;
    END PROCESS;
    --------------------------------------

    xhdl2 : IF (CFG_MODE = 0) GENERATE
        cfg_clk_end1 <= int2sl(SPO);
        cfg_clk_idle1 <= int2sl(SPO);
        cfg_clk_idle2 <= int2sl(SPO);
        cfg_clk_ph1 <= int2sl(SPO) XOR int2sl(SPH);
        cfg_clk_ph2 <= NOT((int2sl(SPO) XOR int2sl(SPH)));
        cfg_clk_cap <= int2sl(SPO) XOR int2sl(SPH);
    END GENERATE;
    xhdl3 : IF (NOT(CFG_MODE = 0)) GENERATE
        xhdl4 : IF (CFG_MODE = 1) GENERATE
            cfg_clk_end1 <= '1';
            cfg_clk_idle1 <= int2sl(SPO);
            cfg_clk_idle2 <= '0';
            cfg_clk_ph1 <= '1';
            cfg_clk_ph2 <= '0';
            cfg_clk_cap <= '1';
        END GENERATE;
        xhdl5 : IF (NOT(CFG_MODE = 1)) GENERATE
            xhdl6 : IF (CFG_MODE = 2) GENERATE
                cfg_clk_end1 <= '0';
                cfg_clk_idle1 <= '0';
                cfg_clk_idle2 <= int2sl(SPO);
                cfg_clk_ph1 <= '0';
                cfg_clk_ph2 <= '1';
                cfg_clk_cap <= '0';
            END GENERATE;
            xhdl7 : IF (NOT(CFG_MODE = 2)) GENERATE
                cfg_clk_end1 <= '0';
                cfg_clk_idle1 <= '0';
                cfg_clk_idle2 <= '0';
                cfg_clk_ph1 <= '0';
                cfg_clk_ph2 <= '0';
                cfg_clk_cap <= '0';
            END GENERATE;
        END GENERATE;
    END GENERATE;
    
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            mtx_bitsel <= int2slv(cfg_framesizeM1, 5);
            mtx_state <= MTX_IDLE1;
            mtx_bitcnt <= "00000";
            mtx_fiforead <= '0';
            mtx_lastframe <= '0';
            mtx_consecutive <= '0';
            mtx_datahold <= "000";
            mtx_oen <= '0';
            mtx_busy <= '0';
            mtx_rxbusy <= '0';
            mtx_holdsel <= '0';
            mtx_ssel <= '0';
            mtx_first <= '1';
            mtx_pktsel <= '0';
            mtx_alldone <= '0';
            mtx_re <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN 
            IF ((NOT(sresetn)) = '1') THEN  -- Sync Reset
                mtx_bitsel <= int2slv(cfg_framesizeM1, 5);
                mtx_state <= MTX_IDLE1;
                mtx_bitcnt <= "00000";
                mtx_fiforead <= '0';
                mtx_lastframe <= '0';
                mtx_consecutive <= '0';
                mtx_datahold <= "000";
                mtx_oen <= '0';
                mtx_busy <= '0';
                mtx_rxbusy <= '0';
                mtx_holdsel <= '0';
                mtx_ssel <= '0';
                mtx_first <= '1';
                mtx_pktsel <= '0';
                mtx_alldone <= '0';
                mtx_re <= '0';
            ELSE
                mtx_fiforead <= '0';
                mtx_alldone <= '0';
                mtx_re <= '0';
        
                IF ((NOT(cfg_master) OR NOT(cfg_enable)) = '1') THEN
                    mtx_state <= MTX_IDLE1;
                    mtx_pktsel <= '0';
                    mtx_first <= '0';
                ELSIF (spi_clk_tick = '1') THEN
                    mtx_ssel <= '0';
                    CASE mtx_state IS
                    WHEN MTX_IDLE1 | MTX_IDLE2 =>
                        IF (mtx_state = MTX_IDLE1) THEN
                            mtx_state <= MTX_IDLE2;
                        ELSE
                            mtx_state <= MTX_IDLE1;
                        END IF;
                        IF ((NOT(txfifo_empty) AND cfg_master AND cfg_enableON) = '1') THEN
                            mtx_bitsel <= int2slv(cfg_framesizeM1, 5);
                            mtx_bitcnt <= "00000";
                            mtx_pktsel <= '1';
                            mtx_first <= NOT(mtx_holdsel);
                            CASE CFG_MODE IS
                                WHEN 0 =>
                                mtx_state <= MTX_MOTSTART;
                                WHEN 1 =>
                                IF (mtx_state = MTX_IDLE2) THEN
                                    mtx_state <= MTX_TISTART1;
                                END IF;
                                WHEN 2 =>
                                IF (mtx_state = MTX_IDLE2) THEN
                                    mtx_state <= MTX_NSCSTART1;
                                END IF;
                                WHEN OTHERS =>
                            END CASE;
                        ELSE
                            mtx_oen <= '0';
                            IF (mtx_state = MTX_IDLE1) THEN
                                mtx_busy <= '0';
                            END IF;
                            IF ((mtx_state = MTX_IDLE1) AND (mtx_busy = '0')) THEN
                                mtx_rxbusy <= '0';
                            END IF;
                            mtx_pktsel <= mtx_holdsel;
                            mtx_first <= NOT(mtx_holdsel);
                        END IF;
                    WHEN MTX_MOTSTART =>
                        mtx_state <= MTX_SHIFT1;
                        mtx_oen <= '1';
                        mtx_busy <= '1';
                        mtx_rxbusy <= '1';
                    WHEN MTX_TISTART1 =>
                        mtx_state <= MTX_TISTART2;
                        mtx_oen <= '1';
                        mtx_rxbusy <= '1';
                        mtx_busy <= '1';
                    WHEN MTX_TISTART2 =>
                        mtx_state <= MTX_SHIFT1;
                        mtx_ssel <= '0';
                    WHEN MTX_NSCSTART1 =>
                        mtx_state <= MTX_NSCSTART2;
                        mtx_oen <= '1';
                        mtx_busy <= '1';
                        mtx_rxbusy <= '1';
                    WHEN MTX_NSCSTART2 =>
                        mtx_state <= MTX_SHIFT1;
                    WHEN MTX_SHIFT1 =>
                        mtx_state <= MTX_SHIFT2;
                        mtx_ssel <= mtx_ssel;
                        mtx_re <= '1';
                        CASE mtx_bitsel IS
                            WHEN "00011" =>
                                mtx_datahold <= txfifo_data(2 DOWNTO 0);
                            WHEN "00010" =>
                                mtx_fiforead <= '1';
                                mtx_lastframe <= txfifo_last;
                            WHEN "00001" =>
                                mtx_consecutive <= '0';
                                IF ((NOT(txfifo_empty) AND NOT(mtx_lastframe)) = '1') THEN
                                mtx_consecutive <= '1';
                                END IF;
                            WHEN OTHERS =>
                        END CASE;
                    WHEN MTX_SHIFT2 =>
                        mtx_ssel <= mtx_ssel;
                        mtx_state <= MTX_SHIFT1;
                        -- AS: added to ensure in range for bitsel
                        if (mtx_bitsel <= "00000") then
                            mtx_bitsel <= int2slv(cfg_framesizeM1, 5);
                        else
                            mtx_bitsel <= mtx_bitsel - "00001";
                        end if;
                        
                        mtx_bitcnt <= mtx_bitcnt + "00001";
                        mtx_oen <= '1';
                        mtx_holdsel <= '0';
                        IF ((NSCMODE AND (mtx_bitcnt(3) OR mtx_bitcnt(4))) = '1') THEN
                            mtx_oen <= '0';
                        END IF;
                        CASE mtx_bitsel IS
                            WHEN "00001" =>
                                IF ((mtx_consecutive AND TIMODE) = '1') THEN
                                mtx_ssel <= NOT int2sl(SPH);
                                END IF;
                            WHEN "00000" =>
                                mtx_ssel <= '0';
                                mtx_first <= '0';
                                IF (mtx_lastframe = '1') THEN
                                mtx_state <= MTX_END;
                                mtx_oen <= '0';
                                mtx_alldone <= '1';
                                ELSE
                                IF (mtx_consecutive = '1') THEN
                                    mtx_consecutive <= '0';
                                    IF ((TIMODE OR MOTNOSSEL OR NSCNOSSEL) = '1') THEN
					IF ((NSCMODE = '1') AND (SPH = 0) AND (SPS = 0)) THEN
                                            mtx_oen <= '1';
					END IF;
                                        mtx_bitsel <= int2slv(cfg_framesizeM1, 5);
                                        mtx_state <= MTX_SHIFT1;
                                        mtx_bitcnt <= "00000";
                                        IF ((int2sl(SPS) AND NSCMODE) = '1') THEN
                                            mtx_bitsel <= int2slv(cfg_framesizeM1, 5) - "01001";
                                            mtx_bitcnt <= "01000";
                                        END IF;
                                    ELSE
                                        mtx_state <= MTX_END;
                                        mtx_oen <= MOTMODE;
                                    END IF;
                                ELSE
                                    mtx_state <= MTX_END;
                                    mtx_oen <= '0';
                                    mtx_holdsel <= MOTMODE AND int2sl(SPS);
                                END IF;
                                END IF;
                            WHEN OTHERS =>
                        END CASE;
                    WHEN MTX_END =>
                        mtx_state <= MTX_IDLE2;
                        mtx_pktsel <= mtx_holdsel;
                    WHEN OTHERS =>
                        mtx_state <= MTX_IDLE1;
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;
   
    txfifo_dhold <= (txfifo_data(CFG_FRAME_SIZE - 1 DOWNTO 3) & mtx_datahold);
    PROCESS (pclk, aresetn, cfg_clk_idle1)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            spi_clk_out_xhdl0 <= cfg_clk_idle1;
            spi_ssel_pos <= '1';
            mtx_spi_data_oen <= '0';
            mtx_spi_data_out <= '0';
            mtx_lastbit <= '0';
            mtx_firstrx <= '0';
            mtx_midbit <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                spi_clk_out_xhdl0 <= cfg_clk_idle1;
                spi_ssel_pos <= '1';
                mtx_spi_data_oen <= '0';
                mtx_spi_data_out <= '0';
                mtx_lastbit <= '0';
                mtx_firstrx <= '0';
                mtx_midbit <= '0';
            ELSE
                CASE mtx_state IS
                    WHEN MTX_IDLE1 =>
                    spi_clk_out_xhdl0 <= cfg_clk_idle1;
                    spi_ssel_pos <= NOT(TIMODE OR mtx_holdsel);
                    mtx_spi_data_oen <= mtx_oen;
                    WHEN MTX_IDLE2 =>
                    spi_clk_out_xhdl0 <= cfg_clk_idle2;
                    spi_ssel_pos <= NOT(TIMODE OR mtx_holdsel);
                    mtx_spi_data_oen <= mtx_oen;
                    WHEN MTX_MOTSTART =>
                    spi_clk_out_xhdl0 <= cfg_clk_idle1;
                    spi_ssel_pos <= '0';
                    mtx_spi_data_oen <= '0';
                    WHEN MTX_TISTART1 =>
                    spi_clk_out_xhdl0 <= cfg_clk_ph1;
                    spi_ssel_pos <= '1';
                    mtx_spi_data_oen <= '0';
                    WHEN MTX_TISTART2 =>
                    spi_clk_out_xhdl0 <= cfg_clk_ph2;
                    spi_ssel_pos <= '1';
                    mtx_spi_data_oen <= '1';
                    WHEN MTX_NSCSTART1 =>
                    spi_clk_out_xhdl0 <= cfg_clk_ph1;
                    spi_ssel_pos <= '1';
                    mtx_spi_data_oen <= '0';
                    WHEN MTX_NSCSTART2 =>
                    spi_clk_out_xhdl0 <= cfg_clk_ph2;
                    spi_ssel_pos <= '0';
                    mtx_spi_data_oen <= '1';
                    WHEN MTX_SHIFT1 =>
                    spi_clk_out_xhdl0 <= cfg_clk_ph1;
                    spi_ssel_pos <= (TIMODE AND mtx_ssel);
                    mtx_spi_data_oen <= '1' AND mtx_oen;
                    WHEN MTX_SHIFT2 =>
                    spi_clk_out_xhdl0 <= cfg_clk_ph2;
                    spi_ssel_pos <= ((TIMODE) AND mtx_ssel);
                    mtx_spi_data_oen <= '1' AND mtx_oen;
                    WHEN MTX_END =>
                    spi_clk_out_xhdl0 <= cfg_clk_end1;
                    spi_ssel_pos <= '0';
                    mtx_spi_data_oen <= (MOTMODE) OR (TIMODE);
                    WHEN OTHERS =>
                    spi_clk_out_xhdl0 <= '0';
                    spi_ssel_pos <= '0';
                    mtx_spi_data_oen <= '0';
                END CASE;
                mtx_spi_data_out <= txfifo_dhold(sl2int(mtx_bitsel));
                IF (((NSCMODE) AND (mtx_bitcnt(4) OR mtx_bitcnt(3))) = '1') THEN
                    mtx_spi_data_out <= '0';
                END IF;
                IF(mtx_bitsel = "00000") THEN
                    mtx_lastbit <= '1';
                ELSE 
                    mtx_lastbit <= '0';
                END IF;
                IF (mtx_bitsel = "00010") THEN
                    mtx_midbit <= '1';
                ELSE
                    mtx_midbit <= '0';
                END IF;
                mtx_firstrx <= mtx_first;
            END IF;
        END IF;
    END PROCESS;
   
    tx_alldone <= mtx_alldone OR (cfg_slave AND msrxp_alldone);
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            spi_ssel_neg <= '1';
        ELSIF (pclk'EVENT AND pclk = '0') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                spi_ssel_neg <= '1';
            ELSE
                spi_ssel_neg <= spi_ssel_pos;
            END IF;
        END IF;
    END PROCESS;
   
    spi_ssel_out_xhdl1 <= spi_ssel_neg WHEN (NSCMODE = '1') ELSE
                            spi_ssel_pos;

    -- Modified by mahesh
    ----------------------------------
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            SYNC1_stxs_txready <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                SYNC1_stxs_txready <= '0';
            ELSE    
                SYNC1_stxs_txready <= txfifo_davailable;
            END IF;
        END IF;
    END PROCESS;
    ----------------------------------
    stxs_txready <= txfifo_davailable;
    PROCESS (resetn_rx)
    BEGIN
        IF (resetn_rx'EVENT AND resetn_rx = '1') THEN
            stxs_txready_at_ssel <= txfifo_davailable;
        END IF;
    END PROCESS;
   
    PROCESS (pclk, aresetn_tx)
    BEGIN
        IF ((NOT(aresetn_tx)) = '1') THEN
            stxs_state <= STXS_IDLE;
            stxs_strobetx <= '0';
            stxs_midbit <= '0';
            stxs_direct <= '1';
            stxs_datareg <= (OTHERS =>'0');
            stxs_bitsel <= "00000";
            stxs_bitcnt <= "00000";
            stxs_dataerr <= '0';
            stxs_checkorun <= '0';
            stxs_oen <= '0';
            stxs_first <= '0';
            stxs_txzeros <= '0';
            stxs_pktsel <= '0';
            stxs_lastbit <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN 
            IF ((NOT(sresetn_tx))= '1') THEN -- Sync reset
                stxs_state <= STXS_IDLE;
                stxs_strobetx <= '0';
                stxs_midbit <= '0';
                stxs_direct <= '1';
                stxs_datareg <= (OTHERS =>'0');
                stxs_bitsel <= "00000";
                stxs_bitcnt <= "00000";
                stxs_dataerr <= '0';
                stxs_checkorun <= '0';
                stxs_oen <= '0';
                --stxs_locksw <= '0';
                stxs_first <= '0';
                stxs_txzeros <= '0';
                stxs_pktsel <= '0';
                stxs_lastbit <= '0';
            ELSE
                IF ((stxs_txready_re = '1') AND (stxs_bitcnt = "00000")) THEN-- data now available in tx FIFO and still on first bit
                    stxs_datareg   <= txfifo_data(CFG_FRAME_SIZE - 1 DOWNTO 0); --reload with valid data
                END IF;
                
                IF (clock_rx_fe = '1') THEN
                    stxs_strobetx <= '0';
                    stxs_midbit <= '0';
                    stxs_lastbit <= '0';
                    CASE stxs_state IS
                    WHEN STXS_IDLE =>
                        stxs_bitcnt <= "00000";
                        stxs_datareg <= (txfifo_datadelay(CFG_FRAME_SIZE - 2 DOWNTO 0) & '0');
                        stxs_dataerr <= '0';
                        stxs_checkorun <= NOT(cfg_frameurun);
                        stxs_dataerr <= '0';
                        stxs_first <= '1';
                        stxs_txzeros <= '0';
                        stxs_direct <= '1';
                        stxs_oen <= (TIMODE) AND msrxs_ssel;
                        IF ((cfg_slave = '1' AND cfg_enableON = '1') AND ((MOTMODE = '1' OR NSCMODE = '1') OR (TIMODE = '1' AND msrxs_ssel = '1'))) THEN
                            stxs_state <= STXS_SHIFT;
                            stxs_bitsel <= int2slv(cfg_framesizeM1, 5);
                            stxs_oen <= (NOT(NSCMODE));
                            stxs_pktsel <= '1';
                            IF (MOTMODE = '1' AND NOT(int2sl(SPH)) = '1') THEN
                                stxs_bitsel <= int2slv(cfg_framesizeM1, 5) - "00001";
                                stxs_bitcnt <= "00001";
                                stxs_direct <= '0';
                            END IF;
                        END IF;
                    WHEN STXS_SHIFT =>
                        stxs_bitcnt <= stxs_bitcnt + "00001";
                        stxs_bitsel <= stxs_bitsel - "00001";
                        IF ((NOT(stxs_direct)) = '1') THEN
                            stxs_datareg <= (stxs_datareg(CFG_FRAME_SIZE - 2 DOWNTO 0) & '0');
                        END IF;
                        stxs_direct <= '0';
                        CASE stxs_bitcnt IS
                            WHEN "00001" =>
                                stxs_midbit <= '1';
                                IF (((MOTMODE = '1' AND SPH = 0 AND stxs_first = '1') AND stxs_txready_at_ssel = '1' AND (NOT(stxs_dataerr)) = '1') OR (NOT((MOTMODE = '1' AND SPH = 0 AND stxs_first = '1')) AND stxs_txready = '1' AND (NOT(stxs_dataerr)) = '1')) THEN
                                stxs_strobetx <= '1';
                                stxs_checkorun <= '1';
                                ELSE
                                stxs_dataerr <= stxs_checkorun;
                                stxs_txzeros <= '1';
                                END IF;
                            WHEN "00010" =>
                                stxs_strobetx <= stxs_strobetx;
                            WHEN "00111" =>
                                stxs_oen <= '1';
                            WHEN OTHERS =>
                        END CASE;
                        CASE stxs_bitsel IS
                            WHEN "00001" =>
                                stxs_lastbit <= '1';
                            WHEN "00000" =>
                                stxs_oen <= NOT(NSCMODE);
                                stxs_first <= '0';
                                stxs_direct <= '1';
                                stxs_oen <= '0';
                                IF ((TIMODE = '1' AND msrxs_ssel = '1') OR (MOTMODE = '1' ) OR (NSCMODE = '1')) THEN
                                stxs_bitsel <= int2slv(cfg_framesizeM1, 5);
                                stxs_bitcnt <= "00000";
                                stxs_direct <= '0';
                                stxs_datareg <= txfifo_data(CFG_FRAME_SIZE - 1 DOWNTO 0);
                                stxs_oen <= (TIMODE) AND msrxs_ssel;
                                stxs_pktsel <= '1';
                                ELSE
                                stxs_pktsel <= '0';
                                stxs_state <= STXS_IDLE;
                                stxs_oen <= '0';
                                END IF;
                            WHEN OTHERS =>
                        END CASE;
                    WHEN OTHERS =>
                    END CASE;
                END IF;
            END IF;
        END IF;
    END PROCESS;
   
    PROCESS (stxs_txzeros, stxs_direct, txfifo_datadelay, stxs_datareg, ssel_rx_q2, stxs_oen, cfg_slave, cfg_enableON)
    BEGIN
        IF (stxs_txzeros = '1') THEN
            stxs_spi_data_out <= '0';
        ELSIF (stxs_direct = '1') THEN
            stxs_spi_data_out <= txfifo_datadelay(cfg_framesizeM1);
        ELSE
            stxs_spi_data_out <= stxs_datareg(cfg_framesizeM1);
        END IF;
        CASE CFG_MODE IS
            WHEN 0 =>
                stxs_spi_data_oen <= NOT(ssel_rx_q2);
            WHEN 1 =>
                stxs_spi_data_oen <= stxs_oen;
            WHEN 2 =>
                stxs_spi_data_oen <= (NOT(ssel_rx_q2) AND stxs_oen);
            WHEN OTHERS =>
                stxs_spi_data_oen <= 'X';
        END CASE;
        IF ((NOT(cfg_slave) OR NOT(cfg_enableON)) = '1') THEN
            stxs_spi_data_oen <= '0';
        END IF;
    END PROCESS;
   
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            SYNC1_stxp_strobetx <= '0';
            SYNC1_stxp_dataerr <= '0';
            SYNC2_stxp_strobetx <= '0';
            SYNC2_stxp_dataerr <= '0';
            SYNC3_stxp_strobetx <= '0';
            SYNC3_stxp_dataerr <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                SYNC1_stxp_strobetx <= '0';
                SYNC1_stxp_dataerr <= '0';
                SYNC2_stxp_strobetx <= '0';
                SYNC2_stxp_dataerr <= '0';
                SYNC3_stxp_strobetx <= '0';
                SYNC3_stxp_dataerr <= '0';    
            ELSE
                SYNC1_stxp_strobetx <= stxs_strobetx;
                SYNC1_stxp_dataerr <= stxs_dataerr;
                SYNC2_stxp_strobetx <= SYNC1_stxp_strobetx;
                SYNC2_stxp_dataerr <= SYNC1_stxp_dataerr;
                SYNC3_stxp_strobetx <= SYNC2_stxp_strobetx;
                SYNC3_stxp_dataerr <= SYNC2_stxp_dataerr;
            END IF;
        END IF;
    END PROCESS;
   
    stxp_strobe <= SYNC2_stxp_strobetx AND NOT(SYNC3_stxp_strobetx);
    stxp_fiforead <= stxp_strobe;
    stxp_underrun <= SYNC2_stxp_dataerr AND NOT(SYNC3_stxp_dataerr);
    
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            txfifo_davailable <= '0';
            txfifo_datadelay <= (OTHERS => '0');
            stxp_lastframe <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                txfifo_davailable <= '0';
                txfifo_datadelay <= (OTHERS => '0');
                stxp_lastframe <= '0';
            ELSE
                txfifo_davailable <= NOT(txfifo_empty);
                txfifo_datadelay <= txfifo_data;
                IF (stxp_strobe = '1') THEN
                    stxp_lastframe <= txfifo_last;
                END IF;
                IF ((NOT(cfg_slave)) = '1') THEN
                    stxp_lastframe <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
   
    txfifo_read <= mtx_fiforead WHEN (cfg_master = '1') ELSE
                    stxp_fiforead;
    spi_data_out <= stxs_spi_data_out WHEN (cfg_slave = '1') ELSE
                    mtx_spi_data_out;
    spi_data_oex <= stxs_spi_data_oen WHEN (cfg_slave = '1') ELSE
                    mtx_spi_data_oen;
    spi_data_oen <= spi_data_oex AND NOT(cfg_oenoff);
    busy <= '1' WHEN (mtx_busy = '1' OR mtx_rxbusy = '1' OR (stxs_state /= STXS_IDLE) OR (cfg_master = '1' AND txfifo_empty = '0')) ELSE '0';
    tx_active <= busy;
    tx_underrun <= stxp_underrun;
   
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            msrx_async_reset_ok <= '0';
            stx_async_reset_ok <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                msrx_async_reset_ok <= '0';
                stx_async_reset_ok <= '0';
            ELSE
                msrx_async_reset_ok <= cfg_enable AND (NOT(TIMODE));
                stx_async_reset_ok <= cfg_enable AND (NOT(TIMODE)) AND cfg_slave;
            END IF;
        END IF;
    END PROCESS;
   
   aresetn_tx <= '1' WHEN (SYNC_RESET=1) ELSE resetn_tx;
   sresetn_tx <= resetn_tx WHEN (SYNC_RESET=1) ELSE '1';
   
   resetn_rx <= NOT((NOT(presetn) OR (spi_ssel_mux AND msrx_async_reset_ok)));
   resetn_tx <= NOT((NOT(presetn) OR (ssel_rx_q2 AND stx_async_reset_ok)));
   
   
    UCLKMUX1 : spi_clockmux
        PORT MAP (
            sel     => cfg_master,
            clka    => spi_clk_in,
            clkb    => spi_clk_out_xhdl0,
            clkout  => clock_rx_mux1
        );
    clock_rx_mux2 <= (cfg_clk_cap XOR clock_rx_mux1);
    clock_rx <= clock_rx_mux2;
    
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            clock_rx_q1 <= '0';
            clock_rx_q2 <= '0';
            clock_rx_q3 <= '0';
    
            data_rx_q1 <=  '0';
            data_rx_q2 <=  '0';
    
            ssel_rx_q1 <=  '0';
            ssel_rx_q2 <=  '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                clock_rx_q1 <= '0';
                clock_rx_q2 <= '0';
                clock_rx_q3 <= '0';
        
                data_rx_q1 <=  '0';
                data_rx_q2 <=  '0';
        
                ssel_rx_q1 <=  '0';
                ssel_rx_q2 <=  '0';
            ELSE
                clock_rx_q1 <= clock_rx ;
                clock_rx_q2 <= clock_rx_q1;
                clock_rx_q3 <= clock_rx_q2;
        
                data_rx_q1 <=  spi_data_in;
                data_rx_q2 <=  data_rx_q1;
        
                ssel_rx_q1 <=  spi_ssel_in;
                ssel_rx_q2 <=  ssel_rx_q1;
            END IF;
        END IF; 
    END PROCESS;
   ---------------------------

    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            msrxs_strobe <= '0';
            msrxs_datain <= (OTHERS => '0');
            msrxs_shiftreg <= (OTHERS => '0');
            msrxs_first <= '0';
            msrxs_ssel <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                msrxs_strobe <= '0';
                msrxs_datain <= (OTHERS => '0');
                msrxs_shiftreg <= (OTHERS => '0');
                msrxs_first <= '0';
                msrxs_ssel <= '0';
            ELSE    
                IF (clock_rx_re = '1') THEN
                    msrxs_ssel <= ssel_rx_q2 AND cfg_enableON;
                    msrxs_shiftreg <= (msrxs_shiftreg(CFG_FRAME_SIZE - 3 DOWNTO 0) & spi_di_mux);
                    IF ((stxs_midbit OR mtx_midbit) = '1') THEN
                        msrxs_strobe <= '0';
                    END IF;
                    IF ((TIMODE AND spi_ssel_mux) = '1') THEN
                        msrxs_shiftreg <= (OTHERS => '0');
                    END IF;
                    IF ((stxs_lastbit OR mtx_lastbit) = '1') THEN
                        msrxs_first <= mtx_firstrx OR (cfg_slave AND stxs_first);
                        msrxs_shiftreg <= (OTHERS => '0');
                        msrxs_datain <= (msrxs_shiftreg(CFG_FRAME_SIZE - 2 DOWNTO 0) & spi_di_mux);
                        msrxs_strobe <= '1';
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
   
    msrxs_pktsel <= stxs_pktsel OR mtx_pktsel;
    rxfifo_data <= msrxs_datain;
    rxfifo_first <= msrxs_first;
    
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            SYNC1_msrxp_strobe <= '1';
            SYNC2_msrxp_strobe <= '1';
            SYNC3_msrxp_strobe <= '1';
            SYNC1_msrxp_pktsel <= '0';
            SYNC2_msrxp_pktsel <= '0';
            SYNC3_msrxp_pktsel <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                SYNC1_msrxp_strobe <= '1';
                SYNC2_msrxp_strobe <= '1';
                SYNC3_msrxp_strobe <= '1';
                SYNC1_msrxp_pktsel <= '0';
                SYNC2_msrxp_pktsel <= '0';
                SYNC3_msrxp_pktsel <= '0';
            ELSE    
                SYNC1_msrxp_strobe <= msrxs_strobe;
                SYNC2_msrxp_strobe <= SYNC1_msrxp_strobe;
                SYNC3_msrxp_strobe <= SYNC2_msrxp_strobe;
                SYNC1_msrxp_pktsel <= msrxs_pktsel;
                SYNC2_msrxp_pktsel <= SYNC1_msrxp_pktsel;
                SYNC3_msrxp_pktsel <= SYNC2_msrxp_pktsel;
            END IF;
        END IF;
    END PROCESS;
   
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            msrxp_strobe <= '0';
            msrxp_pktend <= '0';
            msrxp_alldone <= '0';
            rx_alldone <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                msrxp_strobe <= '0';
                msrxp_pktend <= '0';
                msrxp_alldone <= '0';
                rx_alldone <= '0';
            ELSE
                msrxp_strobe <= '0';
                msrxp_pktend <= '0';
                msrxp_alldone <= '0';
                IF ((SYNC2_msrxp_strobe AND NOT(SYNC3_msrxp_strobe)) = '1') THEN
                    msrxp_strobe <= '1';
                    msrxp_alldone <= mtx_lastframe OR stxp_lastframe;
                END IF;
                IF ((NOT(SYNC2_msrxp_pktsel) AND SYNC3_msrxp_pktsel) = '1') THEN
                    msrxp_pktend <= '1';
                END IF;
                rx_alldone <= msrxp_alldone;
            END IF;
        END IF;
    END PROCESS;
   
    rxfifo_write <= msrxp_strobe;
    msrxp_pktsel <= SYNC2_msrxp_pktsel;
    tmp <= msrxp_frames(2 DOWNTO 0) + "001";
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            msrxp_frames <= "000000";
            rx_cmdsize <= '0';
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                msrxp_frames <= "000000";
                rx_cmdsize <= '0';
            ELSE
                rx_cmdsize <= '0';
                
                IF (msrxp_pktsel = '0') THEN
                    msrxp_frames <= "000000";
                ELSIF (msrxp_strobe = '1') THEN
                    msrxp_frames <= ("000" & tmp);
                    IF (tmp = cfg_cmdsize) THEN
                        rx_cmdsize <= '1';
                    ELSE
                        rx_cmdsize <= '0';
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
   
   rx_pktend <= msrxp_pktend;
   queued <= rxfifo_count + txfifo_count;
   
END trans;



