-- ********************************************************************
-- Actel Corporation Proprietary and Confidential
--  Copyright 2010 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	User Testbench for CoreAPB3
--
-- Revision Information:
-- Date     Description
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
-- 1. best viewed with tabstops set to "4"
-- 2. Most of the behavior is driven from the BFM script for the APB
--    master.  Consult the Actel AMBA BFM documentation for more information.
--
-- History:		1/28/10  - TFB created
--
-- *********************************************************************
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.coreparameters.all;
use work.components.all;
use work.bfm_package.all;

entity testbench is
generic (
-------------------------------------------------------------------------------
-- top-level parameters
-------------------------------------------------------------------------------

-- vector files for driving the APB master BFM
-- NOTE: location of the following files can be overridden at run time
APB_MASTER_VECTFILE			: string  := "coreapb3_usertb_master.vec";

-- APB Master System Clock cycle (in ns)
APB_MASTER_CLK_CYCLE		: integer := 30;

-- propagation delay in ns
TPD							: integer := 3
);
end entity testbench;

architecture testbench_arch of testbench is

-----------------------------------------------------------------------------
-- components
-----------------------------------------------------------------------------
-- from work.components ...

--constant RANGESIZE			: integer := 268435456;
--constant IADDR_ENABLE		: integer range 0 to 1 := 0;

-- BFM slave constants
constant SLAVE_AWIDTH		: integer := 8;
constant SLAVE_DEPTH		: integer := (2**SLAVE_AWIDTH) ;


-- System signals
signal SYSRSTN_apb			: std_logic;
signal SYSCLK_apb			: std_logic;

-- APB master bfm signals
signal PCLK					: std_logic;
signal PRESETN				: std_logic;
signal PADDR_apb_bfm_wide	: std_logic_vector(31 downto 0);
--signal PADDR				: std_logic_vector(23 downto 0);
signal PADDR				: std_logic_vector(31 downto 0);
signal PSEL_apb_bfm_wide	: std_logic_vector(15 downto 0);
signal PSEL					: std_logic;
signal PENABLE				: std_logic;
signal PWRITE				: std_logic;
signal PWDATA_apb_bfm_wide	: std_logic_vector(31 downto 0);
--signal PWDATA				: std_logic_vector(APB_DWIDTH-1 downto 0);
signal PWDATA				: std_logic_vector(31 downto 0);

-- input to bfm
signal PRDATA_apb_bfm_wide	: std_logic_vector(31 downto 0);
--signal PRDATA				: std_logic_vector(APB_DWIDTH-1 downto 0);
signal PRDATA				: std_logic_vector(31 downto 0);
signal PREADY				: std_logic;
signal PSLVERR				: std_logic;

-- input to APB bfm
--signal GP_IN_apb_bfm		: std_logic_vector(31 downto 0);
--signal GP_OUT_apb_bfm		: std_logic_vector(31 downto 0);
signal FINISHED_apb_bfm		: std_logic;
signal FAILED_apb_bfm		: std_logic;


-- misc. signals
signal GND256				: std_logic_vector(255 downto 0)	:=(others=>'0');
signal GND32				: std_logic_vector(31 downto 0)	:=(others=>'0');
signal GND1					: std_logic	:= '0';
signal stopsim				: integer range 0 to 1 := 0;

--signal PADDRS		: std_logic_vector(23 downto 0);
signal PADDRS		: std_logic_vector(31 downto 0);
--signal PADDRS0		: std_logic_vector((((1-IADDR_ENABLE)*24)+((IADDR_ENABLE)*32))-1 downto 0);
signal PWRITES		: std_logic;
signal PENABLES		: std_logic;
--signal PWDATAS		: std_logic_vector(APB_DWIDTH-1 downto 0);
signal PWDATAS		: std_logic_vector(31 downto 0);
signal PSELS0		: std_logic;
signal PSELS1		: std_logic;
signal PSELS2		: std_logic;
signal PSELS3		: std_logic;
signal PSELS4		: std_logic;
signal PSELS5		: std_logic;
signal PSELS6		: std_logic;
signal PSELS7		: std_logic;
signal PSELS8		: std_logic;
signal PSELS9		: std_logic;
signal PSELS10		: std_logic;
signal PSELS11		: std_logic;
signal PSELS12		: std_logic;
signal PSELS13		: std_logic;
signal PSELS14		: std_logic;
signal PSELS15		: std_logic;
signal PSELS16		: std_logic;

