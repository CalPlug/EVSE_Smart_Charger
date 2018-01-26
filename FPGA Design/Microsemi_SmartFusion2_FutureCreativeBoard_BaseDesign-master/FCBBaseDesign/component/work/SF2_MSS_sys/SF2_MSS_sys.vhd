----------------------------------------------------------------------
-- Created by SmartDesign Wed Jan 24 22:42:56 2018
-- Version: v11.8 SP2 11.8.2.4
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- SF2_MSS_sys entity declaration
----------------------------------------------------------------------
entity SF2_MSS_sys is
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in    std_logic;
        GPIO_IN          : in    std_logic_vector(2 downto 0);
        RX               : in    std_logic;
        SPISDI0          : in    std_logic;
        SPISDI1          : in    std_logic;
        SPI_0_CLK_F2M    : in    std_logic;
        SPI_0_DI_F2M     : in    std_logic;
        SPI_0_SS0_F2M    : in    std_logic;
        -- Outputs
        GPIO_OUT         : out   std_logic_vector(2 downto 0);
        PWM              : out   std_logic_vector(7 downto 0);
        SPISCLK0         : out   std_logic;
        SPISCLK1         : out   std_logic;
        SPISDO0          : out   std_logic;
        SPISDO1          : out   std_logic;
        SPISS0           : out   std_logic;
        SPISS1           : out   std_logic;
        SPI_0_CLK_M2F    : out   std_logic;
        SPI_0_DO_M2F     : out   std_logic;
        SPI_0_SS0_M2F    : out   std_logic;
        SPI_0_SS0_M2F_OE : out   std_logic;
        SPI_0_SS1_M2F    : out   std_logic;
        SPI_0_SS2_M2F    : out   std_logic;
        SPI_0_SS3_M2F    : out   std_logic;
        SPI_0_SS4_M2F    : out   std_logic;
        TX               : out   std_logic;
        -- Inouts
        SCL              : inout std_logic_vector(0 to 0);
        SDA              : inout std_logic_vector(0 to 0)
        );
