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
-- SPI Register file
--
--
-- SVN Revision Information:
-- SVN $Revision: 27727 $
-- SVN $Date: 2016-11-01 18:17:41 +0530 (Tue, 01 Nov 2016) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes:
--
--
-- *********************************************************************/

ENTITY spi_rf IS
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
END spi_rf;

ARCHITECTURE trans OF spi_rf IS
   SIGNAL control1             : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL control2             : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL command              : STD_LOGIC_VECTOR(5 DOWNTO 0);
   SIGNAL int_masked           : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL int_raw              : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL status_byte          : STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL sticky               : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL rdata                : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   
   -- Declare intermediate signals for referenced outputs
   SIGNAL cfg_ssel_xhdl0       : STD_LOGIC_VECTOR(7 DOWNTO 0);

   CONSTANT ZEROS              : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
    -- Drive referenced outputs
    cfg_ssel <= cfg_ssel_xhdl0;
    int_masked <= ((int_raw(7) AND control2(7)) & (int_raw(6) AND control2(6)) & (int_raw(5) AND control2(5)) & (int_raw(4) AND control2(4)) & (int_raw(3) AND control1(5)) & (int_raw(2) AND control1(4)) & ('0') & (int_raw(0) AND control1(3)));
    interrupt <= int_masked(7) OR int_masked(6) OR int_masked(5) OR int_masked(4) OR int_masked(3) OR int_masked(2) OR int_masked(1) OR int_masked(0);
    status_byte <= (tx_active & ssel & int_raw(3) & int_raw(2) & tx_fifo_full & rx_fifo_empty & (sticky(0) AND sticky(1)) & first_frame);
    command <= "000000";
    PROCESS (pclk, aresetn)
    BEGIN
        IF ((NOT(aresetn)) = '1') THEN
            control1 <= "00000000";
            cfg_ssel_xhdl0 <= "00000000";
            control2 <= "00000000";
            clr_rxfifo <= '0';
            clr_txfifo <= '0';
            int_raw <= "10000000";
            sticky <= "00";
        ELSIF (pclk'EVENT AND pclk = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN -- Sync Reset
                control1 <= "00000000";
                cfg_ssel_xhdl0 <= "00000000";
                control2 <= "00000000";
                clr_rxfifo <= '0';
                clr_txfifo <= '0';
                int_raw <= "10000000";
                sticky <= "00";
            ELSE
                clr_rxfifo <= '0';
                clr_txfifo <= '0';
                IF ((psel AND pwrite AND penable) = '1') THEN
                    CASE paddr IS
                        WHEN "0000000" =>
                            control1(7 DOWNTO 0) <= wrdata(7 DOWNTO 0);
                        WHEN "0000100" =>
                            FOR i IN 0 TO 7 LOOP
                                IF ((wrdata(i)) = '1') THEN
                                    int_raw(i) <= '0';
                                END IF;
                            END LOOP;
                        WHEN "0011000" =>
                            control2(7 DOWNTO 0) <= wrdata(7 DOWNTO 0);
                        WHEN "0011100" =>
                            clr_rxfifo <= wrdata(0);
                            clr_txfifo <= wrdata(1);
                        WHEN "0100100" =>
                            cfg_ssel_xhdl0 <= wrdata(7 DOWNTO 0);
                        WHEN OTHERS =>
                    END CASE;
                END IF;
                IF (tx_done = '1') THEN
                    sticky(0) <= '1';
                END IF;
                IF (rx_done = '1') THEN
                    sticky(1) <= '1';
                END IF;
                IF (tx_fifo_write = '1') THEN
                    sticky(0) <= '0';
                END IF;
                IF (rx_fifo_read = '1') THEN
                    sticky(1) <= '0';
                END IF;
                IF (tx_done = '1') THEN
                    int_raw(0) <= '1';
                END IF;
                IF (rx_done = '1') THEN
                    int_raw(1) <= '1';
                END IF;
                IF (rx_channel_overflow = '1') THEN
                    int_raw(2) <= '1';
                END IF;
                IF (tx_channel_underflow = '1') THEN
                    int_raw(3) <= '1';
                END IF;
                IF (rx_cmdsize = '1') THEN
                    int_raw(4) <= '1';
                END IF;
                IF (rx_pktend = '1') THEN
                    int_raw(5) <= '1';
                END IF;
                IF (rx_fifo_empty = '0') THEN
                    int_raw(6) <= '1';
                END IF;
                IF (tx_fifo_full = '0') THEN
                    int_raw(7) <= '1';
                END IF;
                control2(3) <= '0';
            END IF;
        END IF;
    END PROCESS;
   
   cfg_enable <= control1(0);
   cfg_master <= control1(1);
   cfg_frameurun <= control1(6);
   cfg_oenoff <= control1(7);
   cfg_cmdsize <= control2(2 DOWNTO 0);
   
   PROCESS (psel, paddr, control1, int_masked, int_raw, control2, status_byte, cfg_ssel_xhdl0)
   BEGIN
      IF (psel = '1') THEN
         rdata <= ZEROS;
         --synthesis parallel_case
         CASE paddr IS		-- control register 1
            WHEN "0000000" =>		-- write-only
               rdata(7 DOWNTO 0) <= control1(7 DOWNTO 0);
            -- 0x08 assigned elsewhere
            WHEN "0000100" =>		-- write-only
               rdata(7 DOWNTO 0) <= "00000000";
            WHEN "0001100" =>		-- masked interrupt register
               rdata(7 DOWNTO 0) <= "00000000";
            WHEN "0010000" =>		-- raw interrupt register
               rdata(7 DOWNTO 0) <= int_masked(7 DOWNTO 0);
            WHEN "0010100" =>		-- control register 2
               rdata(7 DOWNTO 0) <= int_raw(7 DOWNTO 0);
            WHEN "0011000" =>		-- status register
               rdata(7 DOWNTO 0) <= control2(7 DOWNTO 0);
            WHEN "0100000" =>		-- slave select register
               rdata(7 DOWNTO 0) <= status_byte(7 DOWNTO 0);
            WHEN "0100100" =>
               rdata(7 DOWNTO 0) <= cfg_ssel_xhdl0(7 DOWNTO 0);
            WHEN OTHERS =>
               rdata <= ZEROS;
         END CASE;
      ELSE
         rdata <= ZEROS;
      END IF;
   END PROCESS;
   
   
   prdata <= rdata WHEN ((psel AND penable) = '1') ELSE
             ZEROS;
   
END trans;
