-- ********************************************************************
-- Actel Corporation Proprietary and Confidential
--  Copyright 2008 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description: CoreUART/ CoreUARTapb UART core
--
--
--  Revision Information:
-- Date     Description
-- Jun09    Revision 4.1
-- Aug10    Revision 4.2

-- SVN Revision Information:
-- SVN $Revision: 8508 $
-- SVN $Date: 2009-06-15 16:49:49 -0700 (Mon, 15 Jun 2009) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
-- 20741    2Sep10   AS    Increased baud rate by ensuring fifo ctrl runs off
--                         sys clk (not baud clock).  See note below.

-- Notes:
-- best viewed with tabstops set to "4"
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async IS
   GENERIC ( SYNC_RESET      : integer := 0;
             -- RX Parameters
             RX_FIFO         :  integer := 0);    --  0=without rx fifo, 1=with rx fifo 
   PORT (
      
      clk                     : IN std_logic;   --   system clock
      baud_clock              : IN std_logic;   --   8x baud clock pulse
      reset_n                 : IN std_logic;   --   active low async reset  
      bit8                    : IN std_logic;   --   if set to one 8 data bits otherwise 7 data bits
      parity_en               : IN std_logic;   --   if set to one parity is enabled otherwise disabled
      odd_n_even              : IN std_logic;   --   if set to one odd parity otherwise even parity
      read_rx_byte            : IN std_logic;   --   read rx byte register
      clear_parity            : IN std_logic;   --   clear parity error 
      clear_framing_error     : IN std_logic;   --   clear framing error 
      rx                      : IN std_logic;   
      overflow                : OUT std_logic;   --   receiver overflow
      parity_err              : OUT std_logic;   --   parity error indicator on recieved data
      framing_error           : OUT std_logic;   --   framing error indicator (AS)
      rx_idle_out             : OUT std_logic;   --   used for framing error assignment (AS)
      stop_strobe             : OUT std_logic;   --   stop sync signal for RXRDY
      clear_framing_error_en  : OUT std_logic;   --  clear framing error enable
      clear_parity_en         : OUT std_logic;   --  clear parity error enable
      receive_full            : OUT std_logic;   --   receiver has a byte ready
      rx_byte                 : OUT std_logic_vector(7 DOWNTO 0);   
      fifo_write              : OUT std_logic);   
END ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async;

ARCHITECTURE translated OF SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async IS

   -- TYPE receive_states:
   type receive_states  is (rx_idle, rx_data_bits, rx_stop_bit, rx_wait_state);

   --  receive byte register
   SIGNAL rx_state                 :  receive_states;                -- receive state machine
   SIGNAL receive_count            :  std_logic_vector(3 DOWNTO 0);   --   counts bits received
   SIGNAL rx_filtered              :  std_logic;   --   filtered rx data
   SIGNAL rx_shift                 :  std_logic_vector(8 DOWNTO 0);   --   receive shift register
   SIGNAL rx_parity_calc           :  std_logic;   --   received parity, calculated
   SIGNAL rx_bit_cnt               :  std_logic_vector(3 DOWNTO 0);   --   count of received bits 
   SIGNAL receive_full_int         :  std_logic;   --   receiver has a byte ready
   SIGNAL samples                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL overflow_int             :  std_logic;   
   SIGNAL shift_choice             :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL parity_choice            :  std_logic_vector(1 DOWNTO 0);   
   -- ----------------------------------------------------------------------------
   SIGNAL last_bit                 :  std_logic_vector(3 DOWNTO 0);   
   -- ----------------------------------------------------------------------------
   --  receive state machine & byte register
   -- ----------------------------------------------------------------------------
   SIGNAL overflow_xhdl1           :  std_logic;   
   SIGNAL parity_err_xhdl2         :  std_logic;   
   SIGNAL framing_error_i          :  std_logic;
   SIGNAL framing_error_int        :  std_logic;
   SIGNAL stop_strobe_i            :  std_logic;
   SIGNAL clear_parity_en_xhdl3    :  std_logic;   
   SIGNAL clear_framing_error_en_i :  std_logic; -- AS: Added 07-29-09
   SIGNAL receive_full_xhdl4       :  std_logic;   
   SIGNAL rx_byte_xhdl5            :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL last_bit_case            :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL fifo_write_xhdl6         :  std_logic;   
   SIGNAL aresetn                  :  std_logic;
   SIGNAL sresetn                  :  std_logic;

