-- ********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2011 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	AMBA APB3 bus fabric
--				Instantiates the following modules:
--				COREAPB3_MUXPTOB3
--              coreapb3_iaddr_reg
--
-- Revision Information:
-- Date			Description
-- ----			-----------------------------------------
-- 05Feb10		Production Release Version 3.0
--
-- SVN Revision Information:
-- SVN $Revision: 23124 $
-- SVN $Date: 2014-07-17 15:31:27 +0100 (Thu, 17 Jul 2014) $
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

entity CoreAPB3 is
generic (
APB_DWIDTH       : integer range 8 to 32        := 32;
IADDR_OPTION     : integer range 0 to 17        := 0;
APBSLOT0ENABLE   : integer range 0 to 1         := 1;
APBSLOT1ENABLE   : integer range 0 to 1         := 1;
APBSLOT2ENABLE   : integer range 0 to 1         := 1;
APBSLOT3ENABLE   : integer range 0 to 1         := 1;
APBSLOT4ENABLE   : integer range 0 to 1         := 1;
APBSLOT5ENABLE   : integer range 0 to 1         := 1;
APBSLOT6ENABLE   : integer range 0 to 1         := 1;
APBSLOT7ENABLE   : integer range 0 to 1         := 1;
APBSLOT8ENABLE   : integer range 0 to 1         := 1;
APBSLOT9ENABLE   : integer range 0 to 1         := 1;
APBSLOT10ENABLE  : integer range 0 to 1         := 1;
APBSLOT11ENABLE  : integer range 0 to 1         := 1;
APBSLOT12ENABLE  : integer range 0 to 1         := 1;
APBSLOT13ENABLE  : integer range 0 to 1         := 1;
APBSLOT14ENABLE  : integer range 0 to 1         := 1;
APBSLOT15ENABLE  : integer range 0 to 1         := 1;
SC_0             : integer range 0 to 1	        := 1;
SC_1             : integer range 0 to 1	        := 0;
SC_2             : integer range 0 to 1	        := 0;
SC_3             : integer range 0 to 1	        := 0;
SC_4             : integer range 0 to 1	        := 0;
SC_5             : integer range 0 to 1	        := 0;
SC_6             : integer range 0 to 1	        := 0;
SC_7             : integer range 0 to 1	        := 0;
SC_8             : integer range 0 to 1	        := 0;
SC_9             : integer range 0 to 1	        := 0;
SC_10            : integer range 0 to 1	        := 0;
SC_11            : integer range 0 to 1	        := 0;
SC_12            : integer range 0 to 1	        := 0;
SC_13            : integer range 0 to 1	        := 0;
SC_14            : integer range 0 to 1	        := 0;
SC_15            : integer range 0 to 1	        := 0;
MADDR_BITS       : integer range 12 to 32	    := 32;
UPR_NIBBLE_POSN  : integer range 2 to 8	        := 7;
FAMILY           : integer := 19
);
port(
IADDR         : in  std_logic_vector(31 downto 0);
PRESETN       : in  std_logic;
PCLK          : in  std_logic;
PADDR         : in  std_logic_vector(31 downto 0);
PWRITE        : in  std_logic;
PENABLE       : in  std_logic;
PSEL          : in  std_logic;
PWDATA        : in  std_logic_vector(31 downto 0);
PRDATA        : out std_logic_vector(31 downto 0);
PREADY        : out std_logic;
PSLVERR       : out std_logic;
PADDRS        : out std_logic_vector(31 downto 0);
PWRITES       : out std_logic;
PENABLES      : out std_logic;
PWDATAS       : out std_logic_vector(31 downto 0);
PSELS0        : out std_logic;
PSELS1        : out std_logic;
PSELS2        : out std_logic;
PSELS3        : out std_logic;
PSELS4        : out std_logic;
PSELS5        : out std_logic;
PSELS6        : out std_logic;
PSELS7        : out std_logic;
PSELS8        : out std_logic;
PSELS9        : out std_logic;
PSELS10       : out std_logic;
PSELS11       : out std_logic;
PSELS12       : out std_logic;
PSELS13       : out std_logic;
PSELS14       : out std_logic;
PSELS15       : out std_logic;
PSELS16       : out std_logic;
PRDATAS0      : in  std_logic_vector(31 downto 0);
PRDATAS1      : in  std_logic_vector(31 downto 0);
PRDATAS2      : in  std_logic_vector(31 downto 0);
PRDATAS3      : in  std_logic_vector(31 downto 0);
PRDATAS4      : in  std_logic_vector(31 downto 0);
PRDATAS5      : in  std_logic_vector(31 downto 0);
PRDATAS6      : in  std_logic_vector(31 downto 0);
PRDATAS7      : in  std_logic_vector(31 downto 0);
PRDATAS8      : in  std_logic_vector(31 downto 0);
PRDATAS9      : in  std_logic_vector(31 downto 0);
PRDATAS10     : in  std_logic_vector(31 downto 0);
PRDATAS11     : in  std_logic_vector(31 downto 0);
PRDATAS12     : in  std_logic_vector(31 downto 0);
PRDATAS13     : in  std_logic_vector(31 downto 0);
PRDATAS14     : in  std_logic_vector(31 downto 0);
PRDATAS15     : in  std_logic_vector(31 downto 0);
PRDATAS16     : in  std_logic_vector(31 downto 0);
PREADYS0      : in std_logic;
PREADYS1      : in std_logic;
PREADYS2      : in std_logic;
PREADYS3      : in std_logic;
PREADYS4      : in std_logic;
PREADYS5      : in std_logic;
PREADYS6      : in std_logic;
PREADYS7      : in std_logic;
PREADYS8      : in std_logic;
PREADYS9      : in std_logic;
PREADYS10     : in std_logic;
PREADYS11     : in std_logic;
PREADYS12     : in std_logic;
PREADYS13     : in std_logic;
PREADYS14     : in std_logic;
PREADYS15     : in std_logic;
PREADYS16     : in std_logic;
PSLVERRS0     : in std_logic;
PSLVERRS1     : in std_logic;
PSLVERRS2     : in std_logic;
PSLVERRS3     : in std_logic;
PSLVERRS4     : in std_logic;
PSLVERRS5     : in std_logic;
PSLVERRS6     : in std_logic;
PSLVERRS7     : in std_logic;
PSLVERRS8     : in std_logic;
PSLVERRS9     : in std_logic;
PSLVERRS10    : in std_logic;
PSLVERRS11    : in std_logic;
PSLVERRS12    : in std_logic;
PSLVERRS13    : in std_logic;
PSLVERRS14    : in std_logic;
PSLVERRS15    : in std_logic;
PSLVERRS16    : in std_logic
);
end entity CoreAPB3;

architecture CoreAPB3_arch of CoreAPB3 is
function ezlog2 (val: in integer) return integer is
	variable v:integer;
	variable lg:integer;
begin
	v:=val;
	lg:=0;
	while (v>1) loop
		v	:= v / 2;
		lg	:= lg + 1;
	end loop;
	return(lg);
end ezlog2;
function b2nat (b: in boolean) return natural is
	variable natvar: natural range 0 to 1;
begin
	if (b) then
		natvar:=1;
	else
		natvar:=0;
	end if;
	return natvar;
end b2nat;

function SYNC_MODE_SEL (FAMILY: INTEGER) return integer is
    VARIABLE return_val : INTEGER := 0;
    begin
	if(FAMILY = 25) then
	    return_val := 1;
	ELSE
	    return_val := 0;
	end IF;
	return return_val; 
end SYNC_MODE_SEL;
	
constant IADDR_NOTINUSE : integer :=  0;
constant IADDR_EXTERNAL : integer :=  1;
constant IADDR_SLOT0    : integer :=  2;
constant IADDR_SLOT1    : integer :=  3;
constant IADDR_SLOT2    : integer :=  4;
constant IADDR_SLOT3    : integer :=  5;
constant IADDR_SLOT4    : integer :=  6;
constant IADDR_SLOT5    : integer :=  7;
constant IADDR_SLOT6    : integer :=  8;
constant IADDR_SLOT7    : integer :=  9;
constant IADDR_SLOT8    : integer := 10;
constant IADDR_SLOT9    : integer := 11;
constant IADDR_SLOT10   : integer := 12;
constant IADDR_SLOT11   : integer := 13;
constant IADDR_SLOT12   : integer := 14;
constant IADDR_SLOT13   : integer := 15;
constant IADDR_SLOT14   : integer := 16;
constant IADDR_SLOT15   : integer := 17;

