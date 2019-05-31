-- ********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2011 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	Implements indirect address registers for CoreAPB3
--
--
-- SVN Revision Information:
-- SVN $Revision: 23124 $
-- SVN $Date: 2014-07-17 15:31:27 +0100 (Thu, 17 Jul 2014) $
--
--
-- Notes:
-- 1. best viewed with tabstops set to "4" (tabs used throughout file)
--
-- *********************************************************************/
library ieee;
use ieee.std_logic_1164.all;

entity coreapb3_iaddr_reg is
    generic (
		SYNC_RESET      : integer := 0;
        APB_DWIDTH      : integer range 8 to 32  := 32;
        MADDR_BITS      : integer range 12 to 32 := 32
    );
    port (
        PCLK            : in  std_logic;
        PRESETN         : in  std_logic;
        PENABLE         : in  std_logic;
        PSEL            : in  std_logic;
        PADDR           : in  std_logic_vector(31 downto 0);
        PWRITE          : in  std_logic;
        PWDATA          : in  std_logic_vector(31 downto 0);
        PRDATA          : out std_logic_vector(31 downto 0);
        --PREADY          : out std_logic;
        --PSLVERR         : out std_logic;
        IADDR_REG       : out std_logic_vector(31 downto 0)
    );
end entity coreapb3_iaddr_reg;


architecture rtl of coreapb3_iaddr_reg is

    signal IADDR_REG_i      : std_logic_vector(31 downto 0);
    signal aresetn          :   std_logic;
    signal sresetn          :   std_logic;

    constant zero32 : std_logic_vector(31 downto 0) := (others => '0');

begin
aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';
    -----------------------------------------------------------------
    process (PCLK, aresetn)
    begin
        if (aresetn = '0') then
            IADDR_REG_i <= (others => '0');
        elsif (PCLK'event and PCLK = '1') then
            if (sresetn = '0') then
                IADDR_REG_i <= (others => '0');
		    else
                if (PSEL = '1' and PENABLE = '1' and PWRITE = '1') then
                    if (APB_DWIDTH = 32) then
                        if (PADDR(MADDR_BITS-4-1 downto 0) = zero32(MADDR_BITS-4-1 downto 0)) then
                            IADDR_REG_i <= PWDATA;
                        end if;
                    end if;
                    if (APB_DWIDTH = 16) then
                        if (PADDR(MADDR_BITS-4-1 downto 4) = zero32(MADDR_BITS-4-1 downto 4)) then
                            case PADDR(3 downto 0) is
                                when "0000" => IADDR_REG_i(15 downto  0) <= PWDATA(15 downto 0);
                                when "0100" => IADDR_REG_i(31 downto 16) <= PWDATA(15 downto 0);
                                when "1000" => IADDR_REG_i               <= IADDR_REG_i;
                                when "1100" => IADDR_REG_i               <= IADDR_REG_i;
                                when others => null;
                            end case;
                        end if;
                    end if;
                    if (APB_DWIDTH =  8) then
                        if (PADDR(MADDR_BITS-4-1 downto 4) = zero32(MADDR_BITS-4-1 downto 4)) then
                            case PADDR(3 downto 0) is
                                when "0000" => IADDR_REG_i( 7 downto  0) <= PWDATA(7 downto 0);
                                when "0100" => IADDR_REG_i(15 downto  8) <= PWDATA(7 downto 0);
                                when "1000" => IADDR_REG_i(23 downto 16) <= PWDATA(7 downto 0);
                                when "1100" => IADDR_REG_i(31 downto 24) <= PWDATA(7 downto 0);
                                when others => null;
                            end case;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    IADDR_REG <= IADDR_REG_i;

    process (IADDR_REG_i, PADDR)
    begin
        PRDATA <= (others => '0');
        if (APB_DWIDTH = 32) then
            if (PADDR(MADDR_BITS-4-1 downto 0) = zero32(MADDR_BITS-4-1 downto 0)) then
                PRDATA <= IADDR_REG_i;
            end if;
        end if;
        if (APB_DWIDTH = 16) then
            if (PADDR(MADDR_BITS-4-1 downto 4) = zero32(MADDR_BITS-4-1 downto 4)) then
                case PADDR(3 downto 0) is
                    when "0000" => PRDATA(15 downto 0) <= IADDR_REG_i(15 downto  0);
                    when "0100" => PRDATA(15 downto 0) <= IADDR_REG_i(31 downto 16);
                    when "1000" => PRDATA              <= (others => '0');
                    when "1100" => PRDATA              <= (others => '0');
                    when others => null;
                end case;
            end if;
        end if;
        if (APB_DWIDTH =  8) then
            if (PADDR(MADDR_BITS-4-1 downto 4) = zero32(MADDR_BITS-4-1 downto 4)) then
                case PADDR(3 downto 0) is
                    when "0000" => PRDATA(7 downto 0) <= IADDR_REG_i( 7 downto  0);
                    when "0100" => PRDATA(7 downto 0) <= IADDR_REG_i(15 downto  8);
                    when "1000" => PRDATA(7 downto 0) <= IADDR_REG_i(23 downto 16);
                    when "1100" => PRDATA(7 downto 0) <= IADDR_REG_i(31 downto 24);
                    when others => null;
                end case;
            end if;
        end if;
    end process;

end architecture rtl;
