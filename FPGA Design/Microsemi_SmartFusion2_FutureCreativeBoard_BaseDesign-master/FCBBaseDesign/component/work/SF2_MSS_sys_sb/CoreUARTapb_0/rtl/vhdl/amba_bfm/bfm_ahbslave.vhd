-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 6419 $
-- SVN $Date: 2009-02-04 04:34:22 -0800 (Wed, 04 Feb 2009) $
library IEEe;
use Ieee.stD_Logic_1164.all;
use IEEe.numERIc_stD.all;
use worK.bfm_Misc.all;
use woRK.bfM_textIO.all;
use woRK.SF2_MSS_sys_sb_CoreUARTapb_0_bfM_packAGE.all;
use Std.TExtio.all;
entity SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVE is
generic (awIDTh: INTeger range 1 to 32;
dePTH: intEGEr := 256;
inITFIle: STring := "";
ID: INtegeR := 0;
enFUNc: inTEGer := 0;
tpd: IntegER range 0 to 1000 := 1;
deBUG: intEGEr range -1 to 5 := -1); port (hCLK: in STD_loGIC;
HreseTN: in std_Logic;
hsEL: in Std_lOGIc;
HwritE: in Std_lOGIc;
HADdr: in STD_logIC_vecTOr(awIDTh-1 downto 0);
hwDATa: in sTD_logIC_vecTOr(31 downto 0);
HRData: out Std_lOGIc_veCTor(31 downto 0);
hrEADyin: in stD_logiC;
HREadyoUT: out stD_LogiC;
htRANs: in Std_lOGIc_vECTor(1 downto 0);
hsizE: in STD_loGIC_vecTOr(2 downto 0);
HburST: in Std_lOGIc_veCTor(2 downto 0);
hMAStlocK: in STD_logIC;
hpROT: in Std_LOGIc_vECTor(3 downto 0);
HresP: out std_Logic);
end SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVE;

architecture BFMA1Io1ol of SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVE is

signal EXt_en: std_LOgic;

signal EXT_wr: sTD_logIC;

signal Ext_rD: STd_loGIC;

signal Ext_aDDR: Std_lOGIc_vECTor(aWIDth-1 downto 0);

signal ext_DATa: Std_LOGIc_vECTor(31 downto 0);

begin
ext_EN <= '0';
exT_Wr <= '0';
Ext_rD <= '0';
EXT_adDR <= ( others => '0');
ext_DAta <= ( others => 'Z');
BFMA1Oiill: SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVEeXT
generic map (AWidth => AWIdth,
DEpth => depTH,
eXT_sizE => 2,
INitfiLE => InitfILE,
Id => ID,
eNFUnc => enFUNc,
EnfiFO => 0,
tpd => Tpd,
Debug => debUG)
port map (hclk => hcLK,
hRESetn => hrESEtn,
HSel => hsel,
HWrite => HWrite,
HADdr => HAddr,
HWdata => HwdatA,
hrdATA => hRDAta,
HreadYIN => hREAdyiN,
HREadyoUT => hreaDYOut,
htrANS => hTRAns,
hSIZe => hsIZE,
hBURst => hbURSt,
hmaSTLock => HmasTLOCk,
Hprot => hproT,
hRESp => hrESP,
EXT_en => ext_EN,
ext_WR => Ext_WR,
Ext_rD => ext_RD,
EXT_addR => ext_ADDr,
Ext_DATA => Ext_dATA,
TXReadY => open ,
RXReady => open );
end BFMA1io1OL;