constant SL0_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT0ENABLE  * (2** 0)),16));
constant SL1_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT1ENABLE  * (2** 1)),16));
constant SL2_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT2ENABLE  * (2** 2)),16));
constant SL3_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT3ENABLE  * (2** 3)),16));
constant SL4_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT4ENABLE  * (2** 4)),16));
constant SL5_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT5ENABLE  * (2** 5)),16));
constant SL6_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT6ENABLE  * (2** 6)),16));
constant SL7_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT7ENABLE  * (2** 7)),16));
constant SL8_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT8ENABLE  * (2** 8)),16));
constant SL9_0  : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT9ENABLE  * (2** 9)),16));
constant SL10_0 : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT10ENABLE * (2**10)),16));
constant SL11_0 : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT11ENABLE * (2**11)),16));
constant SL12_0 : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT12ENABLE * (2**12)),16));
constant SL13_0 : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT13ENABLE * (2**13)),16));
constant SL14_0 : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT14ENABLE * (2**14)),16));
constant SL15_0 : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned((APBSLOT15ENABLE * (2**15)),16));

constant IADDR_slv : std_logic_vector(17 downto 0) := std_logic_vector(to_unsigned((2**IADDR_OPTION),18));

constant SYNC_RESET : integer := SYNC_MODE_SEL(FAMILY);

constant SC : integer :=
(SC_15 * (2**15)) +
(SC_14 * (2**14)) +
(SC_13 * (2**13)) +
(SC_12 * (2**12)) +
(SC_11 * (2**11)) +
(SC_10 * (2**10)) +
(SC_9  * (2**9))  +
(SC_8  * (2**8))  +
(SC_7  * (2**7))  +
(SC_6  * (2**6))  +
(SC_5  * (2**5))  +
(SC_4  * (2**4))  +
(SC_3  * (2**3))  +
(SC_2  * (2**2))  +
(SC_1  * (2**1))  +
(SC_0  * (2**0))  ;

constant SC_slv  : std_logic_vector(15 downto 0) :=
    std_logic_vector(to_unsigned(SC,16));

-- Qualify SC. Don't want to assign a slot to the combined region if it has been
-- selected for indirect address registers.
constant SC_qual : std_logic_vector(15 downto 0) :=
(SC_slv(15) and not(IADDR_slv(17))) &
(SC_slv(14) and not(IADDR_slv(16))) &
(SC_slv(13) and not(IADDR_slv(15))) &
(SC_slv(12) and not(IADDR_slv(14))) &
(SC_slv(11) and not(IADDR_slv(13))) &
(SC_slv(10) and not(IADDR_slv(12))) &
(SC_slv( 9) and not(IADDR_slv(11))) &
(SC_slv( 8) and not(IADDR_slv(10))) &
(SC_slv( 7) and not(IADDR_slv( 9))) &
(SC_slv( 6) and not(IADDR_slv( 8))) &
(SC_slv( 5) and not(IADDR_slv( 7))) &
(SC_slv( 4) and not(IADDR_slv( 6))) &
(SC_slv( 3) and not(IADDR_slv( 5))) &
(SC_slv( 2) and not(IADDR_slv( 4))) &
(SC_slv( 1) and not(IADDR_slv( 3))) &
(SC_slv( 0) and not(IADDR_slv( 2))) ;

constant SL0  : std_logic_vector(15 downto 0) := SL0_0(15)                     &
                                                 SL0_0(14)                     &
                                                 SL0_0(13)                     &
                                                 SL0_0(12)                     &
                                                 SL0_0(11)                     &
                                                 SL0_0(10)                     &
                                                 SL0_0( 9)                     &
                                                 SL0_0( 8)                     &
                                                 SL0_0( 7)                     &
                                                 SL0_0( 6)                     &
                                                 SL0_0( 5)                     &
                                                 SL0_0( 4)                     &
                                                 SL0_0( 3)                     &
                                                 SL0_0( 2)                     &
                                                 SL0_0( 1)                     &
                                                 ((SL0_0( 0) or SC_slv( 0)) or IADDR_slv( 2)) ;

constant SL1  : std_logic_vector(15 downto 0) := SL1_0(15)                     &
                                                 SL1_0(14)                     &
                                                 SL1_0(13)                     &
                                                 SL1_0(12)                     &
                                                 SL1_0(11)                     &
                                                 SL1_0(10)                     &
                                                 SL1_0( 9)                     &
                                                 SL1_0( 8)                     &
                                                 SL1_0( 7)                     &
                                                 SL1_0( 6)                     &
                                                 SL1_0( 5)                     &
                                                 SL1_0( 4)                     &
                                                 SL1_0( 3)                     &
                                                 SL1_0( 2)                     &
                                                 ((SL1_0( 1)) or IADDR_slv( 3)) &
                                                 SL1_0( 0)                     ;

constant SL2  : std_logic_vector(15 downto 0) := SL2_0(15)                     &
                                                 SL2_0(14)                     &
                                                 SL2_0(13)                     &
                                                 SL2_0(12)                     &
                                                 SL2_0(11)                     &
                                                 SL2_0(10)                     &
                                                 SL2_0( 9)                     &
                                                 SL2_0( 8)                     &
                                                 SL2_0( 7)                     &
                                                 SL2_0( 6)                     &
                                                 SL2_0( 5)                     &
                                                 SL2_0( 4)                     &
                                                 SL2_0( 3)                     &
                                                 ((SL2_0( 2) or SC_slv( 2)) or IADDR_slv( 4)) &
                                                 SL2_0( 1)                     &
                                                 SL2_0( 0)                     ;

constant SL3  : std_logic_vector(15 downto 0) := SL3_0(15)                     &
                                                 SL3_0(14)                     &
                                                 SL3_0(13)                     &
                                                 SL3_0(12)                     &
                                                 SL3_0(11)                     &
                                                 SL3_0(10)                     &
                                                 SL3_0( 9)                     &
                                                 SL3_0( 8)                     &
                                                 SL3_0( 7)                     &
                                                 SL3_0( 6)                     &
                                                 SL3_0( 5)                     &
                                                 SL3_0( 4)                     &
                                                 ((SL3_0( 3) or SC_slv( 3)) or IADDR_slv( 5)) &
                                                 SL3_0( 2)                     &
                                                 SL3_0( 1)                     &
                                                 SL3_0( 0)                     ;

constant SL4  : std_logic_vector(15 downto 0) := SL4_0(15)                     &
                                                 SL4_0(14)                     &
                                                 SL4_0(13)                     &
                                                 SL4_0(12)                     &
                                                 SL4_0(11)                     &
                                                 SL4_0(10)                     &
                                                 SL4_0( 9)                     &
                                                 SL4_0( 8)                     &
                                                 SL4_0( 7)                     &
                                                 SL4_0( 6)                     &
                                                 SL4_0( 5)                     &
                                                 ((SL4_0( 4) or SC_slv( 4)) or IADDR_slv( 6)) &
                                                 SL4_0( 3)                     &
                                                 SL4_0( 2)                     &
                                                 SL4_0( 1)                     &
                                                 SL4_0( 0)                     ;

constant SL5  : std_logic_vector(15 downto 0) := SL5_0(15)                     &
                                                 SL5_0(14)                     &
                                                 SL5_0(13)                     &
                                                 SL5_0(12)                     &
                                                 SL5_0(11)                     &
                                                 SL5_0(10)                     &
                                                 SL5_0( 9)                     &
                                                 SL5_0( 8)                     &
                                                 SL5_0( 7)                     &
                                                 SL5_0( 6)                     &
                                                 ((SL5_0( 5) or SC_slv( 5)) or IADDR_slv( 7)) &
                                                 SL5_0( 4)                     &
                                                 SL5_0( 3)                     &
                                                 SL5_0( 2)                     &
                                                 SL5_0( 1)                     &
                                                 SL5_0( 0)                     ;

constant SL6  : std_logic_vector(15 downto 0) := SL6_0(15)                     &
                                                 SL6_0(14)                     &
                                                 SL6_0(13)                     &
                                                 SL6_0(12)                     &
                                                 SL6_0(11)                     &
                                                 SL6_0(10)                     &
                                                 SL6_0( 9)                     &
                                                 SL6_0( 8)                     &
                                                 SL6_0( 7)                     &
                                                 ((SL6_0( 6) or SC_slv( 6)) or IADDR_slv( 8)) &
                                                 SL6_0( 5)                     &
                                                 SL6_0( 4)                     &
                                                 SL6_0( 3)                     &
                                                 SL6_0( 2)                     &
                                                 SL6_0( 1)                     &
                                                 SL6_0( 0)                     ;

