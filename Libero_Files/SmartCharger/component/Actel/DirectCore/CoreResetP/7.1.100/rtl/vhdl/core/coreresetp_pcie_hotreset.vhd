-- ***********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2013 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	CoreResetP PCIe HotReset Fix.
--				This module is intended for use when an SDIF block has been
--              configured for PCIe. This module provides a PCIe HotReset
--              fix/workaround by tracking the LTSSM state machine inside
--              the SDIF block and asserting the CORE reset input to the
--              block when appropriate.
--
--              It is intended that inclusion/use of this module is
--              selected at a higher level using parameter setting(s).
--
--              LTSSM status information is available on the PRDATA bus
--              from the SDIF block when an APB read is not in progress.
--
--
-- SVN Revision Information:
-- SVN $Revision: 21127 $
-- SVN $Date: 2013-09-17 18:02:47 +0100 (Tue, 17 Sep 2013) $
--
-- Notes:
--
-- ***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coreresetp_pcie_hotreset is
    port (
        CLK_BASE                : in  std_logic;
        CLK_LTSSM               : in  std_logic;
        psel                    : in  std_logic;
        pwrite                  : in  std_logic;
        prdata                  : in  std_logic_vector(31 downto 0);
        sdif_core_reset_n_0     : in  std_logic;
        sdif_core_reset_n       : out std_logic
    );
end coreresetp_pcie_hotreset;

architecture rtl of coreresetp_pcie_hotreset is
    -- Parameters for state machine states
    constant IDLE            : std_logic_vector(1 downto 0) := "00";
    constant HOTRESET_DETECT : std_logic_vector(1 downto 0) := "01";
    constant DETECT_QUIET    : std_logic_vector(1 downto 0) := "10";
    constant RESET_ASSERT    : std_logic_vector(1 downto 0) := "11";

    -- LTSSM state values (on prdata[30:26])
    constant LTSSM_STATE_HotReset    : std_logic_vector(4 downto 0) := "10100";
    constant LTSSM_STATE_DetectQuiet : std_logic_vector(4 downto 0) := "00000";
    constant LTSSM_STATE_Disabled    : std_logic_vector(4 downto 0) := "10000";

    -- Signals
    signal no_apb_read              : std_logic;
    signal state                    : std_logic_vector(1 downto 0);
    signal hot_reset_n              : std_logic;
    signal count                    : std_logic_vector(6 downto 0);

    signal core_areset_n            : std_logic;

    signal LTSSM_HotReset           : std_logic;
    signal LTSSM_DetectQuiet        : std_logic;
    signal LTSSM_Disabled           : std_logic;

    signal LTSSM_HotReset_q         : std_logic;
    signal LTSSM_DetectQuiet_q      : std_logic;
    signal LTSSM_Disabled_q         : std_logic;

    signal LTSSM_HotReset_entry_p   : std_logic;
    signal LTSSM_DetectQuiet_entry_p: std_logic;
    signal LTSSM_Disabled_entry_p   : std_logic;

    signal reset_n_q1               : std_logic;
    signal reset_n_clk_ltssm        : std_logic;

    signal ltssm_q1                 : std_logic_vector(4 downto 0);
    signal ltssm_q2                 : std_logic_vector(4 downto 0);
    signal psel_q1                  : std_logic;
    signal psel_q2                  : std_logic;
    signal pwrite_q1                : std_logic;
    signal pwrite_q2                : std_logic;

    signal sdif_core_reset_n_q1     : std_logic;

