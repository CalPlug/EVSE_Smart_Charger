
library ieee;
use ieee.std_logic_1164.all;

package SF2_MSS_sys_sb_CoreUARTapb_0_components is
component SF2_MSS_sys_sb_CoreUARTapb_0_CoreUARTapb 
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

end SF2_MSS_sys_sb_CoreUARTapb_0_components;