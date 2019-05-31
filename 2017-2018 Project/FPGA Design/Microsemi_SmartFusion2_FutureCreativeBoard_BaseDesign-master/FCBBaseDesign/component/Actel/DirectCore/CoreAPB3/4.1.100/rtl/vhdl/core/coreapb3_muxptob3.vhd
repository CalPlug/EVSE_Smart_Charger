-- ********************************************************************/
-- Actel Corporation Proprietary and Confidential
-- Copyright 2010 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	COREAPB3_MUXPTOB3 - Central mux - signals from peripherals to
--				bridge.  Stand-alone module to allow ease of removal if an
--				alternative interconnection scheme is to be used.
--
-- Revision Information:
-- Date			Description
-- ----			-----------------------------------------
-- 05Feb10		Production Release Version 3.0
--
-- SVN Revision Information:
-- SVN $Revision: 18496 $
-- SVN $Date: 2012-11-22 15:43:50 +0000 (Thu, 22 Nov 2012) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes:
-- 1. best viewed with tabstops set to "4" (tabs used throughout file)
--
-- *********************************************************************/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity COREAPB3_MUXPTOB3 is
port (
PSELS       : in std_logic_vector(16 downto 0);
PRDATAS0    : in std_logic_vector(31 downto 0);
PRDATAS1    : in std_logic_vector(31 downto 0);
PRDATAS2    : in std_logic_vector(31 downto 0);
PRDATAS3    : in std_logic_vector(31 downto 0);
PRDATAS4    : in std_logic_vector(31 downto 0);
PRDATAS5    : in std_logic_vector(31 downto 0);
PRDATAS6    : in std_logic_vector(31 downto 0);
PRDATAS7    : in std_logic_vector(31 downto 0);
PRDATAS8    : in std_logic_vector(31 downto 0);
PRDATAS9    : in std_logic_vector(31 downto 0);
PRDATAS10   : in std_logic_vector(31 downto 0);
PRDATAS11   : in std_logic_vector(31 downto 0);
PRDATAS12   : in std_logic_vector(31 downto 0);
PRDATAS13   : in std_logic_vector(31 downto 0);
PRDATAS14   : in std_logic_vector(31 downto 0);
PRDATAS15   : in std_logic_vector(31 downto 0);
PRDATAS16   : in std_logic_vector(31 downto 0);
PREADYS     : in std_logic_vector(16 downto 0);
PSLVERRS    : in std_logic_vector(16 downto 0);
PREADY      : out std_logic;
PSLVERR     : out std_logic;
PRDATA      : out std_logic_vector(31 downto 0)
);
end entity COREAPB3_MUXPTOB3;

architecture COREAPB3_MUXPTOB3_arch of COREAPB3_MUXPTOB3 is
constant PSEL_SL0	: std_logic_vector(4 downto 0) := "00000";
constant PSEL_SL1	: std_logic_vector(4 downto 0) := "00001";
constant PSEL_SL2	: std_logic_vector(4 downto 0) := "00010";
constant PSEL_SL3	: std_logic_vector(4 downto 0) := "00011";
constant PSEL_SL4	: std_logic_vector(4 downto 0) := "00100";
constant PSEL_SL5	: std_logic_vector(4 downto 0) := "00101";
constant PSEL_SL6	: std_logic_vector(4 downto 0) := "00110";
constant PSEL_SL7	: std_logic_vector(4 downto 0) := "00111";
constant PSEL_SL8	: std_logic_vector(4 downto 0) := "01000";
constant PSEL_SL9	: std_logic_vector(4 downto 0) := "01001";
constant PSEL_SL10	: std_logic_vector(4 downto 0) := "01010";
constant PSEL_SL11	: std_logic_vector(4 downto 0) := "01011";
constant PSEL_SL12	: std_logic_vector(4 downto 0) := "01100";
constant PSEL_SL13	: std_logic_vector(4 downto 0) := "01101";
constant PSEL_SL14	: std_logic_vector(4 downto 0) := "01110";
constant PSEL_SL15	: std_logic_vector(4 downto 0) := "01111";
constant PSEL_SL16	: std_logic_vector(4 downto 0) := "10000";
    signal iPREADY  : std_logic;
    signal iPSLVERR : std_logic;
    signal iPRDATA  : std_logic_vector(31 downto 0);
    signal PSELSBUS : std_logic_vector(4 downto 0);
    signal lo32     : std_logic_vector(31 downto 0);