--signal PRDATAS0		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS1		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS2		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS3		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS4		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS5		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS6		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS7		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS8		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS9		: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS10	: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS11	: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS12	: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS13	: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS14	: std_logic_vector(APB_DWIDTH-1 downto 0);
--signal PRDATAS15	: std_logic_vector(APB_DWIDTH-1 downto 0);
signal PRDATAS0		: std_logic_vector(31 downto 0);
signal PRDATAS1		: std_logic_vector(31 downto 0);
signal PRDATAS2		: std_logic_vector(31 downto 0);
signal PRDATAS3		: std_logic_vector(31 downto 0);
signal PRDATAS4		: std_logic_vector(31 downto 0);
signal PRDATAS5		: std_logic_vector(31 downto 0);
signal PRDATAS6		: std_logic_vector(31 downto 0);
signal PRDATAS7		: std_logic_vector(31 downto 0);
signal PRDATAS8		: std_logic_vector(31 downto 0);
signal PRDATAS9		: std_logic_vector(31 downto 0);
signal PRDATAS10	: std_logic_vector(31 downto 0);
signal PRDATAS11	: std_logic_vector(31 downto 0);
signal PRDATAS12	: std_logic_vector(31 downto 0);
signal PRDATAS13	: std_logic_vector(31 downto 0);
signal PRDATAS14	: std_logic_vector(31 downto 0);
signal PRDATAS15	: std_logic_vector(31 downto 0);
signal PRDATAS16	: std_logic_vector(31 downto 0);

signal PREADYS0		: std_logic;
signal PREADYS1		: std_logic;
signal PREADYS2		: std_logic;
signal PREADYS3		: std_logic;
signal PREADYS4		: std_logic;
signal PREADYS5		: std_logic;
signal PREADYS6		: std_logic;
signal PREADYS7		: std_logic;
signal PREADYS8		: std_logic;
signal PREADYS9		: std_logic;
signal PREADYS10	: std_logic;
signal PREADYS11	: std_logic;
signal PREADYS12	: std_logic;
signal PREADYS13	: std_logic;
signal PREADYS14	: std_logic;
signal PREADYS15	: std_logic;
signal PREADYS16	: std_logic;
signal PSLVERRS0	: std_logic;
signal PSLVERRS1	: std_logic;
signal PSLVERRS2	: std_logic;
signal PSLVERRS3	: std_logic;
signal PSLVERRS4	: std_logic;
signal PSLVERRS5	: std_logic;
signal PSLVERRS6	: std_logic;
signal PSLVERRS7	: std_logic;
signal PSLVERRS8	: std_logic;
signal PSLVERRS9	: std_logic;
signal PSLVERRS10	: std_logic;
signal PSLVERRS11	: std_logic;
signal PSLVERRS12	: std_logic;
signal PSLVERRS13	: std_logic;
signal PSLVERRS14	: std_logic;
signal PSLVERRS15	: std_logic;
signal PSLVERRS16	: std_logic;

--signal PWDATAS_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS0_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS1_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS2_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS3_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS4_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS5_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS6_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS7_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS8_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS9_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS10_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS11_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS12_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS13_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS14_apb_slave		: std_logic_vector(31 downto 0);
--signal PRDATAS15_apb_slave		: std_logic_vector(31 downto 0);

signal s0_write                : std_logic;
signal s1_write                : std_logic;
signal s2_write                : std_logic;
signal s3_write                : std_logic;
signal s4_write                : std_logic;
signal s5_write                : std_logic;
signal s6_write                : std_logic;
signal s7_write                : std_logic;
signal s8_write                : std_logic;
signal s9_write                : std_logic;
signal s10_write               : std_logic;
signal s11_write               : std_logic;
signal s12_write               : std_logic;
signal s13_write               : std_logic;
signal s14_write               : std_logic;
signal s15_write               : std_logic;
signal s16_write               : std_logic;

-- GPIO for 2 master BFM's
signal GP_OUT       : std_logic_vector(31 downto 0);
signal GP_IN        : std_logic_vector(31 downto 0);