constant SL7  : std_logic_vector(15 downto 0) := SL7_0(15)                     &
                                                 SL7_0(14)                     &
                                                 SL7_0(13)                     &
                                                 SL7_0(12)                     &
                                                 SL7_0(11)                     &
                                                 SL7_0(10)                     &
                                                 SL7_0( 9)                     &
                                                 SL7_0( 8)                     &
                                                 ((SL7_0( 7) or SC_slv( 7)) or IADDR_slv( 9)) &
                                                 SL7_0( 6)                     &
                                                 SL7_0( 5)                     &
                                                 SL7_0( 4)                     &
                                                 SL7_0( 3)                     &
                                                 SL7_0( 2)                     &
                                                 SL7_0( 1)                     &
                                                 SL7_0( 0)                     ;

constant SL8  : std_logic_vector(15 downto 0) := SL8_0(15)                     &
                                                 SL8_0(14)                     &
                                                 SL8_0(13)                     &
                                                 SL8_0(12)                     &
                                                 SL8_0(11)                     &
                                                 SL8_0(10)                     &
                                                 SL8_0( 9)                     &
                                                 ((SL8_0( 8) or SC_slv( 8)) or IADDR_slv(10)) &
                                                 SL8_0( 7)                     &
                                                 SL8_0( 6)                     &
                                                 SL8_0( 5)                     &
                                                 SL8_0( 4)                     &
                                                 SL8_0( 3)                     &
                                                 SL8_0( 2)                     &
                                                 SL8_0( 1)                     &
                                                 SL8_0( 0)                     ;

constant SL9  : std_logic_vector(15 downto 0) := SL9_0(15)                     &
                                                 SL9_0(14)                     &
                                                 SL9_0(13)                     &
                                                 SL9_0(12)                     &
                                                 SL9_0(11)                     &
                                                 SL9_0(10)                     &
                                                 ((SL9_0( 9) or SC_slv( 9)) or IADDR_slv(11)) &
                                                 SL9_0( 8)                     &
                                                 SL9_0( 7)                     &
                                                 SL9_0( 6)                     &
                                                 SL9_0( 5)                     &
                                                 SL9_0( 4)                     &
                                                 SL9_0( 3)                     &
                                                 SL9_0( 2)                     &
                                                 SL9_0( 1)                     &
                                                 SL9_0( 0)                     ;

constant SL10 : std_logic_vector(15 downto 0) := SL10_0(15)                      &
                                                 SL10_0(14)                      &
                                                 SL10_0(13)                      &
                                                 SL10_0(12)                      &
                                                 SL10_0(11)                      &
                                                 ((SL10_0(10) or SC_slv(10))  or IADDR_slv(12)) &
                                                 SL10_0( 9)                      &
                                                 SL10_0( 8)                      &
                                                 SL10_0( 7)                      &
                                                 SL10_0( 6)                      &
                                                 SL10_0( 5)                      &
                                                 SL10_0( 4)                      &
                                                 SL10_0( 3)                      &
                                                 SL10_0( 2)                      &
                                                 SL10_0( 1)                      &
                                                 SL10_0( 0)                      ;

constant SL11 : std_logic_vector(15 downto 0) := SL11_0(15)                      &
                                                 SL11_0(14)                      &
                                                 SL11_0(13)                      &
                                                 SL11_0(12)                      &
                                                 ((SL11_0(11) or SC_slv(11))  or IADDR_slv(13)) &
                                                 SL11_0(10)                      &
                                                 SL11_0( 9)                      &
                                                 SL11_0( 8)                      &
                                                 SL11_0( 7)                      &
                                                 SL11_0( 6)                      &
                                                 SL11_0( 5)                      &
                                                 SL11_0( 4)                      &
                                                 SL11_0( 3)                      &
                                                 SL11_0( 2)                      &
                                                 SL11_0( 1)                      &
                                                 SL11_0( 0)                      ;

constant SL12 : std_logic_vector(15 downto 0) := SL12_0(15)                      &
                                                 SL12_0(14)                      &
                                                 SL12_0(13)                      &
                                                 ((SL12_0(12) or SC_slv(12))  or IADDR_slv(14)) &
                                                 SL12_0(11)                      &
                                                 SL12_0(10)                      &
                                                 SL12_0( 9)                      &
                                                 SL12_0( 8)                      &
                                                 SL12_0( 7)                      &
                                                 SL12_0( 6)                      &
                                                 SL12_0( 5)                      &
                                                 SL12_0( 4)                      &
                                                 SL12_0( 3)                      &
                                                 SL12_0( 2)                      &
                                                 SL12_0( 1)                      &
                                                 SL12_0( 0)                      ;

constant SL13 : std_logic_vector(15 downto 0) := SL13_0(15)                      &
                                                 SL13_0(14)                      &
                                                 ((SL13_0(13) or SC_slv(13))  or IADDR_slv(15)) &
                                                 SL13_0(12)                      &
                                                 SL13_0(11)                      &
                                                 SL13_0(10)                      &
                                                 SL13_0( 9)                      &
                                                 SL13_0( 8)                      &
                                                 SL13_0( 7)                      &
                                                 SL13_0( 6)                      &
                                                 SL13_0( 5)                      &
                                                 SL13_0( 4)                      &
                                                 SL13_0( 3)                      &
                                                 SL13_0( 2)                      &
                                                 SL13_0( 1)                      &
                                                 SL13_0( 0)                      ;

constant SL14 : std_logic_vector(15 downto 0) := SL14_0(15)                      &
                                                 ((SL14_0(14) or SC_slv(14))  or IADDR_slv(16)) &
                                                 SL14_0(13)                      &
                                                 SL14_0(12)                      &
                                                 SL14_0(11)                      &
                                                 SL14_0(10)                      &
                                                 SL14_0( 9)                      &
                                                 SL14_0( 8)                      &
                                                 SL14_0( 7)                      &
                                                 SL14_0( 6)                      &
                                                 SL14_0( 5)                      &
                                                 SL14_0( 4)                      &
                                                 SL14_0( 3)                      &
                                                 SL14_0( 2)                      &
                                                 SL14_0( 1)                      &
                                                 SL14_0( 0)                      ;

constant SL15 : std_logic_vector(15 downto 0) := ((SL15_0(15) or SC_slv(15))  or IADDR_slv(17)) &
                                                 SL15_0(14)                      &
                                                 SL15_0(13)                      &
                                                 SL15_0(12)                      &
                                                 SL15_0(11)                      &
                                                 SL15_0(10)                      &
                                                 SL15_0( 9)                      &
                                                 SL15_0( 8)                      &
                                                 SL15_0( 7)                      &
                                                 SL15_0( 6)                      &
                                                 SL15_0( 5)                      &
                                                 SL15_0( 4)                      &
                                                 SL15_0( 3)                      &
                                                 SL15_0( 2)                      &
                                                 SL15_0( 1)                      &
                                                 SL15_0( 0)                      ;

component COREAPB3_MUXPTOB3
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
end component;

