-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 6419 $
-- SVN $Date: 2009-02-04 04:34:22 -0800 (Wed, 04 Feb 2009) $
use STd.tEXTio.all;
library ieee;
use IEEe.STD_logIC_1164.all;
use ieee.nuMERic_sTD.all;
use woRK.SF2_MSS_sys_sb_CoreUARTapb_0_bfM_packAGE.all;
entity SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBL is
generic (VECtfilE: sTRIng := "test.vec";
Max_iNSTrucTIOns: inteGER := 16384;
mAX_stacK: INTeger := 1024;
max_MEmteST: INtegeR := 65536;
tpD: inTEGEr range 0 to 1000 := 1;
DEbuglEVEl: INtegeR range -1 to 5 := -1;
arGVAlue0: intEGEr := 0;
ArgvaLUE1: INtegeR := 0;
aRGValue2: INtegeR := 0;
arGVAlue3: IntegER := 0;
arGVAlue4: INTeger := 0;
aRGValue5: INtegER := 0;
ARgvalUE6: iNTEger := 0;
ArgvaLUE7: inteGER := 0;
argvALUe8: iNTEger := 0;
argVALue9: iNTEger := 0;
ARgvalUE10: iNTEger := 0;
aRGValue11: INtegeR := 0;
ARGvaluE12: INtegeR := 0;
ArgvALUe13: intEGEr := 0;
aRGValue14: iNTEger := 0;
ARGvaluE15: intEGEr := 0;
ArgvALUE16: inTEGer := 0;
ARGvaluE17: iNTEger := 0;
ARgvaLUE18: inTEGer := 0;
ARGvalUE19: InteGER := 0;
aRGVAlue20: INtegeR := 0;
arGVAlue21: iNTEger := 0;
arGVAlue22: INtegER := 0;
ArgvaLUE23: INtegER := 0;
ArgvALUe24: INTeger := 0;
ARgvaLUE25: inTEGer := 0;
arGVAlue26: inteGER := 0;
aRGValuE27: IntegER := 0;
ARgvalUE28: IntegER := 0;
aRGValue29: iNTEger := 0;
argVALue30: InteGER := 0;
ARgvalUE31: INtegeR := 0;
aRGValue32: inTEGer := 0;
ARgvalUE33: intEGEr := 0;
arGVAlue34: INtegeR := 0;
ArgvaLUE35: intEGEr := 0;
argvALUe36: inteGER := 0;
arGVAlue37: intEGEr := 0;
ArgvaLUE38: intEGEr := 0;
aRGVAlue39: iNTEger := 0;
aRGVAlue40: IntegER := 0;
ARGvaluE41: intEGEr := 0;
ARgvaLUE42: inTEGer := 0;
arGVAlue43: INTeger := 0;
ARGvalUE44: INtegeR := 0;
arGVAlue45: inTEGEr := 0;
ARGvaluE46: iNTEGer := 0;
aRGValue47: inteGER := 0;
argvALUe48: INtegeR := 0;
ArgvALUE49: inTEGer := 0;
ArgvaLUE50: InteGER := 0;
ArgvaLUE51: IntegER := 0;
ArgvaLUE52: IntegER := 0;
aRGValuE53: iNTEger := 0;
argvALUe54: inTEGer := 0;
ARGvalUE55: INTeger := 0;
ARGvaluE56: InteGER := 0;
argVALue57: INTeger := 0;
aRGValue58: inteGER := 0;
ARGValuE59: INtegeR := 0;
aRGValue60: INTEger := 0;
ARgvalUE61: inteGER := 0;
ARGvalUE62: INTeger := 0;
ARgvaLUE63: IntegER := 0;
argVALue64: IntegER := 0;
ARgvaLUE65: inTEGer := 0;
argvALUe66: iNTEger := 0;
ArgvALUE67: inTEGer := 0;
argvALUe68: INtegeR := 0;
arGVAlue69: INTeger := 0;
ArgvaLUE70: INTeger := 0;
ARgvalUE71: iNTEger := 0;
argvALUe72: INTeger := 0;
ARGvalUE73: intEGEr := 0;
ArgvaLUE74: iNTEger := 0;
argVALue75: intEGEr := 0;
argVALue76: INTeger := 0;
argVALue77: inTEGEr := 0;
ARgvalUE78: iNTEger := 0;
ARgvalUE79: INtegeR := 0;
ARGvalUE80: iNTEger := 0;
ArgvaLUE81: iNTEger := 0;
argVALue82: inteGER := 0;
ARGvalUE83: intEGEr := 0;
argvALUe84: intEGEr := 0;
ArgvaLUE85: INTEger := 0;
ARgvalUE86: INtegeR := 0;
argvALUe87: INtegeR := 0;
aRGValue88: intEGEr := 0;
ArgvALUE89: INTeger := 0;
argvALUe90: intEGEr := 0;
argVALue91: INtegeR := 0;
ARGvalUE92: INtegeR := 0;
argvALUe93: inteGER := 0;
arGVAlue94: inTEGer := 0;
argVALue95: inteGER := 0;
ARGvaluE96: INtegeR := 0;
argvALUe97: INtegeR := 0;
ARGvaluE98: InteGER := 0;
aRGValuE99: inteGER := 0); port (sySCLk: in std_LOgic;
SysrsTN: in sTD_logIC;
Haddr: out stD_logiC_VectOR(31 downto 0);
hCLK: out STD_logIC;
HRESetn: out STD_logIC;
HbursT: out std_LOgic_VEctoR(2 downto 0);
HmastLOCk: out Std_lOGIc;
HProt: out STD_loGIC_veCTOr(3 downto 0);
hsiZE: out STD_loGIC_veCTOr(2 downto 0);
htRANs: out STd_loGIC_veCTOr(1 downto 0);
HWRite: out STD_logIC;
HwdatA: out std_LOGic_VECtor(31 downto 0);
hRDAta: in std_LOgic_VEctoR(31 downto 0);
HReady: in STD_logIC;
hRESp: in Std_lOGIc;
hsel: out Std_LOGic_vECTor(15 downto 0);
InterRUPt: in std_LOgic_VEctoR(255 downto 0);
gP_Out: out STD_logIC_vecTOr(31 downto 0);
gp_IN: in STd_lOGIC_veCTor(31 downto 0);
EXT_wr: out Std_lOGIc;
EXt_rd: out Std_lOGIc;
exT_addr: out STd_loGIC_vecTOr(31 downto 0);
ext_DAta: inout sTD_logIC_vecTOR(31 downto 0);
ext_Wait: in STD_logIC;
FINisheD: out std_LOGic;
FAiled: out stD_LogiC);
end SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBL;