begin


-- instantiate DUT(s)
u_coreapb3 : CoreAPB3
generic map (
	APB_DWIDTH          => APB_DWIDTH,
	IADDR_OPTION        => IADDR_OPTION,
	APBSLOT0ENABLE      => APBSLOT0ENABLE,
	APBSLOT1ENABLE      => APBSLOT1ENABLE,
	APBSLOT2ENABLE      => APBSLOT2ENABLE,
	APBSLOT3ENABLE      => APBSLOT3ENABLE,
	APBSLOT4ENABLE      => APBSLOT4ENABLE,
	APBSLOT5ENABLE      => APBSLOT5ENABLE,
	APBSLOT6ENABLE      => APBSLOT6ENABLE,
	APBSLOT7ENABLE      => APBSLOT7ENABLE,
	APBSLOT8ENABLE      => APBSLOT8ENABLE,
	APBSLOT9ENABLE      => APBSLOT9ENABLE,
	APBSLOT10ENABLE     => APBSLOT10ENABLE,
	APBSLOT11ENABLE     => APBSLOT11ENABLE,
	APBSLOT12ENABLE     => APBSLOT12ENABLE,
	APBSLOT13ENABLE     => APBSLOT13ENABLE,
	APBSLOT14ENABLE     => APBSLOT14ENABLE,
	APBSLOT15ENABLE     => APBSLOT15ENABLE,
	MADDR_BITS          => MADDR_BITS,
	UPR_NIBBLE_POSN     => UPR_NIBBLE_POSN,
	SC_0                => SC_0,
	SC_1                => SC_1,
	SC_2                => SC_2,
	SC_3                => SC_3,
	SC_4                => SC_4,
	SC_5                => SC_5,
	SC_6                => SC_6,
	SC_7                => SC_7,
	SC_8                => SC_8,
	SC_9                => SC_9,
	SC_10               => SC_10,
	SC_11               => SC_11,
	SC_12               => SC_12,
	SC_13               => SC_13,
	SC_14               => SC_14,
	SC_15               => SC_15,
	FAMILY              => FAMILY
)
port map (
    IADDR               => (others => '0'),
	PRESETN				=> PRESETN,
	PCLK				=> PCLK,
	PADDR				=> PADDR,
	PWRITE				=> PWRITE,
	PENABLE				=> PENABLE,
	PSEL				=> PSEL,
	PWDATA				=> PWDATA,
	PRDATA				=> PRDATA,
	PREADY				=> PREADY,
	PSLVERR				=> PSLVERR,
	PADDRS				=> PADDRS,
	PWRITES				=> PWRITES,
	PENABLES			=> PENABLES,
	PWDATAS				=> PWDATAS,
	PSELS0				=> PSELS0,
	PSELS1				=> PSELS1,
	PSELS2				=> PSELS2,
	PSELS3				=> PSELS3,
	PSELS4				=> PSELS4,
	PSELS5				=> PSELS5,
	PSELS6				=> PSELS6,
	PSELS7				=> PSELS7,
	PSELS8				=> PSELS8,
	PSELS9				=> PSELS9,
	PSELS10				=> PSELS10,
	PSELS11				=> PSELS11,
	PSELS12				=> PSELS12,
	PSELS13				=> PSELS13,
	PSELS14				=> PSELS14,
	PSELS15				=> PSELS15,
	PSELS16				=> PSELS16,
	PRDATAS0			=> PRDATAS0,
	PRDATAS1			=> PRDATAS1,
	PRDATAS2			=> PRDATAS2,
	PRDATAS3			=> PRDATAS3,
	PRDATAS4			=> PRDATAS4,
	PRDATAS5			=> PRDATAS5,
	PRDATAS6			=> PRDATAS6,
	PRDATAS7			=> PRDATAS7,
	PRDATAS8			=> PRDATAS8,
	PRDATAS9			=> PRDATAS9,
	PRDATAS10			=> PRDATAS10,
	PRDATAS11			=> PRDATAS11,
	PRDATAS12			=> PRDATAS12,
	PRDATAS13			=> PRDATAS13,
	PRDATAS14			=> PRDATAS14,
	PRDATAS15			=> PRDATAS15,
	PRDATAS16			=> PRDATAS16,
	PREADYS0			=> PREADYS0,
	PREADYS1			=> PREADYS1,
	PREADYS2			=> PREADYS2,
	PREADYS3			=> PREADYS3,
	PREADYS4			=> PREADYS4,
	PREADYS5			=> PREADYS5,
	PREADYS6			=> PREADYS6,
	PREADYS7			=> PREADYS7,
	PREADYS8			=> PREADYS8,
	PREADYS9			=> PREADYS9,
	PREADYS10			=> PREADYS10,
	PREADYS11			=> PREADYS11,
	PREADYS12			=> PREADYS12,
	PREADYS13			=> PREADYS13,
	PREADYS14			=> PREADYS14,
	PREADYS15			=> PREADYS15,
	PREADYS16			=> PREADYS16,
	PSLVERRS0			=> PSLVERRS0,
	PSLVERRS1			=> PSLVERRS1,
	PSLVERRS2			=> PSLVERRS2,
	PSLVERRS3			=> PSLVERRS3,
	PSLVERRS4			=> PSLVERRS4,
	PSLVERRS5			=> PSLVERRS5,
	PSLVERRS6			=> PSLVERRS6,
	PSLVERRS7			=> PSLVERRS7,
	PSLVERRS8			=> PSLVERRS8,
	PSLVERRS9			=> PSLVERRS9,
	PSLVERRS10			=> PSLVERRS10,
	PSLVERRS11			=> PSLVERRS11,
	PSLVERRS12			=> PSLVERRS12,
	PSLVERRS13			=> PSLVERRS13,
	PSLVERRS14			=> PSLVERRS14,
	PSLVERRS15			=> PSLVERRS15,
	PSLVERRS16			=> PSLVERRS16
);

