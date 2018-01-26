-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 11878 $
-- SVN $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $
use sTD.TEXtio.all;
library ieee;
use IEee.Std_lOGIc_1164.all;
use IEee.NUMeric_Std.all;
use WORk.BFM_teXTIo.all;
use worK.BFm_mISC.all;
use work.bfm_PACkage.all;
use Std.TExtio.all;
entity bFM_maiN is
generic (OPMode: INTeger range 0 to 2 := 0;
VECtfilE: sTRIng := "test.vec";
maX_InstRUCtioNS: INtegER := 16384;
max_Stack: InteGER := 1024;
max_MEMtesT: INtegeR := 65536;
Tpd: INTeger range 0 to 1000 := 1;
dEBUglevEL: InteGER range -1 to 5 := -1;
con_SPulsE: iNTEger range 0 to 1 := 0;
ArgvALUE0: inTEGer := 0;
argVALUE1: INTeger := 0;
ArgvALUe2: iNTEGer := 0;
ArgvaLUE3: inteGER := 0;
argvALUe4: inTEGEr := 0;
ARGvaluE5: INtegeR := 0;
ARGvaluE6: INTeger := 0;
argVALue7: intEGEr := 0;
ARGvalUE8: InteGER := 0;
ARGvaluE9: intEGEr := 0;
arGVAlue10: IntegER := 0;
arGVAlue11: inteGER := 0;
arGVAlue12: INtegeR := 0;
ARgvalUE13: intEGEr := 0;
ArgvALUE14: inteGER := 0;
aRGValue15: INtegeR := 0;
ARgvalUE16: INTeger := 0;
arGVAlue17: inTEGer := 0;
ArgvaLUE18: iNTEger := 0;
argVALue19: iNTEger := 0;
ArgvaLUE20: IntegER := 0;
argVALue21: INTEger := 0;
ARGvaluE22: INTeger := 0;
arGVAlue23: inTEGer := 0;
arGVALue24: inTEGer := 0;
argVALue25: inteGER := 0;
ArgvaLUE26: inTEGer := 0;
ArgvALUe27: iNTEger := 0;
argvALUe28: inTEGer := 0;
argVALue29: intEGEr := 0;
arGVAlue30: inTEGer := 0;
ArgvaLUE31: INTeger := 0;
ArgvALUe32: INTegeR := 0;
ARgvalUE33: INTeger := 0;
aRGValuE34: inteGER := 0;
ARGvalUE35: inteGER := 0;
ARgvalUE36: INtegER := 0;
ARGValuE37: IntegER := 0;
ArgvALUe38: IntegeR := 0;
arGVAlue39: intEGEr := 0;
ArgvALUE40: IntegER := 0;
aRGValuE41: iNTEger := 0;
ARGvaluE42: inTEGEr := 0;
ARGvaluE43: inteGER := 0;
arGVAlue44: inTEGer := 0;
argvALUe45: inteGER := 0;
arGVAlue46: INTEger := 0;
ArgvALUe47: inteGER := 0;
ARgvalUE48: INTEger := 0;
ARgvalUE49: INTegeR := 0;
aRGValuE50: inTEGer := 0;
ARgvalUE51: inteGER := 0;
ArgvaLUE52: IntegER := 0;
ARGvaluE53: INtegER := 0;
ArgvALUE54: INtegeR := 0;
aRGValuE55: INTeger := 0;
aRGVAlue56: inTEGEr := 0;
arGVAlue57: INtegeR := 0;
ARGvaluE58: intEGEr := 0;
aRGValuE59: IntegER := 0;
aRGValue60: INTeger := 0;
ArgvALUe61: inTEGer := 0;
argvALUe62: INtegER := 0;
aRGValue63: iNTEger := 0;
ArgvALUE64: INTeger := 0;
ARgvaLUE65: IntegER := 0;
ArgvaLUE66: intEGEr := 0;
aRGValue67: INtegeR := 0;
arGVAlue68: inTEGer := 0;
ARGValuE69: inteGER := 0;
ARgvalUE70: InteGER := 0;
argVALue71: INtegER := 0;
argVALue72: IntegER := 0;
ARGvalUE73: INTeger := 0;
argvALUe74: intEGEr := 0;
ArgvaLUE75: inteGER := 0;
ARgvalUE76: IntegER := 0;
ARgvalUE77: InteGER := 0;
arGVAlue78: intEGEr := 0;
ARgvalUE79: INtegeR := 0;
arGVAlue80: InteGER := 0;
arGVAlue81: IntegER := 0;
ARGvalUE82: iNTEger := 0;
ARgvalUE83: iNTEger := 0;
arGVAlue84: iNTEger := 0;
arGVAlue85: iNTEger := 0;
ArgvALUE86: intEGEr := 0;
ArgvaLUE87: intEGEr := 0;
ARGvaluE88: inTEGEr := 0;
ArgvaLUE89: INtegeR := 0;
argVALue90: iNTEger := 0;
argvALUe91: intEGEr := 0;
aRGVAlue92: INTeger := 0;
argvALUe93: iNTEger := 0;
argvALUe94: InteGER := 0;
aRGValue95: IntegER := 0;
aRGValue96: intEGEr := 0;
argvALUe97: INtegeR := 0;
ARgvalUE98: iNTEger := 0;
ARgvalUE99: inTEGer := 0); port (syscLK: in sTD_logIC;
sysRSTn: in Std_lOGIc;
pclk: out STD_logIC;
hclK: out stD_LogiC;
HResetN: out STd_lOGIC;
hADDR: out sTD_logIC_vecTOR(31 downto 0);
HBUrst: out stD_logiC_VectOR(2 downto 0);
HMastlOCK: out std_LOGic;
hproT: out Std_lOGIc_vECTor(3 downto 0);
HSIze: out stD_logiC_VectOR(2 downto 0);
hTRANs: out std_LOGic_vECTor(1 downto 0);
hWRIte: out stD_LogiC;
hwdATA: out std_LOGic_VECtor(31 downto 0);
hrDATa: in stD_logiC_VectOR(31 downto 0);
hreADY: in STd_loGIC;
hrESP: in std_LOGic;
hSEL: out std_Logic_VEctoR(15 downto 0);
InterRUPt: in STD_logIC_veCTOr(255 downto 0);
gP_Out: out std_LOGIc_vECTor(31 downto 0);
GP_in: in stD_logiC_VectOR(31 downto 0);
ext_WR: out Std_lOGIc;
exT_Rd: out std_LOGic;
ext_ADdr: out STd_loGIC_vecTOr(31 downto 0);
EXt_daTA: inout Std_lOGIc_veCTor(31 downto 0);
exT_wait: in Std_lOGIc;
cON_addr: in std_LOGic_VECtor(15 downto 0);
CON_daTA: inout sTD_logIC_vecTOR(31 downto 0);
coN_Rd: in std_LOgic;
CON_wr: in std_LOGic;
coN_Busy: out sTD_logIC;
INstr_OUT: out std_LOGic_VECtor(31 downto 0);
insTR_in: in stD_logiC_VectOR(31 downto 0);
finISHed: out sTD_logIC;
failED: out sTD_logIC);
end bfm_MAin;

architecture BFMA1i10I of bfM_Main is

constant BFMA1oo1i: strING(1 to 3) := "2.1";

constant BFMA1lo1I: stRING(1 to 7) := "22Dec08";

signal BFMA1io1i: STd_loGIC;

signal BFMA1ol1I: STD_logIC;

signal BFMA1LL1i: STd_loGIC_veCTOr(2 downto 0);

signal BFMA1il1I: STD_logIC;

signal BFMA1OI1i: stD_logiC_VectOR(3 downto 0);

signal BFMA1Li1i: std_LOGic_VECtor(1 downto 0);

signal BFMA1iI1I: std_Logic;

signal BFMA1o01I: STD_logIC_vecTOr(31 downto 0);

signal BFMA1l01I: Std_lOGIc_veCTor(31 downto 0) := ( others => '0');

signal BFMA1I01i: std_LOGic_vECTor(31 downto 0) := ( others => '0');

signal BFMA1o11I: Std_lOGIc_vECTor(2 downto 0);

signal BFMA1l11I: STd_loGIC_veCTOr(2 downto 0);

signal BFMA1i11I: STD_loGIC_vecTOr(15 downto 0);

signal BFMA1OOO0: stD_LogiC;

signal BFMA1lOO0: Std_LOGic;

signal BFMA1iOO0: stD_LogiC;

signal BFMA1olo0: STD_logIC;

signal BFMA1LLO0: STd_loGIC;

signal BFMA1ILo0: STD_loGIC;

signal BFMA1oio0: std_LOgic;

signal BFMA1lIO0: std_Logic;

signal BFMA1iiO0: std_LOgic_VEctoR(31 downto 0);

signal BFMA1o0O0: STD_logIC_vecTOR(31 downto 0);

signal BFMA1l0o0: STD_loGIC_veCTOr(31 downto 0);

signal BFMA1I0O0: sTD_logIC_vecTOR(31 downto 0);

signal BFMA1O1o0: Std_loGIC_veCTOr(31 downto 0);

signal BFMA1L1o0: std_LOgic_VEctoR(31 downto 0);

signal BFMA1I1o0: sTD_logiC_vecTOR(31 downto 0);

signal BFMA1Ool0: stD_LogiC_VectOR(31 downto 0);

signal BFMA1lol0: INTeger;

signal BFMA1iOL0: std_LOGic;

signal BFMA1OLl0: stD_logiC;

signal BFMA1LLL0: STD_loGIC_vecTOr(31 downto 0);

signal BFMA1ILl0: stD_LogiC_VectOR(31 downto 0);

signal BFMA1oil0: INtegeR;

signal BFMA1lil0: Std_lOGIc;

signal BFMA1iIL0: std_LOGic;

signal BFMA1O0L0: std_LOGic;

signal BFMA1L0l0: std_LOgic;

signal BFMA1I0L0: std_Logic;

signal BFMA1O1L0: Std_LOGIc_vECTor(31 downto 0);

signal BFMA1L1l0: std_LOGic_vECtor(31 downto 0);

signal BFMA1I1l0: STD_logIC_vecTOR(31 downto 0);

signal BFMA1Ooi0: Std_lOGIc_veCTor(31 downto 0);

signal BFMA1LOi0: Std_lOGIc_vECTor(31 downto 0);

signal BFMA1IOI0: STD_logIC_vecTOr(31 downto 0);

signal BFMA1olI0: std_LOGic;

signal BFMA1Lli0: stD_logiC;

signal DebuG: INTeger;

signal BFMA1ili0: INTeger;

signal BFMA1oii0: INTeger;

signal BFMA1LII0: stD_logiC := '0';

signal BFMA1iiI0: std_Logic_VectoR(31 downto 0);

signal BFMA1o0I0: stRINg(1 to 80);

signal BFMA1l0i0: std_LOGic;

signal BFMA1i0i0: sTD_logIC;

signal BFMA1O1i0: BOoleaN;

signal BFMA1L1I0: BOOleaN;

signal BFMA1i1I0: bOOLean;

signal BFMA1oo00: bOOLean;

constant BFMA1Lo00: Std_LOGIc_vECTor(31 downto 0) := ( others => '0');

constant BFMA1iO00: STD_logIC_vecTOr(255 downto 0) := ( others => '0');

constant BFMA1ol00: tIME := tpd*1 Ns;

