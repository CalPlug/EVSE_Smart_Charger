-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 6419 $
-- SVN $Date: 2009-02-04 04:34:22 -0800 (Wed, 04 Feb 2009) $
use std.TEXtio.all;
library IEEe;
use iEEE.std_logiC_1164.all;
use ieeE.nUMEric_STd.all;
use wORK.bFM_pacKAGe.all;
entity BFM_ahBLApb is
generic (veCTFile: StrinG := "test.vec";
MAX_inSTRuctiONs: INTeger := 16384;
MAx_stACK: IntegER := 1024;
mAX_memTESt: intEGEr := 65536;
tPD: inTEGer range 0 to 1000 := 1;
deBUGleveL: IntegER range -1 to 5 := -1;
ARgvalUE0: intEGEr := 0;
argvALUe1: inteGER := 0;
ARgvalUE2: intEGEr := 0;
arGVALue3: INTeger := 0;
ARgvalUE4: INtegeR := 0;
argvALUe5: intEGEr := 0;
ArgvaLUE6: IntegER := 0;
arGVAlue7: iNTEger := 0;
argVALue8: integER := 0;
ArgvaLUE9: INtegeR := 0;
arGVAlue10: inteGER := 0;
ArgvaLUE11: inteGER := 0;
aRGValue12: INtegeR := 0;
aRGValue13: intEGEr := 0;
ARGvaluE14: inTEGEr := 0;
aRGValue15: iNTEger := 0;
argVALue16: IntegER := 0;
argvALUe17: IntegER := 0;
ARGvaluE18: iNTEger := 0;
ArgvaLUE19: intEGEr := 0;
ARgvalUE20: inTEGer := 0;
arGVAlue21: INtegeR := 0;
ArgvaLUE22: INtegeR := 0;
arGVAlue23: INtegeR := 0;
arGVAlue24: IntegER := 0;
ArgvaLUE25: inteGER := 0;
ArgvaLUE26: INtegeR := 0;
argVALue27: inTEGer := 0;
ARgvaLUE28: inteGER := 0;
ArgvALUe29: InteGER := 0;
ArgvaLUE30: INTeger := 0;
ArgvALUe31: INTegeR := 0;
argvALUe32: INTegeR := 0;
ArgvaLUE33: iNTEger := 0;
ArgvaLUE34: inteGER := 0;
aRGValue35: inteGER := 0;
argVALue36: iNTEger := 0;
ARGvaluE37: IntegER := 0;
arGVALue38: inTEGer := 0;
ARgvalUE39: intEGEr := 0;
ArgvALUe40: INTeger := 0;
ArgvALUe41: inTEGer := 0;
arGVAlue42: IntegER := 0;
ARGvaluE43: inTEGer := 0;
aRGValue44: inteGER := 0;
ARGvaluE45: INtegeR := 0;
ARgvalUE46: INtegeR := 0;
argVALue47: intEGEr := 0;
ArgvALUE48: INTEger := 0;
ARgvalUE49: INtegeR := 0;
aRGValuE50: INtegeR := 0;
ArgvALUe51: inteGER := 0;
ArgvALUE52: InteGER := 0;
argVALue53: inteGER := 0;
aRGValue54: INtegeR := 0;
ArgvaLUE55: INTeger := 0;
aRGValue56: intEGEr := 0;
arGVAlue57: intEGEr := 0;
aRGValue58: INTeger := 0;
ArgvaLUE59: inTEGEr := 0;
arGVAlue60: intEGEr := 0;
argvALUe61: INtegeR := 0;
aRGValue62: iNTEger := 0;
argvALUe63: iNTEger := 0;
aRGValue64: inTEGEr := 0;
aRGValue65: inteGER := 0;
ARGvaluE66: inteGER := 0;
ArgvALUe67: inteGER := 0;
argvALUe68: IntegER := 0;
argVALue69: INtegER := 0;
arGVAlue70: INTeger := 0;
ARGvaluE71: inTEGer := 0;
ARgvaLUE72: iNTEger := 0;
ARgvalUE73: inTEGer := 0;
aRGValue74: INtegeR := 0;
ArgvALUe75: inteGER := 0;
argVALue76: inteGER := 0;
argVALue77: INtegER := 0;
argVALue78: inteGER := 0;
ARgvalUE79: INtegER := 0;
ARGvaluE80: inTEGer := 0;
ARgvalUE81: iNTEger := 0;
aRGVAlue82: intEGEr := 0;
argvALUe83: inTEGer := 0;
arGVAlue84: INtegeR := 0;
ARGvaluE85: INtegER := 0;
arGVAlue86: IntegER := 0;
ArgvaLUE87: INtegeR := 0;
aRGValue88: INTeger := 0;
ARgvalUE89: iNTEger := 0;
argVALue90: INTeger := 0;
arGVAlue91: iNTEger := 0;
arGVAlue92: INTEger := 0;
argvALUe93: INtegeR := 0;
argvALUe94: inTEGer := 0;
ARGvaluE95: inTEGer := 0;
argvALUe96: INtegeR := 0;
ArgvaLUE97: iNTEger := 0;
ArgvaLUE98: inteGER := 0;
ARgvalUE99: inTEGer := 0); port (SYSclk: in std_LOGic;
sYSRStn: in std_LOgic;
hclk: out std_LOGic;
HREsetn: out std_LOGic;
HAddr: out std_LOGic_VECtor(31 downto 0);
hBURst: out sTD_logIC_veCTOr(2 downto 0);
hmASTlocK: out STd_loGIC;
hproT: out Std_lOGIC_veCTor(3 downto 0);
HSIze: out sTD_logIC_vecTOR(2 downto 0);
htraNS: out Std_lOGIc_vECTor(1 downto 0);
hwRITE: out STd_lOGIc;
HWdata: out STd_lOGIc_veCTOr(31 downto 0);
hrdaTA: in std_LOGic_VECtor(31 downto 0);
hreADYin: in STd_loGIC;
HREadyoUT: out STD_loGIC;
HRESp: in std_LOgic;
hsel: out std_LOGic_VECtor(15 downto 0);
pCLK: out std_LOGic;
PresETN: out sTD_logIC;
Paddr: out std_Logic_VEctoR(31 downto 0);
PEnablE: out Std_lOGIc;
pWRIte: out STD_logIC;
pwdaTA: out STd_loGIC_vecTOr(31 downto 0);
pRDATa: in std_LOGic_VECtor(31 downto 0);
preADY: in sTD_logiC;
PSlverR: in STD_logIC;
Psel: out stD_logiC_VectOR(15 downto 0);
intERRupt: in stD_logiC_VectOR(255 downto 0);
gp_Out: out STD_logIC_veCTOr(31 downto 0);
gp_IN: in sTD_logIC_vecTOR(31 downto 0);
ext_WR: out stD_logiC;
Ext_rD: out stD_logiC;
eXT_addR: out STd_loGIC_veCTOr(31 downto 0);
EXT_datA: inout STD_loGIC_veCTOr(31 downto 0);
EXt_waIT: in Std_LOGic;
FinisHED: out std_LOgic;
FAileD: out STd_loGIC);
end bfm_AhblaPB;

