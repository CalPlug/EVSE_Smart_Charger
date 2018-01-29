-- ********************************************************************
-- Actel Corporation Proprietary and Confidential
--  Copyright 2008 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description: SF2_MSS_sys_sb_CoreUARTapb_0_COREUART/ CoreUARTapb UART core
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
use work.SF2_MSS_sys_sb_CoreUARTapb_0_coreuart_pkg.all;

ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_COREUART IS
   GENERIC (
      FAMILY                         :  INTEGER := 15;    -- DEVICE FAMILY
      -- TX PARAMETERS
      TX_FIFO                        :  INTEGER := 0;     -- 0=WITHOUT TX FIFO, 1=WITH TX FIFO
      -- RX PARAMETERS
      RX_FIFO                        :  INTEGER := 0;     -- 0=WITHOUT RX FIFO, 1=WITH RX FIFO
      RX_LEGACY_MODE                 :  INTEGER := 0;
      --BAUD FRACTION PARAMETER
      BAUD_VAL_FRCTN_EN              :  INTEGER := 0     -- 0=DISABLE BAUD FRACTION, 1=ENABLE BAUD FRACTION
      );
   PORT (
      RESET_N                 : IN STD_LOGIC;
      CLK                     : IN STD_LOGIC;
      WEN                     : IN STD_LOGIC;
      OEN                     : IN STD_LOGIC;
      CSN                     : IN STD_LOGIC;
      DATA_IN                 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      RX                      : IN STD_LOGIC;
      BAUD_VAL                : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
      BIT8                    : IN STD_LOGIC;   --   IF SET TO ONE 8 DATA BITS OTHERWISE 7 DATA BITS
      PARITY_EN               : IN STD_LOGIC;   --   IF SET TO ONE PARITY IS ENABLED OTHERWISE DISABLED
      ODD_N_EVEN              : IN STD_LOGIC;   --   IF SET TO ONE ODD PARITY OTHERWISE EVEN PARITY
      BAUD_VAL_FRACTION       : IN STD_LOGIC_VECTOR(2 DOWNTO 0);  --USED TO ADD EXTRA PRECISION TO BAUD VALUE WHEN BAUD_VAL_FRCTN_EN = 1
      PARITY_ERR              : OUT STD_LOGIC;   --   PARITY ERROR INDICATOR ON RECIEVED DATA
      OVERFLOW                : OUT STD_LOGIC;   --   RECEIVER OVERFLOW
      TXRDY                   : OUT STD_LOGIC;   --   TRANSMIT READY FOR ANOTHER BYTE
      RXRDY                   : OUT STD_LOGIC;   --   RECEIVER HAS A BYTE READY
      DATA_OUT                : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      TX                      : OUT STD_LOGIC;
      FRAMING_ERR             : OUT STD_LOGIC);
END ENTITY SF2_MSS_sys_sb_CoreUARTapb_0_COREUART;