--g_0: if (APB_DWIDTH<32) generate
--	PRDATA_apb_bfm_wide(31 downto APB_DWIDTH) <= (others=>'0');
--end generate;
--PRDATA_apb_bfm_wide(APB_DWIDTH-1 downto 0) <= PRDATA(APB_DWIDTH-1 downto 0);
PRDATA_apb_bfm_wide <= PRDATA;

-- BFM monitors various signals
GP_IN <=
	"000000000000000" &  -- 31:17
    s16_write &          -- 16
    s15_write &          -- 15
    s14_write &          -- 14
    s13_write &          -- 13
    s12_write &          -- 12
    s11_write &          -- 11
    s10_write &          -- 10
    s9_write &           --  9
    s8_write &           --  8
    s7_write &           --  7
    s6_write &           --  6
    s5_write &           --  5
    s4_write &           --  4
    s3_write &           --  3
    s2_write &           --  2
    s1_write &           --  1
    s0_write;            --  0

-- instantiate APB Master BFM to drive APB mirrored master port
u_apb_master : BFM_APB
generic map (
	VECTFILE		=> APB_MASTER_VECTFILE,
	TPD				=> TPD,
	-- passing testbench parameters to BFM ARGVALUE* parameters
	ARGVALUE0  => APB_DWIDTH,
	ARGVALUE1  => IADDR_OPTION,
	ARGVALUE2  => APBSLOT0ENABLE,
	ARGVALUE3  => APBSLOT1ENABLE,
	ARGVALUE4  => APBSLOT2ENABLE,
	ARGVALUE5  => APBSLOT3ENABLE,
	ARGVALUE6  => APBSLOT4ENABLE,
	ARGVALUE7  => APBSLOT5ENABLE,
	ARGVALUE8  => APBSLOT6ENABLE,
	ARGVALUE9  => APBSLOT7ENABLE,
	ARGVALUE10 => APBSLOT8ENABLE,
	ARGVALUE11 => APBSLOT9ENABLE,
	ARGVALUE12 => APBSLOT10ENABLE,
	ARGVALUE13 => APBSLOT11ENABLE,
	ARGVALUE14 => APBSLOT12ENABLE,
	ARGVALUE15 => APBSLOT13ENABLE,
	ARGVALUE16 => APBSLOT14ENABLE,
	ARGVALUE17 => APBSLOT15ENABLE,
	ARGVALUE18 => MADDR_BITS,
	ARGVALUE19 => UPR_NIBBLE_POSN,
	ARGVALUE20 => SC_0,
	ARGVALUE21 => SC_1,
	ARGVALUE22 => SC_2,
	ARGVALUE23 => SC_3,
	ARGVALUE24 => SC_4,
	ARGVALUE25 => SC_5,
	ARGVALUE26 => SC_6,
	ARGVALUE27 => SC_7,
	ARGVALUE28 => SC_8,
	ARGVALUE29 => SC_9,
	ARGVALUE30 => SC_10,
	ARGVALUE31 => SC_11,
	ARGVALUE32 => SC_12,
	ARGVALUE33 => SC_13,
	ARGVALUE34 => SC_14,
	ARGVALUE35 => SC_15
)
port map (
	SYSCLK			=> SYSCLK_apb,
	SYSRSTN			=> SYSRSTN_apb,
	PCLK			=> PCLK,
	PRESETN			=> PRESETN,
	PADDR			=> PADDR_apb_bfm_wide,
	PSEL			=> PSEL_apb_bfm_wide,
	PENABLE			=> PENABLE,
	PWRITE			=> PWRITE,
	PWDATA			=> PWDATA_apb_bfm_wide,
	PRDATA			=> PRDATA_apb_bfm_wide,
	PREADY			=> PREADY,
	PSLVERR			=> PSLVERR,
	INTERRUPT		=> GND256,
	GP_OUT			=> GP_OUT,
	GP_IN			=> GP_IN,
	EXT_WR			=> open,
	EXT_RD			=> open,
	EXT_ADDR		=> open,
	EXT_DATA		=> open,
	EXT_WAIT		=> GND1,
	FINISHED		=> FINISHED_apb_bfm,
	FAILED			=> FAILED_apb_bfm
);
--PADDR		<= PADDR_apb_bfm_wide(23 downto 0);
PADDR		<= PADDR_apb_bfm_wide(31 downto 0);
--PSEL		<= PSEL_apb_bfm_wide(0);
PSEL		<= PSEL_apb_bfm_wide( 0) or
               PSEL_apb_bfm_wide( 1) or
               PSEL_apb_bfm_wide( 2) or
               PSEL_apb_bfm_wide( 3) or
               PSEL_apb_bfm_wide( 4) or
               PSEL_apb_bfm_wide( 5) or
               PSEL_apb_bfm_wide( 6) or
               PSEL_apb_bfm_wide( 7) or
               PSEL_apb_bfm_wide( 8) or
               PSEL_apb_bfm_wide( 9) or
               PSEL_apb_bfm_wide(10) or
               PSEL_apb_bfm_wide(11) or
               PSEL_apb_bfm_wide(12) or
               PSEL_apb_bfm_wide(13) or
               PSEL_apb_bfm_wide(14) or
               PSEL_apb_bfm_wide(15) ;
