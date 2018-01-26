-- ***********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2012 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	CoreResetP
--				Soft IP reset controller.
--              Sequences various reset signals to peripheral blocks in a
--              SmartFusion2 or IGLOO2 device.
--
--
-- SVN Revision Information:
-- SVN $Revision: 22245 $
-- SVN $Date: 2014-03-28 16:55:59 +0000 (Fri, 28 Mar 2014) $
--
-- Notes:
--
-- ***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CoreResetP is
    generic(
    FAMILY          : integer := 19;
    -- EXT_RESET_CFG is used to determine what can cause the external reset
    -- to be driven (by asserting EXT_RESET_OUT).
    --    0 = EXT_RESET_OUT is never asserted
    --    1 = EXT_RESET_OUT is asserted if power up reset
    --        (POWER_ON_RESET_N) is asserted
    --    2 = EXT_RESET_OUT is asserted if MSS_HPMS_READY is not
    --        asserted
    --    3 = EXT_RESET_OUT is asserted if power up reset
    --        (POWER_ON_RESET_N) or MSS_HPMS_READY is not asserted.
    EXT_RESET_CFG   : integer := 3;
    -- DEVICE_VOLTAGE is set to according to the supply voltage to the
    -- device. The supply voltage determines the RC oscillator frequency.
    -- This can be 25 or 50 MHz.
    --    1 = 1.0 V (RC osc freq = 25 MHz)
    --    2 = 1.2 V (RC osc freq = 50 MHz)
    DEVICE_VOLTAGE  : integer := 2;
    -- Use the following parameters to indicate whether or not a particular
    -- peripheral block is being used (and connected to this core).
    MDDR_IN_USE     : integer := 1;
    FDDR_IN_USE     : integer := 1;
    SDIF0_IN_USE    : integer := 1;
    SDIF1_IN_USE    : integer := 1;
    SDIF2_IN_USE    : integer := 1;
    SDIF3_IN_USE    : integer := 1;
    -- Following are used to indicate if a particular SDIF block is used
    -- for PCIe.
    SDIF0_PCIE      : integer := 0;
    SDIF1_PCIE      : integer := 0;
    SDIF2_PCIE      : integer := 0;
    SDIF3_PCIE      : integer := 0;
    -- Following are used to enable or disable PCIe HotReset/DLUP
    -- workaround for SDIF blocks. The workaround involves tracking LTSSM
    -- state machine within SDIF and asserting SDIFx_CORE_RESET_N signal
    -- to SDIF when appropriate.
    SDIF0_PCIE_HOTRESET : integer := 1;
    SDIF1_PCIE_HOTRESET : integer := 1;
    SDIF2_PCIE_HOTRESET : integer := 1;
    SDIF3_PCIE_HOTRESET : integer := 1;
    -- Following enable or disable PCIe L2/P2 workaround for SDIF blocks.
    -- When enabled, SDIF PHY and CORE resets are asserted when a rising
    -- edge is observed on PERST_N signal.
    SDIF0_PCIE_L2P2     : integer := 1;
    SDIF1_PCIE_L2P2     : integer := 1;
    SDIF2_PCIE_L2P2     : integer := 1;
    SDIF3_PCIE_L2P2     : integer := 1;
    -- Set the following parameter to 1 to enable the SOFT_XXX inputs that
    -- can be used to directly control the various reset outputs.
    ENABLE_SOFT_RESETS  : integer := 0;
    -- Set the DEVICE_090 parameter to 1 when an 090 or 060 device is being
    -- targeted, otherwise set to 0.
    -- When DEVICE_090 = 1, two core reset signals are available for
    -- connection to SDIF0 instead of just one. This supports the two
    -- PCIe controllers within SDIF0 on an 090 or 060 device.
    DEVICE_090          : integer := 0;
    -- DDR_WAIT specifies the time in microseconds that must have elapsed
    -- DDR_WAIT specifies the time in microseconds that must have elapsed
    -- between release of the reset to the FDDR block (FDDR_CORE_RESET_N)
    -- and assertion of INIT_DONE output.
    DDR_WAIT            : integer := 200
    );
    port (
    -- Clock from RC oscillator
    RCOSC_25_50MHZ              : in  std_logic;
    -- Clock from fabric CCC
    CLK_BASE                    : in  std_logic;
    -- Clock for sampling LTSSM data
    CLK_LTSSM                   : in  std_logic;
    -- Power on reset signal from g4m_control
    POWER_ON_RESET_N            : in  std_logic;
    -- Reset output intended for connection to external logic.
    EXT_RESET_OUT               : out std_logic;
    -- Signals to/from MSS/HPMS
    RESET_N_F2M                 : out std_logic;
    M3_RESET_N                  : out std_logic;
    RESET_N_M2F                 : in  std_logic;
    FIC_2_APB_M_PRESET_N        : in  std_logic;
    MDDR_DDR_AXI_S_CORE_RESET_N : out std_logic;
    -- MSS_HPMS_READY is essentially controlled by either RESET_N_M2F (at
    -- power on) or FIC_2_APB_M_PRESET_N (after power on, during warm
    -- resets).
    MSS_HPMS_READY              : out std_logic;
    -- Signal indicating readiness of DDR controllers
    DDR_READY                   : out std_logic;
    -- Signal indicating readiness of SERDES interfaces
    SDIF_READY                  : out std_logic;
    -- Signals to/from CoreConfigP
    CONFIG1_DONE                : in  std_logic;
    SDIF_RELEASED               : out std_logic;
    CONFIG2_DONE                : in  std_logic;
    INIT_DONE                   : out std_logic;
    -- Reset input from fabric.
    FAB_RESET_N                 : in  std_logic;
    -- FDDR signals
    FPLL_LOCK                   : in  std_logic;
    FDDR_CORE_RESET_N           : out std_logic;
    -- SERDESIF_0 signals
    SDIF0_SPLL_LOCK             : in  std_logic;
    SDIF0_PHY_RESET_N           : out std_logic;
    SDIF0_CORE_RESET_N          : out std_logic;
    -- The following two signals are used when targeting an 090 or 060 device
    -- which has two PCIe controllers within a single SERDES interface
    -- block.
    SDIF0_0_CORE_RESET_N        : out std_logic;
    SDIF0_1_CORE_RESET_N        : out std_logic;
    -- SERDESIF_1 signals
    SDIF1_SPLL_LOCK             : in  std_logic;
    SDIF1_PHY_RESET_N           : out std_logic;
    SDIF1_CORE_RESET_N          : out std_logic;
    -- SERDESIF_0 signals
    SDIF2_SPLL_LOCK             : in  std_logic;
    SDIF2_PHY_RESET_N           : out std_logic;
    SDIF2_CORE_RESET_N          : out std_logic;
    -- SERDESIF_1 signals
    SDIF3_SPLL_LOCK             : in  std_logic;
    SDIF3_PHY_RESET_N           : out std_logic;
    SDIF3_CORE_RESET_N          : out std_logic;
    -- PERST_N (PCIe reset) signals
    SDIF0_PERST_N               : in  std_logic;
    SDIF1_PERST_N               : in  std_logic;
    SDIF2_PERST_N               : in  std_logic;
    SDIF3_PERST_N               : in  std_logic;
    -- Some SDIF APB interface signals are brought into this core to
    -- provide access to status information that is present on the PRDATA
    -- bus when an APB read is not in progress.
    -- This status information is used in this core to implement a HotReset
    -- workaround when an SDIF block has been configured for PCIe.
    -- (Parameters are used to include/exclude the HotReset workaround.)
    SDIF0_PSEL                  : in  std_logic;
    SDIF0_PWRITE                : in  std_logic;
    SDIF0_PRDATA                : in  std_logic_vector(31 downto 0);
    SDIF1_PSEL                  : in  std_logic;
    SDIF1_PWRITE                : in  std_logic;
    SDIF1_PRDATA                : in  std_logic_vector(31 downto 0);
    SDIF2_PSEL                  : in  std_logic;
    SDIF2_PWRITE                : in  std_logic;
    SDIF2_PRDATA                : in  std_logic_vector(31 downto 0);
    SDIF3_PSEL                  : in  std_logic;
    SDIF3_PWRITE                : in  std_logic;
    SDIF3_PRDATA                : in  std_logic_vector(31 downto 0);
    -- The following inputs can be used to control the reset outputs to the
    -- peripheral blocks. The intention is that these may be used by
    -- software to allow software control of individual resets outputs.
    -- When a SOFT_xxx input is high, the corresponding reset output is
    -- asserted. Most (all?) reset outputs are active low.
    SOFT_EXT_RESET_OUT              : in  std_logic;
    SOFT_RESET_F2M                  : in  std_logic;
    SOFT_M3_RESET                   : in  std_logic;
    SOFT_MDDR_DDR_AXI_S_CORE_RESET  : in  std_logic;
    SOFT_FDDR_CORE_RESET            : in  std_logic;
    SOFT_SDIF0_PHY_RESET            : in  std_logic;
    SOFT_SDIF0_CORE_RESET           : in  std_logic;
    SOFT_SDIF1_PHY_RESET            : in  std_logic;
    SOFT_SDIF1_CORE_RESET           : in  std_logic;
    SOFT_SDIF2_PHY_RESET            : in  std_logic;
    SOFT_SDIF2_CORE_RESET           : in  std_logic;
    SOFT_SDIF3_PHY_RESET            : in  std_logic;
    SOFT_SDIF3_CORE_RESET           : in  std_logic;
    -- The following two signals are used when targeting an 090 or 060 device
    -- which has two PCIe controllers within a single SERDES interface
    -- block.
    SOFT_SDIF0_0_CORE_RESET         : in  std_logic;
    SOFT_SDIF0_1_CORE_RESET         : in  std_logic
    );