architecture BFMA1I10i of bFM_ahbLAPb is

signal BFMA1lLOLl: stD_LogiC;

signal BFMA1ILOll: sTD_logiC;

signal BFMA1OIoll: STD_logIC;

signal BFMA1lIOLl: STD_logIC_vecTOR(31 downto 0);

signal BFMA1Iioll: Std_lOGIc_veCTor(2 downto 0);

signal BFMA1o0olL: STD_logIC;

signal BFMA1L0olL: std_LOgic_VEctor(3 downto 0);

signal BFMA1I0olL: STD_loGIC_veCTOr(2 downto 0);

signal BFMA1O1Oll: stD_LogiC_VectOR(1 downto 0);

signal BFMA1l1OLL: STD_logIC;

signal BFMA1I1olL: std_LOGic_VECtor(31 downto 0);

signal BFMA1OOlll: STd_loGIC_veCTOr(31 downto 0);

signal BFMA1LOlll: STd_loGIC;

signal BFMA1IOLll: sTD_logIC;

signal BFMA1olLLL: stD_logiC;

signal BFMA1LLLLl: stD_LogiC;

signal BFMA1iLLLl: STd_loGIC_veCTOr(15 downto 0);

signal BFMA1oilLL: std_LOGic_VECtor(31 downto 0);

signal BFMA1liLLL: std_LOGic;

signal BFMA1iilLL: STd_loGIC;

signal BFMA1o0lLL: stD_logiC;

signal BFMA1oo1OL: Std_lOGIc := '0';

signal InstR_In: std_Logic_VEctoR(31 downto 0) := ( others => '0');

signal CON_adDR: std_LOGic_VECtor(15 downto 0) := ( others => '0');