begin

    -- Synchronize reset to CLK_LTSSM domain
    process (CLK_LTSSM, sdif_core_reset_n_0)
    begin
        if (sdif_core_reset_n_0 = '0') then
            reset_n_q1        <= '0';
            reset_n_clk_ltssm <= '0';
        elsif (CLK_LTSSM'event and CLK_LTSSM = '1') then
            reset_n_q1        <= '1';
            reset_n_clk_ltssm <= reset_n_q1;
        end if;
    end process;

    -- Synchronize APB signals to CLK_LTSSM domain
    process (CLK_LTSSM, reset_n_clk_ltssm)
    begin
        if (reset_n_clk_ltssm = '0') then
            ltssm_q1  <= "00000";
            ltssm_q2  <= "00000";
            psel_q1   <= '0';
            psel_q2   <= '0';
            pwrite_q1 <= '0';
            pwrite_q2 <= '0';
        elsif (CLK_LTSSM'event and CLK_LTSSM = '1') then
            ltssm_q1  <= prdata(30 downto 26);
            ltssm_q2  <= ltssm_q1;
            psel_q1   <= psel;
            psel_q2   <= psel_q1;
            pwrite_q1 <= pwrite;
            pwrite_q2 <= pwrite_q1;
        end if;
    end process;

    no_apb_read <= '1' when ((psel_q2 = '0') or (pwrite_q2 = '1')) else '0';

    -- Create pulse signals to indicate LTSSM state transitions.
    process (CLK_LTSSM, reset_n_clk_ltssm)
    begin
        if (reset_n_clk_ltssm = '0') then
            LTSSM_HotReset      <= '0';
            LTSSM_Disabled      <= '0';
            LTSSM_DetectQuiet   <= '0';

            LTSSM_HotReset_q    <= '0';
            LTSSM_Disabled_q    <= '0';
            LTSSM_DetectQuiet_q <= '0';

            LTSSM_HotReset_entry_p    <= '0';
            LTSSM_Disabled_entry_p    <= '0';
            LTSSM_DetectQuiet_entry_p <= '0';
        elsif (CLK_LTSSM'event and CLK_LTSSM = '1') then
            if (no_apb_read = '1') then
                if (ltssm_q2 = LTSSM_STATE_HotReset   ) then LTSSM_HotReset    <= '1'; else LTSSM_HotReset    <= '0'; end if;
                if (ltssm_q2 = LTSSM_STATE_Disabled   ) then LTSSM_Disabled    <= '1'; else LTSSM_Disabled    <= '0'; end if;
                if (ltssm_q2 = LTSSM_STATE_DetectQuiet) then LTSSM_DetectQuiet <= '1'; else LTSSM_DetectQuiet <= '0'; end if;
            else
                LTSSM_HotReset    <= '0';
                LTSSM_Disabled    <= '0';
                LTSSM_DetectQuiet <= '0';
            end if;

            LTSSM_HotReset_q          <= LTSSM_HotReset;
            LTSSM_Disabled_q          <= LTSSM_Disabled;
            LTSSM_DetectQuiet_q       <= LTSSM_DetectQuiet;

            LTSSM_HotReset_entry_p    <= not(LTSSM_HotReset_q   ) and LTSSM_HotReset;
            LTSSM_Disabled_entry_p    <= not(LTSSM_Disabled_q   ) and LTSSM_Disabled;
            LTSSM_DetectQuiet_entry_p <= not(LTSSM_DetectQuiet_q) and LTSSM_DetectQuiet;
        end if;
    end process;

    -----------------------------------------------------------------------
    -- State machine to control SDIF hot reset.
    -- Tracks LTSSM in SDIF and can cause assertion of core reset to SDIF.
    -----------------------------------------------------------------------
    process (CLK_LTSSM, reset_n_clk_ltssm)
    begin
        if (reset_n_clk_ltssm = '0') then
            state <= IDLE;
            hot_reset_n <= '1';
        elsif (CLK_LTSSM'event and CLK_LTSSM = '1') then
            case state is
                when IDLE =>
                    if (LTSSM_HotReset_entry_p = '1' or LTSSM_Disabled_entry_p = '1') then
                        state <= HOTRESET_DETECT;
                    end if;
                when HOTRESET_DETECT =>
                    if (LTSSM_DetectQuiet_entry_p = '1') then
                        state <= DETECT_QUIET;
                        hot_reset_n <= '0';
                    end if;
                when DETECT_QUIET =>
                    state <= RESET_ASSERT;
                when RESET_ASSERT =>
                    if (count = "1100011") then
                        state <= IDLE;
                        hot_reset_n <= '1';
                    end if;
                when others =>
                    state <= IDLE;
                    hot_reset_n <= '1';
            end case;
        end if;
    end process;

    -----------------------------------------------------------------------
    -- Counter used to ensure that the core_reset signal is asserted for
    -- a sufficient amount of time.
    -----------------------------------------------------------------------
    process (CLK_LTSSM, reset_n_clk_ltssm)
    begin
        if (reset_n_clk_ltssm = '0') then
            count <= "0000000";
        elsif (CLK_LTSSM'event and CLK_LTSSM = '1') then
            if (state = DETECT_QUIET) then
                count <= "0000000";
            else
                if (state = RESET_ASSERT) then
                    count <= std_logic_vector(unsigned(count) + 1);
                end if;
            end if;
        end if;
    end process;

    -- Async core reset signal
    core_areset_n <= hot_reset_n and sdif_core_reset_n_0;

    -- Create reset signal to SDIF core.
    -- (Synchronize core_areset_n signal to CLK_BASE domain.)
    process (CLK_BASE, core_areset_n)
    begin
        if (core_areset_n = '0') then
            sdif_core_reset_n_q1 <= '0';
            sdif_core_reset_n    <= '0';
        elsif (CLK_BASE'event and CLK_BASE = '1') then
            sdif_core_reset_n_q1 <= '1';
            sdif_core_reset_n    <= sdif_core_reset_n_q1;
        end if;
    end process;

end rtl;