component coreapb3_iaddr_reg
    generic (
		SYNC_RESET      : integer := 0;
        APB_DWIDTH      : integer range 8 to 32;
        MADDR_BITS      : integer range 12 to 32
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
end component;

--signal iPADDR      : std_logic_vector(31 downto 0);
signal iPRDATA     : std_logic_vector(31 downto 0);
signal iPRDATAS0   : std_logic_vector(31 downto 0);
signal iPRDATAS1   : std_logic_vector(31 downto 0);
signal iPRDATAS2   : std_logic_vector(31 downto 0);
signal iPRDATAS3   : std_logic_vector(31 downto 0);
signal iPRDATAS4   : std_logic_vector(31 downto 0);
signal iPRDATAS5   : std_logic_vector(31 downto 0);
signal iPRDATAS6   : std_logic_vector(31 downto 0);
signal iPRDATAS7   : std_logic_vector(31 downto 0);
signal iPRDATAS8   : std_logic_vector(31 downto 0);
signal iPRDATAS9   : std_logic_vector(31 downto 0);
signal iPRDATAS10  : std_logic_vector(31 downto 0);
signal iPRDATAS11  : std_logic_vector(31 downto 0);
signal iPRDATAS12  : std_logic_vector(31 downto 0);
signal iPRDATAS13  : std_logic_vector(31 downto 0);
signal iPRDATAS14  : std_logic_vector(31 downto 0);
signal iPRDATAS15  : std_logic_vector(31 downto 0);
signal IA_PRDATA   : std_logic_vector(31 downto 0);
signal iPREADYS    : std_logic_vector(15 downto 0);
signal iPSLVERRS   : std_logic_vector(15 downto 0);
signal iPSELS      : std_logic_vector(15 downto 0);
signal iPSELS_raw  : std_logic_vector(15 downto 0);
signal slotSel     : std_logic_vector(3 downto 0);
signal IADDR_REG   : std_logic_vector(31 downto 0);
signal infill      : std_logic_vector(31 downto 0);
signal infill_upr  : std_logic_vector(31 downto 0);
signal mux_psels   : std_logic_vector(16 downto 0);
signal mux_preadys : std_logic_vector(16 downto 0);
signal mux_pslverrs: std_logic_vector(16 downto 0);
signal iPSELS16    : std_logic;

signal TieOffLo32  : std_logic_vector(31 downto 0);
signal TieOffHi    : std_logic;
signal TieOffLo    : std_logic;

begin
    TieOffLo32 <= (others=>'0');
    TieOffHi <= '1';
    TieOffLo <= '0';
    --PADDRS <= iPADDR(31 downto 0);
    PWRITES <= PWRITE;
    PENABLES <= PENABLE;
    PWDATAS <= PWDATA;

    slotSel <= PADDR((MADDR_BITS-1) downto (MADDR_BITS-4));

    process (PSEL, slotSel)
    begin
        if (PSEL = '1') then
            case slotSel is
                when "0000" => iPSELS_raw <= SL0;
                when "0001" => iPSELS_raw <= SL1;
                when "0010" => iPSELS_raw <= SL2;
                when "0011" => iPSELS_raw <= SL3;
                when "0100" => iPSELS_raw <= SL4;
                when "0101" => iPSELS_raw <= SL5;
                when "0110" => iPSELS_raw <= SL6;
                when "0111" => iPSELS_raw <= SL7;
                when "1000" => iPSELS_raw <= SL8;
                when "1001" => iPSELS_raw <= SL9;
                when "1010" => iPSELS_raw <= SL10;
                when "1011" => iPSELS_raw <= SL11;
                when "1100" => iPSELS_raw <= SL12;
                when "1101" => iPSELS_raw <= SL13;
                when "1110" => iPSELS_raw <= SL14;
                when "1111" => iPSELS_raw <= SL15;
                when others => iPSELS_raw <= (others => '0');
            end case;
        else
            iPSELS_raw <= (others => '0');
        end if;
    end process;

    iPSELS(15) <= iPSELS_raw(15) and not(SC_qual(15));
    iPSELS(14) <= iPSELS_raw(14) and not(SC_qual(14));
    iPSELS(13) <= iPSELS_raw(13) and not(SC_qual(13));
    iPSELS(12) <= iPSELS_raw(12) and not(SC_qual(12));
    iPSELS(11) <= iPSELS_raw(11) and not(SC_qual(11));
    iPSELS(10) <= iPSELS_raw(10) and not(SC_qual(10));
    iPSELS(9)  <= iPSELS_raw(9)  and not(SC_qual(9));
    iPSELS(8)  <= iPSELS_raw(8)  and not(SC_qual(8));
    iPSELS(7)  <= iPSELS_raw(7)  and not(SC_qual(7));
    iPSELS(6)  <= iPSELS_raw(6)  and not(SC_qual(6));
    iPSELS(5)  <= iPSELS_raw(5)  and not(SC_qual(5));
    iPSELS(4)  <= iPSELS_raw(4)  and not(SC_qual(4));
    iPSELS(3)  <= iPSELS_raw(3)  and not(SC_qual(3));
    iPSELS(2)  <= iPSELS_raw(2)  and not(SC_qual(2));
    iPSELS(1)  <= iPSELS_raw(1)  and not(SC_qual(1));
    iPSELS(0)  <= iPSELS_raw(0)  and not(SC_qual(0));

    iPSELS16 <=     (iPSELS_raw(15) and SC_qual(15))
                 or (iPSELS_raw(14) and SC_qual(14))
                 or (iPSELS_raw(13) and SC_qual(13))
                 or (iPSELS_raw(12) and SC_qual(12))
                 or (iPSELS_raw(11) and SC_qual(11))
                 or (iPSELS_raw(10) and SC_qual(10))
                 or (iPSELS_raw(9)  and SC_qual(9) )
                 or (iPSELS_raw(8)  and SC_qual(8) )
                 or (iPSELS_raw(7)  and SC_qual(7) )
                 or (iPSELS_raw(6)  and SC_qual(6) )
                 or (iPSELS_raw(5)  and SC_qual(5) )
                 or (iPSELS_raw(4)  and SC_qual(4) )
                 or (iPSELS_raw(3)  and SC_qual(3) )
                 or (iPSELS_raw(2)  and SC_qual(2) )
                 or (iPSELS_raw(1)  and SC_qual(1) )
                 or (iPSELS_raw(0)  and SC_qual(0) );


    PSELS16 <= iPSELS16;


    g_s0data_ia1 : if (IADDR_OPTION = IADDR_SLOT0) generate
        iPRDATAS0(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s0data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT0)) generate
        g_s0data_en1 : if (APBSLOT0ENABLE = 1) generate
            iPRDATAS0(31 downto 0) <= PRDATAS0(31 downto 0);
        end generate;
        g_s0data_en0 : if (not(APBSLOT0ENABLE = 1)) generate
            iPRDATAS0(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s1data_ia1 : if (IADDR_OPTION = IADDR_SLOT1) generate
        iPRDATAS1(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s1data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT1)) generate
        g_s1data_en1 : if (APBSLOT1ENABLE = 1) generate
            iPRDATAS1(31 downto 0) <= PRDATAS1(31 downto 0);
        end generate;
        g_s1data_en0 : if (not(APBSLOT1ENABLE = 1)) generate
            iPRDATAS1(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s2data_ia1 : if (IADDR_OPTION = IADDR_SLOT2) generate
        iPRDATAS2(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s2data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT2)) generate
        g_s2data_en1 : if (APBSLOT2ENABLE = 1) generate
            iPRDATAS2(31 downto 0) <= PRDATAS2(31 downto 0);
        end generate;
        g_s2data_en0 : if (not(APBSLOT2ENABLE = 1)) generate
            iPRDATAS2(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s3data_ia1 : if (IADDR_OPTION = IADDR_SLOT3) generate
        iPRDATAS3(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s3data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT3)) generate
        g_s3data_en1 : if (APBSLOT3ENABLE = 1) generate
            iPRDATAS3(31 downto 0) <= PRDATAS3(31 downto 0);
        end generate;
        g_s3data_en0 : if (not(APBSLOT3ENABLE = 1)) generate
            iPRDATAS3(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s4data_ia1 : if (IADDR_OPTION = IADDR_SLOT4) generate
        iPRDATAS4(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s4data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT4)) generate
        g_s4data_en1 : if (APBSLOT4ENABLE = 1) generate
            iPRDATAS4(31 downto 0) <= PRDATAS4(31 downto 0);
        end generate;
        g_s4data_en0 : if (not(APBSLOT4ENABLE = 1)) generate
            iPRDATAS4(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s5data_ia1 : if (IADDR_OPTION = IADDR_SLOT5) generate
        iPRDATAS5(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s5data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT5)) generate
        g_s5data_en1 : if (APBSLOT5ENABLE = 1) generate
            iPRDATAS5(31 downto 0) <= PRDATAS5(31 downto 0);
        end generate;
        g_s5data_en0 : if (not(APBSLOT5ENABLE = 1)) generate
            iPRDATAS5(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s6data_ia1 : if (IADDR_OPTION = IADDR_SLOT6) generate
        iPRDATAS6(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s6data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT6)) generate
        g_s6data_en1 : if (APBSLOT6ENABLE = 1) generate
            iPRDATAS6(31 downto 0) <= PRDATAS6(31 downto 0);
        end generate;
        g_s6data_en0 : if (not(APBSLOT6ENABLE = 1)) generate
            iPRDATAS6(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s7data_ia1 : if (IADDR_OPTION = IADDR_SLOT7) generate
        iPRDATAS7(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s7data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT7)) generate
        g_s7data_en1 : if (APBSLOT7ENABLE = 1) generate
            iPRDATAS7(31 downto 0) <= PRDATAS7(31 downto 0);
        end generate;
        g_s7data_en0 : if (not(APBSLOT7ENABLE = 1)) generate
            iPRDATAS7(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s8data_ia1 : if (IADDR_OPTION = IADDR_SLOT8) generate
        iPRDATAS8(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s8data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT8)) generate
        g_s8data_en1 : if (APBSLOT8ENABLE = 1) generate
            iPRDATAS8(31 downto 0) <= PRDATAS8(31 downto 0);
        end generate;
        g_s8data_en0 : if (not(APBSLOT8ENABLE = 1)) generate
            iPRDATAS8(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s9data_ia1 : if (IADDR_OPTION = IADDR_SLOT9) generate
        iPRDATAS9(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s9data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT9)) generate
        g_s9data_en1 : if (APBSLOT9ENABLE = 1) generate
            iPRDATAS9(31 downto 0) <= PRDATAS9(31 downto 0);
        end generate;
        g_s9data_en0 : if (not(APBSLOT9ENABLE = 1)) generate
            iPRDATAS9(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s10data_ia1 : if (IADDR_OPTION = IADDR_SLOT10) generate
        iPRDATAS10(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s10data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT10)) generate
        g_s10data_en1 : if (APBSLOT10ENABLE = 1) generate
            iPRDATAS10(31 downto 0) <= PRDATAS10(31 downto 0);
        end generate;
        g_s10data_en0 : if (not(APBSLOT10ENABLE = 1)) generate
            iPRDATAS10(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s11data_ia1 : if (IADDR_OPTION = IADDR_SLOT11) generate
        iPRDATAS11(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s11data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT11)) generate
        g_s11data_en1 : if (APBSLOT11ENABLE = 1) generate
            iPRDATAS11(31 downto 0) <= PRDATAS11(31 downto 0);
        end generate;
        g_s11data_en0 : if (not(APBSLOT11ENABLE = 1)) generate
            iPRDATAS11(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s12data_ia1 : if (IADDR_OPTION = IADDR_SLOT12) generate
        iPRDATAS12(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s12data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT12)) generate
        g_s12data_en1 : if (APBSLOT12ENABLE = 1) generate
            iPRDATAS12(31 downto 0) <= PRDATAS12(31 downto 0);
        end generate;
        g_s12data_en0 : if (not(APBSLOT12ENABLE = 1)) generate
            iPRDATAS12(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s13data_ia1 : if (IADDR_OPTION = IADDR_SLOT13) generate
        iPRDATAS13(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s13data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT13)) generate
        g_s13data_en1 : if (APBSLOT13ENABLE = 1) generate
            iPRDATAS13(31 downto 0) <= PRDATAS13(31 downto 0);
        end generate;
        g_s13data_en0 : if (not(APBSLOT13ENABLE = 1)) generate
            iPRDATAS13(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s14data_ia1 : if (IADDR_OPTION = IADDR_SLOT14) generate
        iPRDATAS14(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s14data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT14)) generate
        g_s14data_en1 : if (APBSLOT14ENABLE = 1) generate
            iPRDATAS14(31 downto 0) <= PRDATAS14(31 downto 0);
        end generate;
        g_s14data_en0 : if (not(APBSLOT14ENABLE = 1)) generate
            iPRDATAS14(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    g_s15data_ia1 : if (IADDR_OPTION = IADDR_SLOT15) generate
        iPRDATAS15(31 downto 0) <= IA_PRDATA(31 downto 0);
    end generate;
    g_s15data_ia0 : if (not(IADDR_OPTION = IADDR_SLOT15)) generate
        g_s15data_en1 : if (APBSLOT15ENABLE = 1) generate
            iPRDATAS15(31 downto 0) <= PRDATAS15(31 downto 0);
        end generate;
        g_s15data_en0 : if (not(APBSLOT15ENABLE = 1)) generate
            iPRDATAS15(31 downto 0) <= TieOffLo32(31 downto 0);
        end generate;
    end generate;

    -- ===================================================================
    -- =                                                                 =
    -- =                                                                 =
    -- =                                                                 =
    -- =                                                                 =
    -- ===================================================================
    g_s0ready_ia1 : if (IADDR_OPTION = IADDR_SLOT0) generate
        iPREADYS(0) <= TieOffHi;
    end generate;
    g_s0ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT0)) generate
        g_s0ready_en1 : if (APBSLOT0ENABLE = 1) generate
            iPREADYS(0) <= PREADYS0;
        end generate;
        g_s0ready_en0 : if (not(APBSLOT0ENABLE = 1)) generate
            iPREADYS(0) <= TieOffHi;
        end generate;
    end generate;

    g_s1ready_ia1 : if (IADDR_OPTION = IADDR_SLOT1) generate
        iPREADYS(1) <= TieOffHi;
    end generate;
    g_s1ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT1)) generate
        g_s1ready_en1 : if (APBSLOT1ENABLE = 1) generate
            iPREADYS(1) <= PREADYS1;
        end generate;
        g_s1ready_en0 : if (not(APBSLOT1ENABLE = 1)) generate
            iPREADYS(1) <= TieOffHi;
        end generate;
    end generate;

    g_s2ready_ia1 : if (IADDR_OPTION = IADDR_SLOT2) generate
        iPREADYS(2) <= TieOffHi;
    end generate;
    g_s2ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT2)) generate
        g_s2ready_en1 : if (APBSLOT2ENABLE = 1) generate
            iPREADYS(2) <= PREADYS2;
        end generate;
        g_s2ready_en0 : if (not(APBSLOT2ENABLE = 1)) generate
            iPREADYS(2) <= TieOffHi;
        end generate;
    end generate;

    g_s3ready_ia1 : if (IADDR_OPTION = IADDR_SLOT3) generate
        iPREADYS(3) <= TieOffHi;
    end generate;
    g_s3ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT3)) generate
        g_s3ready_en1 : if (APBSLOT3ENABLE = 1) generate
            iPREADYS(3) <= PREADYS3;
        end generate;
        g_s3ready_en0 : if (not(APBSLOT3ENABLE = 1)) generate
            iPREADYS(3) <= TieOffHi;
        end generate;
    end generate;

    g_s4ready_ia1 : if (IADDR_OPTION = IADDR_SLOT4) generate
        iPREADYS(4) <= TieOffHi;
    end generate;
    g_s4ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT4)) generate
        g_s4ready_en1 : if (APBSLOT4ENABLE = 1) generate
            iPREADYS(4) <= PREADYS4;
        end generate;
        g_s4ready_en0 : if (not(APBSLOT4ENABLE = 1)) generate
            iPREADYS(4) <= TieOffHi;
        end generate;
    end generate;

    g_s5ready_ia1 : if (IADDR_OPTION = IADDR_SLOT5) generate
        iPREADYS(5) <= TieOffHi;
    end generate;
    g_s5ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT5)) generate
        g_s5ready_en1 : if (APBSLOT5ENABLE = 1) generate
            iPREADYS(5) <= PREADYS5;
        end generate;
        g_s5ready_en0 : if (not(APBSLOT5ENABLE = 1)) generate
            iPREADYS(5) <= TieOffHi;
        end generate;
    end generate;

    g_s6ready_ia1 : if (IADDR_OPTION = IADDR_SLOT6) generate
        iPREADYS(6) <= TieOffHi;
    end generate;
    g_s6ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT6)) generate
        g_s6ready_en1 : if (APBSLOT6ENABLE = 1) generate
            iPREADYS(6) <= PREADYS6;
        end generate;
        g_s6ready_en0 : if (not(APBSLOT6ENABLE = 1)) generate
            iPREADYS(6) <= TieOffHi;
        end generate;
    end generate;

    g_s7ready_ia1 : if (IADDR_OPTION = IADDR_SLOT7) generate
        iPREADYS(7) <= TieOffHi;
    end generate;
    g_s7ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT7)) generate
        g_s7ready_en1 : if (APBSLOT7ENABLE = 1) generate
            iPREADYS(7) <= PREADYS7;
        end generate;
        g_s7ready_en0 : if (not(APBSLOT7ENABLE = 1)) generate
            iPREADYS(7) <= TieOffHi;
        end generate;
    end generate;

    g_s8ready_ia1 : if (IADDR_OPTION = IADDR_SLOT8) generate
        iPREADYS(8) <= TieOffHi;
    end generate;
    g_s8ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT8)) generate
        g_s8ready_en1 : if (APBSLOT8ENABLE = 1) generate
            iPREADYS(8) <= PREADYS8;
        end generate;
        g_s8ready_en0 : if (not(APBSLOT8ENABLE = 1)) generate
            iPREADYS(8) <= TieOffHi;
        end generate;
    end generate;

    g_s9ready_ia1 : if (IADDR_OPTION = IADDR_SLOT9) generate
        iPREADYS(9) <= TieOffHi;
    end generate;
    g_s9ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT9)) generate
        g_s9ready_en1 : if (APBSLOT9ENABLE = 1) generate
            iPREADYS(9) <= PREADYS9;
        end generate;
        g_s9ready_en0 : if (not(APBSLOT9ENABLE = 1)) generate
            iPREADYS(9) <= TieOffHi;
        end generate;
    end generate;

    g_s10ready_ia1 : if (IADDR_OPTION = IADDR_SLOT10) generate
        iPREADYS(10) <= TieOffHi;
    end generate;
    g_s10ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT10)) generate
        g_s10ready_en1 : if (APBSLOT10ENABLE = 1) generate
            iPREADYS(10) <= PREADYS10;
        end generate;
        g_s10ready_en0 : if (not(APBSLOT10ENABLE = 1)) generate
            iPREADYS(10) <= TieOffHi;
        end generate;
    end generate;

    g_s11ready_ia1 : if (IADDR_OPTION = IADDR_SLOT11) generate
        iPREADYS(11) <= TieOffHi;
    end generate;
    g_s11ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT11)) generate
        g_s11ready_en1 : if (APBSLOT11ENABLE = 1) generate
            iPREADYS(11) <= PREADYS11;
        end generate;
        g_s11ready_en0 : if (not(APBSLOT11ENABLE = 1)) generate
            iPREADYS(11) <= TieOffHi;
        end generate;
    end generate;

    g_s12ready_ia1 : if (IADDR_OPTION = IADDR_SLOT12) generate
        iPREADYS(12) <= TieOffHi;
    end generate;
    g_s12ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT12)) generate
        g_s12ready_en1 : if (APBSLOT12ENABLE = 1) generate
            iPREADYS(12) <= PREADYS12;
        end generate;
        g_s12ready_en0 : if (not(APBSLOT12ENABLE = 1)) generate
            iPREADYS(12) <= TieOffHi;
        end generate;
    end generate;

    g_s13ready_ia1 : if (IADDR_OPTION = IADDR_SLOT13) generate
        iPREADYS(13) <= TieOffHi;
    end generate;
    g_s13ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT13)) generate
        g_s13ready_en1 : if (APBSLOT13ENABLE = 1) generate
            iPREADYS(13) <= PREADYS13;
        end generate;
        g_s13ready_en0 : if (not(APBSLOT13ENABLE = 1)) generate
            iPREADYS(13) <= TieOffHi;
        end generate;
    end generate;

    g_s14ready_ia1 : if (IADDR_OPTION = IADDR_SLOT14) generate
        iPREADYS(14) <= TieOffHi;
    end generate;
    g_s14ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT14)) generate
        g_s14ready_en1 : if (APBSLOT14ENABLE = 1) generate
            iPREADYS(14) <= PREADYS14;
        end generate;
        g_s14ready_en0 : if (not(APBSLOT14ENABLE = 1)) generate
            iPREADYS(14) <= TieOffHi;
        end generate;
    end generate;

    g_s15ready_ia1 : if (IADDR_OPTION = IADDR_SLOT15) generate
        iPREADYS(15) <= TieOffHi;
    end generate;
    g_s15ready_ia0 : if (not(IADDR_OPTION = IADDR_SLOT15)) generate
        g_s15ready_en1 : if (APBSLOT15ENABLE = 1) generate
            iPREADYS(15) <= PREADYS15;
        end generate;
        g_s15ready_en0 : if (not(APBSLOT15ENABLE = 1)) generate
            iPREADYS(15) <= TieOffHi;
        end generate;
    end generate;

    -- ===================================================================
    -- =                                                                 =
    -- =                                                                 =
    -- =                                                                 =
    -- =                                                                 =
    -- ===================================================================
    g_s0err_ia1 : if (IADDR_OPTION = IADDR_SLOT0) generate
        iPSLVERRS(0) <= TieOffLo;
    end generate;
    g_s0err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT0)) generate
        g_s0err_en1 : if (APBSLOT0ENABLE = 1) generate
            iPSLVERRS(0) <= PSLVERRS0;
        end generate;
        g_s0err_en0 : if (not(APBSLOT0ENABLE = 1)) generate
            iPSLVERRS(0) <= TieOffLo;
        end generate;
    end generate;

    g_s1err_ia1 : if (IADDR_OPTION = IADDR_SLOT1) generate
        iPSLVERRS(1) <= TieOffLo;
    end generate;
    g_s1err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT1)) generate
        g_s1err_en1 : if (APBSLOT1ENABLE = 1) generate
            iPSLVERRS(1) <= PSLVERRS1;
        end generate;
        g_s1err_en0 : if (not(APBSLOT1ENABLE = 1)) generate
            iPSLVERRS(1) <= TieOffLo;
        end generate;
    end generate;

    g_s2err_ia1 : if (IADDR_OPTION = IADDR_SLOT2) generate
        iPSLVERRS(2) <= TieOffLo;
    end generate;
    g_s2err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT2)) generate
        g_s2err_en1 : if (APBSLOT2ENABLE = 1) generate
            iPSLVERRS(2) <= PSLVERRS2;
        end generate;
        g_s2err_en0 : if (not(APBSLOT2ENABLE = 1)) generate
            iPSLVERRS(2) <= TieOffLo;
        end generate;
    end generate;

    g_s3err_ia1 : if (IADDR_OPTION = IADDR_SLOT3) generate
        iPSLVERRS(3) <= TieOffLo;
    end generate;
    g_s3err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT3)) generate
        g_s3err_en1 : if (APBSLOT3ENABLE = 1) generate
            iPSLVERRS(3) <= PSLVERRS3;
        end generate;
        g_s3err_en0 : if (not(APBSLOT3ENABLE = 1)) generate
            iPSLVERRS(3) <= TieOffLo;
        end generate;
    end generate;

    g_s4err_ia1 : if (IADDR_OPTION = IADDR_SLOT4) generate
        iPSLVERRS(4) <= TieOffLo;
    end generate;
    g_s4err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT4)) generate
        g_s4err_en1 : if (APBSLOT4ENABLE = 1) generate
            iPSLVERRS(4) <= PSLVERRS4;
        end generate;
        g_s4err_en0 : if (not(APBSLOT4ENABLE = 1)) generate
            iPSLVERRS(4) <= TieOffLo;
        end generate;
    end generate;

    g_s5err_ia1 : if (IADDR_OPTION = IADDR_SLOT5) generate
        iPSLVERRS(5) <= TieOffLo;
    end generate;
    g_s5err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT5)) generate
        g_s5err_en1 : if (APBSLOT5ENABLE = 1) generate
            iPSLVERRS(5) <= PSLVERRS5;
        end generate;
        g_s5err_en0 : if (not(APBSLOT5ENABLE = 1)) generate
            iPSLVERRS(5) <= TieOffLo;
        end generate;
    end generate;

    g_s6err_ia1 : if (IADDR_OPTION = IADDR_SLOT6) generate
        iPSLVERRS(6) <= TieOffLo;
    end generate;
    g_s6err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT6)) generate
        g_s6err_en1 : if (APBSLOT6ENABLE = 1) generate
            iPSLVERRS(6) <= PSLVERRS6;
        end generate;
        g_s6err_en0 : if (not(APBSLOT6ENABLE = 1)) generate
            iPSLVERRS(6) <= TieOffLo;
        end generate;
    end generate;

    g_s7err_ia1 : if (IADDR_OPTION = IADDR_SLOT7) generate
        iPSLVERRS(7) <= TieOffLo;
    end generate;
    g_s7err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT7)) generate
        g_s7err_en1 : if (APBSLOT7ENABLE = 1) generate
            iPSLVERRS(7) <= PSLVERRS7;
        end generate;
        g_s7err_en0 : if (not(APBSLOT7ENABLE = 1)) generate
            iPSLVERRS(7) <= TieOffLo;
        end generate;
    end generate;

    g_s8err_ia1 : if (IADDR_OPTION = IADDR_SLOT8) generate
        iPSLVERRS(8) <= TieOffLo;
    end generate;
    g_s8err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT8)) generate
        g_s8err_en1 : if (APBSLOT8ENABLE = 1) generate
            iPSLVERRS(8) <= PSLVERRS8;
        end generate;
        g_s8err_en0 : if (not(APBSLOT8ENABLE = 1)) generate
            iPSLVERRS(8) <= TieOffLo;
        end generate;
    end generate;

    g_s9err_ia1 : if (IADDR_OPTION = IADDR_SLOT9) generate
        iPSLVERRS(9) <= TieOffLo;
    end generate;
    g_s9err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT9)) generate
        g_s9err_en1 : if (APBSLOT9ENABLE = 1) generate
            iPSLVERRS(9) <= PSLVERRS9;
        end generate;
        g_s9err_en0 : if (not(APBSLOT9ENABLE = 1)) generate
            iPSLVERRS(9) <= TieOffLo;
        end generate;
    end generate;

    g_s10err_ia1 : if (IADDR_OPTION = IADDR_SLOT10) generate
        iPSLVERRS(10) <= TieOffLo;
    end generate;
    g_s10err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT10)) generate
        g_s10err_en1 : if (APBSLOT10ENABLE = 1) generate
            iPSLVERRS(10) <= PSLVERRS10;
        end generate;
        g_s10err_en0 : if (not(APBSLOT10ENABLE = 1)) generate
            iPSLVERRS(10) <= TieOffLo;
        end generate;
    end generate;

    g_s11err_ia1 : if (IADDR_OPTION = IADDR_SLOT11) generate
        iPSLVERRS(11) <= TieOffLo;
    end generate;
    g_s11err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT11)) generate
        g_s11err_en1 : if (APBSLOT11ENABLE = 1) generate
            iPSLVERRS(11) <= PSLVERRS11;
        end generate;
        g_s11err_en0 : if (not(APBSLOT11ENABLE = 1)) generate
            iPSLVERRS(11) <= TieOffLo;
        end generate;
    end generate;

    g_s12err_ia1 : if (IADDR_OPTION = IADDR_SLOT12) generate
        iPSLVERRS(12) <= TieOffLo;
    end generate;
    g_s12err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT12)) generate
        g_s12err_en1 : if (APBSLOT12ENABLE = 1) generate
            iPSLVERRS(12) <= PSLVERRS12;
        end generate;
        g_s12err_en0 : if (not(APBSLOT12ENABLE = 1)) generate
            iPSLVERRS(12) <= TieOffLo;
        end generate;
    end generate;

    g_s13err_ia1 : if (IADDR_OPTION = IADDR_SLOT13) generate
        iPSLVERRS(13) <= TieOffLo;
    end generate;
    g_s13err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT13)) generate
        g_s13err_en1 : if (APBSLOT13ENABLE = 1) generate
            iPSLVERRS(13) <= PSLVERRS13;
        end generate;
        g_s13err_en0 : if (not(APBSLOT13ENABLE = 1)) generate
            iPSLVERRS(13) <= TieOffLo;
        end generate;
    end generate;

    g_s14err_ia1 : if (IADDR_OPTION = IADDR_SLOT14) generate
        iPSLVERRS(14) <= TieOffLo;
    end generate;
    g_s14err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT14)) generate
        g_s14err_en1 : if (APBSLOT14ENABLE = 1) generate
            iPSLVERRS(14) <= PSLVERRS14;
        end generate;
        g_s14err_en0 : if (not(APBSLOT14ENABLE = 1)) generate
            iPSLVERRS(14) <= TieOffLo;
        end generate;
    end generate;

    g_s15err_ia1 : if (IADDR_OPTION = IADDR_SLOT15) generate
        iPSLVERRS(15) <= TieOffLo;
    end generate;
    g_s15err_ia0 : if (not(IADDR_OPTION = IADDR_SLOT15)) generate
        g_s15err_en1 : if (APBSLOT15ENABLE = 1) generate
            iPSLVERRS(15) <= PSLVERRS15;
        end generate;
        g_s15err_en0 : if (not(APBSLOT15ENABLE = 1)) generate
            iPSLVERRS(15) <= TieOffLo;
        end generate;
    end generate;
    -- ===================================================================
    -- =                                                                 =
    -- =                                                                 =
    -- =                                                                 =
    -- =                                                                 =
    -- ===================================================================

    mux_psels    <= iPSELS16   &    iPSELS(15 downto 0);
    mux_preadys  <= PREADYS16  &  iPREADYS(15 downto 0);
    mux_pslverrs <= PSLVERRS16 & iPSLVERRS(15 downto 0);

    u_mux_p_to_b3 : COREAPB3_MUXPTOB3
        port map (
            PSELS      => mux_psels,
            PRDATAS0   => iPRDATAS0(31 downto 0),
            PRDATAS1   => iPRDATAS1(31 downto 0),
            PRDATAS2   => iPRDATAS2(31 downto 0),
            PRDATAS3   => iPRDATAS3(31 downto 0),
            PRDATAS4   => iPRDATAS4(31 downto 0),
            PRDATAS5   => iPRDATAS5(31 downto 0),
            PRDATAS6   => iPRDATAS6(31 downto 0),
            PRDATAS7   => iPRDATAS7(31 downto 0),
            PRDATAS8   => iPRDATAS8(31 downto 0),
            PRDATAS9   => iPRDATAS9(31 downto 0),
            PRDATAS10  => iPRDATAS10(31 downto 0),
            PRDATAS11  => iPRDATAS11(31 downto 0),
            PRDATAS12  => iPRDATAS12(31 downto 0),
            PRDATAS13  => iPRDATAS13(31 downto 0),
            PRDATAS14  => iPRDATAS14(31 downto 0),
            PRDATAS15  => iPRDATAS15(31 downto 0),
            PRDATAS16  => PRDATAS16(31 downto 0),
            PREADYS    => mux_preadys,
            PSLVERRS   => mux_pslverrs,
            PREADY     => PREADY,
            PSLVERR    => PSLVERR,
            PRDATA     => iPRDATA(31 downto 0)
        );

    PRDATA(31 downto 0) <= iPRDATA(31 downto 0);