signal CON_daTA: stD_logiC_VectOR(31 downto 0) := ( others => 'Z');

begin
BFMA1Lo1ol: Bfm_mAIN
generic map (opMODe => 0,
Con_sPULse => 0,
veCTFile => VEctfiLE,
MAx_iNSTRuctIONs => max_INStruCTIons,
TPD => tpD,
maX_StacK => MAx_stACK,
MAx_meMTEst => maX_memtEST,
DEbuglEVEl => DEbugLEVEl,
aRGValue0 => ArgvaLUE0,
argVALue1 => ARgvalUE1,
ArgvALUe2 => ARgvalUE2,
ARgvalUE3 => ArgvaLUE3,
ArgvALUe4 => argvALUe4,
argVALue5 => ARgvalUE5,
argvALUe6 => argvALUe6,
ArgvALUE7 => ARGvaluE7,
arGVAlue8 => ARgvalUE8,
ARgvalUE9 => ARgvalUE9,
aRGValue10 => argvALUe10,
argvALUe11 => arGVAlue11,
argVALue12 => argVALue12,
ArgvaLUE13 => ArgvALUe13,
ARgvalUE14 => aRGValue14,
argvALUe15 => aRGValuE15,
ARgvalUE16 => aRGValuE16,
ArgvALUe17 => arGVAlue17,
aRGValue18 => aRGValue18,
aRGValuE19 => arGVAlue19,
aRGVAlue20 => ARGvaluE20,
ARGvaluE21 => ArgvALUE21,
argVALue22 => argVALue22,
argvALUe23 => argvALUe23,
argvALUe24 => aRGValue24,
argVALue25 => arGVAlue25,
argvALUe26 => ARGvalUE26,
ArgvaLUE27 => arGVAlue27,
argvALUe28 => ARGvaluE28,
ARGvalUE29 => aRGValuE29,
argVALue30 => ArgvALUe30,
ARGvaluE31 => argVALue31,
arGVAlue32 => arGVAlue32,
argVALue33 => argVALue33,
ARgvalUE34 => arGVAlue34,
ARgvalUE35 => arGVAlue35,
arGVAlue36 => argvALUe36,
ArgvaLUE37 => argVALue37,
ARGvaluE38 => ARGValuE38,
ArgvaLUE39 => aRGValue39,
argVALue40 => argVALue40,
argvALUe41 => argvALUe41,
ArgvALUE42 => ArgvaLUE42,
aRGValue43 => ARgvalUE43,
ARGvaluE44 => argvALUe44,
ArgvaLUE45 => ArgvaLUE45,
ARGvalUE46 => argVALue46,
aRGValuE47 => arGVAlue47,
ARGvaluE48 => arGVAlue48,
ArgvaLUE49 => ArgvaLUE49,
ARgvalUE50 => arGVAlue50,
ARGvaluE51 => ARGvaluE51,
ArgvaLUE52 => arGVAlue52,
aRGValue53 => aRGValue53,
argvALUe54 => argvALUe54,
arGVAlue55 => aRGValue55,
arGVAlue56 => ARGvalUE56,
argvALUe57 => argVALue57,
argvALUe58 => ArgvALUe58,
ArgvaLUE59 => ArgvALUe59,
ARgvaLUE60 => ARGvaluE60,
argvALUe61 => ARGvalUE61,
ArgvaLUE62 => argvALUe62,
argvALUe63 => argvALUe63,
ARGvaluE64 => arGVAlue64,
argVALue65 => ARGValuE65,
argVALue66 => argVALue66,
ARgvalUE67 => aRGValue67,
ARGvaluE68 => ArgvaLUE68,
ARgvalUE69 => ARgvalUE69,
aRGVAlue70 => ARGvaluE70,
aRGValue71 => ARGvaluE71,
ArgvaLUE72 => ARgvalUE72,
ARGvalUE73 => aRGValue73,
aRGValue74 => ARgvalUE74,
argVALue75 => aRGValue75,
ARgvalUE76 => argVALue76,
arGVAlue77 => ArgvALUe77,
arGVALue78 => ARGvalUE78,
aRGVAlue79 => ARGvalUE79,
argVALue80 => argVALue80,
ArgvaLUE81 => ARgvaLUE81,
ARGvalUE82 => ARGvaluE82,
ArgvaLUE83 => aRGValue83,
ARgvalUE84 => arGVAlue84,
ArgvALUe85 => ARgvalUE85,
ARgvalUE86 => ARgvaLUE86,
argvALUe87 => ARGvalUE87,
aRGValue88 => ARgvalUE88,
ArgvaLUE89 => argVALue89,
ARgvalUE90 => ARgvalUE90,
ARGvaluE91 => argVALue91,
aRGValue92 => ARgvalUE92,
ARGvaluE93 => ArgvaLUE93,
arGVAlue94 => aRGValuE94,
arGVAlue95 => arGVAlue95,
aRGValue96 => ARGvaluE96,
ArgvALUE97 => ARGvalUE97,
ARGvaluE98 => argVALue98,
aRGValue99 => argvALUe99)
port map (sysCLK => SYSclk,
sysRSTn => SYsrstN,
HADdr => BFMA1lioLL,
hcLK => BFMA1IlolL,
PClk => BFMA1LLoll,
hresETN => BFMA1OIOll,
HbursT => BFMA1iiOLL,
hmasTLOck => BFMA1O0Oll,
hPROt => BFMA1L0olL,
hsizE => BFMA1i0oLL,
htRANs => BFMA1O1oll,
HWrite => BFMA1l1oLL,
hwdATA => BFMA1OOLLl,
hrDATa => BFMA1i1OLL,
hREAdy => BFMA1LOLll,
hRESp => BFMA1llLLL,
Hsel => BFMA1ilLLL,
InteRRUPt => INTerrUPT,
GP_out => gp_OUt,
GP_in => gp_IN,
eXT_wr => EXt_wr,
ext_RD => exT_Rd,
eXT_addR => ext_ADdr,
exT_data => EXt_daTA,
ext_WAit => ext_WAit,
cON_addR => con_ADDr,
Con_DATa => COn_daTA,
con_RD => BFMA1OO1ol,
con_WR => BFMA1Oo1ol,
Con_bUSY => open ,
INstr_OUt => open ,
inSTR_in => iNSTr_in,
fINIshed => FInishED,
FAiled => FailED);
hclk <= BFMA1ILOll;
Pclk <= BFMA1LLOll;
PreseTN <= BFMA1oioLL;
BFMA1L0lll: BFMA1I1li
generic map (Tpd => Tpd)
port map (HCLk => BFMA1ILOll,
hreSETn => BFMA1OIOll,
hSEL => BFMA1ILlll(1),
hwriTE => BFMA1l1OLL,
HaddR => BFMA1lIOLl,
HWData => BFMA1OOLll,
hrdaTA => BFMA1oillL,
hreaDYIn => HReadyIN,
hrEADYout => BFMA1IILll,
htRANs => BFMA1o1OLL,
hsizE => BFMA1i0OLL,
hbURSt => BFMA1Iioll,
HMastlOCK => BFMA1o0oLL,
HProt => BFMA1l0OLl,
hreSP => BFMA1LIlll,
PSel => PSel,
Paddr => Paddr,
pWRIte => pwRITe,
penABLe => PEnablE,
PWdata => PWData,
PrdatA => prdATA,
PREady => PREAdy,
pSLVerr => pSLVErr);
process (BFMA1iLOLl,BFMA1OIOLl)
begin
if BFMA1oIOLl = '0' then
BFMA1O0Lll <= '0';
elsif BFMA1iloLL = '1' and BFMA1ILoll'EVEnt then
if BFMA1lolLL = '1' then
BFMA1o0lLL <= '0';
if BFMA1ilLLL(1) = '1' then
BFMA1o0LLL <= '1';
end if;
end if;
end if;
end process;
process (BFMA1o0llL,BFMA1LILll,BFMA1iILLl,BFMA1OILll,hRESp,HReadyIN,HRData)
begin
if BFMA1O0lll = '1' then
BFMA1LLlll <= BFMA1liLLL;
BFMA1lollL <= BFMA1IILLl;
BFMA1i1OLl <= BFMA1oilLL;
else
BFMA1llLLL <= hreSP;
BFMA1lOLLl <= hreaDYIn;
BFMA1i1oLL <= HRData;
end if;
end process;
HREadyoUT <= BFMA1lollL;
hresETN <= BFMA1OIoll;
hadDR <= BFMA1LIOll;
HbursT <= BFMA1Iioll;
HmastLOCk <= BFMA1O0Oll;
Hprot <= BFMA1l0olL;
hsizE <= BFMA1i0OLl;
htrANS <= BFMA1o1olL;
hwriTE <= BFMA1L1Oll;
HWdata <= BFMA1OOLll;
HSel <= BFMA1iLLLl;
end BFMA1i10i;