--PWDATA		<= PWDATA_apb_bfm_wide(APB_DWIDTH-1 downto 0);
PWDATA		<= PWDATA_apb_bfm_wide;

-- BFM slave 0
u_slave0 : BFM_APBSLAVE
generic map (
	--AWIDTH		=> (((1-IADDR_ENABLE)*SLAVE_AWIDTH)+((IADDR_ENABLE)*28)),
	--DEPTH		=> (((1-IADDR_ENABLE)*SLAVE_DEPTH)+((IADDR_ENABLE)*(2**28))),
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS0,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	--PADDR		=> PADDRS0((((1-IADDR_ENABLE)*SLAVE_AWIDTH)+((IADDR_ENABLE)*28)-1) downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS0,
	PREADY		=> PREADYS0,
	PSLVERR		=> PSLVERRS0
);

-- BFM slave 1
u_slave1 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS1,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS1,
	PREADY		=> PREADYS1,
	PSLVERR		=> PSLVERRS1
);

-- BFM slave 2
u_slave2 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS2,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS2,
	PREADY		=> PREADYS2,
	PSLVERR		=> PSLVERRS2
);

-- BFM slave 3
u_slave3 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS3,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS3,
	PREADY		=> PREADYS3,
	PSLVERR		=> PSLVERRS3
);