g_sel0_ia0  : if (not(IADDR_OPTION = IADDR_SLOT0 )) generate PSELS0  <= iPSELS( 0); end generate;
g_sel0_ia1  : if (    IADDR_OPTION = IADDR_SLOT0 )  generate PSELS0  <= '0';        end generate;
g_sel1_ia0  : if (not(IADDR_OPTION = IADDR_SLOT1 )) generate PSELS1  <= iPSELS( 1); end generate;
g_sel1_ia1  : if (    IADDR_OPTION = IADDR_SLOT1 )  generate PSELS1  <= '0';        end generate;
g_sel2_ia0  : if (not(IADDR_OPTION = IADDR_SLOT2 )) generate PSELS2  <= iPSELS( 2); end generate;
g_sel2_ia1  : if (    IADDR_OPTION = IADDR_SLOT2 )  generate PSELS2  <= '0';        end generate;
g_sel3_ia0  : if (not(IADDR_OPTION = IADDR_SLOT3 )) generate PSELS3  <= iPSELS( 3); end generate;
g_sel3_ia1  : if (    IADDR_OPTION = IADDR_SLOT3 )  generate PSELS3  <= '0';        end generate;
g_sel4_ia0  : if (not(IADDR_OPTION = IADDR_SLOT4 )) generate PSELS4  <= iPSELS( 4); end generate;
g_sel4_ia1  : if (    IADDR_OPTION = IADDR_SLOT4 )  generate PSELS4  <= '0';        end generate;
g_sel5_ia0  : if (not(IADDR_OPTION = IADDR_SLOT5 )) generate PSELS5  <= iPSELS( 5); end generate;
g_sel5_ia1  : if (    IADDR_OPTION = IADDR_SLOT5 )  generate PSELS5  <= '0';        end generate;
g_sel6_ia0  : if (not(IADDR_OPTION = IADDR_SLOT6 )) generate PSELS6  <= iPSELS( 6); end generate;
g_sel6_ia1  : if (    IADDR_OPTION = IADDR_SLOT6 )  generate PSELS6  <= '0';        end generate;
g_sel7_ia0  : if (not(IADDR_OPTION = IADDR_SLOT7 )) generate PSELS7  <= iPSELS( 7); end generate;
g_sel7_ia1  : if (    IADDR_OPTION = IADDR_SLOT7 )  generate PSELS7  <= '0';        end generate;
g_sel8_ia0  : if (not(IADDR_OPTION = IADDR_SLOT8 )) generate PSELS8  <= iPSELS( 8); end generate;
g_sel8_ia1  : if (    IADDR_OPTION = IADDR_SLOT8 )  generate PSELS8  <= '0';        end generate;
g_sel9_ia0  : if (not(IADDR_OPTION = IADDR_SLOT9 )) generate PSELS9  <= iPSELS( 9); end generate;
g_sel9_ia1  : if (    IADDR_OPTION = IADDR_SLOT9 )  generate PSELS9  <= '0';        end generate;
g_sel10_ia0 : if (not(IADDR_OPTION = IADDR_SLOT10)) generate PSELS10 <= iPSELS(10); end generate;
g_sel10_ia1 : if (    IADDR_OPTION = IADDR_SLOT10)  generate PSELS10 <= '0';        end generate;
g_sel11_ia0 : if (not(IADDR_OPTION = IADDR_SLOT11)) generate PSELS11 <= iPSELS(11); end generate;
g_sel11_ia1 : if (    IADDR_OPTION = IADDR_SLOT11)  generate PSELS11 <= '0';        end generate;
g_sel12_ia0 : if (not(IADDR_OPTION = IADDR_SLOT12)) generate PSELS12 <= iPSELS(12); end generate;
g_sel12_ia1 : if (    IADDR_OPTION = IADDR_SLOT12)  generate PSELS12 <= '0';        end generate;
g_sel13_ia0 : if (not(IADDR_OPTION = IADDR_SLOT13)) generate PSELS13 <= iPSELS(13); end generate;
g_sel13_ia1 : if (    IADDR_OPTION = IADDR_SLOT13)  generate PSELS13 <= '0';        end generate;
g_sel14_ia0 : if (not(IADDR_OPTION = IADDR_SLOT14)) generate PSELS14 <= iPSELS(14); end generate;
g_sel14_ia1 : if (    IADDR_OPTION = IADDR_SLOT14)  generate PSELS14 <= '0';        end generate;
g_sel15_ia0 : if (not(IADDR_OPTION = IADDR_SLOT15)) generate PSELS15 <= iPSELS(15); end generate;
g_sel15_ia1 : if (    IADDR_OPTION = IADDR_SLOT15)  generate PSELS15 <= '0';        end generate;


