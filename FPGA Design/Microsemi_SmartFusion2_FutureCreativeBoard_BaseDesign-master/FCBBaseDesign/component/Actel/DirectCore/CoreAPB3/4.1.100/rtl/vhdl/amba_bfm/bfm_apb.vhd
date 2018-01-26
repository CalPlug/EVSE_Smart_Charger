-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 11878 $
-- SVN $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $
use sTd.TEXtio.all;
library ieee;
use ieEE.std_LOGic_1164.all;
use IEee.NUMeriC_Std.all;
use Work.BFM_pacKAGe.all;
entity BFM_apb is
generic (VECtfilE: strING := "test.vec";
max_InstrUCTionS: INTeger := 16384;
Max_mEMTest: iNTEger := 65536;
MAx_stACK: INTeger := 1024;
TPd: IntegER range 0 to 1000 := 1;
debuGLEvel: INTEger range -1 to 5 := -1;
ArgvaLUE0: iNTEGer := 0;
ARgvalUE1: iNTEger := 0;
ARGvaluE2: inteGER := 0;
argVALue3: intEGEr := 0;
ARGvaluE4: IntegER := 0;
ArgvALUe5: INtegER := 0;
ARgvalUE6: InteGER := 0;
ARGvaluE7: INTEger := 0;
arGVAlue8: INTegeR := 0;
argVALue9: INTeger := 0;
arGVAlue10: inteGER := 0;
ArgvALUe11: inTEGer := 0;
ARgvalUE12: IntegER := 0;
ArgvaLUE13: INtegeR := 0;
ArgvALUe14: inteGER := 0;
argVALue15: inteGEr := 0;
ArgvaLUE16: INtegER := 0;
argvALUe17: inteGER := 0;
ARgvaLUE18: INtegER := 0;
argVALue19: INTeger := 0;
arGVAlue20: INtegeR := 0;
arGVAlue21: INTEger := 0;
ARGvaluE22: INTeger := 0;
ARGvaluE23: inteGER := 0;
ArgvaLUE24: INTegeR := 0;
aRGValuE25: INtegeR := 0;
argVALue26: INTeger := 0;
ArgvALUe27: iNTEGer := 0;
argVALue28: inTEGer := 0;
aRGValuE29: intEGEr := 0;
argvALUe30: inTEGer := 0;
argVALue31: InteGER := 0;
arGVAlue32: INTeger := 0;
ARgvaLUE33: iNTEger := 0;
arGVAlue34: IntegER := 0;
arGVAlue35: inteGER := 0;
ArgvaLUE36: iNTEGer := 0;
ARgvalUE37: inteGER := 0;
ARgvalUE38: INTegeR := 0;
ARGvaluE39: INTeger := 0;
ArgvALUe40: INtegeR := 0;
aRGValue41: inteGER := 0;
ARgvalUE42: intEGEr := 0;
ARGValuE43: IntegER := 0;
ARgvalUE44: IntegER := 0;
ARGvaluE45: INTEger := 0;
arGVAlue46: iNTEger := 0;
argvALUe47: iNTEger := 0;
argVALue48: INtegeR := 0;
argVALue49: integER := 0;
arGVALue50: IntegER := 0;
ARGvaluE51: iNTEger := 0;
ArgvaLUE52: inteGER := 0;
argvALUe53: intEGEr := 0;
ARgvalUE54: IntegER := 0;
ARGValuE55: iNTEGer := 0;
argvALUe56: INtegeR := 0;
aRGValue57: intEGEr := 0;
argvALUe58: iNTEger := 0;
argVALue59: INtegeR := 0;
ArgvaLUE60: inteGER := 0;
argVALue61: intEGER := 0;
ARGvaluE62: iNTEger := 0;
ARgvalUE63: INTEger := 0;
ArgvaLUE64: INTeger := 0;
arGVAlue65: inteGER := 0;
ArgvaLUE66: intEGEr := 0;
argvALUe67: intEGEr := 0;
argvALUe68: inteGER := 0;
ARgvalUE69: intEGEr := 0;
ArgvaLUE70: INTegeR := 0;
aRGVAlue71: inteGER := 0;
ARgvalUE72: intEGEr := 0;
arGVAlue73: INtegeR := 0;
ARgvaLUE74: inteGER := 0;
ArgvALUE75: intEGEr := 0;
ARgvalUE76: IntegER := 0;
argvALUe77: IntegER := 0;
ArgvALUe78: IntegER := 0;
ArgvaLUE79: IntegER := 0;
aRGValuE80: iNTEger := 0;
aRGValue81: IntegER := 0;
ARgvalUE82: IntegER := 0;
argvALUe83: inTEGer := 0;
ARGvalUE84: INtegeR := 0;
ArgvaLUE85: IntegER := 0;
ArgvALUe86: INtegER := 0;
ArgvaLUE87: iNTEger := 0;
arGVAlue88: IntegER := 0;
ARgvalUE89: iNTEGer := 0;
ARGvalUE90: iNTEger := 0;
argvALue91: inteGER := 0;
ArgvaLUE92: InteGER := 0;
ARgvalUE93: inteGER := 0;
ArgvaLUE94: INTeger := 0;
ArgvaLUE95: IntegER := 0;
ArgvaLUE96: INTeger := 0;
ARgvalUE97: iNTEger := 0;
ArgvALUe98: intEGEr := 0;
ArgvaLUE99: iNTEger := 0); port (syscLK: in Std_lOGIc;
SYsrstN: in stD_logiC;
pclk: out STd_loGIC;
PResetN: out std_LOgic;
paDDR: out STd_loGIC_veCTOr(31 downto 0);
penaBLE: out sTD_logIC;
pwRITe: out Std_LOGic;
pWDAta: out STD_logIC_veCTOr(31 downto 0);
PRdata: in STd_lOGIC_veCTor(31 downto 0);
PreadY: in std_LOgic;
pSLVerr: in std_LOGic;
Psel: out stD_logiC_VectOR(15 downto 0);
InterRUPt: in Std_lOGIc_veCTor(255 downto 0);
gp_oUT: out stD_LogiC_VectOR(31 downto 0);
Gp_in: in STD_logIC_veCTOr(31 downto 0);
Ext_WR: out sTD_logIC;
Ext_rD: out sTD_logIC;
eXT_addR: out std_LOGic_vECtor(31 downto 0);
exT_data: inout sTD_logIC_vecTOR(31 downto 0);
Ext_WAIt: in stD_logiC;
fiNIShed: out sTD_logIC;
faiLED: out Std_LOGIc);
end Bfm_aPB;