begin
BFMA1io1I <= SYsclk;
BFMA1i10I:
process (BFMA1iO1I,sySRSTn)
file BFMA1ll00: teXT;
file BFMA1IL00: texT;
subtype BFMA1oi00 is sTRIng(1 to 256);
type BFMA1LI00 is (BFMA1II00,BFMA1o000);
type BFMA1l000 is array (intEGEr range <> ) of BFMA1oi00;
variable L: liNE;
variable BFMA1i000: File_OPen_STAtus;
variable BFMA1O100: boolEAN;
variable BFMA1OLli: inteGER_arRAY(0 to mAX_instRUCtioNS-1);
variable BFMA1L100: BFMA1O11l(0 to max_INStruCTIons-1);
variable BFMA1ioLI: InteGER_arRAY(0 to Max_iNSTrucTIOns-1) := ( others => 0);
variable BFMA1I100: iNTEger_ARRay(0 to MAX_staCK-1);
variable BFMA1oo10: inteGER_arRAY(0 to 4);
variable BFMA1lO10: INtegeR;
variable BFMA1loLI: inTEGer;
variable BFMA1io10: IntegER;
variable BFMA1ol10: intEGEr;
variable BFMA1ll10: INtegeR;
variable BFMA1IL10: InteGER;
variable BFMA1Oi10: std_LOgic_VEctoR(31 downto 0);
variable BFMA1li10: inteGER range 0 to 3;
variable BFMA1II10: INtegeR;
variable BFMA1O010: InteGER;
variable BFMA1l010: INtegeR;
variable BFMA1i010: INtegeR;
variable BFMA1O110: inTEGer;
variable BFMA1l110: INtegER;
variable BFMA1i110: std_LOGic_VECtor(2 downto 0);
variable BFMA1OOO1: STD_logIC_veCTOr(31 downto 0);
variable BFMA1lOO1: STD_logIC_veCTOr(31 downto 0);
variable BFMA1ioo1: std_LOgic_VEctoR(31 downto 0);
variable BFMA1Olo1: booLEAn;
variable BFMA1llo1: bOOLean;
variable BFMA1ilO1: BOoleaN;
variable BFMA1oio1: bOOLean;
variable BFMA1lIO1: BOoleaN;
variable BFMA1IIo1: BOoleAN;
variable BFMA1o0O1: boOLEan;
variable BFMA1l0o1: BOoleAN;
variable BFMA1I0o1: booLEAn;
variable BFMA1o1o1: BoolEAN;
variable BFMA1l1o1: boolEAN;
variable BFMA1I1o1: inTEGEr;
variable BFMA1Ool1: inteGER;
variable BFMA1lOL1: inTEGer;
variable BFMA1oo0I: IntegER;
variable BFMA1I0ii: iNTEGer;
variable BFMA1lL0I: IntegER;
variable X: intEGEr;
variable Y: inTEGer;
variable V: inteGER;
variable BFMA1iO0I: STrinG(1 to 256);
variable BFMA1iol1: StrinG(1 to 256);
variable BFMA1olL1: STring(1 to 256);
variable BFMA1Lll1: inTEGer;
variable BFMA1ILl1: inTEGEr;
variable BFMA1oiL1: INtegeR;
variable BFMA1LIL1: intEGEr;
variable BFMA1IIL1: INtegER_arrAY(0 to 8191);
variable BFMA1o0l1: stRINg(1 to 8);
variable BFMA1L0l1: BOOlean;
variable BFMA1i0L1: boOLEan;
variable BFMA1o1L1: CharACTEr;
variable BFMA1L1L1: inTEGer;
variable BFMA1i1L1: IntegER;
variable BFMA1OOI1: inteGEr;
variable BFMA1lOI1: INtegeR;
variable BFMA1IOi1: intEGEr;
variable BFMA1oLI1: INtegeR;
variable BFMA1Lli1: INTegeR;
variable BFMA1l1II: inTEGer;
variable BFMA1ili1: INtegER;
variable BFMA1oii1: INTEger;
variable BFMA1liI1: INTeger;
variable BFMA1Iii1: IntegER;
variable BFMA1o0i1: intEGEr := 0;
variable BFMA1l0I1: INtegeR := 0;
variable BFMA1i0i1: INtegER;
variable BFMA1O1i1: IntegER;
variable exP: STD_loGIC_vecTOr(31 downto 0);
variable BFMA1L1I1: STd_loGIC_vecTOr(31 downto 0);
variable BFMA1i1I1: bOOLean;
variable BFMA1oo01: BOOlean;
variable BFMA1LO01: boolEAN;
variable BFMA1IO01: BOoleaN;
variable BFMA1ol01: BFMA1LI00;
variable BFMA1lL01: iNTEger := 0;
variable BFMA1iL01: sTRIng(1 to 10);
variable BFMA1OI01: std_LOgic;
variable BFMA1LI01: Std_lOGIc_vECTor(3 downto 0);
variable BFMA1iI01: STD_logIC_vecTOr(2 downto 0);
variable BFMA1o001: iNTEger;
variable BFMA1l001: BOOLean;
variable BFMA1i001: booLEAn;
variable BFMA1o101: BFMA1L000(0 to 100);
variable BFMA1L101: INtegeR := 0;
variable BFMA1i101: intEGEr := 65536;
variable BFMA1oO11: INTeger range 0 to 3;
variable BFMA1Lo11: intEGEr range 0 to 32;
variable BFMA1IO11: intEGEr range 0 to 65536;
variable BFMA1oL11: BOOlean;
variable BFMA1LL11: INTegeR;
variable BFMA1il11: InteGER;
variable BFMA1oi11: booLEAn;
variable BFMA1LI11: booleAN;
variable BFMA1II11: BOoleAN;
variable BFMA1o011: InteGER;
variable BFMA1l011: BOOlean;
variable BFMA1i011: BOoleaN;
variable BFMA1O111: boolEAN;
variable BFMA1L111: BOoleaN;
variable BFMA1i111: BooleAN;
variable BFMA1oOOOl: iNTEger;
variable BFMA1lOOOl: IntegER;
variable BFMA1Ioool: intEGEr;
variable BFMA1OLool: INTeger;
variable BFMA1LLool: INTEger;
variable BFMA1iloOL: inTEGer;
variable BFMA1OIool: INTegeR := 0;
variable BFMA1LIOol: std_LOGic;
variable BFMA1IIOol: Std_lOGIc_vECTor(1 downto 0);
variable BFMA1o0oOL: STD_logIC_vecTOR(2 downto 0);
variable BFMA1l0OOl: STD_loGIC;
variable BFMA1i0ooL: STD_logIC_veCTOr(3 downto 0);
variable BFMA1O1Ool: INTeger := 0;
variable BFMA1l1oOL: iNTEger := 0;
variable BFMA1i1oOL: inteGER_arrAY(0 to 15);
variable BFMA1oolOL: intEGEr;
variable BFMA1LOLol: intEGEr_arRAY(0 to 255);
variable BFMA1iOLOl: INTegeR range 0 to 256;
variable BFMA1olLOL: inteGER range 0 to 256;
variable BFMA1llLOL: bOOLean_ARRay(1 to 255);
variable BFMA1ilLOL: InteGER range 0 to 256;
variable BFMA1oilOL: inTEGer;
type BFMA1liLOL is (BFMA1iILOl,BFMA1O0lol,ActiVE,BFMA1l0LOl,BFMA1i0LOl,BFMA1O1Lol);
variable BFMA1l1loL: INTegeR;
variable BFMA1i1LOL: inteGER;
variable BFMA1ooiOL: inteGER;
variable BFMA1Loiol: INtegeR;
variable BFMA1ioioL: intEGEr;
variable BFMA1OLIol: BFMA1LIlol;
variable BFMA1llIOL: InteGER_arrAY(0 to Max_MEMTest-1);
variable BFMA1ilIOL: intEGEr;
variable BFMA1oIIOl: iNTEger;
variable BFMA1Liiol: inTEGer;
variable BFMA1iiIOL: inteGER;
variable BFMA1O0iol: boOLEan;
variable BFMA1l0iOL: intEGEr;
variable BFMA1i0iOL: inTEGer;
variable BFMA1O1Iol: IntegER;
variable BFMA1l1IOL: boOLEan;
variable BFMA1i1ioL: booLEAn;
variable BFMA1OO0ol: BOoleAN;
variable BFMA1LO0ol: BoolEAN;
variable BFMA1iO0Ol: BOoleaN;
variable BFMA1ol0oL: iNTEger;
variable BFMA1lL0Ol: INtegER;
impure function BFMA1iL0Ol(BFMA1oi0OL: BooleAN;
X: inTEGer)
return iNTEger is
variable Y: inteGER;
variable BFMA1li0oL: iNTEger;
variable BFMA1II0ol: iNTEGer;
variable BFMA1O00ol: intEGEr;
variable BFMA1L00ol: INtegeR;
variable BFMA1i00oL: INTegeR;
variable BFMA1lIOI: sTD_logiC_VectOR(31 downto 0);
variable BFMA1O10ol: inTEGer;
begin
if BFMA1oI0Ol then
BFMA1liOI := TO_slv32(X);
BFMA1LI0ol := to_iNT_unsIGned(BFMA1liOI(30 downto 16));
BFMA1ii0oL := to_INT_unsIGned(BFMA1LIoi(14 downto 13));
BFMA1o00ol := To_inT_UnsiGNEd(BFMA1lioi(12 downto 0));
BFMA1l00OL := to_iNT_unsIGNed(BFMA1LIoi(12 downto 8));
BFMA1I00ol := to_INT_unsIGned(BFMA1lioI(7 downto 0));
BFMA1O10oL := 0;
if BFMA1LIOi(15) = '1' then
BFMA1O10oL := BFMA1iL0Ol(trUE,
BFMA1li0oL);
end if;
case BFMA1ii0OL is
when 3 =>
case BFMA1l00OL is
when BFMA1OL0l =>
case BFMA1I00oL is
when BFMA1O00l =>
y := BFMA1OLI1;
when BFMA1L00l =>
y := (now/1 NS);
when BFMA1I00l =>
Y := DEBug;
when BFMA1O10l =>
Y := BFMA1o110;
when BFMA1L10l =>
y := BFMA1LL01;
when BFMA1I10l =>
Y := BFMA1oiLOL-1;
when BFMA1Oo1l =>
Y := BFMA1o1OOl;
when BFMA1LO1l =>
y := BFMA1L1Ool;
when others =>
assert FAlse report "Illegal Parameter P0" severity faiLURe;
end case;
when BFMA1LL0l =>
case BFMA1i00OL is
when 0 =>
Y := argVALue0;
when 1 =>
y := argVALue1;
when 2 =>
y := ArgvaLUE2;
when 3 =>
Y := aRGValuE3;
when 4 =>
y := argvALUe4;
when 5 =>
Y := arGVAlue5;
when 6 =>
y := arGVAlue6;
when 7 =>
Y := aRGValue7;
when 8 =>
Y := ArgvaLUE8;
when 9 =>
y := argvALUe9;
when 10 =>
Y := argvALUe10;
when 11 =>
Y := ARGValuE11;
when 12 =>
y := ARgvalUE12;
when 13 =>
y := ARgvalUE13;
when 14 =>
y := arGVAlue14;
when 15 =>
Y := argVALue15;
when 16 =>
Y := ARGvalUE16;
when 17 =>
Y := ARgvalUE17;
when 18 =>
y := ARGvalUE18;
when 19 =>
Y := ARgvalUE19;
when 20 =>
y := aRGValuE20;
when 21 =>
Y := argVALue21;
when 22 =>
y := argvALUe22;
when 23 =>
Y := aRGVAlue23;
when 24 =>
y := ArgvALUe24;
when 25 =>
Y := ArgvaLUE25;
when 26 =>
Y := ArgvaLUE26;
when 27 =>
Y := arGVAlue27;
when 28 =>
y := argVALue28;
when 29 =>
y := arGVAlue29;
when 30 =>
y := argvALUe30;
when 31 =>
Y := ArgvaLUE31;
when 32 =>
y := ARGvaluE32;
when 33 =>
Y := ArgvaLUE33;
when 34 =>
Y := arGVALue34;
when 35 =>
y := argVALue35;
when 36 =>
y := argVALue36;
when 37 =>
y := arGVAlue37;
when 38 =>
y := argVALue38;
when 39 =>
Y := argVALue39;
when 40 =>
y := ArgvALUe40;
when 41 =>
Y := argvALUe41;
when 42 =>
Y := argvALUe42;
when 43 =>
y := argvALUe43;
when 44 =>
y := aRGValue44;
when 45 =>
Y := ARGvaluE45;
when 46 =>
y := argvALUe46;
when 47 =>
y := argvaLUe47;
when 48 =>
Y := ARGvalUE48;
when 49 =>
Y := ARGvaluE49;
when 50 =>
y := argvALUe50;
when 51 =>
Y := ARGvaluE51;
when 52 =>
y := arGVAlue52;
when 53 =>
y := ArgvaLUE53;
when 54 =>
Y := ArgvALUE54;
when 55 =>
y := ArgvaLUE55;
when 56 =>
Y := ArgvALUE56;
when 57 =>
Y := ArgvaLUE57;
when 58 =>
Y := argVALue58;
when 59 =>
Y := arGVAlue59;
when 60 =>
y := argvALUe60;
when 61 =>
Y := aRGValue61;
when 62 =>
Y := arGVAlue62;
when 63 =>
y := ArgvaLUE63;
when 64 =>
Y := argVALue64;
when 65 =>
y := aRGValuE65;
when 66 =>
Y := ARGvalUE66;
when 67 =>
y := arGVAlue67;
when 68 =>
Y := aRGValue68;
when 69 =>
Y := ArgvALUe69;
when 70 =>
y := ARgvalUE70;
when 71 =>
Y := ArgvaLUE71;
when 72 =>
y := argVALue72;
when 73 =>
y := ArgvALUE73;
when 74 =>
Y := ArgvALUe74;
when 75 =>
y := ARGvaluE75;
when 76 =>
y := ARGvaluE76;
when 77 =>
Y := argVALUe77;
when 78 =>
y := argVALue78;
when 79 =>
y := ARGvalUE79;
when 80 =>
y := ARGvaluE80;
when 81 =>
Y := ARgvaLUE81;
when 82 =>
y := argvALUe82;
when 83 =>
Y := ArgvALUe83;
when 84 =>
y := aRGValue84;
when 85 =>
y := argVALue85;
when 86 =>
y := arGVALue86;
when 87 =>
Y := argvALUe87;
when 88 =>
Y := ArgvALUE88;
when 89 =>
Y := argvALUe89;
when 90 =>
Y := arGVAlue90;
when 91 =>
y := aRGValue91;
when 92 =>
y := arGVAlue92;
when 93 =>
Y := argVALue93;
when 94 =>
Y := ArgvalUE94;
when 95 =>
y := argVALue95;
when 96 =>
Y := arGVAlue96;
when 97 =>
Y := ArgvALUe97;
when 98 =>
Y := ARgvalUE98;
when 99 =>
y := argVALue99;
when others =>
assert FAlse report "Illegal Parameter P1" severity fAILure;
end case;
when BFMA1iL0L =>
BFMA1LLool := BFMA1O0Li(BFMA1llOOL);
Y := BFMA1l0li(BFMA1llOOL,
BFMA1i00oL);
when BFMA1oI0L =>
BFMA1ILool := BFMA1lloOL;
BFMA1llOOL := BFMA1O0Li(BFMA1LLOol);
y := BFMA1l0lI(BFMA1LLool,
BFMA1i00OL);
when BFMA1lI0L =>
BFMA1llooL := BFMA1ILool;
BFMA1llOOL := BFMA1o0li(BFMA1Llool);
y := BFMA1L0li(BFMA1llooL,
BFMA1i00oL);
when others =>
assert FalsE report "Illegal Parameter P2" severity fAILure;
end case;
when 2 =>
y := BFMA1i100(BFMA1lL10-BFMA1o00Ol+BFMA1o10oL);
when 1 =>
y := BFMA1i100(BFMA1o00OL+BFMA1O10ol);
when 0 =>
Y := BFMA1o00OL;
when others =>
assert falSE report "Illegal Parameter P3" severity fAILure;
end case;
else
y := x;
end if;
return (Y);
end BFMA1iL0Ol;
impure function BFMA1l10oL(X: inTEGer)
return INTegeR is
variable BFMA1I10ol: iNTEger;
variable BFMA1LI0ol: inTEGer;
variable BFMA1II0ol: inTEGer;
variable BFMA1O00ol: inTEGer;
variable BFMA1l00OL: INTeger;
variable BFMA1I00ol: INTeger;
variable BFMA1LIoi: std_LOGic_vECtor(31 downto 0);
variable BFMA1O10ol: IntegER;
begin
BFMA1LIoi := To_sLV32(x);
BFMA1lI0Ol := tO_Int_UNSigneD(BFMA1LIoi(30 downto 16));
BFMA1iI0ol := TO_int_UNsigNED(BFMA1lIOI(14 downto 13));
BFMA1O00ol := to_INt_uNSIgneD(BFMA1liOI(12 downto 0));
BFMA1l00ol := TO_int_UNsigNED(BFMA1Lioi(12 downto 8));
BFMA1i00OL := TO_int_UnsigNEd(BFMA1liOI(7 downto 0));
BFMA1O10ol := 0;
if BFMA1LIOi(15) = '1' then
BFMA1O10ol := BFMA1IL0ol(True,
BFMA1li0OL);
end if;
case BFMA1iI0Ol is
when 3 =>
assert FalsE report "$Variables not allowed" severity failURE;
when 2 =>
BFMA1i10Ol := BFMA1LL10-BFMA1O00ol+BFMA1o10OL;
when 1 =>
BFMA1i10OL := BFMA1O00ol+BFMA1O10ol;
when 0 =>
assert FAlse report "Immediate data not allowed" severity fAILure;
when others =>
assert falsE report "Illegal Parameter P3" severity failURE;
end case;
return (BFMA1i10OL);
end BFMA1L10ol;
begin
if sysRSTn = '0' then
BFMA1LII0 <= '0';
debUG <= deBUGleveL;
BFMA1l01I <= ( others => '0');
BFMA1LL1i <= ( others => '0');
BFMA1il1I <= '0';
BFMA1OI1i <= ( others => '0');
BFMA1O11i <= ( others => '0');
BFMA1LI1i <= ( others => '0');
BFMA1II1i <= '0';
BFMA1iiI0 <= ( others => '0');
Instr_OUt <= ( others => '0');
BFMA1lOO0 <= '0';
BFMA1iOO0 <= '0';
BFMA1IIO0 <= ( others => '0');
BFMA1o0o0 <= ( others => '0');
BFMA1l0o0 <= ( others => '0');
BFMA1l0l0 <= '0';
BFMA1lil0 <= '0';
BFMA1iil0 <= '0';
BFMA1i1l0 <= ( others => '0');
BFMA1l1L0 <= ( others => '0');
BFMA1l0i0 <= '0';
BFMA1o0i0(1 to 8) <= "UNKNOWN"&NUL;
BFMA1oLO0 <= '0';
BFMA1i0O0 <= ( others => '0');
BFMA1o1o0 <= ( others => '0');
BFMA1oii0 <= 0;
BFMA1I01i <= ( others => '0');
BFMA1oll0 <= '0';
BFMA1llL0 <= ( others => '0');
BFMA1Ill0 <= ( others => '0');
BFMA1oIL0 <= 0;
BFMA1I0I0 <= '0';
BFMA1OL1i <= '0';
CON_busY <= '0';
BFMA1oII0 <= 0;
BFMA1Llo0 <= '0';
BFMA1iLO0 <= '0';
BFMA1O1I0 <= falsE;
BFMA1L1i0 <= FAlse;
BFMA1i1I0 <= FAlse;
BFMA1Oo00 <= FAlse;
BFMA1OL01 := BFMA1II00;
BFMA1O100 := falSE;
BFMA1lOLI := 0;
BFMA1O1O1 := FALse;
BFMA1iiI1 := 0;
BFMA1olO1 := fALSe;
BFMA1O0o1 := falsE;
BFMA1lio1 := falsE;
BFMA1llo1 := faLSE;
BFMA1ILo1 := FALse;
BFMA1oiO1 := falSE;
BFMA1IIO1 := FAlse;
BFMA1l0O1 := falSE;
BFMA1Ll10 := 0;
BFMA1lII1 := 0;
BFMA1L110 := 512;
BFMA1L001 := FAlse;
BFMA1ll01 := 0;
BFMA1io01 := FALse;
BFMA1OI01 := '0';
BFMA1li01 := "0011";
BFMA1ii01 := "001";
BFMA1l0L1 := falsE;
BFMA1OO11 := 2;
BFMA1lo11 := 4;
BFMA1io11 := 0;
BFMA1OL11 := False;
BFMA1iL11 := 0;
BFMA1lL0Ol := 0;
BFMA1OLI1 := 0;
BFMA1oi11 := falsE;
BFMA1o011 := 0;
BFMA1i011 := FALse;
BFMA1o111 := False;
BFMA1L111 := FALse;
BFMA1i111 := fALSE;
BFMA1Oll1(1) := Nul;
BFMA1L011 := falSE;
BFMA1olooL := 0;
BFMA1ILool := 1;
BFMA1lloOL := 1;
BFMA1OIOol := 0;
BFMA1ooLOL := 0;
BFMA1ioloL := 0;
BFMA1olLOL := 0;
BFMA1illoL := 0;
BFMA1LL11 := 0;
BFMA1oiloL := 0;
elsif BFMA1io1I = '1' and BFMA1Io1i'EVENt then
BFMA1olI0 <= CON_rd;
BFMA1Lli0 <= CON_wr;
BFMA1LIL0 <= '0';
BFMA1IIL0 <= '0';
BFMA1L0l0 <= '0';
BFMA1i0l0 <= '0';
BFMA1i0O1 := falsE;
if not BFMA1o100 then
PRIntf(" ");
PrinTF("###########################################################################");
pRINtf("AMBA BFM Model");
PRIntf("Version %s  %s",
Fmt(BFMA1Oo1i)&fmT(BFMA1lo1I));
PrintF(" ");
PrintF("Opening BFM Script file %s",
FMT(VectFILe));
if not BFMA1o100 and opmODE /= 2 then
File_OPen(BFMA1I000,
BFMA1ll00,
vECTfile);
if not (BFMA1i000 = OPEn_ok) then
assert False report "FAILED to load script file "&vecTFIle severity faILUre;
else
V := 0;
BFMA1I0l1 := falsE;
while not BFMA1I0l1
loop
REAdlinE(BFMA1LL00,
l);
for BFMA1Ll0i in 1 to 8
loop
rEAD(l,
BFMA1O1L1);
BFMA1o0L1(BFMA1lL0I) := BFMA1O1L1;
end loop;
BFMA1IOli(v) := tO_InteGER(TO_dwoRD_sigNED(BFMA1O0L1));
V := V+1;
BFMA1i0l1 := enDFILe(BFMA1Ll00);
end loop;
fILE_cloSE(BFMA1LL00);
end if;
BFMA1o100 := tRUE;
BFMA1LO10 := v;
BFMA1ooooL := BFMA1IOli(0) mod 65536;
BFMA1ioOOL := BFMA1iolI(0)/65536;
priNTF("Read %d Vectors - Compiler Version %d.%d",
fmT(BFMA1LO10)&fmt(BFMA1ioOOL)&fmt(BFMA1ooooL));
if BFMA1ioOOL /= BFMA1o then
assert FAlse report "Incorrect vectors file format for this BFM"&vectFILe severity FAilurE;
end if;
BFMA1Loli := BFMA1IOli(1);
BFMA1ol10 := BFMA1IOli(2);
BFMA1Ll10 := BFMA1IOLi(3);
BFMA1i100(BFMA1LL10) := 0;
BFMA1Ll10 := BFMA1LL10+1;
if BFMA1LOli = 0 then
assert FAlse report "BFM Compiler reported errors" severity FailuRE;
end if;
PrinTF("BFM:Filenames includes in Vectors");
BFMA1OI10 := TO_slv32(BFMA1IOLi(BFMA1oL10));
BFMA1ii10 := BFMA1ioLI(BFMA1oL10) rem 256;
while BFMA1iI10 = BFMA1L00
loop
BFMA1i010 := BFMA1Llli(BFMA1Ioli(BFMA1ol10+1));
BFMA1olLI := ( others => 0);
BFMA1iO0I := BFMA1OOLi(BFMA1OL10,
BFMA1IOLI(BFMA1oL10 to BFMA1ol10+BFMA1I010-1),
BFMA1OLLi);
pRINtf("  %s",
FMT(BFMA1IO0i));
for BFMA1i0II in 1 to 256
loop
BFMA1o101(BFMA1l101)(BFMA1i0ii) := BFMA1iO0I(BFMA1i0ii);
end loop;
BFMA1L101 := BFMA1l101+1;
BFMA1Ol10 := BFMA1OL10+BFMA1I010;
BFMA1oi10 := TO_slv32(BFMA1IOLi(BFMA1oL10));
BFMA1Ii10 := BFMA1IOLi(BFMA1OL10) rem 256;
end loop;
BFMA1i101 := 65536;
if BFMA1l101 > 1 then
BFMA1I101 := 32768;
end if;
if BFMA1l101 > 2 then
BFMA1i101 := 16384;
end if;
if BFMA1L101 > 4 then
BFMA1I101 := 8912;
end if;
if BFMA1l101 > 8 then
BFMA1I101 := 4096;
end if;
if BFMA1L101 > 16 then
BFMA1i101 := 2048;
end if;
if BFMA1L101 > 32 then
BFMA1I101 := 1024;
end if;
BFMA1oI11 := (opMODe = 0);
end if;
end if;
if OPmodE = 2 and not BFMA1o100 then
BFMA1I101 := 65536;
BFMA1O100 := truE;
BFMA1oi11 := FALse;
BFMA1LL10 := 0;
BFMA1I100(BFMA1ll10) := 0;
BFMA1LL10 := BFMA1LL10+1;
end if;
if BFMA1Oiool <= 1 then
BFMA1ol1I <= '1';
else
BFMA1OIool := BFMA1oioOL-1;
end if;
case BFMA1OL01 is
when BFMA1II00 =>
if HresP = '1' and hrEADY = '1' then
assert fALSe report "BFM: HRESP Signaling Protocol Error T2" severity ERror;
BFMA1LL01 := BFMA1Ll01+1;
end if;
if hreSP = '1' and HreaDY = '0' then
BFMA1ol01 := BFMA1O000;
end if;
when BFMA1o000 =>
if HResp = '0' or HreadY = '0' then
assert faLSE report "BFM: HRESP Signaling Protocol Error T3" severity ERRor;
BFMA1lL01 := BFMA1ll01+1;
end if;
if HresP = '1' and HReadY = '1' then
BFMA1Ol01 := BFMA1Ii00;
end if;
case BFMA1Lii1 is
when 0 =>
assert FALse report "BFM: Unexpected HRESP Signaling Occured" severity errOR;
BFMA1Ll01 := BFMA1LL01+1;
when 1 =>
BFMA1IO01 := truE;
when others =>
assert False report "BFM: HRESP mode is not correctly set" severity ERror;
BFMA1ll01 := BFMA1ll01+1;
end case;
end case;
if opMODe > 0 then
if COn_wr = '1' and (BFMA1LLI0 = '0' or con_SPulsE = 1) then
BFMA1oo0i := BFMA1OIoi(CON_addR);
case BFMA1oo0i is
when 0 =>
BFMA1OI11 := (BFMA1loi0(0) = '1');
BFMA1Li11 := (BFMA1LOI0(1) = '1');
BFMA1l0l1 := False;
if BFMA1oi11 and not BFMA1Li11 then
BFMA1I100(BFMA1ll10) := 0;
BFMA1ll10 := BFMA1lL10+1;
end if;
if deBUG >= 2 and BFMA1oI11
and not BFMA1Li11 then
prINTf("BFM: Starting script at %08x (%d parameters)",
fmT(BFMA1loLI)&FMt(BFMA1ooloL));
end if;
if Debug >= 2 and BFMA1oi11
and BFMA1li11 then
prINTf("BFM: Starting instruction at %08x",
fmt(BFMA1lOLI));
end if;
if BFMA1Oi11 then
if BFMA1ooLOL > 0 then
for BFMA1i0II in 0 to BFMA1OOlol-1
loop
BFMA1I100(BFMA1ll10) := BFMA1i1oOL(BFMA1I0ii);
BFMA1lL10 := BFMA1lL10+1;
end loop;
BFMA1oolOL := 0;
end if;
BFMA1iolOL := 0;
BFMA1olloL := 0;
end if;
when 1 =>
BFMA1LOLi := TO_int_UNsigNED(BFMA1LOI0);
when 2 =>
BFMA1I1Ool(BFMA1oOLOl) := to_iNT_sigNED(BFMA1lOI0);
BFMA1OOlol := BFMA1OOlol+1;
when others =>
BFMA1ioLI(BFMA1oo0I) := to_INT_sigNED(BFMA1LOi0);
end case;
end if;
if CON_rd = '1' and (BFMA1OLI0 = '0' or con_SpulsE = 1) then
BFMA1oo0I := BFMA1OIOi(COn_adDR);
case BFMA1OO0i is
when 0 =>
BFMA1iOI0 <= ( others => '0');
BFMA1ioI0(2) <= tO_std_LOGic(BFMA1OI11);
BFMA1IOI0(3) <= to_STd_lOGIc(BFMA1LL01 > 0);
when 1 =>
BFMA1ioi0 <= TO_std_LOgic(to_UNsignED(BFMA1LOli,
32));
when 2 =>
BFMA1ioI0 <= to_STD_logIC(to_UNsigNED(BFMA1olI1,
32));
BFMA1OOLol := 0;
when 3 =>
if BFMA1ioLOL > BFMA1OLLol then
BFMA1ioi0 <= to_STD_logIC(to_UNSIgneD(BFMA1Lolol(BFMA1OLLol),
32));
BFMA1Ollol := BFMA1olloL+1;
else
PrinTF("BFM: Overread Control return stack");
BFMA1IOI0 <= ( others => '0');
end if;
when others =>
BFMA1ioi0 <= to_Std_lOGIc(tO_unsiGNEd(BFMA1IOli(BFMA1oo0I),
32));
end case;
end if;
end if;
BFMA1o0i1 := BFMA1o0i1+1;
BFMA1oiloL := BFMA1oiloL+1;
BFMA1L1iol := TRue;
while BFMA1l1IOl
loop
BFMA1l1IOl := falSE;
if not BFMA1O1O1 and BFMA1oi11 then
BFMA1OI10 := to_SLV32(BFMA1IOLi(BFMA1loLI));
BFMA1lI10 := TO_int_UNSignED(BFMA1OI10(1 downto 0));
BFMA1Ii10 := to_Int_uNSIgneD(BFMA1oi10(7 downto 0));
BFMA1L010 := To_iNT_unsIGNed(BFMA1OI10(15 downto 8));
BFMA1o110 := tO_Int_UNSignED(BFMA1OI10(31 downto 16));
BFMA1LOL1 := BFMA1L110;
BFMA1L0I1 := BFMA1l0I1+1;
BFMA1I010 := 1;
BFMA1o001 := -1;
BFMA1o011 := 0;
ifprINTf((debuG >= 5),
"BFM: Instruction %d Line Number %d Command %d",
fmt(BFMA1loLI)&Fmt(BFMA1O110)&FMt(BFMA1II10));
if BFMA1i111 then
SPRintF(BFMA1IOl1,
"%05t BF %4d %4d %3d",
fmt(BFMA1LOli)&FMt(BFMA1O110)&fmt(BFMA1II10));
WRIte(L,
BFMA1IOL1);
WriteLINe(BFMA1IL00,
L);
end if;
if BFMA1Ii10 >= 100 then
BFMA1O010 := BFMA1II10;
else
BFMA1o010 := 4*(BFMA1Ii10/4);
end if;
if BFMA1II10 /= BFMA1il1 then
BFMA1o0i1 := 0;
end if;
case BFMA1o010 is
when BFMA1iI0
| BFMA1o00
| BFMA1L00
| BFMA1illL =>
BFMA1Oo0i := 8;
when BFMA1o0
| BFMA1L1 =>
BFMA1oo0I := 4+BFMA1IOli(BFMA1LOli+1);
when BFMA1l1i =>
BFMA1oo0I := 3+BFMA1ioLI(BFMA1loLI+2);
when BFMA1o1i =>
BFMA1Oo0i := 3;
when BFMA1oi0 =>
BFMA1OO0i := 2+BFMA1IOli(BFMA1LOLi+1);
when BFMA1oooL =>
BFMA1oO0I := 3+BFMA1IOLi(BFMA1LOli+2);
when BFMA1IIll =>
BFMA1OO0i := 2+BFMA1Ioli(BFMA1loLI+1);
when BFMA1lii =>
BFMA1oO0I := 3+BFMA1ioLI(BFMA1lOLI+1);
when others =>
BFMA1oo0I := 8;
end case;
if BFMA1oO0I > 0 then
for BFMA1I0ii in 0 to BFMA1OO0i-1
loop
if (BFMA1I0Ii >= 1 and BFMA1I0ii <= 8) then
BFMA1OLli(BFMA1i0II) := BFMA1iL0Ol((BFMA1oi10(7+BFMA1i0II) = '1'),
BFMA1IOli(BFMA1loLI+BFMA1I0Ii));
else
BFMA1olli(BFMA1I0ii) := BFMA1Ioli(BFMA1LOli+BFMA1I0Ii);
end if;
BFMA1L100(BFMA1I0Ii) := to_SLV32(BFMA1OLLi(BFMA1i0II));
end loop;
end if;
case BFMA1o010 is
when BFMA1O0ll =>
assert falSE report "BFM Compiler reported an error" severity FailURE;
BFMA1lL01 := BFMA1LL01+1;
when BFMA1L01 =>
BFMA1i010 := 2;
BFMA1l1iOL := True;
BFMA1lOLOl(BFMA1Iolol) := BFMA1OLli(1);
BFMA1ioloL := BFMA1IOlol+1;
IfpriNTF((DEBug >= 2),
"BFM:%d:conifpush %d ",
fmt(BFMA1O110)&fMT(BFMA1Olli(1)));
when BFMA1IOol =>
BFMA1i010 := 2;
BFMA1OL1i <= '0';
BFMA1OIOOl := BFMA1ollI(1);
iFPRintf((debuG >= 2),
"BFM:%d:RESET %d",
fMT(BFMA1o110)&fmt(BFMA1Olli(1)));
when BFMA1OLol =>
BFMA1I010 := 2;
BFMA1liI0 <= BFMA1L100(1)(0);
iFPRintf((dEBUG >= 2),
"BFM:%d:STOPCLK %d ",
fmT(BFMA1o110)&fMT(BFMA1L100(1)(0)));
when BFMA1L10 =>
BFMA1i010 := 2;
BFMA1iII1 := BFMA1OLli(1);
ifPRIntf((Debug >= 2),
"BFM:%d:mode %d (No effect in this version)",
Fmt(BFMA1O110)&FMt(BFMA1Iii1));
when BFMA1I10 =>
BFMA1L1Iol := truE;
BFMA1i010 := 4;
BFMA1Oo0i := BFMA1olLI(1);
x := BFMA1OLLi(2);
y := BFMA1olLI(3);
IFprinTF((DebuG >= 2),
"BFM:%d:setup %d %d %d ",
FMt(BFMA1O110)&fmt(BFMA1oo0I)&FMT(x)&FMT(Y));
case BFMA1OO0i is
when 1 =>
BFMA1i010 := 4;
BFMA1OO11 := X;
BFMA1LO11 := y;
IFprinTF((deBUG >= 2),
"BFM:%d:Setup- Memory Cycle Transfer Size %s %d",
FMT(BFMA1O110)&Fmt(BFMA1ILOi(BFMA1oo11))&fMT(BFMA1lo11));
when 2 =>
BFMA1i010 := 3;
BFMA1OL11 := to_BOOlean(x);
IfpriNTF((DEbug >= 2),
"BFM:%d:Setup- Automatic Flush %d",
FMt(BFMA1O110)&FMT(BFMA1ol11));
when 3 =>
BFMA1I010 := 3;
BFMA1IO11 := X;
IfpriNTF((DebuG >= 2),
"BFM:%d:Setup- XRATE %d",
Fmt(BFMA1o110)&FMT(BFMA1iO11));
when 4 =>
BFMA1I010 := 3;
BFMA1LL11 := X;
ifPRINtf((DEbug >= 2),
"BFM:%d:Setup- Burst Disable %d",
fmt(BFMA1o110)&FMT(BFMA1ll11));
when 5 =>
BFMA1i010 := 3;
BFMA1iL11 := X;
IfprINTf((debUG >= 2),
"BFM:%d:Setup- Alignment %d",
Fmt(BFMA1o110)&fmt(BFMA1IL11));
if BFMA1IL11 = 1 or BFMA1Il11 = 2 then
assert FALse report "BFM: Untested 8 or 16 Bit alignment selected" severity wARNing;
end if;
when 6 =>
BFMA1i010 := 3;
BFMA1Ll0oL := X;
ifPRIntf((Debug >= 2),
"BFM:%d:Setup- End Sim Action %0d",
FMT(BFMA1o110)&FMT(BFMA1ll0OL));
if (BFMA1LL0ol > 4) then
PRintf("BFM: Unexpected End Simulation value (WARNING)");
end if;
when 7 =>
BFMA1i010 := 3;
when others =>
assert faLSE report "BFM Unknown Setup Command" severity fAILure;
end case;
when BFMA1OLll =>
BFMA1l1iOL := truE;
BFMA1I010 := 2;
BFMA1i1I0 <= (BFMA1L100(1)(0) = '1');
BFMA1oO00 <= (BFMA1L100(1)(1) = '1');
BFMA1l1I0 <= (BFMA1l100(1)(2) = '1');
BFMA1O1i0 <= (BFMA1L100(1)(3) = '1');
IfprINTf((dEBUg >= 2),
"BFM:%d:drivex %d ",
fmt(BFMA1O110)&fmt(BFMA1OLli(1)));
when BFMA1ol1 =>
BFMA1l1IOL := TRUe;
BFMA1I010 := 3;
ifpriNTF((debuG >= 2),
"BFM:%d:error %d %d (No effect in this version)",
fMT(BFMA1O110)&FMt(BFMA1OLli(1))&fMT(BFMA1olLI(2)));
when BFMA1LO1 =>
BFMA1l1IOl := true;
BFMA1i010 := 2;
BFMA1LI01 := BFMA1L100(1)(3 downto 0);
ifpRINtf((dEBUg >= 2),
"BFM:%d:prot %d ",
FMT(BFMA1o110)&fMT(BFMA1li01));
when BFMA1IO1 =>
BFMA1l1IOL := true;
BFMA1i010 := 2;
BFMA1oI01 := BFMA1L100(1)(0);
IfprINTf((DebuG >= 2),
"BFM:%d:lock %d ",
fMT(BFMA1O110)&fMT(BFMA1OI01));
when BFMA1LL1 =>
BFMA1L1ioL := trUE;
BFMA1i010 := 2;
BFMA1II01 := BFMA1L100(1)(2 downto 0);
IFPrintF((deBUG >= 2),
"BFM:%d:burst %d ",
fMT(BFMA1O110)&Fmt(BFMA1II01));
when BFMA1Io0 =>
BFMA1I010 := 2;
BFMA1I1o1 := BFMA1OLli(1);
IFprinTF((DEbug >= 2),
"BFM:%d:wait %d  starting at %t ns",
Fmt(BFMA1O110)&fmt(BFMA1i1O1));
BFMA1OLO1 := TRue;
when BFMA1ioll =>
BFMA1i010 := 2;
BFMA1olooL := BFMA1olli(1)*1000+(NOW/1 ns);
ifpRINtf((Debug >= 2),
"BFM:%d:waitus %d  starting at %t ns",
Fmt(BFMA1o110)&fMT(BFMA1Olli(1)));
BFMA1Olo1 := tRUE;
when BFMA1LOLl =>
BFMA1I010 := 2;
BFMA1olooL := BFMA1ollI(1)*1+(Now/1 NS);
IFPrintF((Debug >= 2),
"BFM:%d:waitns %d  starting at %t ns",
fmt(BFMA1o110)&fMT(BFMA1oLLI(1)));
BFMA1OLo1 := true;
when BFMA1IL1 =>
BFMA1I010 := 3;
IFprinTF((deBUG >= 2),
"BFM:%d:checktime %d %d at %t ns ",
fmT(BFMA1o110)&Fmt(BFMA1OLli(1))&fMT(BFMA1oLLI(2)));
BFMA1OLo1 := tRUE;
when BFMA1li1 =>
BFMA1L1Iol := TRue;
BFMA1i010 := 1;
BFMA1oilOL := 1;
ifpRINtf(DEBug >= 2,
"BFM:%d:starttimer at %t ns",
FMt(BFMA1o110));
when BFMA1Ii1 =>
BFMA1I010 := 3;
IFprinTF((debuG >= 2),
"BFM:%d:checktimer %d %d at %t ns ",
fmt(BFMA1O110)&fmt(BFMA1olli(1))&FMt(BFMA1OLLi(2)));
BFMA1OLO1 := tRUE;
when BFMA1i =>
BFMA1I010 := 4;
BFMA1I110 := BFMA1L0Oi(BFMA1li10,
BFMA1OO11);
BFMA1oOO1 := TO_slv32(BFMA1OLli(1)+BFMA1olLI(2));
BFMA1lOO1 := BFMA1l100(3);
IFPrinTF((debuG >= 2),
"BFM:%d:write %c %08x %08x at %t ns",
Fmt(BFMA1o110)&fmt(BFMA1iLOI(BFMA1li10))&fmT(BFMA1Ooo1)&fmT(BFMA1loO1));
BFMA1Lio1 := tRUE;
when BFMA1LLL =>
BFMA1I010 := 5;
BFMA1i110 := BFMA1l0OI(BFMA1LI10,
BFMA1oO11);
BFMA1OOO1 := tO_Slv32(BFMA1olLI(1)+BFMA1oLLI(2));
BFMA1loO1 := BFMA1L100(3);
BFMA1lIOOl := BFMA1L100(4)(0);
BFMA1IIOol := BFMA1L100(4)(5 downto 4);
BFMA1o0oOL := BFMA1L100(4)(10 downto 8);
BFMA1l0oOL := BFMA1l100(4)(12);
BFMA1I0Ool := BFMA1L100(4)(19 downto 16);
ifPRIntf((debUG >= 2),
"BFM:%d:ahbcycle %c %08x %08x %08x at %t ns",
fMT(BFMA1O110)&fmt(BFMA1iLOI(BFMA1li10))&Fmt(BFMA1ooO1)&fmT(BFMA1loO1)&fmt(BFMA1l100(4)));
BFMA1l0O1 := True;
when BFMA1ol =>
BFMA1I010 := 3;
BFMA1i110 := BFMA1l0oI(BFMA1LI10,
BFMA1OO11);
BFMA1Ooo1 := tO_slv32(BFMA1OLLi(1)+BFMA1olli(2));
BFMA1loo1 := ( others => '0');
BFMA1IOo1 := ( others => '0');
ifPRIntf((debuG >= 2),
"BFM:%d:read %c %08x  at %t ns",
FMT(BFMA1O110)&fMT(BFMA1ILoi(BFMA1LI10))&fmt(BFMA1OOo1));
BFMA1Llo1 := True;
when BFMA1olL =>
BFMA1i010 := 4;
BFMA1i110 := BFMA1L0oi(BFMA1LI10,
BFMA1oO11);
BFMA1ooo1 := TO_slv32(BFMA1olli(1)+BFMA1olli(2));
BFMA1loO1 := ( others => '0');
BFMA1IOo1 := ( others => '0');
BFMA1O001 := BFMA1L10ol(BFMA1IOLi(BFMA1loli+3));
ifprINTf((Debug >= 2),
"BFM:%d:readstore %c %08x @%d at %t ns ",
FMt(BFMA1o110)&Fmt(BFMA1iloi(BFMA1li10))&fmT(BFMA1oOO1)&fMT(BFMA1o001));
BFMA1llO1 := tRUE;
BFMA1o0o1 := TRUe;
when BFMA1LL =>
BFMA1I010 := 4;
BFMA1i110 := BFMA1L0oi(BFMA1LI10,
BFMA1OO11);
BFMA1ooo1 := to_SLV32(BFMA1ollI(1)+BFMA1OLli(2));
BFMA1LOo1 := BFMA1L100(3);
BFMA1Ioo1 := ( others => '1');
IFPrintF((deBUG >= 2),
"BFM:%d:readcheck %c %08x %08x at %t ns",
FMT(BFMA1o110)&fmt(BFMA1Iloi(BFMA1LI10))&fMT(BFMA1ooo1)&FMt(BFMA1Loo1));
BFMA1llO1 := TRUe;
when BFMA1il =>
BFMA1I010 := 5;
BFMA1i110 := BFMA1L0oi(BFMA1lI10,
BFMA1OO11);
BFMA1OOo1 := TO_slv32(BFMA1OLLi(1)+BFMA1OLli(2));
BFMA1loO1 := BFMA1l100(3);
BFMA1iOO1 := BFMA1l100(4);
IFPrintF((debUG >= 2),
"BFM:%d:readmask %c %08x %08x %08x at %t ns",
fmt(BFMA1O110)&fmt(BFMA1ILoi(BFMA1li10))&Fmt(BFMA1oOO1)&fMT(BFMA1LOO1)&fmt(BFMA1iOO1));
BFMA1llo1 := trUE;
when BFMA1oi =>
BFMA1I010 := 4;
BFMA1I110 := BFMA1L0oi(BFMA1LI10,
BFMA1OO11);
BFMA1ooO1 := to_Slv32(BFMA1ollI(1)+BFMA1oLLI(2));
BFMA1loo1 := BFMA1l100(3);
BFMA1ioo1 := ( others => '1');
IfprINTf((Debug >= 2),
"BFM:%d:poll %c %08x %08x at %t ns",
Fmt(BFMA1O110)&fmt(BFMA1iloi(BFMA1Li10))&Fmt(BFMA1OOo1)&FMT(BFMA1LOO1));
BFMA1O1o1 := trUE;
BFMA1IIO1 := TRUE;
BFMA1IIo1 := trUE;
when BFMA1LI =>
BFMA1i010 := 5;
BFMA1i110 := BFMA1L0Oi(BFMA1lI10,
BFMA1oo11);
BFMA1OOO1 := to_SLv32(BFMA1olLI(1)+BFMA1oLLI(2));
BFMA1LOo1 := BFMA1L100(3);
BFMA1ioO1 := BFMA1l100(4);
IFprinTF((Debug >= 2),
"BFM:%d:pollmask %c %08x %08x %08x at %t ns",
fmt(BFMA1o110)&fmt(BFMA1iloI(BFMA1LI10))&Fmt(BFMA1ooo1)&FMt(BFMA1loO1)&fMT(BFMA1Ioo1));
BFMA1IIO1 := true;
when BFMA1II =>
BFMA1i010 := 5;
BFMA1I110 := BFMA1L0Oi(BFMA1LI10,
BFMA1oo11);
BFMA1oOO1 := to_SLV32(BFMA1ollI(1)+BFMA1OLLi(2));
BFMA1LOo1 := ( others => '0');
BFMA1Ioo1 := ( others => '0');
BFMA1OOl1 := BFMA1olli(3);
BFMA1ioO1(BFMA1Ool1) := '1';
BFMA1Loo1(BFMA1OOl1) := BFMA1l100(4)(0);
IFpriNTF((DEbug >= 2),
"BFM:%d:pollbit %c %08x %d %d at %t ns",
FMT(BFMA1O110)&fMT(BFMA1ilOI(BFMA1lI10))&FMt(BFMA1ooo1)&FMT(BFMA1ool1)&fmt(BFMA1loO1(BFMA1ooL1)));
BFMA1IIo1 := True;
when BFMA1O0 =>
BFMA1ill1 := BFMA1ollI(1);
BFMA1I010 := 4+BFMA1ill1;
BFMA1I110 := BFMA1L0Oi(BFMA1li10,
BFMA1oo11);
BFMA1ooo1 := to_sLV32(BFMA1oLLI(2)+BFMA1oLLI(3));
BFMA1OIL1 := 0;
BFMA1LIl1 := BFMA1IIOi(BFMA1lI10,
BFMA1LO11);
for BFMA1i0II in 0 to BFMA1ILl1-1
loop
BFMA1iIL1(BFMA1I0Ii) := BFMA1olLI(BFMA1I0ii+4);
end loop;
ifPRIntf((dEBUg >= 2),
"BFM:%d:writemultiple %c %08x %08x ... at %t ns",
fmt(BFMA1O110)&FMT(BFMA1ILoi(BFMA1lI10))&FMT(BFMA1ooo1)&Fmt(BFMA1Iil1(0)));
BFMA1Ilo1 := tRUE;
when BFMA1L0 =>
BFMA1ilL1 := BFMA1oLLI(3);
BFMA1i010 := 6;
BFMA1I110 := BFMA1l0OI(BFMA1li10,
BFMA1Oo11);
BFMA1Ooo1 := TO_slV32(BFMA1Olli(1)+BFMA1oLLI(2));
BFMA1oiL1 := 0;
BFMA1lil1 := BFMA1Iioi(BFMA1li10,
BFMA1LO11);
BFMA1ILi1 := BFMA1oLLI(4);
BFMA1OIi1 := BFMA1OLli(5);
for BFMA1i0iI in 0 to BFMA1ill1-1
loop
BFMA1iIL1(BFMA1I0ii) := BFMA1ILi1;
BFMA1ilI1 := BFMA1Ili1+BFMA1OII1;
end loop;
IFPrintF((dEBUg >= 2),
"BFM:%d:fill %c %08x %d %d %d at %t ns",
fmT(BFMA1O110)&FMt(BFMA1iLOI(BFMA1li10))&Fmt(BFMA1OOO1)&Fmt(BFMA1Ill1)&Fmt(BFMA1oLLI(4))&fmT(BFMA1olLI(4)));
BFMA1ILO1 := tRUE;
when BFMA1I0 =>
BFMA1ILl1 := BFMA1Olli(4);
BFMA1I010 := 5;
BFMA1i110 := BFMA1L0Oi(BFMA1lI10,
BFMA1oo11);
BFMA1OOO1 := to_Slv32(BFMA1OLli(1)+BFMA1OLLi(2));
BFMA1Oil1 := 0;
BFMA1lil1 := BFMA1iIOI(BFMA1li10,
BFMA1LO11);
BFMA1L1l1 := BFMA1oLLI(3);
for BFMA1I0ii in 0 to BFMA1ILl1-1
loop
BFMA1IIL1(BFMA1i0II) := BFMA1ioLI(2+BFMA1l1L1+BFMA1I0ii);
end loop;
ifprINTf((deBUG >= 2),
"BFM:%d:writetable %c %08x %d %d at %t ns ",
Fmt(BFMA1O110)&Fmt(BFMA1ilOI(BFMA1Li10))&Fmt(BFMA1ooo1)&Fmt(BFMA1l1L1)&fmT(BFMA1ILL1));
BFMA1ilO1 := trUE;
when BFMA1ill =>
BFMA1ILL1 := BFMA1OLli(4);
BFMA1I010 := 5;
BFMA1I110 := BFMA1L0Oi(BFMA1li10,
BFMA1OO11);
BFMA1ooo1 := tO_slv32(BFMA1ollI(1)+BFMA1olLI(2));
BFMA1OIl1 := 0;
BFMA1LIl1 := BFMA1iioI(BFMA1lI10,
BFMA1LO11);
BFMA1I0i1 := BFMA1L10ol(BFMA1iOLI(BFMA1LOli+3));
for BFMA1I0ii in 0 to BFMA1ilL1-1
loop
BFMA1Iil1(BFMA1I0Ii) := BFMA1i100(BFMA1I0i1+BFMA1I0Ii);
end loop;
ifPRIntf((Debug >= 2),
"BFM:%d:writearray %c %08x %d %d at %t ns ",
fmt(BFMA1o110)&FMt(BFMA1iLOI(BFMA1lI10))&Fmt(BFMA1ooo1)&fmt(BFMA1i0i1)&FMt(BFMA1ILL1));
BFMA1iLO1 := true;
when BFMA1o1 =>
BFMA1ILl1 := BFMA1OLLi(3);
BFMA1i010 := 4;
BFMA1i110 := BFMA1L0Oi(BFMA1LI10,
BFMA1OO11);
BFMA1oOO1 := to_SLv32(BFMA1OLLi(1)+BFMA1ollI(2));
BFMA1ioo1 := ( others => '0');
BFMA1Oil1 := 0;
BFMA1LIl1 := BFMA1IIOi(BFMA1LI10,
BFMA1lo11);
BFMA1IOO1 := ( others => '0');
IFpriNTF((deBUG >= 2),
"BFM:%d:readmult %c %08x %d at %t ns",
Fmt(BFMA1O110)&FMt(BFMA1iloI(BFMA1LI10))&Fmt(BFMA1ooo1)&FMT(BFMA1iLL1));
BFMA1OIo1 := tRUE;
when BFMA1l1 =>
BFMA1Ill1 := BFMA1ollI(1);
BFMA1I010 := 4+BFMA1ILL1;
BFMA1i110 := BFMA1l0OI(BFMA1LI10,
BFMA1OO11);
BFMA1OOo1 := To_slV32(BFMA1OLli(2)+BFMA1olli(3));
BFMA1iOO1 := ( others => '1');
BFMA1OIL1 := 0;
BFMA1lIL1 := BFMA1IIOi(BFMA1lI10,
BFMA1lo11);
BFMA1IOO1 := ( others => '1');
for BFMA1i0II in 0 to BFMA1Ill1-1
loop
BFMA1IIL1(BFMA1I0ii) := BFMA1oLLI(BFMA1I0Ii+4);
end loop;
ifpRINtf((debUG >= 2),
"BFM:%d:readmultchk %c %08x %08x ... at %t ns",
fMT(BFMA1o110)&fmT(BFMA1ILOi(BFMA1LI10))&fmt(BFMA1oOO1)&Fmt(BFMA1iiL1(0)));
BFMA1oIO1 := True;
when BFMA1i1 =>
BFMA1iLL1 := BFMA1OLli(3);
BFMA1i010 := 6;
BFMA1i110 := BFMA1l0OI(BFMA1LI10,
BFMA1oO11);
BFMA1ooo1 := to_SLv32(BFMA1olLI(1)+BFMA1Olli(2));
BFMA1iOO1 := ( others => '1');
BFMA1oil1 := 0;
BFMA1lil1 := BFMA1Iioi(BFMA1li10,
BFMA1lo11);
BFMA1ili1 := BFMA1OLli(4);
BFMA1oii1 := BFMA1Olli(5);
for BFMA1I0ii in 0 to BFMA1ill1-1
loop
BFMA1IIl1(BFMA1i0iI) := BFMA1iLI1;
BFMA1ilI1 := BFMA1iLI1+BFMA1OII1;
end loop;
IFpriNTF((debuG >= 2),
"BFM:%d:fillcheck %c %08x %d %d %d at %t ns",
FMT(BFMA1o110)&Fmt(BFMA1ILoi(BFMA1li10))&FMt(BFMA1Ooo1)&fmt(BFMA1ILL1)&fmt(BFMA1OLLi(4))&fmT(BFMA1Olli(5)));
BFMA1OIo1 := True;
when BFMA1Oil =>
BFMA1Ill1 := BFMA1OLli(4);
BFMA1I010 := 5;
BFMA1i110 := BFMA1l0oI(BFMA1li10,
BFMA1OO11);
BFMA1ooo1 := tO_slv32(BFMA1olLI(1)+BFMA1OLLi(2));
BFMA1ioo1 := ( others => '1');
BFMA1oil1 := 0;
BFMA1liL1 := BFMA1IIoi(BFMA1lI10,
BFMA1lO11);
BFMA1I0I1 := BFMA1L10ol(BFMA1Ioli(BFMA1LOLi+3));
for BFMA1i0ii in 0 to BFMA1ILL1-1
loop
BFMA1iil1(BFMA1I0ii) := BFMA1I100(BFMA1I0I1+BFMA1i0II);
end loop;
ifPRIntf((debuG >= 2),
"BFM:%d:readarray %c %08x %d %d at %t ns",
Fmt(BFMA1O110)&fmT(BFMA1iLOI(BFMA1Li10))&FMT(BFMA1ooo1)&FMT(BFMA1i0I1)&FMt(BFMA1Ill1));
BFMA1oio1 := True;
when BFMA1oOL =>
BFMA1ill1 := BFMA1olLI(4);
BFMA1i010 := 5;
BFMA1i110 := BFMA1L0oi(BFMA1LI10,
BFMA1OO11);
BFMA1ooO1 := TO_slv32(BFMA1oLLI(1)+BFMA1oLLI(2));
BFMA1iOO1 := ( others => '1');
BFMA1oil1 := 0;
BFMA1lIL1 := BFMA1iiOI(BFMA1lI10,
BFMA1lO11);
BFMA1L1l1 := BFMA1olLI(3);
for BFMA1i0II in 0 to BFMA1Ill1-1
loop
BFMA1IIl1(BFMA1I0Ii) := BFMA1ioLI(BFMA1L1l1+2+BFMA1I0Ii);
end loop;
ifprINTf((DEbug >= 2),
"BFM:%d:readtable %c %08x %d %d at %t ns",
FMT(BFMA1O110)&fmt(BFMA1Iloi(BFMA1lI10))&FMt(BFMA1Ooo1)&Fmt(BFMA1L1l1)&fmt(BFMA1ILl1));
BFMA1oio1 := tRUE;
when BFMA1I00 =>
BFMA1i010 := 7;
BFMA1OLO1 := truE;
BFMA1OLIol := BFMA1o0LOl;
when BFMA1O10 =>
BFMA1i010 := 7;
BFMA1olo1 := true;
BFMA1oLIOl := BFMA1o0LOl;
when BFMA1i1l =>
BFMA1I010 := 1;
BFMA1oOI1 := 0;
iFPRintf((dEBUg >= 2),
"BFM:%d:waitfiq at %t ns ",
fmt(BFMA1O110));
BFMA1oLO1 := truE;
when BFMA1ooi =>
BFMA1i010 := 1;
BFMA1ooi1 := 1;
IFPrintF((dEBUg >= 2),
"BFM:%d:waitirq at %t ns ",
fmt(BFMA1O110));
BFMA1oLO1 := True;
when BFMA1L1L =>
BFMA1i010 := 2;
BFMA1ooI1 := BFMA1oLLI(1);
IfpriNTF((Debug >= 2),
"BFM:%d:waitint %d  at %t ns",
Fmt(BFMA1o110)&FMt(BFMA1Ooi1));
BFMA1olo1 := TRUe;
when BFMA1Lil =>
BFMA1I010 := 2;
BFMA1Loo1 := BFMA1l100(1);
BFMA1iiI0 <= BFMA1LOo1;
BFMA1I0L0 <= '1';
IFprinTF((DEBug >= 2),
"BFM:%d:iowrite %08x  at %t ns ",
Fmt(BFMA1O110)&Fmt(BFMA1LOo1));
when BFMA1Iil =>
BFMA1i010 := 2;
BFMA1LOO1 := ( others => '0');
BFMA1iOO1 := ( others => '0');
BFMA1O001 := BFMA1l10OL(BFMA1IOLi(BFMA1LOli+1));
IfprINTf((Debug >= 2),
"BFM:%d:ioread @%d at %t ns",
FMt(BFMA1O110)&fmT(BFMA1o001));
BFMA1L0l0 <= '1';
BFMA1olo1 := trUE;
BFMA1O0o1 := truE;
BFMA1i0o1 := tRUE;
when BFMA1o0l =>
BFMA1I010 := 2;
BFMA1loo1 := BFMA1l100(1);
BFMA1ioo1 := ( others => '1');
BFMA1l0L0 <= '1';
ifpRINtf((Debug >= 2),
"BFM:%d:iocheck %08x  at %t ns ",
fMT(BFMA1O110)&FMT(BFMA1loo1));
BFMA1Olo1 := TRUe;
when BFMA1l0L =>
BFMA1I010 := 3;
BFMA1Loo1 := BFMA1L100(1);
BFMA1IOo1 := BFMA1l100(2);
iFPRintf((DEBug >= 2),
"BFM:%d:iomask %08x %08x  at %t ns",
Fmt(BFMA1o110)&fmt(BFMA1LOO1)&FMT(BFMA1ioo1));
BFMA1L0l0 <= '1';
BFMA1OLO1 := trUE;
when BFMA1LOL =>
BFMA1I010 := 2;
BFMA1Loo1 := ( others => '0');
BFMA1IOO1 := ( others => '0');
BFMA1OOL1 := BFMA1ollI(1);
BFMA1Loo1(BFMA1OOl1) := BFMA1oi10(0);
BFMA1ioO1(BFMA1ool1) := '1';
BFMA1l0l0 <= '1';
ifprINTf((debuG >= 2),
"BFM:%d:iotest %d %d  at %t ns",
fmT(BFMA1O110)&FMt(BFMA1oOL1)&Fmt(BFMA1OI10(0)));
BFMA1OLo1 := True;
when BFMA1I0l =>
BFMA1i010 := 2;
BFMA1OOL1 := BFMA1OLLi(1);
BFMA1iii0(BFMA1OOL1) <= '1';
BFMA1i0L0 <= '1';
iFPRintf((DebuG >= 2),
"BFM:%d:ioset %d at %t ns",
fmt(BFMA1o110)&fMT(BFMA1OOl1));
when BFMA1O1l =>
BFMA1i010 := 2;
BFMA1OOL1 := BFMA1olLI(1);
BFMA1iii0(BFMA1ool1) <= '0';
BFMA1i0l0 <= '1';
IfpriNTF((DEBug >= 2),
"BFM:%d:ioclr %d at %t ns",
FMT(BFMA1o110)&fMT(BFMA1OOL1));
when BFMA1Iol =>
BFMA1I010 := 2;
BFMA1LOo1 := ( others => '0');
BFMA1ioO1 := ( others => '0');
BFMA1ool1 := BFMA1OLli(1);
BFMA1loo1(BFMA1ool1) := BFMA1OI10(0);
BFMA1ioO1(BFMA1Ool1) := '1';
IFPrintF((debUG >= 2),
"BFM:%d:iowait %d %d at %t ns ",
FMT(BFMA1o110)&fmt(BFMA1Ool1)&fmt(BFMA1oI10(0)));
BFMA1L0L0 <= '1';
BFMA1OLO1 := trUE;
when BFMA1IOI =>
BFMA1I010 := 3;
BFMA1oOO1 := BFMA1l100(1);
BFMA1Loo1 := BFMA1L100(2);
IfpriNTF(DEBug >= 2,
"BFM:%d:extwrite %08x %08x at %t ns",
FMT(BFMA1O110)&FMT(BFMA1ooO1)&fMT(BFMA1loO1));
BFMA1OLO1 := TRUe;
when BFMA1lII =>
BFMA1ilL1 := BFMA1ollI(1);
BFMA1LLL1 := BFMA1Olli(2);
BFMA1I010 := BFMA1ill1+3;
for BFMA1i0iI in 0 to BFMA1ilL1-1
loop
BFMA1IIL1(BFMA1I0Ii) := BFMA1ollI(BFMA1I0ii+3);
end loop;
ifpRINtf(debuG >= 2,
"BFM:%d:extwrite %08x %0d Words at %t ns",
FMt(BFMA1o110)&fmt(BFMA1ooo1)&Fmt(BFMA1ill1));
BFMA1OIl1 := 0;
BFMA1olo1 := TRUe;
when BFMA1OLi =>
BFMA1i010 := 3;
BFMA1OOO1 := BFMA1L100(1);
BFMA1LOo1 := ( others => '0');
BFMA1Ioo1 := ( others => '0');
BFMA1O001 := BFMA1l10oL(BFMA1IOLi(BFMA1LOli+2));
BFMA1iil0 <= '1';
IFPrintF(DEbug >= 2,
"BFM:%d:extread @%d %08x at %t ns ",
fmt(BFMA1O110)&FMT(BFMA1o001)&FMt(BFMA1OOO1));
BFMA1oLO1 := TRUe;
BFMA1o0O1 := true;
BFMA1i0o1 := truE;
when BFMA1llI =>
BFMA1I010 := 3;
BFMA1OOo1 := BFMA1L100(1);
BFMA1Loo1 := BFMA1l100(2);
BFMA1Ioo1 := ( others => '1');
BFMA1o1O1 := True;
BFMA1Iil0 <= '1';
ifPRIntf(debuG >= 2,
"BFM:%d:extcheck %08x %08x at %t ns",
FMt(BFMA1O110)&fmt(BFMA1ooO1)&FMt(BFMA1lOO1));
BFMA1OLo1 := TRUe;
when BFMA1ILI =>
BFMA1I010 := 4;
BFMA1Ooo1 := BFMA1l100(1);
BFMA1Loo1 := BFMA1l100(2);
BFMA1iOO1 := BFMA1l100(3);
BFMA1iiL0 <= '1';
IFprinTF(DEBug >= 2,
"BFM:%d:extmask %08x %08x %08x at %t ns",
FMt(BFMA1o110)&fmt(BFMA1ooO1)&FMt(BFMA1loo1)&fmt(BFMA1Ioo1));
BFMA1Olo1 := truE;
when BFMA1oII =>
BFMA1I010 := 1;
BFMA1i1o1 := 1;
BFMA1o1O1 := truE;
IfpriNTF(DEbug >= 2,
"BFM:%d:extwait ",
fMT(BFMA1O110));
BFMA1olO1 := TRue;
when BFMA1IIi =>
assert falsE report "LABEL instructions not allowed in vector files" severity FailURE;
when BFMA1OI0 =>
BFMA1L1iol := truE;
BFMA1i010 := 2+BFMA1olLI(1);
ifprINTf((dEBUg >= 2),
"BFM:%d:table %08x ... (length=%d)",
fMT(BFMA1o110)&fmt(BFMA1oLLI(2))&fmT(BFMA1i010-2));
when BFMA1o0I =>
BFMA1L1iol := trUE;
BFMA1I010 := 2;
BFMA1LLI1 := BFMA1oLLI(1);
BFMA1I010 := BFMA1llI1-BFMA1lOLI;
IFprinTF((DEbug >= 2),
"BFM:%d:jump",
FMT(BFMA1o110));
when BFMA1L0i =>
BFMA1l1iOL := trUE;
BFMA1I010 := 3;
BFMA1LLI1 := BFMA1oLLI(1);
if BFMA1olLI(2) = 0 then
BFMA1I010 := BFMA1LLI1-BFMA1lOLI;
end if;
IfpriNTF((DEBug >= 2),
"BFM:%d:jumpz  %08x",
fmT(BFMA1o110)&fmT(BFMA1olLI(2)));
when BFMA1Llol =>
BFMA1l1ioL := TRUe;
BFMA1i010 := 5;
BFMA1Lli1 := BFMA1ollI(1);
BFMA1o1i1 := BFMA1o1OI(BFMA1olLI(3),
BFMA1olLI(2),
BFMA1ollI(4),
Debug);
if BFMA1O1I1 = 0 then
BFMA1I010 := BFMA1LLI1+2-BFMA1lolI;
end if;
IFPrintF((DEbug >= 2),
"BFM:%d:if %08x func %08x",
Fmt(BFMA1o110)&Fmt(BFMA1OLli(2))&FMT(BFMA1olLI(4)));
when BFMA1iLOL =>
BFMA1L1Iol := trUE;
BFMA1I010 := 5;
BFMA1lLI1 := BFMA1oLLI(1);
BFMA1o1i1 := BFMA1o1oi(BFMA1Olli(3),
BFMA1Olli(2),
BFMA1OLLI(4),
dEBUg);
if BFMA1O1i1 /= 0 then
BFMA1I010 := BFMA1Lli1+2-BFMA1Loli;
end if;
IFprinTF((Debug >= 2),
"BFM:%d:ifnot %08x func %08x",
fMT(BFMA1o110)&fMT(BFMA1oLLI(2))&Fmt(BFMA1Olli(4)));
when BFMA1LIol =>
BFMA1L1iol := True;
BFMA1i010 := 2;
BFMA1lli1 := BFMA1olLI(1);
BFMA1i010 := BFMA1lLI1+2-BFMA1Loli;
ifpRINtf((Debug >= 2),
"BFM:%d:else ",
FMt(BFMA1O110));
when BFMA1IIOl =>
BFMA1l1IOL := True;
BFMA1i010 := 2;
iFPRintf((DEbug >= 2),
"BFM:%d:endif ",
fmT(BFMA1O110));
when BFMA1Oiol =>
BFMA1l1ioL := True;
BFMA1I010 := 5;
BFMA1LLI1 := BFMA1olLI(1)+2;
BFMA1O1I1 := BFMA1O1oi(BFMA1olLI(3),
BFMA1OLli(2),
BFMA1Olli(4),
Debug);
if BFMA1O1i1 = 0 then
BFMA1i010 := BFMA1llI1-BFMA1Loli;
end if;
ifPRIntf((DEbug >= 2),
"BFM:%d:while %08x func %08x",
fmT(BFMA1O110)&Fmt(BFMA1oLLI(2))&fMT(BFMA1olLI(4)));
when BFMA1o0oL =>
BFMA1L1iol := TRue;
BFMA1i010 := 2;
BFMA1llI1 := BFMA1oLLI(1);
BFMA1i010 := BFMA1lli1-BFMA1Loli;
IfpriNTF((debUG >= 2),
"BFM:%d:endwhile",
fMT(BFMA1O110));
when BFMA1I0ol =>
BFMA1L1Iol := trUE;
BFMA1I010 := 4;
BFMA1lLI1 := BFMA1olLI(3);
if BFMA1ollI(1) /= BFMA1Olli(2) then
BFMA1I010 := BFMA1llI1-BFMA1loLI;
else
BFMA1lLLOl(BFMA1ILLol) := TRue;
end if;
iFPRintf((Debug >= 2),
"BFM:%d:when %08x=%08x %08x",
fMT(BFMA1O110)&Fmt(BFMA1olLI(1))&fmT(BFMA1OLli(2))&fmt(BFMA1oLLI(3)));
when BFMA1L1ol =>
BFMA1l1IOL := tRUE;
BFMA1I010 := 4;
BFMA1lli1 := BFMA1Olli(3);
if BFMA1lLLOl(BFMA1ILLol) then
BFMA1I010 := BFMA1LLi1-BFMA1lOLI;
else
BFMA1LLLol(BFMA1illOL) := falsE;
end if;
ifpRINtf((debuG >= 2),
"BFM:%d:default %08x=%08x %08x",
fMT(BFMA1o110)&FMt(BFMA1oLLI(1))&Fmt(BFMA1OLli(2))&fmt(BFMA1ollI(3)));
when BFMA1l0oL =>
BFMA1L1iol := True;
BFMA1i010 := 1;
BFMA1iLLOl := BFMA1ilLOL+1;
BFMA1lLLOl(BFMA1ILlol) := falSE;
ifprINTf((dEBUg >= 2),
"BFM:%d:case",
fmT(BFMA1o110));
when BFMA1o1OL =>
BFMA1l1ioL := TRue;
BFMA1I010 := 1;
BFMA1ilLOL := BFMA1iLLOl-1;
ifprINTf((DEbug >= 2),
"BFM:%d:endcase",
Fmt(BFMA1o110));
when BFMA1i0I =>
BFMA1L1iol := tRUE;
BFMA1i010 := 3;
BFMA1LLi1 := BFMA1oLLI(1);
if BFMA1ollI(2) /= 0 then
BFMA1I010 := BFMA1lLI1-BFMA1loli;
end if;
ifpRINtf((DEbug >= 2),
"BFM:%d:jumpnz  %08x",
Fmt(BFMA1o110)&fmT(BFMA1OLli(2)));
when BFMA1lool =>
BFMA1L1Iol := TRue;
BFMA1i010 := 4;
BFMA1LOO1 := BFMA1l100(2);
BFMA1iOO1 := BFMA1l100(3);
BFMA1lOOOl := BFMA1OIOi((BFMA1L100(1) xor BFMA1LOO1) and BFMA1IOo1);
iFPRintF(dEBUg >= 2,
"BFM:%d:compare  %08x==%08x Mask=%08x (RES=%08x) at %t ns",
fmT(BFMA1o110)&Fmt(BFMA1olLI(1))&Fmt(BFMA1loO1)&FMT(BFMA1IOO1)&FMt(BFMA1Loool));
if BFMA1LOool /= 0 then
BFMA1lL01 := BFMA1ll01+1;
prINTf("ERROR:  compare failed %08x==%08x Mask=%08x (RES=%08x) ",
FMt(BFMA1ollI(1))&fmt(BFMA1loO1)&FMt(BFMA1iOO1)&fmT(BFMA1looOL));
prINTf("       Stimulus file %s  Line No %d",
FMt(BFMA1o101(BFMA1oiLI(BFMA1o110,
BFMA1i101)))&FMt(BFMA1Iili(BFMA1O110,
BFMA1I101)));
assert FALse report "BFM Data Compare Error" severity ERRor;
end if;
when BFMA1i1OL =>
BFMA1l1IOL := truE;
BFMA1I010 := 4;
BFMA1loo1 := BFMA1L100(2);
BFMA1IOo1 := BFMA1L100(3);
if BFMA1ollI(1) >= BFMA1olli(2) and BFMA1OLLi(1) <= BFMA1Olli(3) then
BFMA1loooL := 1;
else
BFMA1lOOOl := 0;
end if;
IFprinTF(DEBug >= 2,
"BFM:%d:cmprange %d in %d to %d at %t ns",
FMt(BFMA1o110)&FMT(BFMA1OLli(1))&fMT(BFMA1Olli(2))&FMT(BFMA1olLI(3)));
if BFMA1LOOol = 0 then
BFMA1LL01 := BFMA1LL01+1;
PRIntf("ERROR: cmprange failed %d in %d to %d",
FMt(BFMA1Olli(1))&fmt(BFMA1OLli(2))&fMT(BFMA1OLLi(3)));
PrintF("       Stimulus file %s  Line No %d",
FMT(BFMA1o101(BFMA1OIli(BFMA1O110,
BFMA1i101)))&FMT(BFMA1IILi(BFMA1o110,
BFMA1I101)));
assert falsE report "BFM Data Compare Error" severity ERRor;
end if;
when BFMA1i11 =>
BFMA1L1iol := TRue;
BFMA1I010 := 2;
BFMA1L1Ii := BFMA1OLLi(1);
BFMA1lL10 := BFMA1ll10+BFMA1L1Ii;
BFMA1i100(BFMA1LL10) := 0;
ifPRIntf((dEBUg >= 2),
"BFM:%d:int %d",
Fmt(BFMA1o110)&fmt(BFMA1ollI(1)));
when BFMA1o1i
| BFMA1l1I =>
BFMA1L1iol := tRUE;
if BFMA1iI10 = BFMA1o1I then
BFMA1I010 := 2;
BFMA1l1ii := 0;
else
BFMA1L1ii := BFMA1OLLi(2);
BFMA1i010 := 3+BFMA1L1ii;
end if;
BFMA1LOi1 := BFMA1ollI(1);
BFMA1IOi1 := BFMA1loLI+BFMA1I010;
BFMA1I010 := BFMA1LOI1-BFMA1lOLI;
BFMA1I100(BFMA1ll10) := BFMA1iOI1;
BFMA1LL10 := BFMA1LL10+1;
if BFMA1l1ii > 0 then
for BFMA1i0iI in 0 to BFMA1l1iI-1
loop
BFMA1i100(BFMA1ll10) := BFMA1Olli(3+BFMA1i0iI);
BFMA1lL10 := BFMA1lL10+1;
end loop;
end if;
IFprinTF((deBUG >= 2 and BFMA1Ii10 = BFMA1o1i),
"BFM:%d:call %d",
FMt(BFMA1O110)&fmt(BFMA1loI1));
iFPRintf((Debug >= 2 and BFMA1II10 = BFMA1l1i),
"BFM:%d:call %d %08x ... ",
fMT(BFMA1O110)&fMT(BFMA1loi1)&Fmt(BFMA1OLLi(3)));
when BFMA1i1I =>
BFMA1L1iol := true;
BFMA1I010 := 2;
BFMA1LL10 := BFMA1LL10-BFMA1OLLI(1);
BFMA1IOI1 := 0;
if BFMA1lL10 > 0 then
BFMA1LL10 := BFMA1ll10-1;
BFMA1ioi1 := BFMA1i100(BFMA1LL10);
end if;
if BFMA1IOi1 = 0 then
BFMA1L0L1 := TRue;
BFMA1O0o1 := True;
BFMA1l1ioL := faLSE;
else
BFMA1i010 := BFMA1Ioi1-BFMA1Loli;
end if;
IfpriNTF((dEBUg >= 2),
"BFM:%d:return",
fMT(BFMA1O110));
when BFMA1ooLL =>
BFMA1l1IOL := true;
BFMA1i010 := 3;
BFMA1Ll10 := BFMA1Ll10-BFMA1OLli(1);
BFMA1IOi1 := 0;
if BFMA1ll10 > 0 then
BFMA1ll10 := BFMA1Ll10-1;
BFMA1IOi1 := BFMA1I100(BFMA1ll10);
end if;
BFMA1Oli1 := BFMA1OLli(2);
if BFMA1ioi1 = 0 then
BFMA1L0l1 := trUE;
BFMA1O0o1 := true;
BFMA1l1IOL := FAlse;
else
BFMA1i010 := BFMA1ioi1-BFMA1lolI;
end if;
iFPRintF((debuG >= 2),
"BFM:%d:return %08x",
fmt(BFMA1o110)&FMt(BFMA1OLi1));
when BFMA1oo0 =>
BFMA1l1ioL := TRUe;
BFMA1I010 := 5;
BFMA1i0I1 := BFMA1l10Ol(BFMA1IOLi(BFMA1LOLi+1));
BFMA1o1I1 := BFMA1OLli(2);
BFMA1I100(BFMA1i0i1) := BFMA1O1I1;
ifpRINtf(Debug >= 2,
"BFM:%d:loop %d %d %d %d ",
Fmt(BFMA1o110)&FMt(BFMA1I0i1)&Fmt(BFMA1OLLi(2))&FMT(BFMA1OLli(3))&FMt(BFMA1OLli(4)));
when BFMA1lo0 =>
BFMA1l1ioL := trUE;
BFMA1I010 := 2;
BFMA1IO10 := BFMA1Olli(1);
for BFMA1I0ii in 2 to 4
loop
BFMA1oo10(BFMA1i0iI) := BFMA1il0OL((To_sLV32(BFMA1IOli(BFMA1IO10))(7+BFMA1I0Ii) = '1'),
BFMA1ioLI(BFMA1IO10+BFMA1I0Ii));
end loop;
BFMA1I0i1 := BFMA1l10ol(BFMA1Ioli(BFMA1Io10+1));
BFMA1OO0i := BFMA1oo10(4);
BFMA1ll0I := BFMA1OO10(3);
BFMA1Il10 := BFMA1I100(BFMA1i0I1);
BFMA1il10 := BFMA1il10+BFMA1oO0I;
BFMA1i100(BFMA1I0i1) := BFMA1Il10;
BFMA1lLI1 := BFMA1IO10+5;
if ((BFMA1OO0i >= 0 and BFMA1IL10 <= BFMA1LL0i) or (BFMA1oO0I < 0 and BFMA1il10 >= BFMA1LL0i)) then
BFMA1i010 := BFMA1lLI1-BFMA1LOLi;
IFPrintF(DEbug >= 2,
"BFM:%d:endloop (Next Loop=%d)",
fmt(BFMA1o110)&fmt(BFMA1iL10));
else
iFPRintF(Debug >= 2,
"BFM:%d:endloop (Finished)",
fmT(BFMA1o110));
end if;
when BFMA1il0 =>
BFMA1L1ioL := tRUE;
BFMA1I010 := 2;
BFMA1L110 := BFMA1OLLi(1);
iFPRintF(debuG >= 2,
"BFM:%d:timeout %d",
FMt(BFMA1O110)&fmt(BFMA1L110));
when BFMA1O01 =>
BFMA1L1Iol := tRUE;
BFMA1i010 := 2;
BFMA1LLOol := BFMA1OLli(1);
IFprinTF(debuG >= 2,
"BFM:%d:rand %d",
Fmt(BFMA1o110)&fmt(BFMA1LLOol));
when BFMA1ii0 =>
BFMA1l1IOL := TRUe;
BFMA1I010 := BFMA1LLLi(BFMA1ollI(1));
BFMA1Io0i := BFMA1oOLI(BFMA1loli,
BFMA1ioli(BFMA1Loli to BFMA1Loli+BFMA1I010-1),
BFMA1OLLi);
priNTF("BFM:%s",
FMT(BFMA1iO0I));
when BFMA1o00 =>
BFMA1L1Iol := trUE;
BFMA1i010 := BFMA1lLLI(BFMA1olLI(1));
BFMA1Io0i := BFMA1OOLi(BFMA1LOLi,
BFMA1ioli(BFMA1LOLi to BFMA1LOli+BFMA1i010-1),
BFMA1olli);
PRintf("################################################################");
PRintf("BFM:%s",
fmT(BFMA1IO0i));
when BFMA1l =>
BFMA1I010 := 1;
ifPRIntf((DEBug >= 2),
"BFM:%d:nop",
Fmt(BFMA1o110));
when BFMA1L00 =>
BFMA1l1ioL := trUE;
BFMA1I010 := BFMA1lLLI(BFMA1OLLi(1));
when BFMA1OO1 =>
BFMA1L1Iol := True;
BFMA1I010 := 2;
if debuGLEvel >= 0 and deBUGlevEL <= 5 then
prinTF("BFM:%d: DEBUG - ignored due to DEBUGLEVEL generic setting",
fMT(BFMA1o110));
else
Debug <= BFMA1ollI(1);
PRintf("BFM:%d: DEBUG %d",
fmt(BFMA1O110)&fmt(BFMA1OLli(1)));
end if;
when BFMA1lOI =>
BFMA1l1iOL := FAlse;
BFMA1i010 := 2;
BFMA1LIi1 := BFMA1olLI(1);
BFMA1iL01(1) := NUL;
if BFMA1liI1 = 2 then
if BFMA1IO01 then
BFMA1iL01(1 to 9) := "OCCURRED"&Nul;
else
assert fALSe report "BFM: HRESP Did Not Occur When Expected" severity errOR;
BFMA1LL01 := BFMA1ll01+1;
end if;
BFMA1LII1 := 0;
end if;
BFMA1iO01 := FALse;
IfprINTF(DebuG >= 2,
"BFM:%d:hresp %d %s",
fmt(BFMA1O110)&fmt(BFMA1LIi1)&FMt(BFMA1il01));
when BFMA1OL0 =>
BFMA1L1Iol := True;
BFMA1I010 := 2;
IfpriNTF(debUG >= 2,
"BFM:%d:stop %d",
fmt(BFMA1O110)&fmt(BFMA1Olli(1)));
PRIntf("       Stimulus file %s  Line No %d",
fMT(BFMA1o101(BFMA1oili(BFMA1O110,
BFMA1i101)))&fmT(BFMA1iiLI(BFMA1o110,
BFMA1I101)));
case BFMA1OLli(1) is
when 0 =>
assert FAlse report "BFM Script Stop Command" severity note;
when 1 =>
assert faLSE report "BFM Script Stop Command" severity WarnING;
when 3 =>
assert FAlse report "BFM Script Stop Command" severity FailuRE;
when others =>
assert FalsE report "BFM Script Stop Command" severity erroR;
end case;
when BFMA1lL0 =>
BFMA1L0l1 := true;
when BFMA1iiLL =>
BFMA1L1iol := True;
ifpRINtf(deBUG >= 1,
"BFM:%d:echo at %t ns",
Fmt(BFMA1o110));
BFMA1i010 := 2+BFMA1OLli(1);
prinTF("BFM Parameter values are");
for BFMA1i0ii in 0 to BFMA1I010-3
loop
PRintf(" Para %d=0x%08x (%d)",
fmt(BFMA1I0ii+1)&fmt(BFMA1L100(2+BFMA1I0ii))&FMt(BFMA1olLI(2+BFMA1I0Ii)));
end loop;
when BFMA1li0 =>
BFMA1i010 := 2;
BFMA1I1o1 := BFMA1OLLi(1);
IFprinTF(DEBug >= 2,
"BFM:%d:flush %d at %t ns",
fMT(BFMA1O110)&fmT(BFMA1i1O1));
BFMA1O0o1 := true;
BFMA1OLo1 := true;
when BFMA1OI1 =>
BFMA1l1IOL := TRUe;
BFMA1LL01 := BFMA1Ll01+1;
IFpriNTF(debUG >= 2,
"BFM:%d:setfail",
FMT(BFMA1O110));
assert False report "BFM: User Script detected ERROR" severity erROR;
when BFMA1o11 =>
BFMA1l1IOL := truE;
BFMA1I010 := 3;
BFMA1I0i1 := BFMA1l10OL(BFMA1iOLI(BFMA1Loli+1));
BFMA1O1I1 := BFMA1OLLi(2);
BFMA1i100(BFMA1I0i1) := BFMA1O1i1;
ifPRIntf(debuG >= 2,
"BFM:%d:set %d= 0x%08x (%d)",
FMt(BFMA1o110)&fMT(BFMA1i0I1)&fMT(BFMA1O1I1)&fmT(BFMA1o1I1));
when BFMA1OOOl =>
BFMA1L1iol := tRUE;
BFMA1I010 := BFMA1OLLi(2)+3;
BFMA1I0i1 := BFMA1l10OL(BFMA1IOli(BFMA1Loli+1));
BFMA1O1I1 := BFMA1o1oI(BFMA1oLLI(4),
BFMA1OLLi(3),
BFMA1ollI(5),
DEbug);
BFMA1I0Ii := 6;
while (BFMA1I0Ii < BFMA1i010)
loop
BFMA1O1i1 := BFMA1O1oi(BFMA1OLLi(BFMA1I0ii),
BFMA1O1I1,
BFMA1oLLI(BFMA1i0iI+1),
DEbug);
BFMA1i0II := BFMA1i0II+2;
end loop;
BFMA1I100(BFMA1I0i1) := BFMA1o1I1;
ifprINTf(DebuG >= 2,
"BFM:%d:set %d= 0x%08x (%d)",
FMT(BFMA1o110)&Fmt(BFMA1I0I1)&fmT(BFMA1O1I1)&FMt(BFMA1o1i1));
when BFMA1ILll =>
BFMA1L1Iol := TRUe;
BFMA1I1L1 := BFMA1l010;
BFMA1I010 := BFMA1lllI(BFMA1oLLI(1));
if BFMA1OLl1(1) /= Nul then
FILe_cLOSe(BFMA1il00);
end if;
BFMA1Oll1 := BFMA1oolI(BFMA1lOLI,
BFMA1ioLI(BFMA1lolI to BFMA1lolI+BFMA1I010-1),
BFMA1ollI);
prINTf("BFM:%d:LOGFILE %s",
fmt(BFMA1O110)&FMt(BFMA1oLL1));
if BFMA1OLL1(1) /= nul then
File_OPEn(BFMA1I000,
BFMA1IL00,
BFMA1OLL1,
wriTE_modE);
if BFMA1I000 = oPEN_ok then
else
assert FALse report "Logfile open FAILED" severity faiLURe;
end if;
end if;
when BFMA1oilL =>
BFMA1L1iol := True;
BFMA1i010 := 2;
PrintF("BFM:%d:LOGSTART %d",
FMt(BFMA1o110)&FMt(BFMA1OLLi(1)));
if BFMA1oll1(1) = nul then
assert FAlse report "Logfile not defined, ignoring command" severity eRROr;
else
BFMA1I011 := (BFMA1l100(1)(0) = '1');
BFMA1o111 := (BFMA1L100(1)(1) = '1');
BFMA1L111 := (BFMA1l100(1)(2) = '1');
BFMA1I111 := (BFMA1L100(1)(3) = '1');
end if;
when BFMA1lill =>
BFMA1l1IOl := true;
BFMA1I010 := 1;
priNTF("BFM:%d:LOGSTOP",
fmt(BFMA1O110));
BFMA1I011 := FAlse;
BFMA1O111 := FALse;
BFMA1L111 := FALSe;
BFMA1I111 := falSE;
when BFMA1llLL =>
BFMA1l1IOL := TRUe;
BFMA1i010 := 1;
PRintf("BFM:%d:VERSION",
Fmt(BFMA1O110));
PrintF("  BFM VHDL Version %s",
FMT(BFMA1oo1I));
priNTF("  BFM Date %s",
fMT(BFMA1lo1I));
prinTF("  SVN Revision $Revision: 11878 $");
PRIntf("  SVN Date $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $");
PRintf("  Compiler Version %d",
Fmt(BFMA1oOOOl));
PRINtf("  Vectors Version %d",
fmt(BFMA1IOool));
pRINtf("  No of Vectors %d",
Fmt(BFMA1LO10));
if BFMA1oll1(1) /= Nul then
sPRIntf(BFMA1ioL1,
"%05t VR %s %s %d %d %d",
Fmt(BFMA1oO1I)&fmT(BFMA1LO1i)&fMT(BFMA1OOOol)&FMt(BFMA1ioooL)&fMT(BFMA1lO10));
wrITE(L,
BFMA1iOL1);
WRitelINE(BFMA1IL00,
L);
end if;
when others =>
pRINtf("BFM: Instruction %d Line Number %d Command %d",
Fmt(BFMA1loLI)&Fmt(BFMA1o110)&FMt(BFMA1II10));
prinTF("       Stimulus file %s  Line No %d",
fmt(BFMA1O101(BFMA1OILi(BFMA1O110,
BFMA1I101)))&Fmt(BFMA1IIli(BFMA1o110,
BFMA1i101)));
assert FALse report "Instruction not yet implemented" severity ERror;
end case;
end if;
if BFMA1l1IOl then
BFMA1O1O1 := falsE;
BFMA1LOLi := BFMA1lolI+BFMA1i010;
BFMA1I010 := 0;
end if;
end loop;
BFMA1i1I1 := fALSe;
BFMA1oo01 := FALse;
BFMA1LO01 := fALSe;
if BFMA1oLO0 = '1' then
EXp := BFMA1I0o0 and BFMA1O1o0;
BFMA1l1i1 := HrdatA and BFMA1O1o0;
BFMA1I1I1 := (eXP = BFMA1L1i1);
end if;
if BFMA1o0L0 = '1' then
Exp := BFMA1lll0 and BFMA1iLL0;
BFMA1L1I1 := BFMA1O1L0 and BFMA1ILL0;
BFMA1OO01 := (exp = BFMA1l1i1);
end if;
if BFMA1L0l0 = '1' then
eXP := BFMA1I1o0 and BFMA1OOl0;
BFMA1L1I1 := GP_in and BFMA1ool0;
BFMA1LO01 := (exp = BFMA1l1i1);
end if;
BFMA1L001 := BFMA1lLO1 or BFMA1liO1
or BFMA1ilo1
or BFMA1oIO1
or BFMA1iIO1
or BFMA1l0O1
or BFMA1i0o1
or To_boOLEan(BFMA1OLO0 or BFMA1IOo0
or BFMA1lOO0
or BFMA1ooo0
or BFMA1Iil0
or BFMA1o0L0
or BFMA1l0L0);
if BFMA1OLO1 then
case BFMA1o010 is
when BFMA1LI0 =>
if not BFMA1l001 then
if BFMA1I1o1 <= 1 then
BFMA1OLo1 := FALse;
else
BFMA1i1o1 := BFMA1i1o1-1;
end if;
end if;
when BFMA1IO0 =>
if BFMA1I1O1 <= 1 then
BFMA1Olo1 := faLSE;
else
BFMA1i1O1 := BFMA1I1o1-1;
end if;
when BFMA1lOLL
| BFMA1Ioll =>
if (nOW/1 NS) >= BFMA1oloOL then
BFMA1olO1 := fALSe;
end if;
when BFMA1ooi
| BFMA1i1l
| BFMA1l1l =>
if BFMA1Ooi1 = 256 then
BFMA1Ii11 := (InterRUPT /= BFMA1iO00);
else
BFMA1ii11 := (intERRupt(BFMA1OOI1) = '1');
end if;
if BFMA1Ii11 then
ifPRIntf((Debug >= 2),
"BFM:Interrupt Wait Time %d cycles",
FMT(BFMA1o0I1));
BFMA1oLO1 := fALSe;
end if;
when BFMA1ioi =>
BFMA1I1l0 <= BFMA1OOO1;
BFMA1L1L0 <= BFMA1Loo1;
BFMA1lil0 <= '1';
BFMA1oLO1 := faLSE;
when BFMA1LII =>
BFMA1I1L0 <= to_sLV32(BFMA1lLL1+BFMA1Oil1);
BFMA1l1l0 <= TO_slv32(BFMA1IIl1(BFMA1OIL1));
BFMA1liL0 <= '1';
BFMA1OIL1 := BFMA1oIL1+1;
if BFMA1oil1 >= BFMA1ilL1 then
BFMA1OLo1 := FAlse;
end if;
when BFMA1olI
| BFMA1Lli
| BFMA1ILi =>
BFMA1I1l0 <= BFMA1OOO1;
BFMA1i1O0 <= BFMA1loO1;
BFMA1ool0 <= BFMA1IOo1;
BFMA1loL0 <= BFMA1o110;
BFMA1iol0 <= '1';
if BFMA1o0L0 = '1' then
BFMA1olO1 := fALSe;
end if;
when BFMA1oiI =>
if EXT_waIT = '0' and BFMA1I1o1 = 0 then
IfpriNTF((DEbug >= 2),
"BFM:Exteral Wait Time %d cycles",
FMt(BFMA1O0i1));
BFMA1oLO1 := falsE;
end if;
if BFMA1i1O1 >= 1 then
BFMA1I1o1 := BFMA1I1O1-1;
end if;
when BFMA1O0l
| BFMA1L0L
| BFMA1LOl
| BFMA1IIL =>
BFMA1IOl0 <= '1';
BFMA1i1o0 <= BFMA1loo1;
BFMA1OOl0 <= BFMA1iOO1;
BFMA1Lol0 <= BFMA1o110;
BFMA1OLo1 := falSE;
when BFMA1IOL =>
BFMA1i1O0 <= BFMA1loo1;
BFMA1ool0 <= BFMA1Ioo1;
BFMA1lol0 <= BFMA1o110;
BFMA1l0L0 <= '1';
BFMA1IOL0 <= '0';
if BFMA1L0l0 = '1' and BFMA1LO01 then
BFMA1L0l0 <= '0';
BFMA1oLO1 := False;
ifprINTf((deBUG >= 2),
"BFM:GP IO Wait Time %d cycles",
fmt(BFMA1O0i1));
end if;
when BFMA1I00
| BFMA1o10 =>
case BFMA1olIOL is
when BFMA1iiLOL =>
BFMA1OLO1 := faLSE;
when BFMA1o0LOL =>
BFMA1liIOL := BFMA1olLI(1)+BFMA1OLLi(2);
BFMA1iiIOL := 0;
BFMA1i1LOL := BFMA1oLLI(3);
BFMA1Ooiol := BFMA1OLLI(4) mod 65536;
BFMA1oO0Ol := (BFMA1L100(4)(16) = '1');
BFMA1lo0OL := (BFMA1l100(4)(17) = '1');
BFMA1io0OL := (BFMA1L100(4)(18) = '1');
BFMA1loIOL := BFMA1olli(5);
BFMA1Ioiol := BFMA1Olli(6);
if not BFMA1IO0ol then
BFMA1LlioL := ( others => 0);
end if;
BFMA1l0iOL := 0;
BFMA1I0iol := 0;
BFMA1o1IOl := 0;
BFMA1ol0OL := 0;
BFMA1I1Iol := faLSE;
if BFMA1o010 = BFMA1o10 then
BFMA1lIIOl := BFMA1oLLI(1);
BFMA1IIiol := BFMA1olLI(2)-BFMA1I1Lol;
BFMA1i1Lol := 2*BFMA1I1lol;
BFMA1i1IOL := TRUe;
end if;
if not BFMA1I1iol then
PRIntf("BFM:%d: memtest Started at %t ns",
FMT(BFMA1O110));
PRintf("BFM:  Address %08x Size %d Cycles %5d",
FMT(BFMA1LIiol)&fmt(BFMA1i1LOL)&Fmt(BFMA1loIOL));
else
PRintf("BFM:%d: dual memtest Started at %t ns",
FMt(BFMA1o110));
PrintF("BFM:  Address %08x & %08x Size %d Cycles %5d",
fmt(BFMA1LIIol)&FMt(BFMA1iiiOL+BFMA1I1lol/2)&Fmt(BFMA1I1lol/2)&fmt(BFMA1LOIol));
end if;
case BFMA1OOIol is
when 0 =>
when 1 =>
prinTF("BFM: Transfers are APB Byte aligned");
when 2 =>
prinTF("BFM: Transfers are APB Half Word aligned");
when 3 =>
priNTF("BFM: Transfers are APB Word aligned");
when 4 =>
pRINtf("BFM: Byte Writes Suppressed");
when others =>
assert FalsE report "Illegal Align on memtest" severity FAilurE;
end case;
if BFMA1IO0ol then
priNTF("BFM: memtest restarted");
end if;
if BFMA1oo0OL then
prinTF("BFM: Memtest Filling Memory");
BFMA1OLiol := BFMA1I0lol;
elsif BFMA1loiOL > 0 then
prINTf("BFM: Memtest Random Read Writes");
BFMA1oliOL := actIVE;
elsif BFMA1LO0ol then
pRINtf("BFM: Memtest Verifying Memory Content");
BFMA1OlioL := BFMA1O1lol;
else
BFMA1OLIol := BFMA1L0Lol;
end if;
when aCTIve
| BFMA1i0LOL
| BFMA1o1loL =>
if not (BFMA1LIo1 or BFMA1Llo1) then
case BFMA1OlioL is
when ACtivE =>
BFMA1IOiol := BFMA1o0LI(BFMA1IOiol);
BFMA1IlioL := BFMA1I0li(BFMA1IoioL,
BFMA1I1lol);
BFMA1IOiol := BFMA1o0li(BFMA1iOIOl);
BFMA1OIIol := BFMA1I0Li(BFMA1Ioiol,
8);
when BFMA1I0lol =>
BFMA1ilIOL := BFMA1oL0Ol;
BFMA1OIiol := 6;
when BFMA1o1LOl =>
BFMA1iLIOl := BFMA1Ol0ol;
BFMA1oiIOL := 2;
when others =>
end case;
case BFMA1oOIOl is
when 0 =>
when 1 =>
BFMA1iliOL := 4*(BFMA1ilioL/4);
case BFMA1OIIol is
when 0
| 4 =>
BFMA1OIiol := BFMA1oiiOL;
when 1
| 5 =>
BFMA1oiioL := BFMA1OIIOl-1;
when 2
| 6 =>
BFMA1OIIol := BFMA1OIIol-2;
when others =>
end case;
when 2 =>
BFMA1IlioL := 4*(BFMA1ILIol/4);
case BFMA1OIiol is
when 0
| 4 =>
BFMA1OIIol := BFMA1oIIOl+1;
when 1
| 5 =>
BFMA1OIiol := BFMA1OIIol;
when 2
| 6 =>
BFMA1OIIol := BFMA1OIIol-1;
when others =>
end case;
when 3 =>
BFMA1iliOL := 4*(BFMA1ILIol/4);
case BFMA1Oiiol is
when 0
| 4 =>
BFMA1OIIol := BFMA1OIiol+2;
when 1
| 5 =>
BFMA1oIIOl := BFMA1oiioL+1;
when 2
| 6 =>
BFMA1oIIOl := BFMA1oIIOl;
when others =>
end case;
when 4 =>
case BFMA1OIIol is
when 4 =>
BFMA1iLIOl := 2*(BFMA1iLIOl/2);
BFMA1oiIOL := 5;
when others =>
end case;
when others =>
end case;
if BFMA1Oiiol >= 0 and BFMA1OIiol <= 2 then
case BFMA1oiioL is
when 0 =>
BFMA1I110 := "000";
BFMA1ILiol := BFMA1iliOL;
BFMA1O0Iol := (BFMA1LLiol(BFMA1iLIOl+0) >= 256);
when 1 =>
BFMA1I110 := "001";
BFMA1ilIOL := 2*(BFMA1ILIOl/2);
BFMA1o0IOl := ((BFMA1lliOL(BFMA1ILIol+0) >= 256) and (BFMA1LlioL(BFMA1ILIol+1) >= 256));
when 2 =>
BFMA1I110 := "010";
BFMA1ILiol := 4*(BFMA1IlioL/4);
BFMA1O0iol := ((BFMA1lLIOl(BFMA1iliOL+0) >= 256) and (BFMA1lLIOl(BFMA1iliOL+1) >= 256)
and (BFMA1lliOL(BFMA1ILiol+2) >= 256)
and (BFMA1lLIOL(BFMA1ILiol+3) >= 256));
when others =>
end case;
if BFMA1O0iol then
BFMA1llO1 := trUE;
BFMA1l0IOL := BFMA1L0Iol+1;
if BFMA1I1Iol and BFMA1iliOL >= BFMA1I1lol/2 then
BFMA1OOO1 := To_slV32(BFMA1iiioL+BFMA1iliOL);
else
BFMA1oOO1 := TO_slv32(BFMA1Liiol+BFMA1ILIOl);
end if;
case BFMA1oiIOL is
when 0 =>
BFMA1LOO1 := BFMA1lO00(31 downto 8)&to_SLV32(BFMA1LLIol(BFMA1iLIOl+0))(7 downto 0);
when 1 =>
BFMA1Loo1 := BFMA1lO00(31 downto 16)&TO_slv32(BFMA1llioL(BFMA1iLIOl+1))(7 downto 0)&to_SLV32(BFMA1llIOL(BFMA1iliOL+0))(7 downto 0);
when 2 =>
BFMA1loo1 := to_sLV32(BFMA1llioL(BFMA1ILIol+3))(7 downto 0)&tO_slv32(BFMA1LLIol(BFMA1iLIOl+2))(7 downto 0)&TO_slv32(BFMA1lliOL(BFMA1ILiol+1))(7 downto 0)&To_slV32(BFMA1lliOL(BFMA1ILiol+0))(7 downto 0);
when others =>
BFMA1Loo1 := BFMA1LO00(31 downto 0);
end case;
BFMA1ioO1 := ( others => '1');
else
BFMA1OIIol := BFMA1OIIol+4;
if BFMA1oiIOL = 4 and BFMA1ooIOL = 4 then
BFMA1oIIOl := 5;
end if;
end if;
end if;
if BFMA1oIIOl >= 4 and BFMA1oiIOL <= 6 then
BFMA1LIO1 := TRUe;
BFMA1i0iOL := BFMA1I0Iol+1;
BFMA1iOIOl := BFMA1O0li(BFMA1IOIol);
BFMA1loO1 := to_SLv32(BFMA1ioiOL);
case BFMA1OIIOl is
when 4 =>
BFMA1i110 := "000";
BFMA1Iliol := BFMA1ilIOL;
BFMA1llIOL(BFMA1IlioL+0) := 256+tO_Int_UNSignED(BFMA1LOo1(7 downto 0));
when 5 =>
BFMA1I110 := "001";
BFMA1ILiol := 2*(BFMA1ILIol/2);
BFMA1llioL(BFMA1iliOL+0) := 256+To_iNT_unsIGNed(BFMA1loo1(7 downto 0));
BFMA1LLiol(BFMA1ILIol+1) := 256+To_inT_UnsiGNEd(BFMA1LOo1(15 downto 8));
when 6 =>
BFMA1I110 := "010";
BFMA1Iliol := 4*(BFMA1Iliol/4);
BFMA1LLIol(BFMA1ilIOL+0) := 256+TO_int_UnsigNEd(BFMA1LOO1(7 downto 0));
BFMA1llIOL(BFMA1ILIOl+1) := 256+TO_int_UNsigNED(BFMA1Loo1(15 downto 8));
BFMA1LLIol(BFMA1ilIOL+2) := 256+To_iNT_unsIGNed(BFMA1loo1(23 downto 16));
BFMA1LLIol(BFMA1ilIOL+3) := 256+TO_int_UNsigNED(BFMA1LOO1(31 downto 24));
when others =>
end case;
if BFMA1I1Iol and BFMA1ILiol >= BFMA1I1Lol/2 then
BFMA1OOO1 := TO_slv32(BFMA1IiioL+BFMA1iLIOl);
else
BFMA1OOO1 := To_slV32(BFMA1LIIol+BFMA1ILiol);
end if;
end if;
if BFMA1Oiiol = 3 or BFMA1OIiol = 7 then
BFMA1o1IOL := BFMA1O1Iol+1;
end if;
BFMA1OL0ol := BFMA1OL0ol+4;
case BFMA1olIOL is
when acTIVe =>
if BFMA1lOIOl > 0 then
BFMA1LOIol := BFMA1LOIol-1;
elsif BFMA1LO0ol then
BFMA1ol0OL := 0;
BFMA1oLIOL := BFMA1O1Lol;
priNTF("BFM: Memtest Verifying Memory Content");
else
BFMA1OLIol := BFMA1L0Lol;
end if;
when BFMA1I0lol =>
if BFMA1ol0OL >= BFMA1i1LOL then
if BFMA1LOiol = 0 then
if BFMA1Lo0ol then
BFMA1OL0ol := 0;
BFMA1oLIOl := BFMA1o1LOl;
priNTF("BFM: Memtest Verifying Memory Content");
else
BFMA1oLIOl := BFMA1L0lol;
end if;
else
BFMA1OLIOl := actiVE;
prinTF("BFM: Memtest Random Read Writes");
end if;
end if;
when BFMA1O1lol =>
if BFMA1Ol0ol >= BFMA1i1LOL then
BFMA1olioL := BFMA1L0lol;
end if;
when others =>
end case;
BFMA1lOL1 := BFMA1L110;
end if;
when BFMA1L0Lol =>
if not BFMA1l001 then
BFMA1OLIOl := BFMA1iILOl;
PRIntf("BFM: bfmtest complete  Writes %d  Reads %d  Nops %d",
Fmt(BFMA1I0iol)&fmt(BFMA1L0Iol)&fMT(BFMA1O1iol));
end if;
end case;
when others =>
end case;
end if;
if BFMA1o011 = 0 then
BFMA1l011 := FAlse;
BFMA1o011 := BFMA1Io11;
else
BFMA1O011 := BFMA1o011-1;
BFMA1l011 := truE;
end if;
if HReady = '1' then
BFMA1LI1i <= "00";
BFMA1ii1I <= '0';
BFMA1Loo0 <= '0';
BFMA1ioo0 <= '0';
BFMA1llo0 <= '0';
if BFMA1Loo0 = '1' or BFMA1ioO0 = '1' then
BFMA1OIO0 <= '0';
end if;
if BFMA1Lio1 and HREady = '1' then
BFMA1l01I <= BFMA1ooO1;
BFMA1Ii1i <= '1';
BFMA1Ll1i <= BFMA1iI01;
BFMA1li1I <= "10";
BFMA1IL1i <= BFMA1OI01;
BFMA1OI1i <= BFMA1li01;
BFMA1o11I <= BFMA1I110;
BFMA1l0o0 <= BFMA1L11l(BFMA1i110,
BFMA1OOO1(1 downto 0),
BFMA1loO1,
BFMA1Il11);
BFMA1loo0 <= '1';
BFMA1ILI0 <= BFMA1O110;
BFMA1liO1 := FAlse;
end if;
if BFMA1lLO1 and hREADy = '1' then
BFMA1l01i <= BFMA1OOO1;
BFMA1ii1i <= '0';
BFMA1LL1i <= BFMA1II01;
BFMA1LI1i <= "10";
BFMA1iL1I <= BFMA1oI01;
BFMA1Oi1i <= BFMA1li01;
BFMA1O11i <= BFMA1i110;
BFMA1Iio0 <= BFMA1L11l(BFMA1I110,
BFMA1Ooo1(1 downto 0),
BFMA1LOo1,
BFMA1IL11);
BFMA1o0o0 <= BFMA1IOoi(BFMA1i110,
BFMA1oOO1(1 downto 0),
BFMA1Ioo1,
BFMA1iL11);
BFMA1Ili0 <= BFMA1o110;
BFMA1IOO0 <= '1';
BFMA1OIO0 <= '1';
BFMA1LLo1 := falSE;
end if;
if BFMA1l0O1 and hrEADy = '1' then
BFMA1L01i <= BFMA1ooo1;
BFMA1II1i <= BFMA1LIOol;
BFMA1lL1I <= BFMA1O0Ool;
BFMA1li1I <= BFMA1iIOOl;
BFMA1IL1i <= BFMA1L0ool;
BFMA1OI1i <= BFMA1I0ool;
BFMA1O11i <= BFMA1I110;
BFMA1L0o0 <= BFMA1l11L(BFMA1I110,
BFMA1OOO1(1 downto 0),
BFMA1Loo1,
BFMA1iL11);
BFMA1loo0 <= '1';
BFMA1Ili0 <= BFMA1o110;
BFMA1L0o1 := falsE;
end if;
if BFMA1iio1 and HreadY = '1' then
BFMA1l01I <= BFMA1ooo1;
BFMA1II1i <= '0';
BFMA1LL1i <= BFMA1Ii01;
BFMA1IL1i <= BFMA1OI01;
BFMA1OI1i <= BFMA1li01;
BFMA1o11I <= BFMA1I110;
BFMA1IIO0 <= BFMA1L11l(BFMA1I110,
BFMA1oOO1(1 downto 0),
BFMA1loo1,
BFMA1IL11);
BFMA1o0O0 <= BFMA1iooI(BFMA1I110,
BFMA1ooo1(1 downto 0),
BFMA1ioo1,
BFMA1il11);
BFMA1ili0 <= BFMA1O110;
if BFMA1ioo0 = '1' or BFMA1OLO0 = '1' then
BFMA1LI1i <= "00";
else
BFMA1LI1i <= "10";
BFMA1Ioo0 <= '1';
BFMA1LLo0 <= '1';
end if;
if BFMA1ilo0 = '1' and BFMA1i1i1 then
BFMA1IIo1 := FAlse;
end if;
end if;
if BFMA1ILo1 and HReady = '1' then
BFMA1L01i <= BFMA1OOO1;
BFMA1II1i <= '1';
BFMA1LL1i <= BFMA1II01;
BFMA1Il1i <= BFMA1oi01;
BFMA1oI1I <= BFMA1lI01;
BFMA1o11I <= BFMA1i110;
BFMA1Ili0 <= BFMA1o110;
if BFMA1L011 then
BFMA1LI1i <= "01";
else
BFMA1l0O0 <= BFMA1L11l(BFMA1i110,
BFMA1oOO1(1 downto 0),
TO_slV32(BFMA1iil1(BFMA1oiL1)),
BFMA1IL11);
BFMA1Loo0 <= '1';
if BFMA1oil1 = 0 or BFMA1lI10 = 3
or BOund1K(BFMA1ll11,
BFMA1oOO1) then
BFMA1li1I <= "10";
else
BFMA1LI1i <= "11";
end if;
BFMA1ooo1 := TO_std_LOgic(to_UNsignED(BFMA1ooo1)+BFMA1lIL1);
BFMA1oil1 := BFMA1OIL1+1;
if BFMA1OIl1 = BFMA1ILL1 then
BFMA1ilo1 := FAlse;
end if;
end if;
end if;
if BFMA1oio1 and hreADY = '1' then
BFMA1l01I <= BFMA1oOO1;
BFMA1II1i <= '0';
BFMA1Ll1i <= BFMA1II01;
BFMA1IL1i <= BFMA1OI01;
BFMA1oI1I <= BFMA1li01;
BFMA1o11I <= BFMA1I110;
BFMA1ILI0 <= BFMA1o110;
if BFMA1l011 then
BFMA1LI1i <= "01";
else
BFMA1Iio0 <= BFMA1L11l(BFMA1I110,
BFMA1OOo1(1 downto 0),
to_sLV32(BFMA1IIL1(BFMA1oil1)),
BFMA1il11);
BFMA1O0o0 <= BFMA1ioOI(BFMA1i110,
BFMA1OOO1(1 downto 0),
BFMA1ioo1,
BFMA1il11);
BFMA1IOO0 <= '1';
BFMA1oIO0 <= '1';
if BFMA1oIL1 = 0 or BFMA1LI10 = 3
or boUND1k(BFMA1LL11,
BFMA1ooO1) then
BFMA1lI1I <= "10";
else
BFMA1li1i <= "11";
end if;
BFMA1OOo1 := TO_std_LOgic(tO_UnsiGNEd(BFMA1ooo1)+BFMA1lIL1);
BFMA1OIl1 := BFMA1oIL1+1;
if BFMA1oIL1 = BFMA1ilL1 then
BFMA1oIO1 := FALse;
end if;
end if;
end if;
end if;
if hreADY = '1' then
BFMA1OOO0 <= BFMA1lOO0;
BFMA1olO0 <= BFMA1IOo0;
BFMA1iLO0 <= BFMA1llo0;
BFMA1Lio0 <= BFMA1Oio0;
BFMA1I0o0 <= BFMA1IIO0;
BFMA1O1o0 <= BFMA1O0o0;
BFMA1Oii0 <= BFMA1ILi0;
BFMA1i01I <= BFMA1L01i;
BFMA1L11i <= BFMA1o11i;
end if;
BFMA1O0l0 <= BFMA1iIL0;
BFMA1OOi0 <= BFMA1I1l0;
BFMA1OLl0 <= BFMA1ioL0;
BFMA1lLL0 <= BFMA1i1O0;
BFMA1ilL0 <= BFMA1oOL0;
BFMA1OIl0 <= BFMA1lOL0;
if HREady = '1' then
if BFMA1loO0 = '1' then
BFMA1l1o0 <= BFMA1L0O0;
else
BFMA1l1o0 <= ( others => '0');
end if;
if BFMA1oOO0 = '1' and dEBUg >= 3 then
PrintF("BFM: Data Write %08x %08x",
FMt(BFMA1I01i)&Fmt(BFMA1L1O0));
end if;
if BFMA1I011 and BFMA1ooo0 = '1' then
SPrintF(BFMA1iol1,
"%05t AW %c %08x %08x",
FMT(BFMA1ILOi(BFMA1l11I))&fmt(BFMA1i01i)&FMT(BFMA1L1O0));
wRITe(l,
BFMA1iol1);
WriteLINE(BFMA1il00,
L);
end if;
end if;
if BFMA1I0l0 = '1' and BFMA1l111 then
SPRintf(BFMA1iOL1,
"%05t GW   %08x ",
fmT(BFMA1IIi0));
WritE(L,
BFMA1iOL1);
wRITelinE(BFMA1IL00,
L);
end if;
if BFMA1LIl0 = '1' and BFMA1O111 then
SPrintF(BFMA1IOl1,
"%05t EW   %08x %08x",
fmt(BFMA1I1l0)&FMt(BFMA1l1L0));
WRite(l,
BFMA1ioL1);
WRitelINE(BFMA1il00,
l);
end if;
if HreadY = '1' then
if BFMA1olo0 = '1' then
if DEbug >= 3 then
if BFMA1o1O0 = BFMA1lo00 then
PrintF("BFM: Data Read %08x %08x",
FMt(BFMA1i01I)&FMt(HrdatA));
else
prinTF("BFM: Data Read %08x %08x MASK:%08x",
FMT(BFMA1I01i)&FMT(hRDAta)&FMt(BFMA1O1o0));
end if;
end if;
if BFMA1i011 then
SPRintF(BFMA1IOl1,
"%05t AR %c %08x %08x",
fmt(BFMA1iloi(BFMA1L11i))&FMt(BFMA1i01I)&FMt(hrdATA));
writE(L,
BFMA1ioL1);
wrITElinE(BFMA1IL00,
L);
end if;
if BFMA1o001 >= 0 then
BFMA1i100(BFMA1o001) := BFMA1oiOI(BFMA1oloI(BFMA1l11I,
BFMA1i01I(1 downto 0),
hrdaTA,
BFMA1il11));
end if;
if BFMA1liO0 = '1' and not BFMA1i1I1 then
BFMA1Ll01 := BFMA1LL01+1;
pRINtf("ERROR: AHB Data Read Comparison failed Addr:%08x  Got:%08x  EXP:%08x  (MASK:%08x)",
fmt(BFMA1I01i)&Fmt(hRDAta)&fmt(BFMA1i0o0)&FMt(BFMA1o1O0));
PRIntf("       Stimulus file %s  Line No %d",
fmt(BFMA1O101(BFMA1oiLI(BFMA1oii0,
BFMA1i101)))&fmt(BFMA1IIli(BFMA1Oii0,
BFMA1i101)));
assert faLSE report "BFM Data Compare Error" severity ERror;
if BFMA1i011 then
sPRINtf(BFMA1IOL1,
"%05t ERROR  Addr:%08x  Got:%08x  EXP:%08x  (MASK:%08x)",
fmt(BFMA1I01i)&FMT(HRData)&FMt(BFMA1i0o0)&fMT(BFMA1O1O0));
writE(L,
BFMA1iOL1);
writELIne(BFMA1IL00,
L);
end if;
end if;
end if;
end if;
if BFMA1L0l0 = '1' then
if debUG >= 3 then
if BFMA1oOL0 = BFMA1Lo00 then
PRintf("BFM: GP IO Data Read %08x",
FMt(gp_In));
else
pRINtf("BFM: GP IO Data Read %08x MASK:%08x",
Fmt(gP_In)&fmT(BFMA1oOL0));
end if;
end if;
if BFMA1L111 then
SPRintf(BFMA1IOL1,
"%05t GR   %08x ",
fmt(BFMA1I1O0));
Write(L,
BFMA1IOl1);
WRitelINE(BFMA1Il00,
L);
end if;
if BFMA1o001 >= 0 then
BFMA1i100(BFMA1o001) := BFMA1Oioi(gp_In);
end if;
if BFMA1iol0 = '1' and not BFMA1LO01 then
BFMA1LL01 := BFMA1LL01+1;
PRIntf("GPIO input not as expected  Got:%08x  EXP:%08x  (MASK:%08x)",
fMT(gp_IN)&FMt(BFMA1i1o0)&fmt(BFMA1ooL0));
PRintf("       Stimulus file %s  Line No %d",
fmt(BFMA1o101(BFMA1OIli(BFMA1loL0,
BFMA1i101)))&fMT(BFMA1iILI(BFMA1loL0,
BFMA1I101)));
assert faLSE report "BFM GPIO Compare Error" severity errOR;
if BFMA1L111 then
sPRIntf(BFMA1IOL1,
"ERROR  Got:%08x  EXP:%08x  (MASK:%08x)",
fMT(gp_In)&FMT(BFMA1i1O0)&FMT(BFMA1ool0));
wrITE(l,
BFMA1IOL1);
WRIteliNE(BFMA1il00,
l);
end if;
end if;
end if;
if BFMA1o0l0 = '1' then
if debuG >= 3 then
if BFMA1ill0 = BFMA1lo00 then
pRINtf("BFM: Extention Data Read %08x %08x",
fMT(BFMA1oOI0)&FMt(BFMA1o1L0));
else
PrintF("BFM: Extention Data Read %08x %08x MASK:%08x",
fmt(BFMA1OOI0)&fmt(BFMA1o1L0)&FMT(BFMA1ill0));
end if;
end if;
if BFMA1o111 then
SpriNTF(BFMA1IOL1,
"%05t ER   %08x %08x",
FMT(BFMA1Ooi0)&FMT(BFMA1LLL0));
WRite(l,
BFMA1iOL1);
writELIne(BFMA1il00,
l);
end if;
if BFMA1O001 >= 0 then
BFMA1I100(BFMA1o001) := BFMA1oioI(BFMA1O1l0);
end if;
if BFMA1olL0 = '1' and not BFMA1Oo01 then
BFMA1lL01 := BFMA1ll01+1;
prinTF("ERROR: Extention Data Read Comparison failed  Got:%08x  EXP:%08x  (MASK:%08x)",
fMT(BFMA1O1L0)&fmt(BFMA1llL0)&FMt(BFMA1iLL0));
prINTf("       Stimulus file %s  Line No %d",
FMt(BFMA1O101(BFMA1Oili(BFMA1OIl0,
BFMA1I101)))&fmt(BFMA1IILi(BFMA1OIl0,
BFMA1i101)));
assert falSE report "BFM Extention Data Compare Error" severity erROR;
if BFMA1O111 then
sPRIntf(BFMA1IOL1,
"ERROR  Got:%08x  EXP:%08x  (MASK:%08x)",
fmt(BFMA1o1l0)&fmt(BFMA1lLL0)&FMt(BFMA1ILL0));
wRITe(L,
BFMA1IOl1);
writELIne(BFMA1il00,
L);
end if;
end if;
end if;
BFMA1i001 := BFMA1LLO1 or BFMA1lio1
or BFMA1iLO1
or BFMA1oIO1
or BFMA1IIO1
or BFMA1L0O1
or to_BooleAN(BFMA1IOo0 or BFMA1LOo0
or BFMA1IIL0
or BFMA1l0L0)
or (tO_boolEAN((BFMA1OLo0 or BFMA1OOO0) and not hreaDY));
if BFMA1olo1 then
case BFMA1o010 is
when BFMA1il1 =>
if not BFMA1I001 then
iFPRintF((dEBUg >= 2),
"BFM:%d:checktime was %d cycles ",
fmt(BFMA1o110)&fMT(BFMA1O0I1));
if BFMA1O0i1 < BFMA1olli(1) or BFMA1O0i1 > BFMA1olLI(2) then
pRINtf("BFM: ERROR checktime %d %d Actual %d",
Fmt(BFMA1OLli(1))&Fmt(BFMA1Olli(2))&Fmt(BFMA1O0I1));
PRintF("       Stimulus file %s  Line No %d",
fmt(BFMA1O101(BFMA1OIli(BFMA1o110,
BFMA1I101)))&FMt(BFMA1iILI(BFMA1o110,
BFMA1I101)));
assert fALSe report "BFM checktime failure" severity ERror;
BFMA1LL01 := BFMA1LL01+1;
end if;
BFMA1OLo1 := falSE;
BFMA1l1OOL := BFMA1O0i1;
end if;
when BFMA1ii1 =>
if not BFMA1i001 then
BFMA1oILOl := BFMA1oilOL-1;
IFpriNTF((deBUG >= 2),
"BFM:%d:checktimer was %d cycles ",
Fmt(BFMA1O110)&FMT(BFMA1OIlol));
if BFMA1oilOL < BFMA1ollI(1) or BFMA1OIlol > BFMA1ollI(2) then
prinTF("BFM: ERROR checktimer %d %d Actual %d",
Fmt(BFMA1OLli(1))&fmt(BFMA1oLLI(2))&Fmt(BFMA1oiloL));
PRintf("       Stimulus file %s  Line No %d",
fmt(BFMA1O101(BFMA1OILi(BFMA1o110,
BFMA1I101)))&fmT(BFMA1iili(BFMA1O110,
BFMA1i101)));
assert fALSe report "BFM checktimer failure" severity Error;
BFMA1lL01 := BFMA1Ll01+1;
end if;
BFMA1olo1 := falSE;
BFMA1O1ooL := BFMA1OILol;
end if;
when others =>
end case;
end if;
if BFMA1OI11 then
if BFMA1lol1 > 0 then
BFMA1lOL1 := BFMA1LOL1-1;
else
BFMA1LOl1 := BFMA1l110;
priNTF("       BFM Command Timeout Occured");
prINTf("       Stimulus file %s  Line No %d",
FMT(BFMA1O101(BFMA1oilI(BFMA1OII0,
BFMA1I101)))&fmt(BFMA1iILI(BFMA1OII0,
BFMA1i101)));
assert BFMA1l0l1 report "BFM Command timeout occured" severity erroR;
assert not BFMA1l0L1 report "BFM Completed and timeout occured" severity ErroR;
end if;
else
BFMA1loL1 := BFMA1l110;
end if;
if BFMA1Ll01 > 0 then
BFMA1i0i0 <= '1';
end if;
if BFMA1olo1 or BFMA1lLO1
or BFMA1lio1
or BFMA1ILO1
or BFMA1OIO1
or BFMA1IIo1
or BFMA1l0O1
or ((BFMA1o0O1 or BFMA1Ol11) and BFMA1l001) then
BFMA1o1O1 := TRue;
else
BFMA1O0O1 := falSE;
if not BFMA1L0L1 then
BFMA1O1o1 := FAlse;
end if;
BFMA1lOLI := BFMA1LOli+BFMA1i010;
BFMA1I010 := 0;
if opmoDE > 0 then
if BFMA1lI11 or BFMA1L0L1 then
BFMA1OI11 := FalsE;
BFMA1o1O1 := fALSe;
end if;
end if;
end if;
if BFMA1l0i0 = '0' and oPMOde = 0
and BFMA1l0l1
and not BFMA1L001 then
PRintf("###########################################################");
PRintf(" ");
if BFMA1ll01 = 0 then
PRintf("BFM Simulation Complete - %d Instructions - NO ERRORS",
fmT(BFMA1L0i1));
else
prINTf("BFM Simulation Complete - %d Instructions - %d ERRORS OCCURED",
fmt(BFMA1L0i1)&Fmt(BFMA1Ll01));
end if;
PRintf(" ");
priNTF("###########################################################");
pRINTf(" ");
BFMA1l0I0 <= '1';
BFMA1o1O1 := truE;
BFMA1oI11 := falSE;
if BFMA1OLL1(1) /= nul then
FIle_cLOSe(BFMA1Il00);
end if;
case BFMA1Ll0oL is
when 1 =>
assert False report "BFM Completed" severity noTE;
when 2 =>
assert falSE report "BFM Completed" severity WarniNG;
when 3 =>
assert FALse report "BFM Completed" severity eRROr;
when 4 =>
assert FalsE report "BFM Completed" severity failURE;
when others =>
end case;
end if;
con_BUsy <= to_sTD_logIC(BFMA1oi11 or BFMA1l001);
inSTR_out <= TO_slv32(BFMA1LOLi);
end if;
end process;
Gp_ouT <= BFMA1iii0 after BFMA1Ol00;
EXt_wr <= BFMA1lil0 after BFMA1OL00;
ext_RD <= BFMA1IIl0 after BFMA1OL00;
Ext_ADDr <= BFMA1I1l0 after BFMA1OL00;
EXT_datA <= BFMA1L1l0 when BFMA1LIl0 = '1' else
( others => 'Z') after BFMA1oL00;
BFMA1o1L0 <= ext_DATa;
process (BFMA1l01I,SYsrstN)
begin
if sySRStn = '0' then
BFMA1I11i <= ( others => '0');
else
for BFMA1i0II in 0 to 15
loop
BFMA1I11i(BFMA1i0ii) <= to_sTD_logIC(to_INTeger((to_UNSignED(BFMA1L01i(31 downto 28)))) = BFMA1I0ii);
end loop;
end if;
end process;
hclk <= 'X' when BFMA1o1i0 else
(SYsclk or BFMA1lII0);
PClk <= 'X' when BFMA1O1I0 else
(SysclK or BFMA1lii0);
hreSETn <= 'X' when BFMA1L1i0 else
BFMA1OL1i after BFMA1ol00;
HADdr <= ( others => 'X') when BFMA1I1I0 else
BFMA1L01i after BFMA1ol00;
hwdaTA <= ( others => 'X') when BFMA1Oo00 else
BFMA1L1o0 after BFMA1Ol00;
hbURSt <= ( others => 'X') when BFMA1i1I0 else
BFMA1ll1I after BFMA1Ol00;
hmASTlocK <= 'X' when BFMA1i1I0 else
BFMA1IL1i after BFMA1Ol00;
hprOT <= ( others => 'X') when BFMA1I1i0 else
BFMA1oi1I after BFMA1OL00;
hsIZE <= ( others => 'X') when BFMA1I1i0 else
BFMA1O11i after BFMA1OL00;
HTranS <= ( others => 'X') when BFMA1i1I0 else
BFMA1LI1i after BFMA1OL00;
HwritE <= 'X' when BFMA1I1i0 else
BFMA1ii1I after BFMA1OL00;
hsEL <= ( others => 'X') when BFMA1i1i0 else
BFMA1I11i after BFMA1OL00;
con_DATa <= BFMA1iOI0 when BFMA1olI0 = '1' else
( others => 'Z') after BFMA1OL00;
BFMA1Loi0 <= cON_datA;
FinisHED <= BFMA1l0I0 after BFMA1oL00;
failED <= BFMA1i0i0 after BFMA1oL00;
end BFMA1I10i;