g_iaddr0  : if (IADDR_OPTION = IADDR_NOTINUSE) generate IADDR_REG <= (others => '0'); end generate;
g_iaddr1  : if (IADDR_OPTION = IADDR_EXTERNAL) generate IADDR_REG <= (others => '0'); end generate;
g_iaddr2  : if (IADDR_OPTION = IADDR_SLOT0 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 0),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr3  : if (IADDR_OPTION = IADDR_SLOT1 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 1),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr4  : if (IADDR_OPTION = IADDR_SLOT2 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 2),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr5  : if (IADDR_OPTION = IADDR_SLOT3 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 3),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr6  : if (IADDR_OPTION = IADDR_SLOT4 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 4),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr7  : if (IADDR_OPTION = IADDR_SLOT5 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 5),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr8  : if (IADDR_OPTION = IADDR_SLOT6 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 6),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr9  : if (IADDR_OPTION = IADDR_SLOT7 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 7),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr10 : if (IADDR_OPTION = IADDR_SLOT8 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 8),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr11 : if (IADDR_OPTION = IADDR_SLOT9 ) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS( 9),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr12 : if (IADDR_OPTION = IADDR_SLOT10) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS(10),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr13 : if (IADDR_OPTION = IADDR_SLOT11) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS(11),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr14 : if (IADDR_OPTION = IADDR_SLOT12) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS(12),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr15 : if (IADDR_OPTION = IADDR_SLOT13) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS(13),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr16 : if (IADDR_OPTION = IADDR_SLOT14) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS(14),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;
g_iaddr17 : if (IADDR_OPTION = IADDR_SLOT15) generate
                ia_reg : coreapb3_iaddr_reg generic map (SYNC_RESET,APB_DWIDTH,MADDR_BITS) port map(PCLK,PRESETN,PENABLE,iPSELS(15),PADDR,PWRITE,PWDATA,IA_PRDATA,IADDR_REG);
            end generate;