-- BFM slave 4
u_slave4 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS4,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS4,
	PREADY		=> PREADYS4,
	PSLVERR		=> PSLVERRS4
);

-- BFM slave 5
u_slave5 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS5,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS5,
	PREADY		=> PREADYS5,
	PSLVERR		=> PSLVERRS5
);

-- BFM slave 6
u_slave6 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS6,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS6,
	PREADY		=> PREADYS6,
	PSLVERR		=> PSLVERRS6
);

-- BFM slave 7
u_slave7 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS7,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS7,
	PREADY		=> PREADYS7,
	PSLVERR		=> PSLVERRS7
);

-- BFM slave 8
u_slave8 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS8,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS8,
	PREADY		=> PREADYS8,
	PSLVERR		=> PSLVERRS8
);

-- BFM slave 9
u_slave9 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS9,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS9,
	PREADY		=> PREADYS9,
	PSLVERR		=> PSLVERRS9
);

-- BFM slave 10
u_slave10 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS10,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS10,
	PREADY		=> PREADYS10,
	PSLVERR		=> PSLVERRS10
);

-- BFM slave 11
u_slave11 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS11,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS11,
	PREADY		=> PREADYS11,
	PSLVERR		=> PSLVERRS11
);

-- BFM slave 12
u_slave12 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS12,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS12,
	PREADY		=> PREADYS12,
	PSLVERR		=> PSLVERRS12
);

-- BFM slave 13
u_slave13 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS13,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS13,
	PREADY		=> PREADYS13,
	PSLVERR		=> PSLVERRS13
);

-- BFM slave 14
u_slave14 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS14,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS14,
	PREADY		=> PREADYS14,
	PSLVERR		=> PSLVERRS14
);

-- BFM slave 15
u_slave15 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS15,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS15,
	PREADY		=> PREADYS15,
	PSLVERR		=> PSLVERRS15
);

-- BFM slave 16
u_slave16 : BFM_APBSLAVE
generic map (
	AWIDTH		=> SLAVE_AWIDTH,
	DEPTH		=> SLAVE_DEPTH,
	DWIDTH		=> 32,
	TPD			=> TPD
)
port map (
	PCLK		=> PCLK,
	PRESETN		=> PRESETN,
	PENABLE		=> PENABLES,
	PWRITE		=> PWRITES,
	PSEL		=> PSELS16,
	PADDR		=> PADDRS(SLAVE_AWIDTH-1 downto 0),
	PWDATA		=> PWDATAS,
	PRDATA		=> PRDATAS16,
	PREADY		=> PREADYS16,
	PSLVERR		=> PSLVERRS16
);

-- adjust busses to widths
--g_1: if (APB_DWIDTH<32) generate
--	PWDATAS_apb_slave(31 downto APB_DWIDTH) <= (others=>'0');
--end generate;
--PWDATAS_apb_slave(APB_DWIDTH-1 downto 0) <= PWDATAS(APB_DWIDTH-1 downto 0);