architecture BFMA1I10i of SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBL is

signal BFMA1OO1ol: STD_logIC := '0';

signal inSTR_in: Std_lOGIc_veCTOr(31 downto 0) := ( others => '0');

signal con_Addr: Std_lOGIc_vECTor(15 downto 0) := ( others => '0');

signal Con_DATa: stD_LogiC_VectOR(31 downto 0) := ( others => 'Z');

begin
BFMA1LO1ol: SF2_MSS_sys_sb_CoreUARTapb_0_BFM_MAIN
generic map (opmODE => 0,
cON_spuLSE => 0,
vECTfile => VectfILE,
Max_iNSTructIONs => max_INstrUCTionS,
Tpd => tPD,
max_STack => maX_StacK,
MAX_memTESt => maX_memtEST,
deBUGleveL => DebugLEVEl,
ARGvaluE0 => ArgvaLUE0,
ARGvalUE1 => ArgvaLUE1,
argVALue2 => ArgvaLUE2,
aRGValue3 => ArgvaLUE3,
ARgvaLUE4 => argVALue4,
argvALUe5 => argvALUe5,
arGVAlue6 => argvALUe6,
argVALue7 => ArgvaLUE7,
aRGValue8 => ArgvaLUE8,
ArgvALUe9 => ARgvalUE9,
ArgvaLUE10 => ARGvaluE10,
aRGValue11 => argvALUe11,
aRGValue12 => ArgvaLUE12,
aRGValue13 => ARgvaLUE13,
arGVAlue14 => ARgvalUE14,
arGVAlue15 => aRGValue15,
argVALue16 => ARGvaluE16,
ARgvalUE17 => ARGvaluE17,
arGVAlue18 => argVALue18,
aRGValue19 => ArgvALUe19,
ArgvaLUE20 => ARGvalUE20,
argvALUe21 => ARgvalUE21,
aRGVAlue22 => arGVAlue22,
aRGVAlue23 => ArgvaLUE23,
ArgvaLUE24 => ARGvaluE24,
argVALue25 => arGVAlue25,
aRGValue26 => ArgvaLUE26,
ARgvalUE27 => arGVAlue27,
aRGValue28 => aRGValuE28,
aRGValue29 => ARGValuE29,
ARgvalUE30 => ARgvalUE30,
arGVALue31 => ARGvaluE31,
aRGValue32 => ARgvalUE32,
ARgvaLUE33 => arGVAlue33,
argVALue34 => argvALUe34,
aRGValuE35 => aRGValue35,
ARGvaluE36 => ArgvaLUE36,
argVALue37 => ARGvaluE37,
arGVAlue38 => ArgvaLUE38,
argVALue39 => argVALue39,
argVALue40 => aRGValue40,
arGVAlue41 => ARGvaluE41,
ArgvALUE42 => aRGValuE42,
ArgvaLUE43 => aRGValue43,
ArgvaLUE44 => aRGVAlue44,
arGVAlue45 => argvALUe45,
argVALue46 => arGVAlue46,
argVALue47 => ARGvaluE47,
ARGvalUE48 => aRGValue48,
ARgvalUE49 => argvALUe49,
ARgvalUE50 => arGVAlue50,
arGVAlue51 => ARGvaluE51,
ArgvaLUE52 => aRGValue52,
aRGValue53 => ARgvalUE53,
aRGVAlue54 => arGVAlue54,
arGVAlue55 => arGVAlue55,
argvALUe56 => aRGValue56,
argvALUe57 => arGVALue57,
ARGvaluE58 => aRGValue58,
argvALUe59 => ARgvalUE59,
ARgvalUE60 => ArgvALUe60,
ARgvalUE61 => ArgvaLUE61,
arGVAlue62 => aRGVAlue62,
argVALue63 => ArgvaLUE63,
ArgvaLUE64 => arGVAlue64,
argvALUe65 => ArgvaLUE65,
ARgvalUE66 => argVALue66,
argVALue67 => argvALUe67,
ARGvalUE68 => ArgvaLUE68,
ArgvaLUE69 => ARgvaLUE69,
ARGvaluE70 => aRGVAlue70,
ARGvaluE71 => arGVAlue71,
aRGValue72 => argvALUe72,
ARGvalUE73 => aRGValue73,
aRGValuE74 => arGVAlue74,
ArgvaLUE75 => aRGValue75,
ArgvaLUE76 => aRGVAlue76,
ARGvaluE77 => aRGValue77,
aRGValue78 => argvALUe78,
ArgvaLUE79 => ARgvaLUE79,
argVALue80 => argVALue80,
ARgvalUE81 => ARGvalUE81,
argvALUe82 => ArgvaLUE82,
ArgvaLUE83 => ARgvalUE83,
argVALue84 => arGVAlue84,
ARgvalUE85 => arGVAlue85,
aRGValue86 => ARgvalUE86,
ARgvalUE87 => ARgvaLUE87,
argVALue88 => arGVAlue88,
ArgvaLUE89 => ArgvALUE89,
ArgvaLUE90 => aRGVAlue90,
aRGValue91 => aRGValue91,
arGVAlue92 => argVALue92,
argvALUe93 => argvALUe93,
ARGvalUE94 => argvALUe94,
ARGvaluE95 => ARGValuE95,
argVALue96 => argvALUe96,
argvALUe97 => ARGValuE97,
ArgvALUe98 => ARgvalUE98,
ARgvalUE99 => arGVAlue99)
port map (sYSClk => SYsclk,
SYSrstn => sySRStn,
HAddr => HADDr,
Hclk => Hclk,
PClk => open ,
HresETN => hreSETn,
HBurst => HBurst,
hmasTLOck => HmastLOCk,
hprOT => hproT,
hSIZe => HSIze,
HtranS => htrANS,
hwriTE => hwrITE,
HwdaTA => HWData,
HRdata => HRdata,
hreaDY => HREady,
hreSP => HResp,
hsel => hSEL,
INterRUPT => iNTErrupT,
GP_ouT => GP_out,
GP_in => gp_iN,
EXT_wr => ext_WR,
ext_RD => ext_RD,
Ext_aDDR => EXt_adDR,
ext_Data => EXT_datA,
Ext_wAIT => exT_wait,
con_Addr => COn_adDR,
con_DATa => CON_datA,
COn_rd => BFMA1OO1ol,
con_WR => BFMA1Oo1ol,
Con_BUSy => open ,
iNSTR_ouT => open ,
INStr_iN => iNSTr_iN,
FInishED => fINIshed,
FAiled => failED);
end BFMA1i10I;