-- Slave address infill
g_infill_iaddr0 :   if (IADDR_OPTION = IADDR_NOTINUSE) generate
                        infill_upr <= PADDR;
                        infill     <= (others => '0');
                    end generate;
g_infill_iaddr1 :   if (IADDR_OPTION = IADDR_EXTERNAL) generate
                        infill_upr <= IADDR;
                        infill     <= IADDR;
                    end generate;
g_infill_iaddro :   if (IADDR_OPTION > IADDR_EXTERNAL) generate
                        infill_upr <= IADDR_REG;
                        infill     <= IADDR_REG;
                    end generate;

-- Slave address
g_addrs_m12 :   if (MADDR_BITS = 12) generate
                    process (infill_upr, infill, PADDR) begin
                        case UPR_NIBBLE_POSN is
                            when 2 => PADDRS <= infill_upr(31 downto 12) & PADDR(11 downto 0);
                            when 3 => PADDRS <= infill_upr(31 downto 16) & PADDR(11 downto 8) & infill(11 downto 8) & PADDR(7 downto 0);
                            when 4 => PADDRS <= infill_upr(31 downto 20) & PADDR(11 downto 8) & infill(15 downto 8) & PADDR(7 downto 0);
                            when 5 => PADDRS <= infill_upr(31 downto 24) & PADDR(11 downto 8) & infill(19 downto 8) & PADDR(7 downto 0);
                            when 6 => PADDRS <= infill_upr(31 downto 28) & PADDR(11 downto 8) & infill(23 downto 8) & PADDR(7 downto 0);
                            when 7 => PADDRS <=                            PADDR(11 downto 8) & infill(27 downto 8) & PADDR(7 downto 0);
                            when 8 => PADDRS <=                                                 infill(31 downto 8) & PADDR(7 downto 0);
                            when others => PADDRS <= PADDR;
                        end case;
                    end process;
                end generate;