begin
    lo32 <= (others=>'0');
    PSELSBUS(4) <= PSELS(16);
    PSELSBUS(3) <= PSELS(15) or PSELS(14) or PSELS(13) or PSELS(12) or PSELS(11) or PSELS(10) or PSELS(9) or PSELS(8);
    PSELSBUS(2) <= PSELS(15) or PSELS(14) or PSELS(13) or PSELS(12) or PSELS(7) or PSELS(6) or PSELS(5) or PSELS(4);
    PSELSBUS(1) <= PSELS(15) or PSELS(14) or PSELS(11) or PSELS(10) or PSELS(7) or PSELS(6) or PSELS(3) or PSELS(2);
    PSELSBUS(0) <= PSELS(15) or PSELS(13) or PSELS(11) or PSELS(9) or PSELS(7) or PSELS(5) or PSELS(3) or PSELS(1);
    process (PSELSBUS,PSELS,PRDATAS0,lo32,PRDATAS1,PRDATAS2,PRDATAS3,PRDATAS4,PRDATAS5,PRDATAS6,PRDATAS7,PRDATAS8,
             PRDATAS9,PRDATAS10,PRDATAS11,PRDATAS12,PRDATAS13,PRDATAS14,PRDATAS15,PRDATAS16)
    begin
        case PSELSBUS is
            when PSEL_SL0 =>
                if ((PSELS(0)) = '1') then
                    iPRDATA(31 downto 0) <= PRDATAS0(31 downto 0);
                else
                    iPRDATA(31 downto 0) <= lo32(31 downto 0);
                end if;
            when PSEL_SL1 =>
                iPRDATA(31 downto 0) <= PRDATAS1(31 downto 0);
            when PSEL_SL2 =>
                iPRDATA(31 downto 0) <= PRDATAS2(31 downto 0);
            when PSEL_SL3 =>
                iPRDATA(31 downto 0) <= PRDATAS3(31 downto 0);
            when PSEL_SL4 =>
                iPRDATA(31 downto 0) <= PRDATAS4(31 downto 0);
            when PSEL_SL5 =>
                iPRDATA(31 downto 0) <= PRDATAS5(31 downto 0);
            when PSEL_SL6 =>
                iPRDATA(31 downto 0) <= PRDATAS6(31 downto 0);
            when PSEL_SL7 =>
                iPRDATA(31 downto 0) <= PRDATAS7(31 downto 0);
            when PSEL_SL8 =>
                iPRDATA(31 downto 0) <= PRDATAS8(31 downto 0);
            when PSEL_SL9 =>
                iPRDATA(31 downto 0) <= PRDATAS9(31 downto 0);
            when PSEL_SL10 =>
                iPRDATA(31 downto 0) <= PRDATAS10(31 downto 0);
            when PSEL_SL11 =>
                iPRDATA(31 downto 0) <= PRDATAS11(31 downto 0);
            when PSEL_SL12 =>
                iPRDATA(31 downto 0) <= PRDATAS12(31 downto 0);
            when PSEL_SL13 =>
                iPRDATA(31 downto 0) <= PRDATAS13(31 downto 0);
            when PSEL_SL14 =>
                iPRDATA(31 downto 0) <= PRDATAS14(31 downto 0);
            when PSEL_SL15 =>
                iPRDATA(31 downto 0) <= PRDATAS15(31 downto 0);
            when PSEL_SL16 =>
                iPRDATA(31 downto 0) <= PRDATAS16(31 downto 0);
            when others =>
                iPRDATA(31 downto 0) <= lo32(31 downto 0);
        end case;
    end process;

    process (PSELSBUS,PSELS,PREADYS)
    begin
        case PSELSBUS is
            when PSEL_SL0 =>
                if ((PSELS(0)) = '1') then
                    iPREADY <= PREADYS(0);
                else
                    iPREADY <= '1';
                end if;
            when PSEL_SL1 =>
                iPREADY <= PREADYS(1);
            when PSEL_SL2 =>
                iPREADY <= PREADYS(2);
            when PSEL_SL3 =>
                iPREADY <= PREADYS(3);
            when PSEL_SL4 =>
                iPREADY <= PREADYS(4);
            when PSEL_SL5 =>
                iPREADY <= PREADYS(5);
            when PSEL_SL6 =>
                iPREADY <= PREADYS(6);
            when PSEL_SL7 =>
                iPREADY <= PREADYS(7);
            when PSEL_SL8 =>
                iPREADY <= PREADYS(8);
            when PSEL_SL9 =>
                iPREADY <= PREADYS(9);
            when PSEL_SL10 =>
                iPREADY <= PREADYS(10);
            when PSEL_SL11 =>
                iPREADY <= PREADYS(11);
            when PSEL_SL12 =>
                iPREADY <= PREADYS(12);
            when PSEL_SL13 =>
                iPREADY <= PREADYS(13);
            when PSEL_SL14 =>
                iPREADY <= PREADYS(14);
            when PSEL_SL15 =>
                iPREADY <= PREADYS(15);
            when PSEL_SL16 =>
                iPREADY <= PREADYS(16);
            when others =>
                iPREADY <= '1';
        end case;
    end process;

    process (PSELSBUS,PSELS,PSLVERRS)
    begin
        case PSELSBUS is
            when PSEL_SL0 =>
                if ((PSELS(0)) = '1') then
                    iPSLVERR <= PSLVERRS(0);
                else
                    iPSLVERR <= '0';
                end if;
            when PSEL_SL1 =>
                iPSLVERR <= PSLVERRS(1);
            when PSEL_SL2 =>
                iPSLVERR <= PSLVERRS(2);
            when PSEL_SL3 =>
                iPSLVERR <= PSLVERRS(3);
            when PSEL_SL4 =>
                iPSLVERR <= PSLVERRS(4);
            when PSEL_SL5 =>
                iPSLVERR <= PSLVERRS(5);
            when PSEL_SL6 =>
                iPSLVERR <= PSLVERRS(6);
            when PSEL_SL7 =>
                iPSLVERR <= PSLVERRS(7);
            when PSEL_SL8 =>
                iPSLVERR <= PSLVERRS(8);
            when PSEL_SL9 =>
                iPSLVERR <= PSLVERRS(9);
            when PSEL_SL10 =>
                iPSLVERR <= PSLVERRS(10);
            when PSEL_SL11 =>
                iPSLVERR <= PSLVERRS(11);
            when PSEL_SL12 =>
                iPSLVERR <= PSLVERRS(12);
            when PSEL_SL13 =>
                iPSLVERR <= PSLVERRS(13);
            when PSEL_SL14 =>
                iPSLVERR <= PSLVERRS(14);
            when PSEL_SL15 =>
                iPSLVERR <= PSLVERRS(15);
            when PSEL_SL16 =>
                iPSLVERR <= PSLVERRS(16);
            when others =>
                iPSLVERR <= '0';
        end case;
    end process;

    PREADY <= iPREADY;
    PSLVERR <= iPSLVERR;
    PRDATA <= iPRDATA(31 downto 0);

end architecture COREAPB3_MUXPTOB3_arch;