end CoreResetP;

architecture rtl of CoreResetP is

    -----------------------------------------------------------------------
    -- Functions
    -----------------------------------------------------------------------
    function greater(x:integer; y:integer) return integer is
    begin
        if   x > y then return x;
        else            return y;
        end if;
    end function greater;

    function calc_count_width( x : integer ) return integer is
    begin
        if    x > 2147483647 then return(32);
        elsif x > 1073741823 then return(31);
        elsif x >  536870911 then return(30);
        elsif x >  268435455 then return(29);
        elsif x >  134217727 then return(28);
        elsif x >   67108863 then return(27);
        elsif x >   33554431 then return(26);
        elsif x >   16777215 then return(25);
        elsif x >    8388607 then return(24);
        elsif x >    4194303 then return(23);
        elsif x >    2097151 then return(22);
        elsif x >    1048575 then return(21);
        elsif x >     524287 then return(20);
        elsif x >     262143 then return(19);
        elsif x >     131071 then return(18);
        elsif x >      65535 then return(17);
        elsif x >      32767 then return(16);
        elsif x >      16383 then return(15);
        elsif x >       8191 then return(14);
        elsif x >       4095 then return(13);
        elsif x >       2047 then return(12);
        elsif x >       1023 then return(11);
        elsif x >        511 then return(10);
        elsif x >        255 then return( 9);
        elsif x >        127 then return( 8);
        elsif x >         63 then return( 7);
        elsif x >         31 then return( 6);
        elsif x >         15 then return( 5);
        elsif x >          7 then return( 4);
        elsif x >          3 then return( 3);
        else                      return( 2);
        end if;
    end function calc_count_width;


    constant RCOSC_MEGAHERTZ : integer := 25 * DEVICE_VOLTAGE;

    constant SDIF_INTERVAL   : integer := 130      * RCOSC_MEGAHERTZ;
    constant DDR_INTERVAL    : integer := DDR_WAIT * RCOSC_MEGAHERTZ;

    constant COUNT_WIDTH_SDIF: integer := calc_count_width(SDIF_INTERVAL);
    constant COUNT_WIDTH_DDR : integer := calc_count_width(DDR_INTERVAL);

    -- Parameters for state machine states
    constant S0 : std_logic_vector(2 downto 0) := "000";
    constant S1 : std_logic_vector(2 downto 0) := "001";
    constant S2 : std_logic_vector(2 downto 0) := "010";
    constant S3 : std_logic_vector(2 downto 0) := "011";
    constant S4 : std_logic_vector(2 downto 0) := "100";
    constant S5 : std_logic_vector(2 downto 0) := "101";
    constant S6 : std_logic_vector(2 downto 0) := "110";

    -- Signals
    signal sm0_state                : std_logic_vector(2 downto 0);
    --signal sm1_state                : std_logic_vector(2 downto 0);
    signal sm2_state                : std_logic_vector(2 downto 0);
    signal sdif0_state              : std_logic_vector(2 downto 0);
    signal sdif1_state              : std_logic_vector(2 downto 0);
    signal sdif2_state              : std_logic_vector(2 downto 0);
    signal sdif3_state              : std_logic_vector(2 downto 0);
    signal next_sm0_state           : std_logic_vector(2 downto 0);
    --signal next_sm1_state           : std_logic_vector(2 downto 0);
    signal next_sm2_state           : std_logic_vector(2 downto 0);
    signal next_sdif0_state         : std_logic_vector(2 downto 0);
    signal next_sdif1_state         : std_logic_vector(2 downto 0);
    signal next_sdif2_state         : std_logic_vector(2 downto 0);
    signal next_sdif3_state         : std_logic_vector(2 downto 0);
    signal next_ext_reset_out       : std_logic;
    signal next_fddr_core_reset_n   : std_logic;
    signal next_sdif0_phy_reset_n   : std_logic;
    signal next_sdif0_core_reset_n  : std_logic;
    signal next_sdif1_phy_reset_n   : std_logic;
    signal next_sdif1_core_reset_n  : std_logic;
    signal next_sdif2_phy_reset_n   : std_logic;
    signal next_sdif2_core_reset_n  : std_logic;
    signal next_sdif3_phy_reset_n   : std_logic;
    signal next_sdif3_core_reset_n  : std_logic;
    signal next_mddr_core_reset_n   : std_logic;
    signal next_count_sdif0_enable  : std_logic;
    signal next_count_sdif1_enable  : std_logic;
    signal next_count_sdif2_enable  : std_logic;
    signal next_count_sdif3_enable  : std_logic;
    signal next_count_ddr_enable    : std_logic;
    signal next_ddr_ready           : std_logic;
    signal next_sdif_released       : std_logic;
    signal next_sdif_ready          : std_logic;
    signal next_init_done           : std_logic;
    signal release_ext_reset        : std_logic;
    signal next_release_ext_reset   : std_logic;

    signal sm0_areset_n             : std_logic;
    signal sm1_areset_n             : std_logic;
    signal sm2_areset_n             : std_logic;
    signal sdif0_areset_n           : std_logic;
    signal sdif1_areset_n           : std_logic;
    signal sdif2_areset_n           : std_logic;
    signal sdif3_areset_n           : std_logic;

    signal SDIF0_PERST_N_int        : std_logic;
    signal SDIF1_PERST_N_int        : std_logic;
    signal SDIF2_PERST_N_int        : std_logic;
    signal SDIF3_PERST_N_int        : std_logic;

    signal SDIF0_PERST_N_q1         : std_logic;
    signal SDIF0_PERST_N_q2         : std_logic;
    signal SDIF0_PERST_N_q3         : std_logic;
    signal SDIF0_PERST_N_re         : std_logic;

    signal SDIF1_PERST_N_q1         : std_logic;
    signal SDIF1_PERST_N_q2         : std_logic;
    signal SDIF1_PERST_N_q3         : std_logic;
    signal SDIF1_PERST_N_re         : std_logic;

    signal SDIF2_PERST_N_q1         : std_logic;
    signal SDIF2_PERST_N_q2         : std_logic;
    signal SDIF2_PERST_N_q3         : std_logic;
    signal SDIF2_PERST_N_re         : std_logic;

    signal SDIF3_PERST_N_q1         : std_logic;
    signal SDIF3_PERST_N_q2         : std_logic;
    signal SDIF3_PERST_N_q3         : std_logic;
    signal SDIF3_PERST_N_re         : std_logic;

    signal sm0_areset_n_q1          : std_logic;
    signal sm0_areset_n_clk_base    : std_logic;
    signal sm1_areset_n_q1          : std_logic;
    signal sm1_areset_n_clk_base    : std_logic;
    signal sm2_areset_n_q1          : std_logic;
    signal sm2_areset_n_clk_base    : std_logic;
    signal sdif0_areset_n_q1        : std_logic;
    signal sdif0_areset_n_clk_base  : std_logic;
    signal sdif1_areset_n_q1        : std_logic;
    signal sdif1_areset_n_clk_base  : std_logic;
    signal sdif2_areset_n_q1        : std_logic;
    signal sdif2_areset_n_clk_base  : std_logic;
    signal sdif3_areset_n_q1        : std_logic;
    signal sdif3_areset_n_clk_base  : std_logic;

    signal sm0_areset_n_rcosc_q1    : std_logic;
    signal sm0_areset_n_rcosc       : std_logic;
    signal sdif0_areset_n_rcosc_q1  : std_logic;
    signal sdif0_areset_n_rcosc     : std_logic;
    signal sdif1_areset_n_rcosc_q1  : std_logic;
    signal sdif1_areset_n_rcosc     : std_logic;
    signal sdif2_areset_n_rcosc_q1  : std_logic;
    signal sdif2_areset_n_rcosc     : std_logic;
    signal sdif3_areset_n_rcosc_q1  : std_logic;
    signal sdif3_areset_n_rcosc     : std_logic;

    signal fpll_lock_q1             : std_logic;
    signal fpll_lock_q2             : std_logic;
    signal sdif0_spll_lock_q1       : std_logic;
    signal sdif0_spll_lock_q2       : std_logic;
    signal sdif1_spll_lock_q1       : std_logic;
    signal sdif1_spll_lock_q2       : std_logic;
    signal sdif2_spll_lock_q1       : std_logic;
    signal sdif2_spll_lock_q2       : std_logic;
    signal sdif3_spll_lock_q1       : std_logic;
    signal sdif3_spll_lock_q2       : std_logic;

    signal count_ddr_enable         : std_logic;
    signal ddr_settled              : std_logic;
    signal count_sdif0_enable       : std_logic;
    signal count_sdif1_enable       : std_logic;
    signal count_sdif2_enable       : std_logic;
    signal count_sdif3_enable       : std_logic;
    signal release_sdif0_core       : std_logic;
    signal release_sdif1_core       : std_logic;
    signal release_sdif2_core       : std_logic;
    signal release_sdif3_core       : std_logic;

    signal DDR_READY_int            : std_logic;
    signal SDIF_RELEASED_int        : std_logic;
    signal SDIF_READY_int           : std_logic;
    signal INIT_DONE_int            : std_logic;

    signal count_sdif0              : std_logic_vector(COUNT_WIDTH_SDIF-1 downto 0);
    signal count_sdif1              : std_logic_vector(COUNT_WIDTH_SDIF-1 downto 0);
    signal count_sdif2              : std_logic_vector(COUNT_WIDTH_SDIF-1 downto 0);
    signal count_sdif3              : std_logic_vector(COUNT_WIDTH_SDIF-1 downto 0);
    signal count_ddr                : std_logic_vector(COUNT_WIDTH_DDR -1 downto 0);

    signal FPLL_LOCK_int            : std_logic;
    signal SDIF0_SPLL_LOCK_int      : std_logic;
    signal SDIF1_SPLL_LOCK_int      : std_logic;
    signal SDIF2_SPLL_LOCK_int      : std_logic;
    signal SDIF3_SPLL_LOCK_int      : std_logic;

    signal CONFIG1_DONE_q1       : std_logic;
    signal CONFIG1_DONE_clk_base : std_logic;

    signal CONFIG2_DONE_q1      : std_logic;
    signal CONFIG2_DONE_clk_base: std_logic;

    signal POWER_ON_RESET_N_q1      : std_logic;
    signal POWER_ON_RESET_N_clk_base: std_logic;
    signal RESET_N_M2F_q1           : std_logic;
    signal RESET_N_M2F_clk_base     : std_logic;
    signal FIC_2_APB_M_PRESET_N_q1  : std_logic;
    signal FIC_2_APB_M_PRESET_N_clk_base: std_logic;
    signal mss_ready_state          : std_logic;
    signal mss_ready_select         : std_logic;
    --signal FAB_RESET_N_int          : std_logic;
    signal MSS_HPMS_READY_int       : std_logic;

    signal count_ddr_enable_q1          : std_logic;
    signal count_ddr_enable_rcosc       : std_logic;
    signal ddr_settled_q1               : std_logic;
    signal ddr_settled_clk_base         : std_logic;
    signal count_sdif0_enable_q1        : std_logic;
    signal count_sdif1_enable_q1        : std_logic;
    signal count_sdif2_enable_q1        : std_logic;
    signal count_sdif3_enable_q1        : std_logic;
    signal count_sdif0_enable_rcosc     : std_logic;
    signal count_sdif1_enable_rcosc     : std_logic;
    signal count_sdif2_enable_rcosc     : std_logic;
    signal count_sdif3_enable_rcosc     : std_logic;
    signal release_sdif0_core_q1        : std_logic;
    signal release_sdif1_core_q1        : std_logic;
    signal release_sdif2_core_q1        : std_logic;
    signal release_sdif3_core_q1        : std_logic;
    signal release_sdif0_core_clk_base  : std_logic;
    signal release_sdif1_core_clk_base  : std_logic;
    signal release_sdif2_core_clk_base  : std_logic;
    signal release_sdif3_core_clk_base  : std_logic;

    signal EXT_RESET_OUT_int                : std_logic;
    signal RESET_N_F2M_int                  : std_logic;
    signal M3_RESET_N_int                   : std_logic;
    signal MDDR_DDR_AXI_S_CORE_RESET_N_int  : std_logic;
    --signal FAB_RESET_N_int                  : std_logic;
    --signal USER_FAB_RESET_N_int             : std_logic;
    signal FDDR_CORE_RESET_N_int            : std_logic;
    signal SDIF0_PHY_RESET_N_int            : std_logic;
    signal SDIF0_CORE_RESET_N_0             : std_logic;
    signal SDIF0_CORE_RESET_N_int           : std_logic;
    signal SDIF1_PHY_RESET_N_int            : std_logic;
    signal SDIF1_CORE_RESET_N_0             : std_logic;
    signal SDIF1_CORE_RESET_N_int           : std_logic;
    signal SDIF2_PHY_RESET_N_int            : std_logic;
    signal SDIF2_CORE_RESET_N_0             : std_logic;
    signal SDIF2_CORE_RESET_N_int           : std_logic;
    signal SDIF3_PHY_RESET_N_int            : std_logic;
    signal SDIF3_CORE_RESET_N_0             : std_logic;
    signal SDIF3_CORE_RESET_N_int           : std_logic;

    -----------------------------------------------------------------------
    -- Components
    -----------------------------------------------------------------------
    component coreresetp_pcie_hotreset
        port(
            CLK_BASE                : in  std_logic;
            CLK_LTSSM               : in  std_logic;
            psel                    : in  std_logic;
            pwrite                  : in  std_logic;
            prdata                  : in  std_logic_vector(31 downto 0);
            sdif_core_reset_n_0     : in  std_logic;
            sdif_core_reset_n       : out std_logic
        );
    end component;

