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
-- SPI Top level control.
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

-- ------------------------------------------------------
-- AS:
-- - remove auto fill and auto empty ports/ function
-- - remove frame count and associated signals
-- - remove tx_fifo_
-- ------------------------------------------------------

ENTITY spi_control IS
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
END spi_control;

ARCHITECTURE trans OF spi_control IS
   
   --######################################################################################################
   
   SIGNAL tx_fifo_write_sig    : STD_LOGIC;
   SIGNAL rx_fifo_read_sig     : STD_LOGIC;
   SIGNAL tx_last_frame_sig    : STD_LOGIC;
BEGIN
   
   -- Output assignments.
   tx_fifo_last <= tx_last_frame_sig;
   tx_fifo_data <= wr_data_in;
   tx_fifo_write <= tx_fifo_write_sig;
   rx_fifo_read <= rx_fifo_read_sig; 
   -- Note combinational generation of FIFO read and write signals
   
   PROCESS (penable, psel, paddr, pwrite)
   BEGIN
      --default no read on rx fifo
      rx_fifo_read_sig <= '0';		--default no write on tx fifo
      tx_fifo_write_sig <= '0';		--default not last frame
      tx_last_frame_sig <= '0';
      IF ((penable AND psel) = '1') THEN
         --synthesis parallel_case
         CASE paddr IS		--write to transmit fifo
            WHEN "0001100" =>
               IF (pwrite = '1') THEN
                  tx_fifo_write_sig <= '1';
               END IF;
            WHEN "0001000" =>		--read from receive fifo
               IF ((NOT(pwrite)) = '1') THEN
                  rx_fifo_read_sig <= '1';
               END IF;
            WHEN "0101000" =>		-- aliased transmit data, sets last frame bit
                IF (pwrite = '1') THEN
                    tx_fifo_write_sig <= '1';
                    tx_last_frame_sig <= '1';
                END IF;
            WHEN OTHERS =>
         END CASE;
      END IF;
   END PROCESS;
   
   
END trans;