--PRDATAS0		<= PRDATAS0_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS1		<= PRDATAS1_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS2		<= PRDATAS2_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS3		<= PRDATAS3_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS4		<= PRDATAS4_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS5		<= PRDATAS5_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS6		<= PRDATAS6_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS7		<= PRDATAS7_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS8		<= PRDATAS8_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS9		<= PRDATAS9_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS10		<= PRDATAS10_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS11		<= PRDATAS11_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS12		<= PRDATAS12_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS13		<= PRDATAS13_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS14		<= PRDATAS14_apb_slave(APB_DWIDTH-1 downto 0);
--PRDATAS15		<= PRDATAS15_apb_slave(APB_DWIDTH-1 downto 0);

    -----------------------------------------------------------------------
    -- Detect writes to individual slots
    -----------------------------------------------------------------------
    process (PCLK, PRESETN)
    begin
        if (PRESETN = '0') then
            s0_write  <= '0';
            s1_write  <= '0';
            s2_write  <= '0';
            s3_write  <= '0';
            s4_write  <= '0';
            s5_write  <= '0';
            s6_write  <= '0';
            s7_write  <= '0';
            s8_write  <= '0';
            s9_write  <= '0';
            s10_write <= '0';
            s11_write <= '0';
            s12_write <= '0';
            s13_write <= '0';
            s14_write <= '0';
            s15_write <= '0';
            s16_write <= '0';
        elsif (PCLK'event and PCLK = '1') then
            -- Set write indication bits
            if (PSELS0  = '1' and PWRITES = '1') then s0_write  <= '1'; end if;
            if (PSELS1  = '1' and PWRITES = '1') then s1_write  <= '1'; end if;
            if (PSELS2  = '1' and PWRITES = '1') then s2_write  <= '1'; end if;
            if (PSELS3  = '1' and PWRITES = '1') then s3_write  <= '1'; end if;
            if (PSELS4  = '1' and PWRITES = '1') then s4_write  <= '1'; end if;
            if (PSELS5  = '1' and PWRITES = '1') then s5_write  <= '1'; end if;
            if (PSELS6  = '1' and PWRITES = '1') then s6_write  <= '1'; end if;
            if (PSELS7  = '1' and PWRITES = '1') then s7_write  <= '1'; end if;
            if (PSELS8  = '1' and PWRITES = '1') then s8_write  <= '1'; end if;
            if (PSELS9  = '1' and PWRITES = '1') then s9_write  <= '1'; end if;
            if (PSELS10 = '1' and PWRITES = '1') then s10_write <= '1'; end if;
            if (PSELS11 = '1' and PWRITES = '1') then s11_write <= '1'; end if;
            if (PSELS12 = '1' and PWRITES = '1') then s12_write <= '1'; end if;
            if (PSELS13 = '1' and PWRITES = '1') then s13_write <= '1'; end if;
            if (PSELS14 = '1' and PWRITES = '1') then s14_write <= '1'; end if;
            if (PSELS15 = '1' and PWRITES = '1') then s15_write <= '1'; end if;
            if (PSELS16 = '1' and PWRITES = '1') then s16_write <= '1'; end if;
            -- Clear write indication bits
            if (GP_OUT(0)  = '1') then s0_write  <= '0'; end if;
            if (GP_OUT(1)  = '1') then s1_write  <= '0'; end if;
            if (GP_OUT(2)  = '1') then s2_write  <= '0'; end if;
            if (GP_OUT(3)  = '1') then s3_write  <= '0'; end if;
            if (GP_OUT(4)  = '1') then s4_write  <= '0'; end if;
            if (GP_OUT(5)  = '1') then s5_write  <= '0'; end if;
            if (GP_OUT(6)  = '1') then s6_write  <= '0'; end if;
            if (GP_OUT(7)  = '1') then s7_write  <= '0'; end if;
            if (GP_OUT(8)  = '1') then s8_write  <= '0'; end if;
            if (GP_OUT(9)  = '1') then s9_write  <= '0'; end if;
            if (GP_OUT(10) = '1') then s10_write <= '0'; end if;
            if (GP_OUT(11) = '1') then s11_write <= '0'; end if;
            if (GP_OUT(12) = '1') then s12_write <= '0'; end if;
            if (GP_OUT(13) = '1') then s13_write <= '0'; end if;
            if (GP_OUT(14) = '1') then s14_write <= '0'; end if;
            if (GP_OUT(15) = '1') then s15_write <= '0'; end if;
            if (GP_OUT(16) = '1') then s16_write <= '0'; end if;
        end if;
    end process;

-- System Clocks
process
begin
	SYSCLK_apb	<= '0';
	wait for (APB_MASTER_CLK_CYCLE / 2)*1 ns;
	SYSCLK_apb	<= '1';
	wait for (APB_MASTER_CLK_CYCLE / 2)*1 ns;
	if (stopsim = 1) then
		wait;
	end if;
end process;

-- Main simulation
process
begin
	SYSRSTN_apb	<= '0';
	wait for APB_MASTER_CLK_CYCLE * 1 ns;
	wait for (TPD)*1 ns;
	SYSRSTN_apb	<= '1';

	-- wait until BFM is finished
	while (not(FINISHED_apb_bfm = '1')) loop
		wait on SYSCLK_apb;
		wait for (TPD)*1 ns;
	end loop;
	wait for 1 ns;
	stopsim <= 1;
	wait;
end process;

end architecture testbench_arch;