architecture BFMA1I10i of bFM_apb is

signal BFMA1llOLL: STd_loGIC;

signal BFMA1ilOLL: STd_loGIC;

signal BFMA1oiolL: sTD_logiC;

signal BFMA1LIoll: Std_LOGIc_vECTor(31 downto 0);

signal BFMA1iIOLl: sTD_logiC_vectOR(2 downto 0);

signal BFMA1O0oll: stD_Logic;

signal BFMA1L0oll: STd_loGIC_veCTOr(3 downto 0);

signal BFMA1I0olL: STD_logIC_veCTOr(2 downto 0);

signal BFMA1o1OLl: Std_lOGIc_vECTor(1 downto 0);

signal BFMA1l1OLl: STD_logIC;

signal BFMA1i1OLL: Std_lOGIc_vECTor(31 downto 0);

signal BFMA1OOlll: Std_LOGic_vECTor(31 downto 0);

signal BFMA1LOlll: stD_Logic;

signal BFMA1iOLLl: std_LOgic;

signal BFMA1OLLll: STD_logIC;

signal BFMA1LLlll: std_LOgic;

signal BFMA1iLLLl: std_LOgic_VEctoR(15 downto 0);

signal BFMA1OO1ol: STd_loGIC := '0';

signal insTR_in: sTD_logIC_vecTOR(31 downto 0) := ( others => '0');