begin

    -- When a SOFT_XXX input is asserted (high), the corresponding reset
    -- output is asserted. (Reset outputs are mainly active low.)
    -- When a SOFT_XXX input is low, the corresponding reset output is
    -- controlled by the logic contained within this core.
    process (
        SOFT_EXT_RESET_OUT,
        SOFT_RESET_F2M,
        SOFT_M3_RESET,
        SOFT_MDDR_DDR_AXI_S_CORE_RESET,
        SOFT_FDDR_CORE_RESET,
        SOFT_SDIF0_PHY_RESET,
        SOFT_SDIF0_CORE_RESET,
        SOFT_SDIF1_PHY_RESET,
        SOFT_SDIF1_CORE_RESET,
        SOFT_SDIF2_PHY_RESET,
        SOFT_SDIF2_CORE_RESET,
        SOFT_SDIF3_PHY_RESET,
        SOFT_SDIF3_CORE_RESET,
        SOFT_SDIF0_0_CORE_RESET,
        SOFT_SDIF0_1_CORE_RESET,
        EXT_RESET_OUT_int,
        RESET_N_F2M_int,
        M3_RESET_N_int,
        MDDR_DDR_AXI_S_CORE_RESET_N_int,
        FDDR_CORE_RESET_N_int,
        SDIF0_PHY_RESET_N_int,
        SDIF0_CORE_RESET_N_int,
        SDIF1_PHY_RESET_N_int,
        SDIF1_CORE_RESET_N_int,
        SDIF2_PHY_RESET_N_int,
        SDIF2_CORE_RESET_N_int,
        SDIF3_PHY_RESET_N_int,
        SDIF3_CORE_RESET_N_int
    )
    begin
        if (ENABLE_SOFT_RESETS = 1 and SOFT_EXT_RESET_OUT             = '1') then EXT_RESET_OUT               <= '1'; else EXT_RESET_OUT               <= EXT_RESET_OUT_int;               end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_RESET_F2M                 = '1') then RESET_N_F2M                 <= '0'; else RESET_N_F2M                 <= RESET_N_F2M_int;                 end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_M3_RESET                  = '1') then M3_RESET_N                  <= '0'; else M3_RESET_N                  <= M3_RESET_N_int;                  end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_MDDR_DDR_AXI_S_CORE_RESET = '1') then MDDR_DDR_AXI_S_CORE_RESET_N <= '0'; else MDDR_DDR_AXI_S_CORE_RESET_N <= MDDR_DDR_AXI_S_CORE_RESET_N_int; end if;
        --if (ENABLE_SOFT_RESETS = 1 and SOFT_FAB_RESET                 = '1') then FAB_RESET_N                 <= '0'; else FAB_RESET_N                 <= FAB_RESET_N_int;                 end if;
        --if (ENABLE_SOFT_RESETS = 1 and SOFT_USER_FAB_RESET            = '1') then USER_FAB_RESET_N            <= '0'; else USER_FAB_RESET_N            <= USER_FAB_RESET_N_int;            end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_FDDR_CORE_RESET           = '1') then FDDR_CORE_RESET_N           <= '0'; else FDDR_CORE_RESET_N           <= FDDR_CORE_RESET_N_int;           end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF0_PHY_RESET           = '1') then SDIF0_PHY_RESET_N           <= '0'; else SDIF0_PHY_RESET_N           <= SDIF0_PHY_RESET_N_int;           end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF0_CORE_RESET          = '1') then SDIF0_CORE_RESET_N          <= '0'; else SDIF0_CORE_RESET_N          <= SDIF0_CORE_RESET_N_int;          end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF1_PHY_RESET           = '1') then SDIF1_PHY_RESET_N           <= '0'; else SDIF1_PHY_RESET_N           <= SDIF1_PHY_RESET_N_int;           end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF1_CORE_RESET          = '1') then SDIF1_CORE_RESET_N          <= '0'; else SDIF1_CORE_RESET_N          <= SDIF1_CORE_RESET_N_int;          end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF2_PHY_RESET           = '1') then SDIF2_PHY_RESET_N           <= '0'; else SDIF2_PHY_RESET_N           <= SDIF2_PHY_RESET_N_int;           end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF2_CORE_RESET          = '1') then SDIF2_CORE_RESET_N          <= '0'; else SDIF2_CORE_RESET_N          <= SDIF2_CORE_RESET_N_int;          end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF3_PHY_RESET           = '1') then SDIF3_PHY_RESET_N           <= '0'; else SDIF3_PHY_RESET_N           <= SDIF3_PHY_RESET_N_int;           end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF3_CORE_RESET          = '1') then SDIF3_CORE_RESET_N          <= '0'; else SDIF3_CORE_RESET_N          <= SDIF3_CORE_RESET_N_int;          end if;
        -- SDIF0_0_CORE_RESET_N and SDIF0_1_CORE_RESET_N are intended for
        -- use in an 090 or 060 device. This device has a single SERDES
        -- interface with two separate PCIe controllers within it.
        -- Separate CORE reset signals are provided for these two PCIe
        -- cores.
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF0_0_CORE_RESET        = '1') then SDIF0_0_CORE_RESET_N        <= '0'; else SDIF0_0_CORE_RESET_N        <= SDIF0_CORE_RESET_N_int;          end if;
        if (ENABLE_SOFT_RESETS = 1 and SOFT_SDIF0_1_CORE_RESET        = '1') then SDIF0_1_CORE_RESET_N        <= '0'; else SDIF0_1_CORE_RESET_N        <= SDIF0_CORE_RESET_N_int;          end if;
    end process;

    -- If a peripheral block is not in use, internally tie its PLL lock
    -- signal high.
    FPLL_LOCK_int       <= FPLL_LOCK       when FDDR_IN_USE  = 1 else '1';
    SDIF0_SPLL_LOCK_int <= SDIF0_SPLL_LOCK when SDIF0_IN_USE = 1 else '1';
    SDIF1_SPLL_LOCK_int <= SDIF1_SPLL_LOCK when SDIF1_IN_USE = 1 else '1';
    SDIF2_SPLL_LOCK_int <= SDIF2_SPLL_LOCK when SDIF2_IN_USE = 1 else '1';
    SDIF3_SPLL_LOCK_int <= SDIF3_SPLL_LOCK when SDIF3_IN_USE = 1 else '1';

    -----------------------------------------------------------------------
    -- The following code creates a reset signal named MSS_HPMS_READY.
    --
    -- After a power on reset, MSS_HPMS_READY will not go high until
    -- FIC_2_APB_M_PRESET_N has gone high, and RESET_N_M2F has been
    -- seen to be high for at least one cycle of RCOSC_25_50MHZ at some
    -- stage.
    --
    -- For subsequent warm resets, MSS_HPMS_READY will essentially follow
    -- FIC_2_APB_M_PRESET_N and RESET_N_M2F is not considered at all.
    -----------------------------------------------------------------------
    -- Synchronize POWER_ON_RESET_N to CLK_BASE domain.
    process (CLK_BASE, POWER_ON_RESET_N)
    begin
        if (POWER_ON_RESET_N = '0') then
            POWER_ON_RESET_N_q1        <= '0';
            POWER_ON_RESET_N_clk_base  <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            POWER_ON_RESET_N_q1        <= '1';
            POWER_ON_RESET_N_clk_base  <= POWER_ON_RESET_N_q1;
        end if;
    end process;

    -- Synchronize RESET_N_M2F to CLK_BASE domain.
    process (CLK_BASE, RESET_N_M2F)
    begin
        if (RESET_N_M2F = '0') then
            RESET_N_M2F_q1         <= '0';
            RESET_N_M2F_clk_base   <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            RESET_N_M2F_q1         <= '1';
            RESET_N_M2F_clk_base   <= RESET_N_M2F_q1;
        end if;
    end process;

    -- Synchronize FIC_2_APB_M_PRESET_N to CLK_BASE domain.
    process (CLK_BASE, FIC_2_APB_M_PRESET_N)
    begin
        if (FIC_2_APB_M_PRESET_N = '0') then
            FIC_2_APB_M_PRESET_N_q1         <= '0';
            FIC_2_APB_M_PRESET_N_clk_base   <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            FIC_2_APB_M_PRESET_N_q1         <= '1';
            FIC_2_APB_M_PRESET_N_clk_base   <= FIC_2_APB_M_PRESET_N_q1;
        end if;
    end process;

    -- At power on, state = '0' and select = '0'.
    -- state will advance to '1' (and remain at '1') when RESET_N_M2F
    -- is seen to be high.
    -- When state = '1', select will move to '1' (and remain at '1') when
    -- FIC_2_APB_M_PRESET_N is seen to be high.
    process (CLK_BASE, POWER_ON_RESET_N_clk_base)
    begin
        if (POWER_ON_RESET_N_clk_base = '0') then
            mss_ready_state  <= '0';
            mss_ready_select <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            if (RESET_N_M2F_clk_base = '1') then
                mss_ready_state  <= '1';
            end if;
            if (FIC_2_APB_M_PRESET_N_clk_base = '1' and mss_ready_state = '1') then
                mss_ready_select <= '1';
            end if;
        end if;
    end process;

    process (CLK_BASE, POWER_ON_RESET_N_clk_base)
    begin
        if (POWER_ON_RESET_N_clk_base = '0') then
            MSS_HPMS_READY_int <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            if (mss_ready_select = '0') then
                MSS_HPMS_READY_int <= FIC_2_APB_M_PRESET_N_clk_base and RESET_N_M2F_clk_base;
            else
                MSS_HPMS_READY_int <= FIC_2_APB_M_PRESET_N_clk_base;
            end if;
        end if;
    end process;

    MSS_HPMS_READY <= MSS_HPMS_READY_int;

    -----------------------------------------------------------------------
    -- Create a number of asynchronous resets.
    -- Some source reset signals may be "combined" to create a single
    -- asynchronous reset.
    -----------------------------------------------------------------------
    process (FAB_RESET_N, POWER_ON_RESET_N, MSS_HPMS_READY_int)
    begin
        sm0_areset_n <= FAB_RESET_N
                        and POWER_ON_RESET_N
                        and MSS_HPMS_READY_int;
    end process;

    -- Assertion of resets to MSS/HPMS (RESET_N_F2M and M3_RESET_N) caused
    -- by assertion of reset signal from fabric.
    process (FAB_RESET_N)
    begin
        sm1_areset_n <= FAB_RESET_N;
    end process;

    -- There are a number of options for what can cause the external reset
    -- to be asserted.
    g_0: if (EXT_RESET_CFG = 0) generate
      process (POWER_ON_RESET_N)
      begin
          sm2_areset_n <= POWER_ON_RESET_N;
      end process;
    end generate;
    g_1: if (not(EXT_RESET_CFG = 0)) generate
      g_2: if (EXT_RESET_CFG = 1) generate
        process (POWER_ON_RESET_N)
        begin
            sm2_areset_n <= POWER_ON_RESET_N;
        end process;
      end generate;
      g_3: if (not(EXT_RESET_CFG = 1)) generate
        g_4: if (EXT_RESET_CFG = 2) generate
          process (MSS_HPMS_READY_int)
          begin
              sm2_areset_n <= MSS_HPMS_READY_int;
          end process;
        end generate;
        g_5: if (not(EXT_RESET_CFG = 2)) generate
          process (POWER_ON_RESET_N, MSS_HPMS_READY_int)
          begin
              sm2_areset_n <= POWER_ON_RESET_N and MSS_HPMS_READY_int;
          end process;
        end generate;
      end generate;
    end generate;

    -- Individual async resets for each SDIF block
    sdif0_areset_n <= FAB_RESET_N
                      and POWER_ON_RESET_N
                      and MSS_HPMS_READY_int
                      and not(SDIF0_PERST_N_re);

    sdif1_areset_n <= FAB_RESET_N
                      and POWER_ON_RESET_N
                      and MSS_HPMS_READY_int
                      and not(SDIF1_PERST_N_re);

    sdif2_areset_n <= FAB_RESET_N
                      and POWER_ON_RESET_N
                      and MSS_HPMS_READY_int
                      and not(SDIF2_PERST_N_re);

    sdif3_areset_n <= FAB_RESET_N
                      and POWER_ON_RESET_N
                      and MSS_HPMS_READY_int
                      and not(SDIF3_PERST_N_re);


    -- Internally tie-off PERST_N signals if SDIFx_PCIE_L2P2 parameters
    -- are not set.
    SDIF0_PERST_N_int <= SDIF0_PERST_N when SDIF0_PCIE_L2P2 = 1 else '0';
    SDIF1_PERST_N_int <= SDIF1_PERST_N when SDIF1_PCIE_L2P2 = 1 else '0';
    SDIF2_PERST_N_int <= SDIF2_PERST_N when SDIF2_PCIE_L2P2 = 1 else '0';
    SDIF3_PERST_N_int <= SDIF3_PERST_N when SDIF3_PCIE_L2P2 = 1 else '0';

    -- Detect rising edge on SDIF0_PERST_N signal
    process (CLK_BASE, SDIF0_PERST_N_int)
    begin
        if (SDIF0_PERST_N_int = '0') then
            SDIF0_PERST_N_q1 <= '0';
            SDIF0_PERST_N_q2 <= '0';
            SDIF0_PERST_N_q3 <= '0';
            SDIF0_PERST_N_re <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            SDIF0_PERST_N_q1 <= '1';
            SDIF0_PERST_N_q2 <= SDIF0_PERST_N_q1;
            SDIF0_PERST_N_q3 <= SDIF0_PERST_N_q2;
            SDIF0_PERST_N_re <= SDIF0_PERST_N_q2 and not(SDIF0_PERST_N_q3);
        end if;
    end process;

    -- Detect rising edge on SDIF1_PERST_N signal
    process (CLK_BASE, SDIF1_PERST_N_int)
    begin
        if (SDIF1_PERST_N_int = '0') then
            SDIF1_PERST_N_q1 <= '0';
            SDIF1_PERST_N_q2 <= '0';
            SDIF1_PERST_N_q3 <= '0';
            SDIF1_PERST_N_re <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            SDIF1_PERST_N_q1 <= '1';
            SDIF1_PERST_N_q2 <= SDIF1_PERST_N_q1;
            SDIF1_PERST_N_q3 <= SDIF1_PERST_N_q2;
            SDIF1_PERST_N_re <= SDIF1_PERST_N_q2 and not(SDIF1_PERST_N_q3);
        end if;
    end process;

    -- Detect rising edge on SDIF2_PERST_N signal
    process (CLK_BASE, SDIF2_PERST_N_int)
    begin
        if (SDIF2_PERST_N_int = '0') then
            SDIF2_PERST_N_q1 <= '0';
            SDIF2_PERST_N_q2 <= '0';
            SDIF2_PERST_N_q3 <= '0';
            SDIF2_PERST_N_re <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            SDIF2_PERST_N_q1 <= '1';
            SDIF2_PERST_N_q2 <= SDIF2_PERST_N_q1;
            SDIF2_PERST_N_q3 <= SDIF2_PERST_N_q2;
            SDIF2_PERST_N_re <= SDIF2_PERST_N_q2 and not(SDIF2_PERST_N_q3);
        end if;
    end process;

    -- Detect rising edge on SDIF3_PERST_N signal
    process (CLK_BASE, SDIF3_PERST_N_int)
    begin
        if (SDIF3_PERST_N_int = '0') then
            SDIF3_PERST_N_q1 <= '0';
            SDIF3_PERST_N_q2 <= '0';
            SDIF3_PERST_N_q3 <= '0';
            SDIF3_PERST_N_re <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            SDIF3_PERST_N_q1 <= '1';
            SDIF3_PERST_N_q2 <= SDIF3_PERST_N_q1;
            SDIF3_PERST_N_q3 <= SDIF3_PERST_N_q2;
            SDIF3_PERST_N_re <= SDIF3_PERST_N_q2 and not(SDIF3_PERST_N_q3);
        end if;
    end process;

    -----------------------------------------------------------------------
    -- Create versions of asynchronous resets that are released
    -- synchronous to CLK_BASE.
    -----------------------------------------------------------------------
    process (CLK_BASE, sm0_areset_n)
    begin
        if (sm0_areset_n = '0') then
            sm0_areset_n_q1       <= '0';
            sm0_areset_n_clk_base <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sm0_areset_n_q1       <= '1';
            sm0_areset_n_clk_base <= sm0_areset_n_q1;
        end if;
    end process;

    process (CLK_BASE, sm1_areset_n)
    begin
        if (sm1_areset_n = '0') then
            sm1_areset_n_q1       <= '0';
            sm1_areset_n_clk_base <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sm1_areset_n_q1       <= '1';
            sm1_areset_n_clk_base <= sm1_areset_n_q1;
        end if;
    end process;

    process (CLK_BASE, sm2_areset_n)
    begin
        if (sm2_areset_n = '0') then
            sm2_areset_n_q1       <= '0';
            sm2_areset_n_clk_base <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sm2_areset_n_q1       <= '1';
            sm2_areset_n_clk_base <= sm2_areset_n_q1;
        end if;
    end process;

    process (CLK_BASE, sdif0_areset_n)
    begin
        if (sdif0_areset_n = '0') then
            sdif0_areset_n_q1       <= '0';
            sdif0_areset_n_clk_base <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif0_areset_n_q1       <= '1';
            sdif0_areset_n_clk_base <= sdif0_areset_n_q1;
        end if;
    end process;

    process (CLK_BASE, sdif1_areset_n)
    begin
        if (sdif1_areset_n = '0') then
            sdif1_areset_n_q1       <= '0';
            sdif1_areset_n_clk_base <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif1_areset_n_q1       <= '1';
            sdif1_areset_n_clk_base <= sdif1_areset_n_q1;
        end if;
    end process;

    process (CLK_BASE, sdif2_areset_n)
    begin
        if (sdif2_areset_n = '0') then
            sdif2_areset_n_q1       <= '0';
            sdif2_areset_n_clk_base <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif2_areset_n_q1       <= '1';
            sdif2_areset_n_clk_base <= sdif2_areset_n_q1;
        end if;
    end process;

    process (CLK_BASE, sdif3_areset_n)
    begin
        if (sdif3_areset_n = '0') then
            sdif3_areset_n_q1       <= '0';
            sdif3_areset_n_clk_base <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif3_areset_n_q1       <= '1';
            sdif3_areset_n_clk_base <= sdif3_areset_n_q1;
        end if;
    end process;

    -----------------------------------------------------------------------
    -- Synchronize some resets to RCOSC_25_50MHZ domain.
    -----------------------------------------------------------------------
    process (RCOSC_25_50MHZ, sm0_areset_n)
    begin
        if (sm0_areset_n = '0') then
            sm0_areset_n_rcosc_q1   <= '0';
            sm0_areset_n_rcosc      <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            sm0_areset_n_rcosc_q1   <= '1';
            sm0_areset_n_rcosc      <= sm0_areset_n_rcosc_q1;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif0_areset_n)
    begin
        if (sdif0_areset_n = '0') then
            sdif0_areset_n_rcosc_q1 <= '0';
            sdif0_areset_n_rcosc    <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            sdif0_areset_n_rcosc_q1 <= '1';
            sdif0_areset_n_rcosc    <= sdif0_areset_n_rcosc_q1;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif1_areset_n)
    begin
        if (sdif1_areset_n = '0') then
            sdif1_areset_n_rcosc_q1 <= '0';
            sdif1_areset_n_rcosc    <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            sdif1_areset_n_rcosc_q1 <= '1';
            sdif1_areset_n_rcosc    <= sdif1_areset_n_rcosc_q1;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif2_areset_n)
    begin
        if (sdif2_areset_n = '0') then
            sdif2_areset_n_rcosc_q1 <= '0';
            sdif2_areset_n_rcosc    <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            sdif2_areset_n_rcosc_q1 <= '1';
            sdif2_areset_n_rcosc    <= sdif2_areset_n_rcosc_q1;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif3_areset_n)
    begin
        if (sdif3_areset_n = '0') then
            sdif3_areset_n_rcosc_q1 <= '0';
            sdif3_areset_n_rcosc    <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            sdif3_areset_n_rcosc_q1 <= '1';
            sdif3_areset_n_rcosc    <= sdif3_areset_n_rcosc_q1;
        end if;
    end process;

    -----------------------------------------------------------------------
    -- Synchronize CONFIG1_DONE input to CLK_BASE domain.
    -----------------------------------------------------------------------
    process (CLK_BASE, sm0_areset_n_clk_base)
    begin
        if (sm0_areset_n_clk_base = '0') then
            CONFIG1_DONE_q1          <= '0';
            CONFIG1_DONE_clk_base    <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            CONFIG1_DONE_q1          <= CONFIG1_DONE;
            CONFIG1_DONE_clk_base    <= CONFIG1_DONE_q1;
        end if;
    end process;

    -----------------------------------------------------------------------
    -- Synchronize CONFIG2_DONE input to CLK_BASE domain.
    -----------------------------------------------------------------------
    process (CLK_BASE, sm0_areset_n_clk_base)
    begin
        if (sm0_areset_n_clk_base = '0') then
            CONFIG2_DONE_q1         <= '0';
            CONFIG2_DONE_clk_base   <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            CONFIG2_DONE_q1         <= CONFIG2_DONE;
            CONFIG2_DONE_clk_base   <= CONFIG2_DONE_q1;
        end if;
    end process;

    -----------------------------------------------------------------------
    -- Synchronize PLL lock signals to CLK_BASE domain.
    -----------------------------------------------------------------------
    process (CLK_BASE, sm0_areset_n_clk_base)
    begin
        if (sm0_areset_n_clk_base = '0') then
            fpll_lock_q1       <= '0';
            fpll_lock_q2       <= '0';
            sdif0_spll_lock_q1 <= '0';
            sdif0_spll_lock_q2 <= '0';
            sdif1_spll_lock_q1 <= '0';
            sdif1_spll_lock_q2 <= '0';
            sdif2_spll_lock_q1 <= '0';
            sdif2_spll_lock_q2 <= '0';
            sdif3_spll_lock_q1 <= '0';
            sdif3_spll_lock_q2 <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            fpll_lock_q1       <= FPLL_LOCK_int;
            fpll_lock_q2       <= fpll_lock_q1;
            sdif0_spll_lock_q1 <= SDIF0_SPLL_LOCK_int;
            sdif0_spll_lock_q2 <= sdif0_spll_lock_q1;
            sdif1_spll_lock_q1 <= SDIF1_SPLL_LOCK_int;
            sdif1_spll_lock_q2 <= sdif1_spll_lock_q1;
            sdif2_spll_lock_q1 <= SDIF2_SPLL_LOCK_int;
            sdif2_spll_lock_q2 <= sdif2_spll_lock_q1;
            sdif3_spll_lock_q1 <= SDIF3_SPLL_LOCK_int;
            sdif3_spll_lock_q2 <= sdif3_spll_lock_q1;
        end if;
    end process;

    -----------------------------------------------------------------------
    -- State machine 0
    -- This is essentially the main state machine in the design.
    -- Controls DDR resets and INIT_DONE output.
    -- Can hold EXT_RESET (if core is appropriately configured).
    -----------------------------------------------------------------------
    -- State machine 0 - combinational part
    process (
        sm0_state,
        FDDR_CORE_RESET_N_int,
        MDDR_DDR_AXI_S_CORE_RESET_N_int,
        count_ddr_enable,
        DDR_READY_int,
        SDIF_RELEASED_int,
        SDIF_READY_int,
        release_ext_reset,
        INIT_DONE_int,
        CONFIG1_DONE_clk_base,
        CONFIG2_DONE_clk_base,
        fpll_lock_q2,
        sdif0_spll_lock_q2,
        sdif1_spll_lock_q2,
        sdif2_spll_lock_q2,
        sdif3_spll_lock_q2,
        ddr_settled_clk_base,
        release_sdif0_core_clk_base,
        release_sdif1_core_clk_base,
        release_sdif2_core_clk_base,
        release_sdif3_core_clk_base
    )
    begin
        next_sm0_state <= sm0_state;
        next_fddr_core_reset_n <= FDDR_CORE_RESET_N_int;
        next_mddr_core_reset_n <= MDDR_DDR_AXI_S_CORE_RESET_N_int;
        next_count_ddr_enable <= count_ddr_enable;
        next_ddr_ready <= DDR_READY_int;
        next_sdif_released <= SDIF_RELEASED_int;
        next_sdif_ready <= SDIF_READY_int;
        next_release_ext_reset <= release_ext_reset;
        next_init_done <= INIT_DONE_int;
        case sm0_state is
            when "000" =>
                next_sm0_state <= "001";
            when "001" =>
                next_sm0_state <= "010";
                -- Release resets to FDDR and MDDR blocks
                next_fddr_core_reset_n <= '1';
                next_mddr_core_reset_n <= '1';
            when "010" =>
                -- Wait for CONFIG1_DONE
                if (CONFIG1_DONE_clk_base = '1') then
                    next_sm0_state <= "011";
                end if;
            when "011" =>
                -- Start DDR counter after FPLL lock is asserted.
                -- (CONFIG1_DONE assertion is necessary to enter this state.)
                if (fpll_lock_q2 = '1') then
                    next_count_ddr_enable <= '1';
                end if;
                -- Wait for assertion of all PLL lock signals
                if (fpll_lock_q2 = '1'
                    and sdif0_spll_lock_q2 = '1' and sdif1_spll_lock_q2 = '1'
                    and sdif2_spll_lock_q2 = '1' and sdif3_spll_lock_q2 = '1'
                   ) then
                    next_sm0_state <= "100";
                end if;
            when "100" =>
                if (ddr_settled_clk_base = '1') then
                    next_count_ddr_enable   <= '0';
                    next_ddr_ready          <= '1';
                end if;
                if (ddr_settled_clk_base = '1'
                    and release_sdif0_core_clk_base = '1'
                    and release_sdif1_core_clk_base = '1'
                    and release_sdif2_core_clk_base = '1'
                    and release_sdif3_core_clk_base = '1'
                   ) then
                    next_sm0_state          <= "101";
                    next_sdif_released      <= '1';
                end if;
            when "101" =>
                -- Wait for indication from configuration master that SDIF
                -- configuration has been completed.
                if (CONFIG2_DONE_clk_base = '1') then
                    next_sm0_state          <= "110";
                    next_sdif_ready         <= '1';
                    next_release_ext_reset  <= '1';
                end if;
            when "110" =>
                next_init_done <= '1';
            when others =>
                next_sm0_state <= "000";
        end case;
    end process;

    -- State machine 0 - sequential part
    process (CLK_BASE, sm0_areset_n_clk_base)
    begin
        if (sm0_areset_n_clk_base = '0') then
            sm0_state                       <= "000";
            FDDR_CORE_RESET_N_int           <= '0';
            MDDR_DDR_AXI_S_CORE_RESET_N_int <= '0';
            count_ddr_enable                <= '0';
            DDR_READY_int                   <= '0';
            SDIF_RELEASED_int               <= '0';
            SDIF_READY_int                  <= '0';
            release_ext_reset               <= '0';
            INIT_DONE_int                   <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sm0_state                       <= next_sm0_state;
            FDDR_CORE_RESET_N_int           <= next_fddr_core_reset_n;
            MDDR_DDR_AXI_S_CORE_RESET_N_int <= next_mddr_core_reset_n;
            count_ddr_enable                <= next_count_ddr_enable;
            DDR_READY_int                   <= next_ddr_ready;
            SDIF_RELEASED_int               <= next_sdif_released;
            SDIF_READY_int                  <= next_sdif_ready;
            release_ext_reset               <= next_release_ext_reset;
            INIT_DONE_int                   <= next_init_done;
        end if;
    end process;

    DDR_READY       <= DDR_READY_int;
    SDIF_RELEASED   <= SDIF_RELEASED_int;
    SDIF_READY      <= SDIF_READY_int;
    INIT_DONE       <= INIT_DONE_int;

    -- End of state machine 0.
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- State machine for controlling SDIF0 reset signals
    -----------------------------------------------------------------------
    process(
        sdif0_state,
        SDIF0_PHY_RESET_N_int,
        SDIF0_CORE_RESET_N_0,
        count_sdif0_enable,
        CONFIG1_DONE_clk_base,
        sdif0_spll_lock_q2,
        ddr_settled_clk_base,
        release_sdif0_core_clk_base
    )
    begin
        next_sdif0_state <= sdif0_state;
        next_sdif0_phy_reset_n <= SDIF0_PHY_RESET_N_int;
        next_sdif0_core_reset_n <= SDIF0_CORE_RESET_N_0;
        next_count_sdif0_enable <= count_sdif0_enable;
        case sdif0_state is
            when S0 =>
                next_sdif0_state <= S1;
            when S1 =>
                next_sdif0_state <= S2;
            when S2 =>
                -- Wait for CONFIG1_DONE and PLL lock signal
                if (CONFIG1_DONE_clk_base = '1' and sdif0_spll_lock_q2 = '1') then
                    next_sdif0_state <= S3;
                    -- Release SDIF0 phy reset and start SDIF0 counter
                    next_sdif0_phy_reset_n  <= '1';
                    next_count_sdif0_enable <= '1';
                end if;
            when S3 =>
                if (ddr_settled_clk_base = '1' and release_sdif0_core_clk_base = '1') then
                    next_sdif0_state <= S3;
                    next_sdif0_core_reset_n <= '1';
                    next_count_sdif0_enable <= '0';
                end if;
            when others =>
                next_sdif0_state <= S0;
        end case;
    end process;

    process (CLK_BASE, sdif0_areset_n_clk_base)
    begin
        if (sdif0_areset_n_clk_base = '0') then
            sdif0_state             <= S0;
            SDIF0_PHY_RESET_N_int   <= '0';
            SDIF0_CORE_RESET_N_0    <= '0';
            count_sdif0_enable      <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif0_state             <= next_sdif0_state;
            SDIF0_PHY_RESET_N_int   <= next_sdif0_phy_reset_n;
            SDIF0_CORE_RESET_N_0    <= next_sdif0_core_reset_n;
            count_sdif0_enable      <= next_count_sdif0_enable;
        end if;
    end process;
    -- End of state machine for controlling SDIF0 reset signals.
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- State machine for controlling SDIF1 reset signals
    -----------------------------------------------------------------------
    process(
        sdif1_state,
        SDIF1_PHY_RESET_N_int,
        SDIF1_CORE_RESET_N_0,
        count_sdif1_enable,
        CONFIG1_DONE_clk_base,
        sdif1_spll_lock_q2,
        ddr_settled_clk_base,
        release_sdif1_core_clk_base
    )
    begin
        next_sdif1_state <= sdif1_state;
        next_sdif1_phy_reset_n <= SDIF1_PHY_RESET_N_int;
        next_sdif1_core_reset_n <= SDIF1_CORE_RESET_N_0;
        next_count_sdif1_enable <= count_sdif1_enable;
        case sdif1_state is
            when S0 =>
                next_sdif1_state <= S1;
            when S1 =>
                next_sdif1_state <= S2;
            when S2 =>
                -- Wait for CONFIG1_DONE and PLL lock signal
                if (CONFIG1_DONE_clk_base = '1' and sdif1_spll_lock_q2 = '1') then
                    next_sdif1_state <= S3;
                    -- Release SDIF1 phy reset and start SDIF1 counter
                    next_sdif1_phy_reset_n  <= '1';
                    next_count_sdif1_enable <= '1';
                end if;
            when S3 =>
                if (ddr_settled_clk_base = '1' and release_sdif1_core_clk_base = '1') then
                    next_sdif1_state <= S3;
                    next_sdif1_core_reset_n <= '1';
                    next_count_sdif1_enable <= '0';
                end if;
            when others =>
                next_sdif1_state <= S0;
        end case;
    end process;

    process (CLK_BASE, sdif1_areset_n_clk_base)
    begin
        if (sdif1_areset_n_clk_base = '0') then
            sdif1_state             <= S0;
            SDIF1_PHY_RESET_N_int   <= '0';
            SDIF1_CORE_RESET_N_0    <= '0';
            count_sdif1_enable      <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif1_state             <= next_sdif1_state;
            SDIF1_PHY_RESET_N_int   <= next_sdif1_phy_reset_n;
            SDIF1_CORE_RESET_N_0    <= next_sdif1_core_reset_n;
            count_sdif1_enable      <= next_count_sdif1_enable;
        end if;
    end process;
    -- End of state machine for controlling SDIF1 reset signals.
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- State machine for controlling SDIF2 reset signals
    -----------------------------------------------------------------------
    process(
        sdif2_state,
        SDIF2_PHY_RESET_N_int,
        SDIF2_CORE_RESET_N_0,
        count_sdif2_enable,
        CONFIG1_DONE_clk_base,
        sdif2_spll_lock_q2,
        ddr_settled_clk_base,
        release_sdif2_core_clk_base
    )
    begin
        next_sdif2_state <= sdif2_state;
        next_sdif2_phy_reset_n <= SDIF2_PHY_RESET_N_int;
        next_sdif2_core_reset_n <= SDIF2_CORE_RESET_N_0;
        next_count_sdif2_enable <= count_sdif2_enable;
        case sdif2_state is
            when S0 =>
                next_sdif2_state <= S1;
            when S1 =>
                next_sdif2_state <= S2;
            when S2 =>
                -- Wait for CONFIG1_DONE and PLL lock signal
                if (CONFIG1_DONE_clk_base = '1' and sdif2_spll_lock_q2 = '1') then
                    next_sdif2_state <= S3;
                    -- Release SDIF2 phy reset and start SDIF2 counter
                    next_sdif2_phy_reset_n  <= '1';
                    next_count_sdif2_enable <= '1';
                end if;
            when S3 =>
                if (ddr_settled_clk_base = '1' and release_sdif2_core_clk_base = '1') then
                    next_sdif2_state <= S3;
                    next_sdif2_core_reset_n <= '1';
                    next_count_sdif2_enable <= '0';
                end if;
            when others =>
                next_sdif2_state <= S0;
        end case;
    end process;

    process (CLK_BASE, sdif2_areset_n_clk_base)
    begin
        if (sdif2_areset_n_clk_base = '0') then
            sdif2_state             <= S0;
            SDIF2_PHY_RESET_N_int   <= '0';
            SDIF2_CORE_RESET_N_0    <= '0';
            count_sdif2_enable      <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif2_state             <= next_sdif2_state;
            SDIF2_PHY_RESET_N_int   <= next_sdif2_phy_reset_n;
            SDIF2_CORE_RESET_N_0    <= next_sdif2_core_reset_n;
            count_sdif2_enable      <= next_count_sdif2_enable;
        end if;
    end process;
    -- End of state machine for controlling SDIF2 reset signals.
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- State machine for controlling SDIF3 reset signals
    -----------------------------------------------------------------------
    process(
        sdif3_state,
        SDIF3_PHY_RESET_N_int,
        SDIF3_CORE_RESET_N_0,
        count_sdif3_enable,
        CONFIG1_DONE_clk_base,
        sdif3_spll_lock_q2,
        ddr_settled_clk_base,
        release_sdif3_core_clk_base
    )
    begin
        next_sdif3_state <= sdif3_state;
        next_sdif3_phy_reset_n <= SDIF3_PHY_RESET_N_int;
        next_sdif3_core_reset_n <= SDIF3_CORE_RESET_N_0;
        next_count_sdif3_enable <= count_sdif3_enable;
        case sdif3_state is
            when S0 =>
                next_sdif3_state <= S1;
            when S1 =>
                next_sdif3_state <= S2;
            when S2 =>
                -- Wait for CONFIG1_DONE and PLL lock signal
                if (CONFIG1_DONE_clk_base = '1' and sdif3_spll_lock_q2 = '1') then
                    next_sdif3_state <= S3;
                    -- Release SDIF3 phy reset and start SDIF3 counter
                    next_sdif3_phy_reset_n  <= '1';
                    next_count_sdif3_enable <= '1';
                end if;
            when S3 =>
                if (ddr_settled_clk_base = '1' and release_sdif3_core_clk_base = '1') then
                    next_sdif3_state <= S3;
                    next_sdif3_core_reset_n <= '1';
                    next_count_sdif3_enable <= '0';
                end if;
            when others =>
                next_sdif3_state <= S0;
        end case;
    end process;

    process (CLK_BASE, sdif3_areset_n_clk_base)
    begin
        if (sdif3_areset_n_clk_base = '0') then
            sdif3_state             <= S0;
            SDIF3_PHY_RESET_N_int   <= '0';
            SDIF3_CORE_RESET_N_0    <= '0';
            count_sdif3_enable      <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif3_state             <= next_sdif3_state;
            SDIF3_PHY_RESET_N_int   <= next_sdif3_phy_reset_n;
            SDIF3_CORE_RESET_N_0    <= next_sdif3_core_reset_n;
            count_sdif3_enable      <= next_count_sdif3_enable;
        end if;
    end process;
    -- End of state machine for controlling SDIF3 reset signals.
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- Control of RESET_N_F2M and M3_RESET_N signals.
    -----------------------------------------------------------------------
    process (CLK_BASE, sm1_areset_n_clk_base)
    begin
        if (sm1_areset_n_clk_base = '0') then
            RESET_N_F2M_int     <= '0';
            M3_RESET_N_int      <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            RESET_N_F2M_int     <= '1';
            M3_RESET_N_int      <= '1';
        end if;
    end process;
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- State machine 2
    -- Controls EXT_RESET_OUT signal.
    -----------------------------------------------------------------------
    -- State machine 2 - combinational part
    process (
        sm2_state,
        EXT_RESET_OUT_int,
        release_ext_reset
    )
    begin
        next_sm2_state <= sm2_state;
        next_ext_reset_out <= EXT_RESET_OUT_int;
        case sm2_state is
            when "000" =>
                next_sm2_state <= "001";
            when "001" =>
                -- release_ext_reset is controlled by state machine 0.
                if (release_ext_reset = '1') then
                    next_ext_reset_out <= '0';
                end if;
            when others =>
                next_sm2_state <= "000";
        end case;
    end process;

    -- State machine 2 - sequential part
    process (CLK_BASE, sm2_areset_n_clk_base)
    variable ext_res_out_rv : std_logic;
    begin
        if (EXT_RESET_CFG > 0) then
            ext_res_out_rv := '1';
        else
            ext_res_out_rv := '0';
        end if;
        if (sm2_areset_n_clk_base = '0') then
            sm2_state       <= "000";
            EXT_RESET_OUT_int <= ext_res_out_rv;
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sm2_state       <= next_sm2_state;
            EXT_RESET_OUT_int <= next_ext_reset_out;
        end if;
    end process;
    -- End of state machine 2.
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    -- Counters clocked by RCOSC_25_50MHZ used to time SERDES and DDR
    -- intervals.
    --

    -- Synchronize enable signals to RCOSC_25_50MHZ domain
    process (RCOSC_25_50MHZ, sm0_areset_n_rcosc)
    begin
        if (sm0_areset_n_rcosc = '0') then
            count_sdif0_enable_q1       <= '0';
            count_sdif1_enable_q1       <= '0';
            count_sdif2_enable_q1       <= '0';
            count_sdif3_enable_q1       <= '0';
            count_sdif0_enable_rcosc    <= '0';
            count_sdif1_enable_rcosc    <= '0';
            count_sdif2_enable_rcosc    <= '0';
            count_sdif3_enable_rcosc    <= '0';
            count_ddr_enable_q1         <= '0';
            count_ddr_enable_rcosc      <= '0';

        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            count_sdif0_enable_q1       <= count_sdif0_enable;
            count_sdif1_enable_q1       <= count_sdif1_enable;
            count_sdif2_enable_q1       <= count_sdif2_enable;
            count_sdif3_enable_q1       <= count_sdif3_enable;
            count_sdif0_enable_rcosc    <= count_sdif0_enable_q1;
            count_sdif1_enable_rcosc    <= count_sdif1_enable_q1;
            count_sdif2_enable_rcosc    <= count_sdif2_enable_q1;
            count_sdif3_enable_rcosc    <= count_sdif3_enable_q1;
            count_ddr_enable_q1         <= count_ddr_enable;
            count_ddr_enable_rcosc      <= count_ddr_enable_q1;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif0_areset_n_rcosc)
    begin
        if (sdif0_areset_n_rcosc = '0') then
            count_sdif0 <= (others => '0');
            release_sdif0_core <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            -- If the SDIF0 interface is not being used, then set
            -- release_sdif0_core high. This ensures that there is no
            -- unnecessary waiting for SDIF0.
            if (SDIF0_IN_USE = 0) then
                release_sdif0_core <= '1';
            else
                if (count_sdif0_enable_rcosc = '1') then
                    count_sdif0 <= std_logic_vector(unsigned(count_sdif0) + 1);
                end if;
                -- Detect when enough time has elapsed since release of
                -- SDIF0 PHY reset to allow release of SDIF0 core reset.
                if (count_sdif0 = std_logic_vector(to_unsigned(SDIF_INTERVAL, COUNT_WIDTH_SDIF))) then
                    release_sdif0_core <= '1';
                end if;
            end if;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif1_areset_n_rcosc)
    begin
        if (sdif1_areset_n_rcosc = '0') then
            count_sdif1 <= (others => '0');
            release_sdif1_core <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            -- If the SDIF1 interface is not being used, then set
            -- release_sdif1_core high. This ensures that there is no
            -- unnecessary waiting for SDIF1.
            if (SDIF1_IN_USE = 0) then
                release_sdif1_core <= '1';
            else
                if (count_sdif1_enable_rcosc = '1') then
                    count_sdif1 <= std_logic_vector(unsigned(count_sdif1) + 1);
                end if;
                -- Detect when enough time has elapsed since release of
                -- SDIF1 PHY reset to allow release of SDIF1 core reset.
                if (count_sdif1 = std_logic_vector(to_unsigned(SDIF_INTERVAL, COUNT_WIDTH_SDIF))) then
                    release_sdif1_core <= '1';
                end if;
            end if;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif2_areset_n_rcosc)
    begin
        if (sdif2_areset_n_rcosc = '0') then
            count_sdif2 <= (others => '0');
            release_sdif2_core <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            -- If the SDIF2 interface is not being used, then set
            -- release_sdif2_core high. This ensures that there is no
            -- unnecessary waiting for SDIF2.
            if (SDIF2_IN_USE = 0) then
                release_sdif2_core <= '1';
            else
                if (count_sdif2_enable_rcosc = '1') then
                    count_sdif2 <= std_logic_vector(unsigned(count_sdif2) + 1);
                end if;
                -- Detect when enough time has elapsed since release of
                -- SDIF2 PHY reset to allow release of SDIF2 core reset.
                if (count_sdif2 = std_logic_vector(to_unsigned(SDIF_INTERVAL, COUNT_WIDTH_SDIF))) then
                    release_sdif2_core <= '1';
                end if;
            end if;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sdif3_areset_n_rcosc)
    begin
        if (sdif3_areset_n_rcosc = '0') then
            count_sdif3 <= (others => '0');
            release_sdif3_core <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            -- If the SDIF3 interface is not being used, then set
            -- release_sdif3_core high. This ensures that there is no
            -- unnecessary waiting for SDIF3.
            if (SDIF3_IN_USE = 0) then
                release_sdif3_core <= '1';
            else
                if (count_sdif3_enable_rcosc = '1') then
                    count_sdif3 <= std_logic_vector(unsigned(count_sdif3) + 1);
                end if;
                -- Detect when enough time has elapsed since release of
                -- SDIF3 PHY reset to allow release of SDIF3 core reset.
                if (count_sdif3 = std_logic_vector(to_unsigned(SDIF_INTERVAL, COUNT_WIDTH_SDIF))) then
                    release_sdif3_core <= '1';
                end if;
            end if;
        end if;
    end process;

    process (RCOSC_25_50MHZ, sm0_areset_n_rcosc)
    begin
        if (sm0_areset_n_rcosc = '0') then
            count_ddr <= (others => '0');
            ddr_settled <= '0';
        elsif (RCOSC_25_50MHZ'event and RCOSC_25_50MHZ = '1') then
            -- If DDR is not being used, then set ddr_settled high. This
            -- ensures that there is no unnecessary waiting for DDR
            -- readiness.
            if (MDDR_IN_USE = 0 and FDDR_IN_USE = 0) then
                ddr_settled <= '1';
            else
                if (count_ddr_enable_rcosc = '1') then
                    count_ddr <= std_logic_vector(unsigned(count_ddr) + 1);
                end if;
                -- Detect when enough time has elapsed since release of DDR
                -- core reset to allow DDR memory to be ready for use.
                if (count_ddr = std_logic_vector(to_unsigned(DDR_INTERVAL, COUNT_WIDTH_DDR))) then
                    ddr_settled <= '1';
                end if;
            end if;
        end if;
    end process;

    -- Synchronize "ready" signals to CLK_BASE domain
    process (CLK_BASE, sm0_areset_n_clk_base)
    begin
        if (sm0_areset_n_clk_base = '0') then
            release_sdif0_core_q1           <= '0';
            release_sdif1_core_q1           <= '0';
            release_sdif2_core_q1           <= '0';
            release_sdif3_core_q1           <= '0';
            release_sdif0_core_clk_base     <= '0';
            release_sdif1_core_clk_base     <= '0';
            release_sdif2_core_clk_base     <= '0';
            release_sdif3_core_clk_base     <= '0';
            ddr_settled_q1                  <= '0';
            ddr_settled_clk_base            <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            release_sdif0_core_q1           <= release_sdif0_core;
            release_sdif1_core_q1           <= release_sdif1_core;
            release_sdif2_core_q1           <= release_sdif2_core;
            release_sdif3_core_q1           <= release_sdif3_core;
            release_sdif0_core_clk_base     <= release_sdif0_core_q1;
            release_sdif1_core_clk_base     <= release_sdif1_core_q1;
            release_sdif2_core_clk_base     <= release_sdif2_core_q1;
            release_sdif3_core_clk_base     <= release_sdif3_core_q1;
            ddr_settled_q1                  <= ddr_settled;
            ddr_settled_clk_base            <= ddr_settled_q1;
        end if;
    end process;


    -----------------------------------------------------------------------
    -- Implement PCIe HotReset workaround for SDIF blocks (if configured).
    -----------------------------------------------------------------------
    -----------------------------------------------------------------------
    SDIF0_HR_FIX_INCLUDED:
    if (
            (SDIF0_IN_USE        = 1)
        and (SDIF0_PCIE          = 1)
        and (SDIF0_PCIE_HOTRESET = 1)
       )
    generate begin
        sdif0_phr: coreresetp_pcie_hotreset
        port map (
            CLK_BASE               => CLK_BASE,
            CLK_LTSSM              => CLK_LTSSM,
            psel                   => SDIF0_PSEL,
            pwrite                 => SDIF0_PWRITE,
            prdata                 => SDIF0_PRDATA,
            sdif_core_reset_n_0    => SDIF0_CORE_RESET_N_0,
            sdif_core_reset_n      => SDIF0_CORE_RESET_N_int
        );
    end generate SDIF0_HR_FIX_INCLUDED;
    -----------------------------------------------------------------------
    SDIF0_HR_FIX_NOT_INCLUDED:
    if (
            (SDIF0_IN_USE        = 0)
        or  (SDIF0_PCIE          = 0)
        or  (SDIF0_PCIE_HOTRESET = 0)
       )
    generate begin
        SDIF0_CORE_RESET_N_int <= SDIF0_CORE_RESET_N_0;
    end generate SDIF0_HR_FIX_NOT_INCLUDED;
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    SDIF1_HR_FIX_INCLUDED:
    if (
            (SDIF1_IN_USE        = 1)
        and (SDIF1_PCIE          = 1)
        and (SDIF1_PCIE_HOTRESET = 1)
       )
    generate begin
        sdif1_phr: coreresetp_pcie_hotreset
        port map (
            CLK_BASE               => CLK_BASE,
            CLK_LTSSM              => CLK_LTSSM,
            psel                   => SDIF1_PSEL,
            pwrite                 => SDIF1_PWRITE,
            prdata                 => SDIF1_PRDATA,
            sdif_core_reset_n_0    => SDIF1_CORE_RESET_N_0,
            sdif_core_reset_n      => SDIF1_CORE_RESET_N_int
        );
    end generate SDIF1_HR_FIX_INCLUDED;
    -----------------------------------------------------------------------
    SDIF1_HR_FIX_NOT_INCLUDED:
    if (
            (SDIF1_IN_USE        = 0)
        or  (SDIF1_PCIE          = 0)
        or  (SDIF1_PCIE_HOTRESET = 0)
       )
    generate begin
        SDIF1_CORE_RESET_N_int <= SDIF1_CORE_RESET_N_0;
    end generate SDIF1_HR_FIX_NOT_INCLUDED;
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    SDIF2_HR_FIX_INCLUDED:
    if (
            (SDIF2_IN_USE        = 1)
        and (SDIF2_PCIE          = 1)
        and (SDIF2_PCIE_HOTRESET = 1)
       )
    generate begin
        sdif2_phr: coreresetp_pcie_hotreset
        port map (
            CLK_BASE               => CLK_BASE,
            CLK_LTSSM              => CLK_LTSSM,
            psel                   => SDIF2_PSEL,
            pwrite                 => SDIF2_PWRITE,
            prdata                 => SDIF2_PRDATA,
            sdif_core_reset_n_0    => SDIF2_CORE_RESET_N_0,
            sdif_core_reset_n      => SDIF2_CORE_RESET_N_int
        );
    end generate SDIF2_HR_FIX_INCLUDED;
    -----------------------------------------------------------------------
    SDIF2_HR_FIX_NOT_INCLUDED:
    if (
            (SDIF2_IN_USE        = 0)
        or  (SDIF2_PCIE          = 0)
        or  (SDIF2_PCIE_HOTRESET = 0)
       )
    generate begin
        SDIF2_CORE_RESET_N_int <= SDIF2_CORE_RESET_N_0;
    end generate SDIF2_HR_FIX_NOT_INCLUDED;
    -----------------------------------------------------------------------

    -----------------------------------------------------------------------
    SDIF3_HR_FIX_INCLUDED:
    if (
            (SDIF3_IN_USE        = 1)
        and (SDIF3_PCIE          = 1)
        and (SDIF3_PCIE_HOTRESET = 1)
       )
    generate begin
        sdif3_phr: coreresetp_pcie_hotreset
        port map (
            CLK_BASE               => CLK_BASE,
            CLK_LTSSM              => CLK_LTSSM,
            psel                   => SDIF3_PSEL,
            pwrite                 => SDIF3_PWRITE,
            prdata                 => SDIF3_PRDATA,
            sdif_core_reset_n_0    => SDIF3_CORE_RESET_N_0,
            sdif_core_reset_n      => SDIF3_CORE_RESET_N_int
        );
    end generate SDIF3_HR_FIX_INCLUDED;
    -----------------------------------------------------------------------
    SDIF3_HR_FIX_NOT_INCLUDED:
    if (
            (SDIF3_IN_USE        = 0)
        or  (SDIF3_PCIE          = 0)
        or  (SDIF3_PCIE_HOTRESET = 0)
       )
    generate begin
        SDIF3_CORE_RESET_N_int <= SDIF3_CORE_RESET_N_0;
    end generate SDIF3_HR_FIX_NOT_INCLUDED;
    -----------------------------------------------------------------------

end rtl;