BEGIN
   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE reset_n;
   sresetn <= reset_n WHEN (SYNC_RESET=1) ELSE '1';
   stop_strobe <= stop_strobe_i;
   framing_error <= framing_error_i;
   overflow <= overflow_xhdl1;
   parity_err <= parity_err_xhdl2;
   clear_parity_en <= clear_parity_en_xhdl3;
   receive_full <= receive_full_xhdl4;
   rx_byte <= rx_byte_xhdl5;
   fifo_write <= fifo_write_xhdl6;
   rx_idle_out <= '1' when (rx_state = rx_idle) else '0';
   clear_framing_error_en <= clear_framing_error_en_i;
   last_bit_case <= bit8 & parity_en; 
   
   --  filter the receive data
   -- ----------------------------------------------------------------------------
   --  The receive data filter is a simple majority voter that accepts three
   --  samples of the "raw" data and reports the most populus result.  This
   --  provides a simple single-cycle glitch filter.
   --  This input needs to go to both the state machine start bit detector as
   --  well as the data shift register as this filter introduces a three-clock 
   --  delay and we need to keep the phases lined up.
   -- 
   
   majority : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         samples <= "111";    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            samples <= "111";    
	     ELSE
            IF (baud_clock = '1') THEN
               samples(1 DOWNTO 0) <= samples(2 DOWNTO 1);    
               samples(2) <= rx;    
            END IF;
         END IF;
      END IF;
   END PROCESS majority;

   --  our voter
   
   PROCESS (samples)
   BEGIN
      CASE samples IS
         WHEN "000" =>
                  rx_filtered <= '0';    
         WHEN "001" =>
                  rx_filtered <= '0';    
         WHEN "010" =>
                  rx_filtered <= '0';    
         WHEN "011" =>
                  rx_filtered <= '1';    
         WHEN "100" =>
                  rx_filtered <= '0';    
         WHEN "101" =>
                  rx_filtered <= '1';    
         WHEN "110" =>
                  rx_filtered <= '1';    
         WHEN OTHERS  =>
                  rx_filtered <= '1';    
         
      END CASE;
   END PROCESS;

   -- ----------------------------------------------------------------------------
   --  receive bit counter
   -- ----------------------------------------------------------------------------
   
   rcv_cnt : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         receive_count <= "0000";    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            receive_count <= "0000";  
	     ELSE
            IF (baud_clock = '1') THEN
               --  no start bit yet or begin sample period for data
               
               IF ((baud_clock = '1' AND rx_state = rx_idle AND (rx_filtered = '1' OR receive_count = "1000")) OR (rx_state = rx_wait_state AND (receive_count = "0110"))) THEN
                  receive_count <= "0000";    
               ELSE
                  receive_count <= receive_count + "0001";    
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS rcv_cnt;

   -- ----------------------------------------------------------------------------
   --  registering of the overflow signal
   -- ----------------------------------------------------------------------------
   
   make_overflow : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         overflow_xhdl1 <= '0';    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            overflow_xhdl1 <= '0'; 
	     ELSE
            IF (baud_clock = '1') THEN
               IF (overflow_int = '1') THEN
                  overflow_xhdl1 <= '1';    
               END IF;
            END IF;
            IF (read_rx_byte = '1') THEN
               overflow_xhdl1 <= '0';    
            END IF;
         END IF;
      END IF;
   END PROCESS make_overflow;

   -- ----------------------------------------------------------------------------
   --  registering of the framing_error signal
   -- ----------------------------------------------------------------------------
   
   make_framing_error : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         framing_error_i <= '0';    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            framing_error_i <= '0'; 
	     ELSE
            IF (baud_clock = '1') THEN
               IF (framing_error_int = '1') THEN
                  framing_error_i <= '1';
               ELSIF (clear_framing_error = '1') THEN
                   framing_error_i <= '0';
               END IF;
            ELSIF (clear_framing_error = '1') THEN
               framing_error_i <= '0';
            ELSE
               framing_error_i <= framing_error_i;
            END IF;
         END IF;
      END IF;
   END PROCESS make_framing_error;

   make_last_bit : PROCESS (clk, aresetn)
   BEGIN
       IF(aresetn = '0') THEN
           last_bit <= "1001"; 
       ELSIF (clk'EVENT AND clk = '1') THEN
           IF(sresetn = '0') THEN
               last_bit <= "1001"; 
	       ELSE
               IF((baud_clock = '1') AND (rx_state = rx_idle) AND (receive_count = "1000")) THEN
                   CASE(last_bit_case) IS
                     WHEN "00" => last_bit <= "0111"; 
                     WHEN "01" => last_bit <= "1000";
                     WHEN "10" => last_bit <= "1000";
                     WHEN "11" => last_bit <= "1001";
                     WHEN OTHERS => last_bit <= "1001";
                   END CASE;
               ELSE
                   last_bit <= last_bit;
               END IF;
           END IF;
       END IF;
   END PROCESS; 

   rcv_sm : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         rx_state <= rx_idle;
         rx_byte_xhdl5 <= "00000000";    
         overflow_int <= '0';
         framing_error_int <= '0';
         stop_strobe_i <= '0';
      ELSIF (clk'EVENT AND clk = '1') THEN
          IF (sresetn = '0') THEN
             rx_state <= rx_idle;
             rx_byte_xhdl5 <= "00000000";    
             overflow_int <= '0';
             framing_error_int <= '0';
             stop_strobe_i <= '0';
	      ELSE
             IF (baud_clock = '1') THEN
                overflow_int <= '0';  
                framing_error_int <= '0';
                stop_strobe_i <= '0';
                CASE rx_state IS
                   WHEN rx_idle =>
                            IF (receive_count = "1000") THEN
                               rx_state <= rx_data_bits;
                            ELSE
                               rx_state <= rx_idle;
                            END IF;
                   WHEN rx_data_bits =>
                            IF (rx_bit_cnt = last_bit) THEN
                               --  last bit has been received
                               --  if receive_full is still active at this point, then overflow     
                               rx_state <= rx_stop_bit ;  
                               overflow_int <= receive_full_int;    
                               IF (receive_full_int = '0') THEN
                                  rx_byte_xhdl5 <= (bit8 AND rx_shift(7)) & rx_shift(6 DOWNTO 0);    
                               END IF;
                            ELSE
                               rx_state <= rx_data_bits;    --   still clocking in bits
                            END IF;
                   WHEN rx_stop_bit =>
                            IF (receive_count = "1110") THEN
                               IF (rx_filtered = '0') THEN
                                  framing_error_int <= '1';
                                END IF;
                            ELSIF (receive_count = "1111") THEN
                               stop_strobe_i <= '1';
                               rx_state <=  rx_wait_state; 
                            ELSE
                               rx_state <= rx_stop_bit;    
                            END IF;
                   WHEN rx_wait_state =>
                            IF ((rx_filtered = '1') OR (receive_count = "0110")) THEN
		    				    rx_state <=  rx_idle; 
		    				ELSE
		    				    rx_state <=  rx_wait_state; 
		    				END IF;
                   WHEN OTHERS  =>
                            rx_state <=  rx_idle;    
                   
                END CASE;
             END IF;
          END IF;
      END IF;
   END PROCESS rcv_sm;
   -- ----------------------------------------------------------------------------
   --  receive shift register and parity calculation
   -- ----------------------------------------------------------------------------
   shift_choice <= bit8 & parity_en ;

   receive_shift : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         rx_shift(8 DOWNTO 0) <= "000000000";    
         rx_bit_cnt <= "0000";    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            rx_shift(8 DOWNTO 0) <= "000000000";    
            rx_bit_cnt <= "0000";   
	     ELSE
            IF (baud_clock = '1') THEN
               IF (rx_state = rx_idle) THEN
                  rx_shift(8 DOWNTO 0) <= "000000000";    
                  rx_bit_cnt <= "0000";    
               ELSE
                  IF (receive_count = "1111") THEN
                     --  sample new data bit
                     
                     rx_bit_cnt <= rx_bit_cnt + "0001";    
                     CASE shift_choice IS
                        WHEN "00" =>
                                 rx_shift(5 DOWNTO 0) <= rx_shift(6 DOWNTO 1);    
                                 rx_shift(6) <= rx_filtered;    
                        WHEN "11" =>
                                 rx_shift(7 DOWNTO 0) <= rx_shift(8 DOWNTO 1);    
                                 rx_shift(8) <= rx_filtered;    
                        WHEN OTHERS  =>
                                 rx_shift(6 DOWNTO 0) <= rx_shift(7 DOWNTO 1);    
                                 rx_shift(7) <= rx_filtered;    
                        
                     END CASE;
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS receive_shift;

   -- ----------------------------------------------------------------------------
   --  receiver parity calculation
   -- ----------------------------------------------------------------------------
   
   rx_par_calc : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         rx_parity_calc <= '0';    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            rx_parity_calc <= '0';    
	     ELSE
            IF (baud_clock = '1') THEN
               IF (receive_count = "1111" AND parity_en = '1') THEN
                  rx_parity_calc <= rx_parity_calc XOR rx_filtered;    
               END IF;
               IF ((rx_state =  rx_stop_bit)) THEN
                  rx_parity_calc <= '0';    
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS rx_par_calc;
   -- ----------------------------------------------------------------------------
   --  latch parity error for even or odd parity
   -- ----------------------------------------------------------------------------
   parity_choice <= bit8 & odd_n_even ;

   make_parity_err : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         parity_err_xhdl2 <= '0';    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            parity_err_xhdl2 <= '0';  
	     ELSE
            IF ((baud_clock = '1' AND parity_en = '1') AND receive_count = "1111") THEN
               CASE parity_choice IS
                  WHEN "00" =>
                           IF (rx_bit_cnt = "0111") THEN
                              parity_err_xhdl2 <= rx_parity_calc XOR rx_filtered;    
                           END IF;
                  WHEN "01" =>
                           IF (rx_bit_cnt = "0111") THEN
                              parity_err_xhdl2 <= NOT (rx_parity_calc XOR rx_filtered);    
                           END IF;
                  WHEN "10" =>
                           IF (rx_bit_cnt = "1000") THEN
                              parity_err_xhdl2 <= rx_parity_calc XOR rx_filtered;    
                           END IF;
                  WHEN "11" =>
                           IF (rx_bit_cnt = "1000") THEN
                              parity_err_xhdl2 <= NOT (rx_parity_calc XOR rx_filtered);    
                           END IF;
                  WHEN OTHERS  =>
                           parity_err_xhdl2 <= '0';    
                  
               END CASE;
            END IF;
            -- if (read_rx_byte == 1'b1)
            
            IF (clear_parity = '1') THEN
               parity_err_xhdl2 <= '0';    
            END IF;
         END IF;
      END IF;
   END PROCESS make_parity_err;

   -- ----------------------------------------------------------------------------
   --  receive full indicator process
   -- ----------------------------------------------------------------------------
   
   receive_full_indicator : PROCESS (clk, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         receive_full_int <= '0';    
         fifo_write_xhdl6 <= '1';    
         clear_parity_en_xhdl3 <= '0';    
         clear_framing_error_en_i <= '0';
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (sresetn = '0') THEN
            receive_full_int <= '0';    
            fifo_write_xhdl6 <= '1';    
            clear_parity_en_xhdl3 <= '0';    
            clear_framing_error_en_i <= '0';
	     ELSE
            fifo_write_xhdl6 <= '1';    
            clear_parity_en_xhdl3 <= '0';  
            clear_framing_error_en_i <= '0';
            IF (baud_clock = '1') THEN
               --  last bit has been received 
               
               IF (bit8 = '1') THEN
                  IF (parity_en = '1') THEN
                     IF (rx_bit_cnt = "1001" AND rx_state = rx_data_bits) THEN
                        fifo_write_xhdl6 <= '0';    
                        clear_parity_en_xhdl3 <= '1';    
                        clear_framing_error_en_i <= '1';
                        IF (RX_FIFO = 2#0#) THEN
                           receive_full_int <= '1';    
                        END IF;
                     END IF;
                  ELSE
                     IF (rx_bit_cnt = "1000" AND rx_state = rx_data_bits) THEN
                        fifo_write_xhdl6 <= '0';    
                        clear_parity_en_xhdl3 <= '1';
                        clear_framing_error_en_i <= '1';
                        IF (RX_FIFO = 2#0#) THEN
                           receive_full_int <= '1';    
                        END IF;
                     END IF;
                  END IF;
               ELSE
                  IF (parity_en = '1') THEN
                     IF (rx_bit_cnt = "1000" AND rx_state = rx_data_bits) THEN
                        fifo_write_xhdl6 <= '0';    
                        clear_parity_en_xhdl3 <= '1';
                        clear_framing_error_en_i <= '1';
                        IF (RX_FIFO = 2#0#) THEN
                           receive_full_int <= '1';    
                        END IF;
                     END IF;
                  ELSE
                     IF (rx_bit_cnt = "0111" AND rx_state = rx_data_bits) THEN
                        fifo_write_xhdl6 <= '0';    
                        clear_parity_en_xhdl3 <= '1';
                        clear_framing_error_en_i <= '1';
                        IF (RX_FIFO = 2#0#) THEN
                           receive_full_int <= '1';    
                        END IF;
                     END IF;
                  END IF;
               END IF;
            END IF;
            IF (read_rx_byte = '1') THEN
               receive_full_int <= '0';    
            END IF;
         END IF;
      END IF;
   END PROCESS receive_full_indicator;
   receive_full_xhdl4 <= receive_full_int ;

END ARCHITECTURE translated;