signal CON_addR: Std_lOGIc_vECTor(15 downto 0) := ( others => '0');

signal coN_data: STd_loGIC_veCTOr(31 downto 0) := ( others => 'Z');

signal BFMA1IlilL: Std_lOGIc;

begin
BFMA1ililL <= '1';
BFMA1lo1OL: bFM_main
generic map (opmoDE => 0,
cON_spuLSE => 0,
VEctfiLE => VECtfiLE,
maX_instRUCtioNS => Max_INStrucTIOns,
max_STAck => max_Stack,
max_MEmteST => MAX_memTESt,
DEbuglEVEl => DEBugleVEL,
ArgvaLUE0 => ArgvaLUE0,
ArgvaLUE1 => aRGValue1,
ARGvaluE2 => arGVAlue2,
argVALue3 => ArgvaLUE3,
ARGvalUE4 => ARgvalUE4,
aRGValue5 => ArgvALUE5,
ARGvaluE6 => aRGValuE6,
aRGVAlue7 => arGVAlue7,
ArgvaLUE8 => aRGValue8,
aRGValue9 => ARGvaluE9,
argvALUe10 => aRGValue10,
argVALue11 => ARgvalUE11,
argVALue12 => ARGvalUE12,
ARGvaluE13 => ArgvALUe13,
aRGValue14 => arGVAlue14,
ArgvALUe15 => ArgvaLUE15,
aRGValue16 => aRGValuE16,
ArgvaLUE17 => aRGValue17,
arGVAlue18 => argvALUe18,
ArgvaLUE19 => arGVALue19,
ArgvaLUE20 => ArgvaLUE20,
ARGvaluE21 => ArgvaLUE21,
ARGvaluE22 => ArgvaLUE22,
ARGvaluE23 => ArgvaLUE23,
ARGvalUE24 => arGVAlue24,
argVALue25 => ARGvaluE25,
ARGvalUE26 => argVALue26,
argvALUe27 => argVALue27,
ArgvaLUE28 => argVALue28,
ARgvalUE29 => aRGValue29,
aRGValue30 => argvALUe30,
ArgvaLUE31 => ARgvalUE31,
aRGValue32 => argVALue32,
ArgvaLUE33 => aRGValue33,
aRGValue34 => argvALUe34,
ARGvaluE35 => ARGvaluE35,
ArgvALUE36 => ARGvaluE36,
ArgvaLUE37 => ArgvALUe37,
ArgvALUe38 => ARGvalUE38,
ARgvalUE39 => aRGVAlue39,
ARGvaluE40 => ARgvaLUE40,
argvALUe41 => aRGValue41,
ARgvalUE42 => ARgvalUE42,
arGVAlue43 => aRGValue43,
argVALue44 => aRGValue44,
ARgvalUE45 => ARgvalUE45,
aRGValue46 => ARGValuE46,
ARGvaluE47 => ARGvaluE47,
ARGValuE48 => ARgvaLUE48,
ArgvaLUE49 => ARgvalUE49,
ArgvaLUE50 => ARgvaLUE50,
ArgvaLUE51 => argVALue51,
ArgvaLUE52 => ArgvALUE52,
ARGvaluE53 => ArgvALUe53,
ARGvaluE54 => argvALUe54,
argVALue55 => argvALUe55,
ArgvaLUE56 => arGVAlue56,
ArgvaLUE57 => ArgvaLUE57,
ArgvALUE58 => aRGValue58,
aRGValuE59 => arGVAlue59,
argvALUe60 => ARGvalUE60,
ARGvalUE61 => arGVAlue61,
aRGValuE62 => argvALUe62,
arGVALue63 => ARGvaluE63,
arGVAlue64 => arGVAlue64,
ArgvALUe65 => ArgvALUE65,
ArgvaLUE66 => ArgvaLUE66,
ArgvaLUE67 => aRGVAlue67,
arGVAlue68 => aRGVAlue68,
argVALue69 => ArgvaLUE69,
argvALUe70 => ARGvaluE70,
argVALue71 => ARgvaLUE71,
arGVAlue72 => ARgvaLUE72,
arGVAlue73 => aRGValue73,
aRGVAlue74 => arGVAlue74,
arGVAlue75 => arGVAlue75,
ArgvaLUE76 => argVALue76,
ARGvaluE77 => ARgvalUE77,
argVALue78 => arGVAlue78,
arGVAlue79 => argvALUe79,
argvALUe80 => arGVAlue80,
argvALUe81 => argVALue81,
ArgvALUe82 => argvALUe82,
argVALue83 => ArgvaLUE83,
ARgvalUE84 => ARGvaluE84,
arGVAlue85 => argVALue85,
ArgvaLUE86 => argVALue86,
ARGvaluE87 => argvALUe87,
ArgvALUe88 => ArgvaLUE88,
ArgvALUe89 => aRGValue89,
aRGValue90 => arGVAlue90,
aRGValue91 => aRGValue91,
ARGvaluE92 => arGVAlue92,
ARGvaluE93 => ARGValuE93,
ARgvaLUE94 => aRGValue94,
ArgvALUe95 => argVALue95,
ARGvaluE96 => ARGvaluE96,
ArgvaLUE97 => arGVAlue97,
ArgvALUe98 => aRGValue98,
ARGvaluE99 => ArgvALUE99)
port map (SysclK => SysclK,
sysrSTN => sysRSTn,
HAddr => BFMA1LIoll,
hclk => BFMA1ilOLL,
PClk => BFMA1lLOLl,
HResetN => BFMA1oIOLl,
HBUrst => BFMA1iiolL,
hmasTLOck => BFMA1O0oll,
hprOT => BFMA1L0Oll,
HsizE => BFMA1i0OLL,
htRANs => BFMA1o1OLl,
HWRite => BFMA1L1oll,
HWdata => BFMA1OOLll,
hrDATa => BFMA1i1OLL,
HREady => BFMA1LOlll,
HResp => BFMA1LLLLl,
HSEl => BFMA1ILLll,
iNTErruPT => InteRRUPt,
GP_out => GP_out,
gp_In => GP_in,
ext_WR => ext_WR,
Ext_RD => EXT_rd,
ext_ADDr => ext_Addr,
exT_data => EXT_datA,
EXT_waIT => EXt_waIT,
con_ADDr => con_ADDr,
CON_datA => Con_dATA,
CON_rd => BFMA1OO1ol,
cON_wr => BFMA1oO1Ol,
COn_buSY => open ,
INstr_OUt => open ,
Instr_IN => Instr_IN,
fINIshed => finiSHEd,
FAiled => FaileD);
pCLK <= BFMA1LLOLl;
preSETn <= BFMA1Oioll;
BFMA1l0LLL: BFMA1i1lI
generic map (Tpd => TPD)
port map (Hclk => BFMA1ILOll,
HReseTN => BFMA1OIoll,
hsEL => BFMA1ILill,
HWrite => BFMA1l1oLL,
haDDR => BFMA1liOLL,
HwdaTA => BFMA1oOLLl,
hRDAta => BFMA1i1oLL,
HreadYIN => BFMA1loLLL,
HReadyOUT => BFMA1LOlll,
HTRans => BFMA1o1oLL,
HSIze => BFMA1i0OLl,
HBUrst => BFMA1iIOLl,
HMAstloCK => BFMA1o0OLL,
hPROt => BFMA1l0olL,
hRESp => BFMA1LLlll,
pseL => pSEL,
paddR => padDR,
PWrite => pwriTE,
PEnabLE => penABLe,
PwdatA => PwdatA,
PRdata => PRData,
PREady => preaDY,
PSLverr => PSLverR);
end BFMA1I10i;