ARCHITECTURE translated OF SF2_MSS_sys_sb_CoreUARTapb_0_COREUART IS

   -- State name constant definitions
   CONSTANT S0  : std_logic_vector(1 DOWNTO 0) := "00";
   CONSTANT S1  : std_logic_vector(1 DOWNTO 0) := "01";
   CONSTANT S2  : std_logic_vector(1 DOWNTO 0) := "10";
   CONSTANT S3  : std_logic_vector(1 DOWNTO 0) := "11";
   
  -- Sync/Async Mode Select
  CONSTANT SYNC_RESET : INTEGER := SYNC_MODE_SEL(FAMILY);

   --  Configuration bits
   --  Status bits
   SIGNAL overflow_legacy          :  std_logic;
   SIGNAL receive_full             :  std_logic;
   SIGNAL fifo_write_rx            :  std_logic;
   SIGNAL fifo_write               :  std_logic;
   SIGNAL xmit_pulse               :  std_logic;   --   transmit pulse
   SIGNAL baud_clock               :  std_logic;   --   8x baud clock pulse
   SIGNAL rst_tx_empty             :  std_logic;   --   reset transmit empty
   SIGNAL tx_hold_reg              :  std_logic_vector(7 DOWNTO 0);   --   transmit byte hold register
   SIGNAL tx_dout_reg              :  std_logic_vector(7 DOWNTO 0);   --   transmit byte hold register
   SIGNAL rx_dout                  :  std_logic_vector(7 DOWNTO 0);   --   receive data out
   SIGNAL read_rx_byte             :  std_logic;   --   read rx byte register
   SIGNAL rx_dout_reg              :  std_logic_vector(7 DOWNTO 0);   --   receive data out
   SIGNAL rx_byte                  :  std_logic_vector(7 DOWNTO 0);   --   receive byte register
   SIGNAL rx_byte_in               :  std_logic_vector(7 DOWNTO 0);   --   receive byte register
   SIGNAL fifo_empty_tx            :  std_logic;
   SIGNAL fifo_empty_rx            :  std_logic;
   SIGNAL fifo_read_rx             :  std_logic;
   SIGNAL fifo_write_tx            :  std_logic;
   SIGNAL fifo_read_tx             :  std_logic;
   SIGNAL fifo_full_tx             :  std_logic;
   SIGNAL fifo_full_rx             :  std_logic;
   SIGNAL clear_parity             :  std_logic;
   SIGNAL clear_parity_en          :  std_logic;
   SIGNAL clear_parity_reg0        :  std_logic;
   SIGNAL clear_parity_reg         :  std_logic;
   SIGNAL data_en                  :  std_logic;
   SIGNAL stop_strobe              :  std_logic;
   SIGNAL clear_framing_error      :  std_logic;
   -- AS: added framing error self-clear mechanism (RX FIFO mode)
   SIGNAL clear_framing_error_en   :  std_logic;
   SIGNAL clear_framing_error_reg0 :  std_logic;
   SIGNAL clear_framing_error_reg  :  std_logic;
   signal rx_idle                  :  std_logic;    -- AS: Added this signal for proper framing_error sync
   SIGNAL framing_err_i            :  std_logic;    -- AS: Internal framing error, for reading
   -- AS: Added changed overflow operation (new signals required - see below)
   SIGNAL overflow_reg             :  std_logic;
   SIGNAL clear_overflow           :  std_logic;
   -- ----------------------------------------------------------------------------
   --  cpu reads from UART registers
   -- ----------------------------------------------------------------------------
   SIGNAL temp_xhdl7               :  std_logic;
   SIGNAL temp_xhdl10              :  std_logic;
   SIGNAL temp_xhdl11              :  std_logic;
   SIGNAL temp_xhdl12              :  std_logic;
   SIGNAL temp_xhdl13              :  std_logic;
   SIGNAL temp_xhdl14              :  std_logic_vector(7 DOWNTO 0);
   SIGNAL temp_xhdl16              :  std_logic;
   SIGNAL temp_xhdl17              :  std_logic;
   SIGNAL parity_err_xhdl1         :  std_logic;
   SIGNAL overflow_xhdl2           :  std_logic;
   SIGNAL txrdy_xhdl3              :  std_logic;
   SIGNAL rxrdy_xhdl4              :  std_logic;
   SIGNAL data_out_xhdl5           :  std_logic_vector(7 DOWNTO 0);
   SIGNAL tx_xhdl6                 :  std_logic;

   SIGNAL rx_dout_reg_empty        :  std_logic;
   SIGNAL rx_state                 :  std_logic_vector(1 DOWNTO 0);
   SIGNAL next_rx_state            :  std_logic_vector(1 DOWNTO 0);
   SIGNAL aresetn  : std_logic;
   SIGNAL sresetn  : std_logic;
   
   COMPONENT SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async
      GENERIC (
         -- RX Parameters
         RX_FIFO    :  integer := 0;  --  0=without rx fifo   
		 SYNC_RESET :  integer := 0);    
      PORT (
         clk                     : IN  std_logic;
         baud_clock              : IN  std_logic;
         reset_n                 : IN  std_logic;
         bit8                    : IN  std_logic;
         parity_en               : IN  std_logic;
         odd_n_even              : IN  std_logic;
         read_rx_byte            : IN  std_logic;
         clear_parity            : IN  std_logic;
         clear_framing_error     : IN  std_logic;
         rx                      : IN  std_logic;
         overflow                : OUT std_logic;
         parity_err              : OUT std_logic;
         framing_error           : OUT std_logic;
         rx_idle_out             : OUT std_logic;       -- AS: added this signal to sync framing error properly
         stop_strobe             : OUT std_logic;
         clear_parity_en         : OUT std_logic;
         clear_framing_error_en  : OUT std_logic;
         receive_full            : OUT std_logic;
         rx_byte                 : OUT std_logic_vector(7 DOWNTO 0);
         fifo_write              : OUT std_logic
    );
   END COMPONENT;


   COMPONENT SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async
      GENERIC (
         -- TX Parameters
         TX_FIFO    :  integer := 0;    --  0=without tx fifo
		 SYNC_RESET :  integer := 0);
      PORT (
         clk                     : IN  std_logic;
         xmit_pulse              : IN  std_logic;
         reset_n                 : IN  std_logic;
         rst_tx_empty            : IN  std_logic;
         tx_hold_reg             : IN  std_logic_vector(7 DOWNTO 0);
         tx_dout_reg             : IN  std_logic_vector(7 DOWNTO 0);
         fifo_empty              : IN  std_logic;
         fifo_full               : IN  std_logic;
         bit8                    : IN  std_logic;
         parity_en               : IN  std_logic;
         odd_n_even              : IN  std_logic;
         txrdy                   : OUT std_logic;
         tx                      : OUT std_logic;
         fifo_read_tx            : OUT std_logic);
   END COMPONENT;


   COMPONENT SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen  
      GENERIC( 
        --BAUD FRACTION Parameter
        BAUD_VAL_FRCTN_EN              :  integer := 0; -- 0=disable baud fraction  
		SYNC_RESET                     :  integer := 0); 
      port (
             clk                : in   std_logic;                      -- system clock
             reset_n            : in   std_logic;                      -- active low async reset
             baud_val           : in   std_logic_vector(12 downto 0);  -- value loaded into cntr
             BAUD_VAL_FRACTION  : in   std_logic_vector(2 downto 0);   -- handles fractional part of baud value 
 
             baud_clock         : out  std_logic;                      -- 8x baud clock pulse
             xmit_pulse         : out  std_logic                       -- transmit pulse
            );
   END COMPONENT;

   COMPONENT SF2_MSS_sys_sb_CoreUARTapb_0_fifo_256x8 IS     
   GENERIC ( SYNC_RESET :  integer := 0);
    PORT (
      DO                      : OUT std_logic_vector(7 DOWNTO 0);
      RCLOCK                  : IN std_logic;
      WCLOCK                  : IN std_logic;
      DI                      : IN std_logic_vector(7 DOWNTO 0);
      WRB                     : IN std_logic;
      RDB                     : IN std_logic;
      RESET                   : IN std_logic;
      FULL                    : OUT std_logic;
      EMPTY                   : OUT std_logic);
   END COMPONENT;
   