g_addrs_m16 :   if (MADDR_BITS = 16) generate
                    process (infill_upr, infill, PADDR) begin
                        case UPR_NIBBLE_POSN is
                            when 2 => PADDRS <= infill_upr(31 downto 16) & PADDR(15 downto 0);
                            when 3 => PADDRS <= infill_upr(31 downto 16) & PADDR(15 downto 0);
                            when 4 => PADDRS <= infill_upr(31 downto 20) & PADDR(15 downto 12) & infill(15 downto 12) & PADDR(11 downto 0);
                            when 5 => PADDRS <= infill_upr(31 downto 24) & PADDR(15 downto 12) & infill(19 downto 12) & PADDR(11 downto 0);
                            when 6 => PADDRS <= infill_upr(31 downto 28) & PADDR(15 downto 12) & infill(23 downto 12) & PADDR(11 downto 0);
                            when 7 => PADDRS <=                            PADDR(15 downto 12) & infill(27 downto 12) & PADDR(11 downto 0);
                            when 8 => PADDRS <=                                                  infill(31 downto 12) & PADDR(11 downto 0);
                            when others => PADDRS <= PADDR;
                        end case;
                    end process;
                end generate;

g_addrs_m20 :   if (MADDR_BITS = 20) generate
                    process (infill_upr, infill, PADDR) begin
                        case UPR_NIBBLE_POSN is
                            when 2 => PADDRS <= infill_upr(31 downto 20) & PADDR(19 downto 0);
                            when 3 => PADDRS <= infill_upr(31 downto 20) & PADDR(19 downto 0);
                            when 4 => PADDRS <= infill_upr(31 downto 20) & PADDR(19 downto 0);
                            when 5 => PADDRS <= infill_upr(31 downto 24) & PADDR(19 downto 16) & infill(19 downto 16) & PADDR(15 downto 0);
                            when 6 => PADDRS <= infill_upr(31 downto 28) & PADDR(19 downto 16) & infill(23 downto 16) & PADDR(15 downto 0);
                            when 7 => PADDRS <=                            PADDR(19 downto 16) & infill(27 downto 16) & PADDR(15 downto 0);
                            when 8 => PADDRS <=                                                  infill(31 downto 16) & PADDR(15 downto 0);
                            when others => PADDRS <= PADDR;
                        end case;
                    end process;
                end generate;

g_addrs_m24 :   if (MADDR_BITS = 24) generate
                    process (infill_upr, infill, PADDR) begin
                        case UPR_NIBBLE_POSN is
                            when 2 => PADDRS <= infill_upr(31 downto 24) & PADDR(23 downto 0);
                            when 3 => PADDRS <= infill_upr(31 downto 24) & PADDR(23 downto 0);
                            when 4 => PADDRS <= infill_upr(31 downto 24) & PADDR(23 downto 0);
                            when 5 => PADDRS <= infill_upr(31 downto 24) & PADDR(23 downto 0);
                            when 6 => PADDRS <= infill_upr(31 downto 28) & PADDR(23 downto 20) & infill(23 downto 20) & PADDR(19 downto 0);
                            when 7 => PADDRS <=                            PADDR(23 downto 20) & infill(27 downto 20) & PADDR(19 downto 0);
                            when 8 => PADDRS <=                                                  infill(31 downto 20) & PADDR(19 downto 0);
                            when others => PADDRS <= PADDR;
                        end case;
                    end process;
                end generate;

g_addrs_m28 :   if (MADDR_BITS = 28) generate
                    process (infill_upr, infill, PADDR) begin
                        case UPR_NIBBLE_POSN is
                            when 2 => PADDRS <= infill_upr(31 downto 28) & PADDR(27 downto 0);
                            when 3 => PADDRS <= infill_upr(31 downto 28) & PADDR(27 downto 0);
                            when 4 => PADDRS <= infill_upr(31 downto 28) & PADDR(27 downto 0);
                            when 5 => PADDRS <= infill_upr(31 downto 28) & PADDR(27 downto 0);
                            when 6 => PADDRS <= infill_upr(31 downto 28) & PADDR(27 downto 0);
                            when 7 => PADDRS <=                            PADDR(27 downto 24) & infill(27 downto 24) & PADDR(23 downto 0);
                            when 8 => PADDRS <=                                                  infill(31 downto 24) & PADDR(23 downto 0);
                            when others => PADDRS <= PADDR;
                        end case;
                    end process;
                end generate;

g_addrs_m32 :   if (MADDR_BITS = 32) generate
                    PADDRS <= PADDR(31 downto 0);
                end generate;

end architecture CoreAPB3_arch;