end SF2_MSS_sys;
----------------------------------------------------------------------
-- SF2_MSS_sys architecture body
----------------------------------------------------------------------
architecture RTL of SF2_MSS_sys is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- SF2_MSS_sys_sb
component SF2_MSS_sys_sb
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in    std_logic;
        FAB_RESET_N      : in    std_logic;
        GPIO_IN          : in    std_logic_vector(2 downto 0);
        RX               : in    std_logic;
        SPISDI0          : in    std_logic;
        SPISDI1          : in    std_logic;
        SPI_0_CLK_F2M    : in    std_logic;
        SPI_0_DI_F2M     : in    std_logic;
        SPI_0_SS0_F2M    : in    std_logic;
        -- Outputs
        FAB_CCC_GL0      : out   std_logic;
        FAB_CCC_LOCK     : out   std_logic;
        GPIO_OUT         : out   std_logic_vector(2 downto 0);
        INIT_DONE        : out   std_logic;
        MSS_READY        : out   std_logic;
        POWER_ON_RESET_N : out   std_logic;
        PWM              : out   std_logic_vector(7 downto 0);
        SPISCLK0         : out   std_logic;
        SPISCLK1         : out   std_logic;
        SPISDO0          : out   std_logic;
        SPISDO1          : out   std_logic;
        SPISS0           : out   std_logic;
        SPISS1           : out   std_logic;
        SPI_0_CLK_M2F    : out   std_logic;
        SPI_0_DO_M2F     : out   std_logic;
        SPI_0_SS0_M2F    : out   std_logic;
        SPI_0_SS0_M2F_OE : out   std_logic;
        SPI_0_SS1_M2F    : out   std_logic;
        SPI_0_SS2_M2F    : out   std_logic;
        SPI_0_SS3_M2F    : out   std_logic;
        SPI_0_SS4_M2F    : out   std_logic;
        TX               : out   std_logic;
        -- Inouts
        SCL              : inout std_logic_vector(0 to 0);
        SDA              : inout std_logic_vector(0 to 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal GPIO_OUT_0             : std_logic_vector(2 downto 0);
signal PWM_2                  : std_logic_vector(7 downto 0);
signal SPI_0_CLK_M2F_net_0    : std_logic;
signal SPI_0_DO_M2F_net_0     : std_logic;
signal SPI_0_SS0_M2F_net_0    : std_logic;
signal SPI_0_SS0_M2F_OE_net_0 : std_logic;
signal SPI_0_SS1_M2F_net_0    : std_logic;
signal SPI_0_SS2_M2F_net_0    : std_logic;
signal SPI_0_SS3_M2F_net_0    : std_logic;
signal SPI_0_SS4_M2F_net_0    : std_logic;
signal SPISCLK0_net_0         : std_logic;
signal SPISCLK1_net_0         : std_logic;
signal SPISDO0_net_0          : std_logic;
signal SPISDO1_net_0          : std_logic;
signal SPISS0_net_0           : std_logic;
signal SPISS1_net_0           : std_logic;
signal TX_net_0               : std_logic;
signal SPI_0_SS1_M2F_net_1    : std_logic;
signal SPI_0_SS2_M2F_net_1    : std_logic;
signal SPI_0_SS3_M2F_net_1    : std_logic;
signal SPI_0_SS4_M2F_net_1    : std_logic;
signal SPI_0_DO_M2F_net_1     : std_logic;
signal SPI_0_CLK_M2F_net_1    : std_logic;
signal SPI_0_SS0_M2F_net_1    : std_logic;
signal SPI_0_SS0_M2F_OE_net_1 : std_logic;
signal TX_net_1               : std_logic;
signal SPISCLK1_net_1         : std_logic;
signal SPISS1_net_1           : std_logic;
signal PWM_2_net_0            : std_logic_vector(7 downto 0);
signal GPIO_OUT_0_net_0       : std_logic_vector(2 downto 0);
signal SPISCLK0_net_1         : std_logic;
signal SPISDO0_net_1          : std_logic;
signal SPISS0_net_1           : std_logic;
signal SPISDO1_net_1          : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_0_SS1_M2F_net_1    <= SPI_0_SS1_M2F_net_0;
 SPI_0_SS1_M2F          <= SPI_0_SS1_M2F_net_1;
 SPI_0_SS2_M2F_net_1    <= SPI_0_SS2_M2F_net_0;
 SPI_0_SS2_M2F          <= SPI_0_SS2_M2F_net_1;
 SPI_0_SS3_M2F_net_1    <= SPI_0_SS3_M2F_net_0;
 SPI_0_SS3_M2F          <= SPI_0_SS3_M2F_net_1;
 SPI_0_SS4_M2F_net_1    <= SPI_0_SS4_M2F_net_0;
 SPI_0_SS4_M2F          <= SPI_0_SS4_M2F_net_1;
 SPI_0_DO_M2F_net_1     <= SPI_0_DO_M2F_net_0;
 SPI_0_DO_M2F           <= SPI_0_DO_M2F_net_1;
 SPI_0_CLK_M2F_net_1    <= SPI_0_CLK_M2F_net_0;
 SPI_0_CLK_M2F          <= SPI_0_CLK_M2F_net_1;
 SPI_0_SS0_M2F_net_1    <= SPI_0_SS0_M2F_net_0;
 SPI_0_SS0_M2F          <= SPI_0_SS0_M2F_net_1;
 SPI_0_SS0_M2F_OE_net_1 <= SPI_0_SS0_M2F_OE_net_0;
 SPI_0_SS0_M2F_OE       <= SPI_0_SS0_M2F_OE_net_1;
 TX_net_1               <= TX_net_0;
 TX                     <= TX_net_1;
 SPISCLK1_net_1         <= SPISCLK1_net_0;
 SPISCLK1               <= SPISCLK1_net_1;
 SPISS1_net_1           <= SPISS1_net_0;
 SPISS1                 <= SPISS1_net_1;
 PWM_2_net_0            <= PWM_2;
 PWM(7 downto 0)        <= PWM_2_net_0;
 GPIO_OUT_0_net_0       <= GPIO_OUT_0;
 GPIO_OUT(2 downto 0)   <= GPIO_OUT_0_net_0;
 SPISCLK0_net_1         <= SPISCLK0_net_0;
 SPISCLK0               <= SPISCLK0_net_1;
 SPISDO0_net_1          <= SPISDO0_net_0;
 SPISDO0                <= SPISDO0_net_1;
 SPISS0_net_1           <= SPISS0_net_0;
 SPISS0                 <= SPISS0_net_1;
 SPISDO1_net_1          <= SPISDO1_net_0;
 SPISDO1                <= SPISDO1_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- SF2_MSS_sys_sb_0
SF2_MSS_sys_sb_0 : SF2_MSS_sys_sb
    port map( 
        -- Inputs
        FAB_RESET_N      => VCC_net,
        DEVRST_N         => DEVRST_N,
        SPI_0_DI_F2M     => SPI_0_DI_F2M,
        SPI_0_CLK_F2M    => SPI_0_CLK_F2M,
        SPI_0_SS0_F2M    => SPI_0_SS0_F2M,
        RX               => RX,
        SPISDI0          => SPISDI0,
        GPIO_IN          => GPIO_IN,
        SPISDI1          => SPISDI1,
        -- Outputs
        POWER_ON_RESET_N => OPEN,
        INIT_DONE        => OPEN,
        FAB_CCC_GL0      => OPEN,
        FAB_CCC_LOCK     => OPEN,
        MSS_READY        => OPEN,
        SPI_0_DO_M2F     => SPI_0_DO_M2F_net_0,
        SPI_0_CLK_M2F    => SPI_0_CLK_M2F_net_0,
        SPI_0_SS0_M2F    => SPI_0_SS0_M2F_net_0,
        SPI_0_SS0_M2F_OE => SPI_0_SS0_M2F_OE_net_0,
        SPI_0_SS1_M2F    => SPI_0_SS1_M2F_net_0,
        SPI_0_SS2_M2F    => SPI_0_SS2_M2F_net_0,
        SPI_0_SS3_M2F    => SPI_0_SS3_M2F_net_0,
        SPI_0_SS4_M2F    => SPI_0_SS4_M2F_net_0,
        TX               => TX_net_0,
        SPISCLK0         => SPISCLK0_net_0,
        SPISDO0          => SPISDO0_net_0,
        SPISS0           => SPISS0_net_0,
        SPISCLK1         => SPISCLK1_net_0,
        SPISS1           => SPISS1_net_0,
        PWM              => PWM_2,
        GPIO_OUT         => GPIO_OUT_0,
        SPISDO1          => SPISDO1_net_0,
        -- Inouts
        SCL              => SCL,
        SDA              => SDA 
        );

end RTL;
