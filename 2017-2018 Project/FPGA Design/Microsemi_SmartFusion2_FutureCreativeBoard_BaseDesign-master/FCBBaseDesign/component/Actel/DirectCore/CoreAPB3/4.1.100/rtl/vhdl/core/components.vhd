-- ********************************************************************/
-- Actel Corporation Proprietary and Confidential
-- Copyright 2010 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	CoreAPB3 - components package
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

package components is

component CoreAPB3
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
FAMILY           : integer range 1 to 25	    := 19
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
end component;

end components;
