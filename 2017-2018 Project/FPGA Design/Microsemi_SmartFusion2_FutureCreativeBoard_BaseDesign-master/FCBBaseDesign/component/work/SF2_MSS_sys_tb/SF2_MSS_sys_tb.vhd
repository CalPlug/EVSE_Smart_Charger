----------------------------------------------------------------------
-- Created by SmartDesign Tue Feb 14 12:02:58 2017
-- Version: v11.7 SP2 11.7.2.2
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- SF2_MSS_sys_tb entity declaration
----------------------------------------------------------------------
entity SF2_MSS_sys_tb is
    -- Port list
    port(
        -- Outputs
        GPIO_OUT : out std_logic_vector(2 downto 0);
        PWM      : out std_logic_vector(7 downto 0)
        );
end SF2_MSS_sys_tb;
----------------------------------------------------------------------
-- SF2_MSS_sys_tb architecture body
----------------------------------------------------------------------
architecture RTL of SF2_MSS_sys_tb is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- RESET_GEN   -   Actel:Simulation:RESET_GEN:1.0.1
component RESET_GEN
    generic( 
        DELAY       : integer := 1000 ;
        LOGIC_LEVEL : integer := 0 
        );
    -- Port list
    port(
        -- Outputs
        RESET : out std_logic
        );
end component;
-- SF2_MSS_sys
component SF2_MSS_sys
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in  std_logic;
        GPIO_IN          : in  std_logic_vector(2 downto 0);
        RX               : in  std_logic;
        SPI_0_CLK_F2M    : in  std_logic;
        SPI_0_DI_F2M     : in  std_logic;
        SPI_0_SS0_F2M    : in  std_logic;
        -- Outputs
        GPIO_OUT         : out std_logic_vector(2 downto 0);
        PWM              : out std_logic_vector(7 downto 0);
        SPI_0_CLK_M2F    : out std_logic;
        SPI_0_DO_M2F     : out std_logic;
        SPI_0_SS0_M2F    : out std_logic;
        SPI_0_SS0_M2F_OE : out std_logic;
        SPI_0_SS1_M2F    : out std_logic;
        SPI_0_SS2_M2F    : out std_logic;
        SPI_0_SS3_M2F    : out std_logic;
        SPI_0_SS4_M2F    : out std_logic;
        TX               : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal GPIO_OUT_net_0    : std_logic_vector(2 downto 0);
signal PWM_2             : std_logic_vector(7 downto 0);
signal RESET_GEN_0_RESET : std_logic;
signal PWM_2_net_0       : std_logic_vector(7 downto 0);
signal GPIO_OUT_net_1    : std_logic_vector(2 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net           : std_logic;
signal GPIO_IN_const_net_0: std_logic_vector(2 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net             <= '0';
 GPIO_IN_const_net_0 <= B"000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 PWM_2_net_0          <= PWM_2;
 PWM(7 downto 0)      <= PWM_2_net_0;
 GPIO_OUT_net_1       <= GPIO_OUT_net_0;
 GPIO_OUT(2 downto 0) <= GPIO_OUT_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- RESET_GEN_0   -   Actel:Simulation:RESET_GEN:1.0.1
RESET_GEN_0 : RESET_GEN
    generic map( 
        DELAY       => ( 1000 ),
        LOGIC_LEVEL => ( 0 )
        )
    port map( 
        -- Outputs
        RESET => RESET_GEN_0_RESET 
        );
-- SF2_MSS_sys_0
SF2_MSS_sys_0 : SF2_MSS_sys
    port map( 
        -- Inputs
        DEVRST_N         => RESET_GEN_0_RESET,
        SPI_0_DI_F2M     => GND_net,
        SPI_0_CLK_F2M    => GND_net,
        SPI_0_SS0_F2M    => GND_net,
        RX               => GND_net,
        GPIO_IN          => GPIO_IN_const_net_0,
        -- Outputs
        SPI_0_SS1_M2F    => OPEN,
        SPI_0_SS2_M2F    => OPEN,
        SPI_0_SS3_M2F    => OPEN,
        SPI_0_SS4_M2F    => OPEN,
        SPI_0_DO_M2F     => OPEN,
        SPI_0_CLK_M2F    => OPEN,
        SPI_0_SS0_M2F    => OPEN,
        SPI_0_SS0_M2F_OE => OPEN,
        TX               => OPEN,
        PWM              => PWM_2,
        GPIO_OUT         => GPIO_OUT_net_0 
        );

end RTL;