BEGIN
   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE RESET_N;
   sresetn <= RESET_N WHEN (SYNC_RESET=1) ELSE '1';
   FRAMING_ERR <= framing_err_i;
   PARITY_ERR <= parity_err_xhdl1;
   OVERFLOW <= overflow_xhdl2;
   TXRDY <= txrdy_xhdl3;
   RXRDY <= rxrdy_xhdl4;
   DATA_OUT <= data_out_xhdl5;
   TX <= tx_xhdl6;


   -- ---------------------------------------------------------
   --  COMPONENT DECLARATIONS
   -- ---------------------------------------------------------
   -- ----------------------------------------------------------------------------
   --  cpu writes to UART registers
   -- ----------------------------------------------------------------------------

   reg_write : PROCESS (CLK, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         tx_hold_reg <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
         fifo_write_tx <= '1';
      ELSIF (CLK'EVENT AND CLK = '1') THEN
          IF (sresetn = '0') THEN
             tx_hold_reg <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
             fifo_write_tx <= '1';
          ELSE
             fifo_write_tx <= '1';
             IF (csn = '0' AND WEn = '0') THEN
                tx_hold_reg <= DATA_IN;
                fifo_write_tx <= '0';
             END IF;
          END IF;
      END IF;
   END PROCESS reg_write;
   temp_xhdl7 <= '1' WHEN (WEn = '0' AND csn = '0') ELSE '0';
   rst_tx_empty <= temp_xhdl7 ;


   PROCESS (rx_byte, rx_dout_reg, parity_err_xhdl1)
   VARIABLE data_out_xhdl5_xhdl8  : std_logic_vector(7 DOWNTO 0);
   BEGIN
       IF (RX_FIFO = 2#0#) THEN
           data_out_xhdl5_xhdl8 := rx_byte;
       ELSE
           IF (parity_err_xhdl1 = '1') THEN
               data_out_xhdl5_xhdl8 := rx_byte;
           ELSE
               data_out_xhdl5_xhdl8 := rx_dout_reg;
           END IF;
       END IF;
       data_out_xhdl5 <= data_out_xhdl5_xhdl8;
   END PROCESS;


   temp_xhdl10 <= '1' WHEN (csn = '0' AND OEn = '0') ELSE '0';
   temp_xhdl11 <= (temp_xhdl10) WHEN (RX_FIFO = 2#0#) ELSE NOT fifo_full_rx;
   read_rx_byte <= temp_xhdl11 ;
   temp_xhdl12 <= '1' WHEN (csn = '0' AND OEn = '0') ELSE '0';
   temp_xhdl13 <= clear_parity_reg WHEN RX_FIFO /= 0 ELSE (temp_xhdl12);
   clear_parity <= temp_xhdl13 ;
   temp_xhdl14 <= rx_byte WHEN (parity_err_xhdl1 = '0') ELSE "00000000";
   rx_byte_in <= temp_xhdl14 ;
   --clear_framing_error <= clear_framing_error_reg WHEN RX_FIFO /= 0 ELSE (temp_xhdl12);
   clear_framing_error <= temp_xhdl12 WHEN (RX_FIFO = 0) ELSE '1' WHEN (temp_xhdl12 = '1') ELSE clear_framing_error_reg;
   clear_overflow <= '1' WHEN (csn = '0' AND OEn = '0') ELSE '0';


   RXRDY_LEGACY: IF (RX_LEGACY_MODE = 1) GENERATE
     PROCESS (receive_full, rx_dout_reg_empty)
       VARIABLE rxrdy_xhdl4_xhdl15  : std_logic;
     BEGIN
       IF (RX_FIFO = 2#0#) THEN
         rxrdy_xhdl4_xhdl15 := receive_full;
       ELSE
         rxrdy_xhdl4_xhdl15 := NOT rx_dout_reg_empty;
       END IF;
       rxrdy_xhdl4 <= rxrdy_xhdl4_xhdl15;
     END PROCESS;
   END GENERATE;

   -- AS, added 11/17/08
   RXRDY_NEW: IF (RX_LEGACY_MODE = 0) GENERATE
    PROCESS (CLK, aresetn)
    BEGIN
      IF (aresetn = '0') THEN
        rxrdy_xhdl4 <= '0';
      ELSIF (clk'EVENT AND clk = '1') THEN
        IF (sresetn = '0') THEN
          rxrdy_xhdl4 <= '0';
	    ELSE
          IF (RX_FIFO = 0) THEN
            IF (stop_strobe = '1' OR receive_full = '0') THEN
              rxrdy_xhdl4 <= receive_full;
            END IF;
          ELSE
		    IF (stop_strobe = '1' OR rx_dout_reg_empty = '1' or (rx_dout_reg_empty = '0' and (rx_idle = '1' or RX_FIFO = 1))) THEN
              rxrdy_xhdl4 <= NOT rx_dout_reg_empty;
            END IF;
          END IF;
        END IF;
      END IF;
    END PROCESS;
   END GENERATE;

   PROCESS (CLK, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         clear_parity_reg <= '0';
         clear_parity_reg0 <= '0';
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (sresetn = '0') THEN
            clear_parity_reg <= '0';
            clear_parity_reg0 <= '0';
	     ELSE
            clear_parity_reg0 <= clear_parity_en;
            clear_parity_reg <= clear_parity_reg0;
         END IF;
      END IF;
   END PROCESS;

   -- AS: added self-clearing framing error
   PROCESS (CLK, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         clear_framing_error_reg <= '0';
         clear_framing_error_reg0 <= '0';
      ELSIF (CLK'EVENT AND CLK = '1') THEN
          IF (sresetn = '0') THEN
             clear_framing_error_reg <= '0';
             clear_framing_error_reg0 <= '0';
	      ELSE
             clear_framing_error_reg0 <= clear_framing_error_en;
             clear_framing_error_reg <= clear_framing_error_reg0;
          END IF;
      END IF;
   END PROCESS;

   -- state machine to control reading from the rx fifo
   PROCESS (CLK, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         rx_state <= S0;
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (sresetn = '0') THEN
            rx_state <= S0;
	     ELSE
            rx_state <= next_rx_state;
         END IF;
      END IF;
   END PROCESS;

   PROCESS (rx_state, rx_dout_reg_empty, fifo_empty_rx)
   BEGIN
      next_rx_state <= rx_state;
      fifo_read_rx <= '1';
      data_en <= '0';
      CASE rx_state IS
         WHEN S0 => IF (rx_dout_reg_empty = '1' AND fifo_empty_rx = '0') THEN
							next_rx_state <= S1;
							fifo_read_rx <= '0';
                    END IF;
         WHEN S1 => next_rx_state <= S2;
         WHEN S2 => next_rx_state <= S3;
         WHEN S3 => next_rx_state <= S0;
                    data_en <= '1';
         WHEN others => next_rx_state <= rx_state;
      END CASE;
   END PROCESS;


   PROCESS (CLK, aresetn)
   BEGIN
      IF (aresetn = '0') THEN
         rx_dout_reg <= "00000000";
      ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (sresetn = '0') THEN
            rx_dout_reg <= "00000000";
	     ELSE
            IF (data_en = '1') THEN
                rx_dout_reg <= rx_dout;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   PROCESS (CLK, aresetn)
   BEGIN
       IF (aresetn = '0') THEN
           rx_dout_reg_empty <= '1';
       ELSIF (CLK'EVENT AND CLK = '1') THEN
           IF (sresetn = '0') THEN
               rx_dout_reg_empty <= '1';
	       ELSE
               IF (data_en = '1') THEN
                   rx_dout_reg_empty <= '0';
               ELSE
                   IF (csn = '0' AND OEn = '0') THEN
		    	       IF (RX_FIFO = 1) THEN
		    	           IF(parity_err_xhdl1 = '0') THEN
		    	               rx_dout_reg_empty <= '1';
		    	           END IF;
		    		   ELSE
		    	           rx_dout_reg_empty <= '1';
		    		   END IF;
                   END IF;
               END IF;
           END IF;
       END IF;
   END PROCESS;

   PROCESS (CLK, aresetn)
   BEGIN
       IF (aresetn = '0') THEN
         overflow_reg <= '0';
       ELSIF (CLK'EVENT AND CLK = '1') THEN
         IF (sresetn = '0') THEN
           overflow_reg <= '0';
	     ELSE
           IF (fifo_write = '0' AND fifo_full_rx = '1') THEN
             overflow_reg <= '1';
           ELSIF (clear_overflow = '1') THEN
             overflow_reg <= '0';
           ELSE
             overflow_reg <= overflow_reg;
           END IF;
         END IF;
       END IF;
   END PROCESS;
-- AS: Changed OVERFLOW condition
--     - We should not be assigning OVERFLOW to FIFO_FULL;
--       instead, we should be asserting OVERFLOW if a write is
--       requested while fifo_full_rx is high
   temp_xhdl16 <= overflow_reg WHEN RX_FIFO /= 0 ELSE overflow_legacy;
   overflow_xhdl2 <= temp_xhdl16 ;

   temp_xhdl17 <= '1' WHEN (parity_err_xhdl1 = '1' or fifo_full_rx = '1') ELSE fifo_write;

   fifo_write_rx <= temp_xhdl17 ;

      make_SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen : SF2_MSS_sys_sb_CoreUARTapb_0_Clock_gen
          GENERIC MAP (
            BAUD_VAL_FRCTN_EN => BAUD_VAL_FRCTN_EN,
			SYNC_RESET => SYNC_RESET)
         PORT MAP (
            clk => CLK,
            reset_n => RESET_N,
            baud_val => BAUD_VAL,
            BAUD_VAL_FRACTION => BAUD_VAL_FRACTION,
            baud_clock => baud_clock,
            xmit_pulse => xmit_pulse);

      make_TX : SF2_MSS_sys_sb_CoreUARTapb_0_Tx_async
         GENERIC MAP (
            TX_FIFO => TX_FIFO,
			SYNC_RESET => SYNC_RESET)
         PORT MAP (
            clk => CLK,
            xmit_pulse => xmit_pulse,
            reset_n => RESET_N,
            rst_tx_empty => rst_tx_empty,
            tx_hold_reg => tx_hold_reg,
            tx_dout_reg => tx_dout_reg,
            fifo_empty => fifo_empty_tx,
            fifo_full => fifo_full_tx,
            bit8 => bit8,
            parity_en => parity_en,
            odd_n_even => odd_n_even,
            txrdy => txrdy_xhdl3,
            tx => tx_xhdl6,
            fifo_read_tx => fifo_read_tx);

      make_RX : SF2_MSS_sys_sb_CoreUARTapb_0_Rx_async
         GENERIC MAP (
            RX_FIFO => RX_FIFO,
			SYNC_RESET => SYNC_RESET)
         PORT MAP (
            clk => CLK,
            baud_clock => baud_clock,
            reset_n => RESET_N,
            bit8 => bit8,
            parity_en => parity_en,
            odd_n_even => odd_n_even,
            read_rx_byte => read_rx_byte,
            clear_parity => clear_parity,
            rx => RX,
            overflow => overflow_legacy,
            parity_err => parity_err_xhdl1,
            clear_parity_en => clear_parity_en,
            receive_full => receive_full,
            rx_byte => rx_byte,
            fifo_write => fifo_write,
            clear_framing_error => clear_framing_error,
            clear_framing_error_en => clear_framing_error_en,
            framing_error => framing_err_i,
            rx_idle_out => rx_idle,
            stop_strobe => stop_strobe);

   UG06a:IF (TX_FIFO = 2#1#) GENERATE
      tx_fifo_xhdl79 : SF2_MSS_sys_sb_CoreUARTapb_0_fifo_256x8
         GENERIC MAP ( SYNC_RESET => SYNC_RESET)
         PORT MAP (
            DO => tx_dout_reg,
            RCLOCK => clk,
            WCLOCK => clk,
-- AS: FIXED SARno 12821
--            DI => data_in,
            DI => tx_hold_reg,
            WRB => fifo_write_tx,
            RDB => fifo_read_tx,
            RESET => reset_n,
            FULL => fifo_full_tx,
            EMPTY => fifo_empty_tx);
   END GENERATE;
   
   UG06b:IF (TX_FIFO = 2#0#) GENERATE
             tx_dout_reg <= "00000000";
             fifo_full_tx <='0';
             fifo_empty_tx <='0';
   END GENERATE;

   UG07:IF (RX_FIFO = 2#1#) GENERATE
      rx_fifo_xhdl80 : SF2_MSS_sys_sb_CoreUARTapb_0_fifo_256x8
         GENERIC MAP ( SYNC_RESET => SYNC_RESET)
         PORT MAP (
            DO => rx_dout,
            RCLOCK => clk,
            WCLOCK => clk,
            DI => rx_byte_in,
            WRB => fifo_write_rx,
            RDB => fifo_read_rx,
            RESET => reset_n,
            FULL => fifo_full_rx,
            EMPTY => fifo_empty_rx);
   END GENERATE;
   
   UG07b:IF (RX_FIFO = 2#0#) GENERATE
             rx_dout <= "00000000";
             fifo_full_rx <='0';
             fifo_empty_rx <='0';
   END GENERATE;

END ARCHITECTURE translated;
