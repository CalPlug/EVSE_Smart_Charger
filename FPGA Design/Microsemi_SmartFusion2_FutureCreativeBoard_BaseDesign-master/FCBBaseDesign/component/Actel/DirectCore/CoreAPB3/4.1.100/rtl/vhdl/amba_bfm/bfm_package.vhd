-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 11878 $
-- SVN $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $
use Std.texTIO.all;
library Ieee;
use IEEe.STD_logIC_1164.all;
use Ieee.numERIc_stD.all;
use WOrk.BFM_teXTIo.all;
use woRK.Bfm_MISc.all;
package bfM_packAGE is

constant BFMA1O: inTEGer := 22;

constant BFMA1l: iNTEger := 0;

constant BFMA1I: InteGER := 4;

constant BFMA1OL: iNTEger := 8;

constant BFMA1LL: INtegeR := 12;

constant BFMA1il: iNTEger := 16;

constant BFMA1OI: INTegeR := 20;

constant BFMA1LI: IntegER := 24;

constant BFMA1Ii: IntegER := 28;

constant BFMA1o0: IntegER := 32;

constant BFMA1l0: INtegER := 36;

constant BFMA1i0: inTEGer := 40;

constant BFMA1O1: intEGEr := 44;

constant BFMA1l1: INTegeR := 48;

constant BFMA1i1: inteGER := 52;

constant BFMA1OOL: InteGER := 56;

constant BFMA1LOL: INtegeR := 60;

constant BFMA1ioL: inTEGEr := 64;

constant BFMA1oll: IntegER := 68;

constant BFMA1LLl: iNTEger := 72;

constant BFMA1ILl: inTEGer := 76;

constant BFMA1OIL: inteGER := 80;

constant BFMA1LIl: iNTEger := 100;

constant BFMA1Iil: intEGEr := 101;

constant BFMA1O0l: InteGER := 102;

constant BFMA1L0l: inteGER := 103;

constant BFMA1i0l: intEGEr := 104;

constant BFMA1o1L: inteGER := 105;

constant BFMA1L1l: inTEGer := 106;

constant BFMA1i1L: INtegeR := 107;

constant BFMA1Ooi: intEGEr := 108;

constant BFMA1LOI: inteGER := 109;

constant BFMA1iOI: INTeger := 110;

constant BFMA1Oli: inteGER := 111;

constant BFMA1lLI: inTEGer := 112;

constant BFMA1ili: INtegER := 113;

constant BFMA1oiI: IntegER := 114;

constant BFMA1lii: iNTEger := 115;

constant BFMA1iii: INTEger := 128;

constant BFMA1O0I: INTegeR := 129;

constant BFMA1l0i: inTEGer := 130;

constant BFMA1I0i: InteGER := 131;

constant BFMA1o1i: INtegeR := 132;

constant BFMA1l1i: INtegeR := 133;

constant BFMA1i1I: inTEGer := 134;

constant BFMA1OO0: InteGER := 135;

constant BFMA1lO0: intEGEr := 136;

constant BFMA1iO0: IntegER := 137;

constant BFMA1Ol0: INTegeR := 138;

constant BFMA1ll0: INTegeR := 139;

constant BFMA1iL0: INTeger := 140;

constant BFMA1oi0: INTeger := 141;

constant BFMA1LI0: IntegER := 142;

constant BFMA1II0: inTEGEr := 150;

constant BFMA1o00: intEGEr := 151;

constant BFMA1l00: IntegER := 152;

constant BFMA1I00: IntegER := 153;

constant BFMA1o10: InteGER := 154;

constant BFMA1L10: iNTEger := 160;

constant BFMA1i10: inteGER := 161;

constant BFMA1oO1: IntegER := 162;

constant BFMA1lo1: inTEGEr := 163;

constant BFMA1iO1: intEGEr := 164;

constant BFMA1OL1: INTeger := 165;

constant BFMA1LL1: inteGER := 166;

constant BFMA1Il1: iNTEger := 167;

constant BFMA1OI1: IntegER := 168;

constant BFMA1Li1: INTegeR := 169;

constant BFMA1ii1: INTeger := 170;

constant BFMA1o01: IntegER := 171;

constant BFMA1L01: intEGEr := 172;

constant BFMA1i01: InteGER := 200;

constant BFMA1o11: IntegER := 201;

constant BFMA1l11: iNTEger := 202;

constant BFMA1I11: INTeger := 203;

constant BFMA1oOOL: INtegeR := 204;

constant BFMA1looL: inteGER := 205;

constant BFMA1iOOL: IntegER := 206;

constant BFMA1OLOl: inTEGer := 207;

constant BFMA1llOL: IntegER := 208;

constant BFMA1ILOl: inTEGer := 209;

constant BFMA1Oiol: inTEGer := 210;

constant BFMA1Liol: INtegeR := 211;

constant BFMA1IIol: INtegeR := 212;

constant BFMA1O0ol: INtegeR := 213;

constant BFMA1L0ol: INtegER := 214;

constant BFMA1i0OL: inTEGer := 215;

constant BFMA1o1oL: INtegeR := 216;

constant BFMA1L1ol: inteGER := 217;

constant BFMA1i1OL: InteGER := 218;

constant BFMA1Ooll: intEGEr := 219;

constant BFMA1LOll: INtegeR := 220;

constant BFMA1iolL: IntegER := 221;

constant BFMA1oLLL: inteGER := 222;

constant BFMA1lLLL: IntegER := 250;

constant BFMA1ILLl: InteGER := 251;

constant BFMA1OILl: INTeger := 252;

constant BFMA1LIll: iNTEGer := 253;

constant BFMA1iiLL: intEGEr := 254;

constant BFMA1o0ll: IntegER := 255;

constant BFMA1L0Ll: IntegER := 1001;

constant BFMA1I0ll: IntegER := 1002;

constant BFMA1O1Ll: inTEGer := 1003;

constant BFMA1l1LL: IntegER := 1004;

constant BFMA1i1LL: inteGER := 1005;

constant BFMA1ooil: intEGEr := 1006;

constant BFMA1lOIL: INTEger := 1007;

constant BFMA1IOil: iNTEGer := 1008;

constant BFMA1olil: INtegER := 1009;

constant BFMA1llil: INTegeR := 1010;

constant BFMA1ilIL: IntegER := 1011;

constant BFMA1OIIl: INtegeR := 1012;

constant BFMA1liil: inTEGer := 1013;

constant BFMA1iIIL: IntegER := 1014;

constant BFMA1o0IL: InteGER := 1015;

constant BFMA1L0il: inteGER := 1016;

constant BFMA1I0il: INtegeR := 1017;

constant BFMA1o1IL: inteGER := 1018;

constant BFMA1L1Il: iNTEGer := 1019;

constant BFMA1i1IL: INtegeR := 1020;

constant BFMA1OO0l: intEGEr := 1021;

constant BFMA1LO0l: INTegeR := 1022;

constant BFMA1Io0l: IntegER := 1023;

constant BFMA1ol0L: INTeger := 0;

constant BFMA1ll0L: inTEGer := 1;

constant BFMA1IL0l: iNTEger := 2;

constant BFMA1oI0L: inteGER := 3;

constant BFMA1lI0L: inteGER := 4;

constant BFMA1Ii0l: INtegeR := 0;

constant BFMA1O00l: INTegeR := 1;

constant BFMA1l00L: iNTEger := 2;

constant BFMA1i00L: INTegeR := 3;

constant BFMA1o10L: integER := 4;

constant BFMA1l10L: INtegER := 5;

constant BFMA1I10l: INTEger := 6;

constant BFMA1OO1l: intEGEr := 7;

constant BFMA1lo1L: INTegeR := 8;

constant BFMA1Io1l: inTEGer := 16#00000000#;

constant BFMA1OL1l: iNTEger := 16#00002000#;

constant BFMA1ll1L: inTEGer := 16#00004000#;

constant BFMA1IL1l: inTEGer := 16#00006000#;

constant BFMA1oI1l: iNTEger := 16#00008000#;

type BFMA1li1L is (BFMA1II1l,BFMA1O01l,BFMA1l01L,X);

subtype BFMA1I01l is sTD_logiC_VectOR(31 downto 0);

type BFMA1O11l is array (INTegeR range <> ) of BFMA1I01l;

function BFMA1L11l(siZE: STD_loGIC_vecTOr(2 downto 0);
BFMA1I11l: sTD_logIC_vecTOR(1 downto 0);
BFMA1Oooi: Std_lOGIc_vECTor(31 downto 0);
BFMA1LOOi: iNTEGer)
return std_LOgic_VEctoR;

function BFMA1Iooi(sizE: std_LOGic_vECTor(2 downto 0);
BFMA1I11l: stD_logiC_VectOR(1 downto 0);
BFMA1oOOI: STD_logIC_veCTOr(31 downto 0);
BFMA1Looi: IntegER)
return std_LOgic_VEctor;

function BFMA1OLOi(sIZE: STd_lOGIc_veCTOr(2 downto 0);
BFMA1i11l: std_LOGic_vECTor(1 downto 0);
BFMA1OOoi: Std_lOGIc_veCTOr(31 downto 0);
BFMA1looI: INtegeR)
return stD_LogiC_VectOR;

function BFMA1lloI(x: iNTEger)
return CHAracTER;

function BFMA1ILOi(Size: iNTEger)
return charACTer;

function BFMA1ILOi(SIze: Std_lOGIc_vECTor)
return CHAractER;

function BFMA1OIOi(BFMA1lioi: STD_logIC_veCTOr)
return intEGEr;

function tO_Slv32(X: iNTEger)
return std_LOGic_vECTor;

function BFMA1iioI(size: inTEGer;
BFMA1O0oi: INtegeR)
return INTegeR;

function BFMA1l0oI(sIZE: IntegER;
BFMA1I0Oi: inteGER)
return STD_logIC_veCTOr;

function BFMA1O1oi(BFMA1L1oi: intEGEr;
X,y: intEGEr;
deBUG: InteGER)
return iNTEger;

function BFMA1i1OI(X: STd_lOGIC_veCTOr)
return std_Logic_VEctoR;

function BFMA1OOLi(BFMA1lOLI: INTeger;
BFMA1ioLI: iNTEGer_ARRay;
BFMA1OLli: intEGEr_arRAY)
return STRing;

function BFMA1llli(BFMA1ilLI: InteGER)
return inteGER;

function BFMA1OIli(BFMA1liLI,x: IntegER)
return INTeger;

function BFMA1Iili(BFMA1Lili,x: INTeger)
return intEGEr;

function To_inT_signED(BFMA1lioi: STD_logIC_veCTOr)
return IntegER;

function tO_Int_uNSIgneD(BFMA1liOI: Std_lOGIc_vECTor)
return IntegER;

function BFMA1o0li(SEed: INTeger)
return IntegER;

function BFMA1L0Li(Seed: INtegeR;
Size: inteGER)
return IntegeR;

function BFMA1i0li(SEEd: intEGEr;
SIZe: INTeger)
return IntegER;

function BounD1K(BFMA1O1li: INtegeR;
BFMA1l1LI: sTD_logIC_vecTOR)
return bOOLEan;

component bfm_Main
generic (oPMODe: inteGER range 0 to 2 := 0;
VectfILE: stRINg := "test.vec";
mAX_insTRUctiONS: INtegeR := 16384;
MAx_stACK: inteGER := 1024;
max_MemteST: INTEger := 65536;
tpD: InteGER range 0 to 1000 := 1;
debuGLEvel: inTEGer range -1 to 5 := -1;
coN_SpulSE: IntegER range 0 to 1 := 0;
aRGValue0: INTegeR := 0;
aRGValue1: iNTEGer := 0;
arGVAlue2: INTeger := 0;
arGVAlue3: inTEGer := 0;
argVALue4: INtegeR := 0;
ARgvaLUE5: inTEGer := 0;
argvALUe6: inTEGer := 0;
argvALUe7: inTEGer := 0;
ARGvaluE8: InteGER := 0;
ArgvALUe9: IntegER := 0;
argvALUe10: intEGEr := 0;
argVALue11: intEGEr := 0;
ARGvalUE12: INtegER := 0;
ArgvALUe13: INtegeR := 0;
ArgvALUe14: IntegER := 0;
ARGValuE15: INtegeR := 0;
arGVAlue16: INTEger := 0;
arGVALue17: INtegeR := 0;
argvALUe18: inTEGer := 0;
argvALUe19: inteGER := 0;
aRGValue20: INTeger := 0;
ArgvALUe21: INTeger := 0;
arGVAlue22: inteGER := 0;
argvALUe23: inTEGer := 0;
aRGValue24: inteGER := 0;
argVALue25: INTeger := 0;
ARgvalUE26: INteGEr := 0;
ARgvalUE27: INtegeR := 0;
argVALue28: IntegER := 0;
argvALUe29: IntegER := 0;
ARgvaLUE30: inTEGer := 0;
ARgvalUE31: inTEGEr := 0;
argVALue32: intEGEr := 0;
ARGvaluE33: intEGEr := 0;
argvALUe34: inteGER := 0;
arGVAlue35: INTeger := 0;
arGVAlue36: inteGER := 0;
aRGVAlue37: inTEGer := 0;
ARGvaluE38: inteGER := 0;
ARGvalUE39: inTEGer := 0;
argVALue40: inteGER := 0;
argVALue41: inTEGEr := 0;
argVALue42: intEGER := 0;
arGVAlue43: intEGEr := 0;
aRGValue44: intEGEr := 0;
ARGvaluE45: inTEGer := 0;
argvALUe46: INTeger := 0;
ArgvALUe47: iNTEGer := 0;
arGVAlue48: IntegER := 0;
aRGValue49: INTeger := 0;
arGVAlue50: iNTEger := 0;
arGVAlue51: intEGEr := 0;
aRGValue52: iNTEger := 0;
ARGvaluE53: iNTEger := 0;
aRGValue54: INTeger := 0;
aRGValue55: inteGER := 0;
aRGVAlue56: inteGER := 0;
ARGvaluE57: INtegER := 0;
ARGvalUE58: IntegER := 0;
argvALUe59: IntegER := 0;
argvALUe60: INtegeR := 0;
ArgvALUe61: INtegeR := 0;
argVALue62: INTegeR := 0;
aRGValue63: InteGER := 0;
argvALUe64: intEGEr := 0;
argVALue65: IntegER := 0;
arGVAlue66: INTegeR := 0;
argvALUe67: INtegeR := 0;
aRGValue68: iNTEGer := 0;
aRGValue69: iNTEGer := 0;
ArgvaLUE70: inTEGer := 0;
ARGvaluE71: intEGEr := 0;
argvALUe72: inTEGer := 0;
ARgvalUE73: integER := 0;
ArgvaLUE74: IntegER := 0;
ARgvaLUE75: inteGER := 0;
ARGvaluE76: INTeger := 0;
ARGvaluE77: inTEGer := 0;
ARgvalUE78: INTeger := 0;
argvALUe79: INtegER := 0;
ArgvaLUE80: inteGER := 0;
ArgvaLUE81: inteGER := 0;
arGVAlue82: inTEGer := 0;
aRGValue83: iNTEger := 0;
ArgvALUe84: iNTEger := 0;
argvALUe85: IntegER := 0;
aRGValue86: INTeger := 0;
arGVALue87: inteGER := 0;
ArgvaLUE88: intEGEr := 0;
ARgvalUE89: inteGER := 0;
ARGvaluE90: INTegeR := 0;
ArgvaLUE91: IntegER := 0;
argVALue92: INtegER := 0;
ARGvalUE93: inTEGer := 0;
ArgvaLUE94: intEGEr := 0;
ARgvaLUE95: intEGEr := 0;
aRGValue96: inteGER := 0;
argvALUe97: inteGER := 0;
ARgvalUE98: inteGER := 0;
aRGValue99: INTeger := 0);
port (sYSClk: in Std_lOGIc;
SysrsTN: in Std_lOGIC;
pclk: out sTD_logIC;
hCLK: out sTD_logIC;
HResetN: out STD_logIC;
hadDR: out STD_logIC_vecTOr(31 downto 0);
HBUrst: out STD_logIC_veCTOr(2 downto 0);
HMastlOCK: out Std_LOGic;
hpROT: out std_LOGic_VECtor(3 downto 0);
hSIZe: out sTD_logIC_vecTOR(2 downto 0);
HTRans: out stD_logiC_VectOR(1 downto 0);
HwriTE: out sTD_logIC;
HwdatA: out STd_loGIC_veCTOr(31 downto 0);
hrDATa: in stD_LogiC_VectOR(31 downto 0);
hREAdy: in std_Logic;
hRESp: in stD_logiC;
HSEl: out std_Logic_VEctoR(15 downto 0);
INterrUPT: in stD_LogiC_VectOR(255 downto 0);
GP_out: out STd_loGIC_vecTOr(31 downto 0);
gp_IN: in std_Logic_VEctoR(31 downto 0);
Ext_wR: out sTD_logIC;
eXT_rd: out STd_loGIC;
exT_Addr: out STD_logIC_veCTOr(31 downto 0);
EXt_daTA: inout Std_lOGIc_vECTor(31 downto 0);
EXT_waiT: in stD_LogiC;
cON_addR: in sTD_logIC_vecTOR(15 downto 0);
CON_datA: inout Std_lOGIc_vECTor(31 downto 0);
coN_Rd: in sTD_logIC;
CON_wr: in STD_logIC;
con_BUSy: out STd_loGIC;
INstr_out: out STD_logIC_vecTOr(31 downto 0);
instR_in: in Std_LOGic_vECTor(31 downto 0);
fiNIShed: out STd_lOGIc;
FailED: out std_LOGic);
end component;

component Bfm_aHBSlavEEXt
generic (awIDTh: InteGER range 1 to 32;
DEPth: intEGEr := 256;
Ext_sIZE: inTEGer range 0 to 2 := 2;
INItfiLE: sTRIng := "";
ID: iNTEGer := 0;
TPD: INTEger range 0 to 1000 := 1;
enfuNC: inteGER := 0;
eNFIfo: INTegeR range 0 to 1024 := 0;
dEBUg: iNTEGer range 0 to 1 := 0);
port (HCLk: in std_LOGic;
hrESETn: in STD_logIC;
hSEL: in stD_logiC;
HWRite: in STd_lOGIC;
HADDr: in sTD_logIC_vecTOR(AwidtH-1 downto 0);
HWdata: in stD_Logic_VectOR(31 downto 0);
HrdatA: out Std_lOGIc_vECTor(31 downto 0);
hreaDYIn: in std_LOgic;
hrEADyout: out sTD_logIC;
HtranS: in STd_lOGIc_veCTOr(1 downto 0);
HSize: in STD_loGIC_veCTOr(2 downto 0);
HBUrst: in sTD_logIC_vecTOR(2 downto 0);
hMAStlocK: in Std_lOGIC;
hPROt: in Std_lOGIc_vECTor(3 downto 0);
HresP: out STd_loGIC;
exT_En: in STD_logIC;
Ext_WR: in STd_lOGIC;
exT_Rd: in std_LOgic;
eXT_addr: in sTD_logiC_vectOR(AWIdth-1 downto 0);
eXT_datA: inout Std_LOGic_vECTor(31 downto 0);
TxreaDY: out std_Logic;
rXREady: out STD_logIC);
end component;

component BFM_ahbSLAve
generic (awIDTh: iNTEger range 1 to 32;
Depth: inteGER := 256;
iNITFile: StrinG := "";
iD: inTEGer := 0;
TPD: InteGER range 0 to 1000 := 1;
ENfunc: INTeger := 0;
DEbug: IntegER range 0 to 1 := 0);
port (HClk: in std_LOGic;
hresETN: in STD_logIC;
hsEL: in stD_LogiC;
HwritE: in stD_logiC;
Haddr: in Std_LOGIc_vECTor(awIDTH-1 downto 0);
hwdATA: in std_Logic_VEctOR(31 downto 0);
HrdaTA: out STD_loGIC_veCTOr(31 downto 0);
hREAdyin: in Std_lOGIc;
HreadYOUt: out STD_logIC;
htrANS: in Std_LOGIc_vECTor(1 downto 0);
hsIZE: in std_Logic_VEctoR(2 downto 0);
hbURSt: in sTD_logIC_vecTOR(2 downto 0);
HmastLOCk: in std_LOGic;
HPRot: in std_LOGic_vECtor(3 downto 0);
hRESp: out Std_LOGIc);
end component;

component BFm_apBSLaveEXT
generic (AWidth: IntegER range 1 to 32;
Depth: IntegER := 256;
DWIdth: INTeger range 8 to 32 := 32;
EXt_siZE: INTeger range 0 to 2 := 2;
iniTFIle: STring := "";
ID: iNTEGer := 0;
tpd: iNTEger range 0 to 1000 := 1;
ENfunC: INTeger := 0;
dEBUg: IntegER range 0 to 1 := 0);
port (PCLk: in stD_LogiC;
pRESetn: in Std_lOGIc;
peNABle: in std_LOGic;
PwritE: in STd_loGIC;
pseL: in STD_logIC;
pADDr: in std_LOGic_vECTor(awIDTh-1 downto 0);
pwdATA: in STD_logIC_veCTOr(dwIDTh-1 downto 0);
prdATA: out std_LOGic_VECtor(dwiDTH-1 downto 0);
prEADy: out STD_loGIC;
pSLVerr: out stD_logiC;
Ext_eN: in stD_logiC;
ext_WR: in STD_loGIC;
exT_Rd: in STD_logIC;
EXt_aDDR: in stD_LogiC_VectOR(AWIdth-1 downto 0);
EXT_datA: inout STd_loGIC_veCTOr(DwidTH-1 downto 0));
end component;

component BFM_apbSLAve
generic (awiDTH: INTeger range 1 to 32;
dePTH: intEGEr := 256;
DWIdth: inTEGer range 8 to 32 := 32;
INItfilE: striNG := "";
id: intEGEr := 0;
TPD: IntegER range 0 to 1000 := 1;
eNFUnc: inteGER := 0;
DEBug: INtegeR range 0 to 1 := 0);
port (Pclk: in std_LOGic;
PreseTN: in STD_loGIC;
peNABle: in STd_lOGIC;
PWRite: in sTD_logIC;
psEL: in STd_loGIC;
PaddR: in std_LOGic_VECtor(aWIDth-1 downto 0);
pWDAta: in std_Logic_VEctoR(dwidTH-1 downto 0);
PrdatA: out sTD_logIC_vecTOR(DwidtH-1 downto 0);
pREAdy: out Std_LOGIc;
pslvERR: out Std_lOGIC);
end component;

component bfM_Ahbl
generic (vecTFIle: stRINg := "test.vec";
Max_INSTrucTIOns: intEGEr := 16384;
tpd: intEGEr range 0 to 1000 := 1;
Max_sTACk: INtegeR := 1024;
max_MEmteST: IntegER := 65536;
debUGLevel: inTEGer range -1 to 5 := -1;
ARGvaluE0: inTEGer := 0;
ARGvaluE1: inTEGer := 0;
argVALue2: iNTEger := 0;
aRGValue3: INtegeR := 0;
ARgvalUE4: intEGEr := 0;
ARGvalUE5: inteGER := 0;
aRGValuE6: inTEGer := 0;
ArgvALUE7: INTeger := 0;
ArgvALUE8: INtegeR := 0;
ArgvALUe9: INtegeR := 0;
ArgvaLUE10: iNTEger := 0;
ARgvalUE11: inTEGer := 0;
aRGValue12: IntegER := 0;
ArgvALUE13: InteGER := 0;
ARGvaluE14: INtegeR := 0;
ARGvaluE15: INTEger := 0;
argVALue16: InteGER := 0;
arGVAlue17: inteGER := 0;
ARgvalUE18: intEGEr := 0;
aRGVAlue19: IntegER := 0;
ArgvaLUE20: inteGER := 0;
arGVAlue21: IntegER := 0;
argvALUe22: inteGER := 0;
ArgvALUe23: InteGER := 0;
arGVAlue24: inTEGEr := 0;
ARgvalUE25: iNTEGer := 0;
ARgvalUE26: intEGEr := 0;
ARGvalUE27: inteGER := 0;
ArgvaLUE28: inTEGer := 0;
argVALue29: intEGEr := 0;
ARGvaluE30: INTegeR := 0;
arGVAlue31: INTeger := 0;
ArgvALUe32: INTegeR := 0;
ARgvalUE33: iNTEger := 0;
ArgvaLUE34: inTEGer := 0;
arGVALue35: inteGER := 0;
argvALUe36: INTeger := 0;
arGVAlue37: iNTEger := 0;
aRGValue38: INTegeR := 0;
ARgvalUE39: INtegeR := 0;
aRGValue40: iNTEger := 0;
ARgvaLUE41: INTeger := 0;
argVALue42: INTeger := 0;
ARGvaluE43: inteGER := 0;
argvALUe44: inTEGer := 0;
aRGValuE45: INtegeR := 0;
arGVAlue46: inteGER := 0;
argvALUe47: IntegER := 0;
aRGValue48: intEGEr := 0;
argvALUe49: IntegER := 0;
ArgvaLUE50: inteGER := 0;
ARGvaluE51: inTEGer := 0;
ArgvaLUE52: inteGER := 0;
ARGvaluE53: INtegeR := 0;
aRGValuE54: INTeger := 0;
ArgvaLUE55: IntegER := 0;
ARGvaluE56: iNTEger := 0;
argVALue57: IntegER := 0;
argvALUe58: iNTEger := 0;
ARgvalUE59: inteGER := 0;
argVALue60: INTegeR := 0;
ARgvalUE61: inteGER := 0;
arGVAlue62: inTEGer := 0;
ArgvALUE63: inteGER := 0;
argVALue64: intEGEr := 0;
argvALUe65: INTeger := 0;
arGVAlue66: INtegER := 0;
ArgvALUe67: inTEGer := 0;
arGVAlue68: IntegER := 0;
ArgvaLUE69: INtegeR := 0;
ArgvaLUE70: IntegeR := 0;
aRGValue71: INtegeR := 0;
ARGvaluE72: intEGEr := 0;
arGVAlue73: InteGER := 0;
aRGValue74: inteGER := 0;
ArgvALUE75: iNTEger := 0;
ARGvalUE76: intEGEr := 0;
ArgvaLUE77: IntegER := 0;
argVALue78: intEGER := 0;
argVALue79: inTEGer := 0;
ArgvaLUE80: INtegER := 0;
ArgvALUe81: inTEGer := 0;
ARGvaluE82: inTEGer := 0;
argvALUe83: intEGEr := 0;
argvALUe84: intEGEr := 0;
argvALUe85: IntegER := 0;
argVALue86: inteGER := 0;
ArgvaLUE87: INtegeR := 0;
ARgvalUE88: iNTEger := 0;
ARGvaluE89: intEGEr := 0;
ArgvALUe90: INTeger := 0;
ARGvaluE91: intEGEr := 0;
arGVAlue92: INtegeR := 0;
arGVAlue93: INtegeR := 0;
ARGvaluE94: IntegER := 0;
aRGValue95: INTeger := 0;
ARgvalUE96: iNTEger := 0;
ARGvaluE97: intEGEr := 0;
ArgvaLUE98: iNTEger := 0;
ARGvaluE99: intEGEr := 0);
port (SYsclK: in std_LOgic;
SysrsTN: in STd_loGIC;
HAddr: out stD_logiC_VectOR(31 downto 0);
Hclk: out stD_logiC;
HRESetn: out STD_loGIC;
hbuRST: out stD_logiC_VectOR(2 downto 0);
hmaSTLock: out std_LOGic;
hproT: out STd_loGIC_veCTOr(3 downto 0);
hSIZE: out stD_logiC_VectOR(2 downto 0);
hTRAns: out std_LOgic_VEctoR(1 downto 0);
HwritE: out Std_LOGic;
hwdaTA: out stD_logiC_VectOR(31 downto 0);
HRdata: in STD_logIC_veCTOr(31 downto 0);
HReady: in stD_logiC;
hRESP: in sTD_logIC;
Hsel: out std_LOGic_vECTor(15 downto 0);
intERRupt: in std_LOgic_VEctoR(255 downto 0);
GP_out: out sTD_logIC_vecTOr(31 downto 0);
Gp_iN: in STD_loGIC_veCTOr(31 downto 0);
exT_wr: out std_LOGic;
EXt_rd: out Std_LOGic;
EXt_aDDR: out std_LOgic_VEctoR(31 downto 0);
EXt_dATA: inout STd_loGIC_veCTOr(31 downto 0);
EXt_waIT: in STd_loGIC;
finISHEd: out sTD_logIC;
FAIled: out std_LOGic);
end component;

component BFMA1i1lI
generic (tpD: INTeger range 0 to 1000 := 1);
port (hCLK: in std_LOGic;
HRESetn: in STD_loGIC;
hSEL: in std_LOGic;
HWRite: in STD_logIC;
HADdr: in std_LOGic_VECtor(31 downto 0);
hwdaTA: in STd_loGIC_veCTOr(31 downto 0);
HRdata: out STd_lOGIC_veCTOr(31 downto 0);
HreaDYIN: in std_LOgic;
HReadyOUT: out STD_logIC;
htraNS: in std_LOgic_VEctoR(1 downto 0);
hsIZE: in sTD_logIC_vecTOR(2 downto 0);
HburST: in std_LOGic_vECTor(2 downto 0);
HMAstloCK: in Std_LOGIc;
hprOT: in sTD_logIC_vecTOR(3 downto 0);
hreSP: out stD_logiC;
psel: out Std_lOGIC_veCTOr(15 downto 0);
padDR: out STD_logIC_vecTOR(31 downto 0);
pwriTE: out Std_LOGic;
pENABle: out Std_lOGIc;
pWDAta: out sTD_logIC_vecTOR(31 downto 0);
PrdatA: in Std_lOGIc_vECTor(31 downto 0);
PreadY: in Std_LOGic;
psLVErr: in std_LOgic);
end component;

component bfM_ahblAPB
generic (VectfILE: STRing := "test.vec";
MAX_insTRUctiONS: IntegER := 16384;
TPd: inTEGer range 0 to 1000 := 1;
MAX_staCK: IntegER := 1024;
Max_mEMTest: inteGER := 65536;
DebugLEVel: inTEGer range -1 to 5 := -1;
ARGvaluE0: INTeger := 0;
aRGValue1: inteGER := 0;
argvALUe2: iNTEger := 0;
argvALUe3: INtegeR := 0;
argVALue4: inteGER := 0;
ArgvaLUE5: IntegER := 0;
arGVAlue6: inteGER := 0;
ArgvaLUE7: INTeger := 0;
aRGValue8: intEGEr := 0;
argVALue9: iNTEger := 0;
argVALue10: iNTEGer := 0;
ARgvalUE11: inTEGer := 0;
argVALue12: iNTEGer := 0;
ARGvalUE13: INtegeR := 0;
ARGvalUE14: IntegER := 0;
ARgvalUE15: InteGER := 0;
ARGvaluE16: inTEGer := 0;
argVALue17: iNTEger := 0;
ArgvaLUE18: intEGEr := 0;
ARgvalUE19: inteGER := 0;
ARgvalUE20: IntegER := 0;
ARGvaluE21: iNTEger := 0;
ARGvaluE22: iNTEger := 0;
aRGValue23: INTeger := 0;
ARgvaLUE24: IntegER := 0;
arGVAlue25: INtegER := 0;
ARGvalUE26: inteGER := 0;
ARGvaluE27: iNTEGer := 0;
ARgvalUE28: IntegER := 0;
aRGValue29: INTeger := 0;
arGVAlue30: intEGEr := 0;
ArgvaLUE31: INTeger := 0;
aRGVAlue32: inteGER := 0;
argvALUe33: INTEger := 0;
ARGvaluE34: intEGEr := 0;
ARGvaluE35: IntegER := 0;
ARgvalUE36: InteGER := 0;
ARgvalUE37: InteGER := 0;
argVALue38: IntegER := 0;
aRGValue39: iNTEger := 0;
ARGvaluE40: INTEger := 0;
argvALUe41: INtegeR := 0;
argVALue42: inteGER := 0;
ARGvaluE43: inTEGer := 0;
aRGValue44: INtegeR := 0;
ARGvalUE45: IntegER := 0;
argvALUe46: IntegER := 0;
arGVAlue47: inteGER := 0;
ARGvaluE48: INTegeR := 0;
ArgvaLUE49: IntegER := 0;
argvALUe50: iNTEGer := 0;
arGVALue51: inteGER := 0;
arGVAlue52: INtegeR := 0;
arGVAlue53: iNTEger := 0;
ARgvaLUE54: INtegeR := 0;
arGVALue55: InteGER := 0;
ARgvalUE56: intEGEr := 0;
argVALue57: INTegeR := 0;
aRGValue58: IntegER := 0;
ArgvaLUE59: inteGER := 0;
arGVAlue60: iNTEger := 0;
argvALUe61: inteGER := 0;
argvALUe62: INTeger := 0;
aRGValue63: intEGEr := 0;
argvALUe64: iNTEger := 0;
ArgvALUE65: inTEGer := 0;
arGVAlue66: INTeger := 0;
arGVAlue67: INTeger := 0;
ARgvaLUE68: inteGER := 0;
ARgvalUE69: IntegER := 0;
arGVAlue70: iNTEger := 0;
arGVAlue71: iNTEger := 0;
ARGvaluE72: inTEGer := 0;
ARgvalUE73: inteGER := 0;
ARgvalUE74: inteGER := 0;
ARGValuE75: InteGER := 0;
ARgvalUE76: IntegER := 0;
ARGvalUE77: IntegER := 0;
aRGValue78: iNTEger := 0;
ArgvaLUE79: INTeger := 0;
ARgvalUE80: INTeger := 0;
arGVAlue81: InteGER := 0;
ArgvALUe82: inTEGEr := 0;
ArgvALUe83: iNTEger := 0;
arGVAlue84: iNTEGer := 0;
aRGVAlue85: INtegeR := 0;
ArgvALUe86: INTeger := 0;
ArgvALUe87: INTegeR := 0;
aRGValue88: inTEGer := 0;
ARGvaluE89: iNTEger := 0;
ARgvalUE90: inteGER := 0;
aRGValuE91: IntegER := 0;
ARgvaLUE92: IntegER := 0;
aRGValuE93: INtegeR := 0;
argvALUe94: INTegeR := 0;
ARgvalUE95: INtegeR := 0;
arGVAlue96: iNTEger := 0;
aRGValue97: intEGEr := 0;
argVALue98: iNTEger := 0;
ArgvALUe99: intEGEr := 0);
port (syscLK: in Std_lOGIc;
sysRSTn: in Std_lOGIc;
HCLk: out std_Logic;
HreseTN: out STD_logIC;
HaddR: out STD_logIC_veCTOr(31 downto 0);
hbuRST: out sTD_logIC_vecTOR(2 downto 0);
HmastLOCk: out Std_LOGIc;
hproT: out stD_logiC_VectOR(3 downto 0);
HSIze: out std_LOGic_vECTor(2 downto 0);
HTRans: out stD_logiC_VectOR(1 downto 0);
HwritE: out std_LOGic;
hwDATa: out std_Logic_VectoR(31 downto 0);
hrdaTA: in stD_LogiC_VectOR(31 downto 0);
hREAdyin: in stD_logiC;
hREAdyouT: out STD_logIC;
hRESp: in STd_loGIC;
Hsel: out Std_lOGIc_vECTor(15 downto 0);
PCLk: out STd_loGIC;
presETN: out std_LOGic;
Paddr: out STd_loGIC_veCTOr(31 downto 0);
peNABLe: out std_Logic;
PWritE: out STD_logIC;
PwdatA: out sTD_logIC_vecTOR(31 downto 0);
pRDAta: in Std_LOGIc_vECTor(31 downto 0);
preaDY: in Std_LOGic;
PSLverR: in std_LOGic;
psel: out std_LOGic_VECtor(15 downto 0);
InterRUPt: in STD_logIC_vecTOr(255 downto 0);
GP_out: out std_LOGic_vECTor(31 downto 0);
gp_IN: in Std_lOGIc_veCTOr(31 downto 0);
EXT_wr: out sTD_logIC;
eXT_rd: out STd_loGIC;
eXT_addR: out std_LOgic_VEctoR(31 downto 0);
EXt_daTA: inout STD_logIC_veCTOr(31 downto 0);
EXt_wAIT: in Std_LOGic;
fINIshed: out std_LOGic;
faILEd: out STD_logIC);
end component;

component bfm_APb
generic (VEctfiLE: STRing := "test.vec";
Max_iNSTrucTIOns: iNTEger := 16384;
tpD: intEGEr range 0 to 1000 := 1;
maX_stacK: intEGEr := 1024;
mAX_memTESt: iNTEger := 65536;
DEBugleVEL: INtegeR range -1 to 5 := -1;
aRGValue0: InteGER := 0;
argvALUe1: InteGER := 0;
argVALue2: intEGEr := 0;
aRGValue3: inTEGer := 0;
arGVAlue4: inteGER := 0;
ARgvalUE5: INTEger := 0;
arGVAlue6: INTegeR := 0;
ARGvaluE7: intEGEr := 0;
aRGValuE8: inteGER := 0;
argvALUe9: inTEGer := 0;
aRGValue10: IntegER := 0;
argVALue11: intEGEr := 0;
aRGValue12: inTEGer := 0;
ARgvaLUE13: iNTEger := 0;
arGVAlue14: inTEGEr := 0;
aRGValue15: inTEGer := 0;
arGVAlue16: intEGEr := 0;
ARGvaluE17: INtegeR := 0;
aRGValue18: INtegeR := 0;
argVALue19: iNTEger := 0;
arGVAlue20: inTEGer := 0;
ARgvalUE21: iNTEger := 0;
arGVAlue22: IntegER := 0;
argvALUe23: INtegeR := 0;
ARgvalUE24: inTEGer := 0;
ARGvaluE25: IntegER := 0;
ARgvaLUE26: inTEGEr := 0;
arGVAlue27: iNTEGer := 0;
aRGValue28: INTeger := 0;
arGVAlue29: IntegER := 0;
ARGValuE30: inTEGer := 0;
ARGValuE31: inTEGer := 0;
argVALue32: IntegER := 0;
arGVAlue33: INtegER := 0;
ArgvALUe34: inteGER := 0;
argVALue35: intEGER := 0;
ARGvaluE36: iNTEger := 0;
ARgvalUE37: InteGER := 0;
ArgvaLUE38: INTegeR := 0;
aRGValue39: InteGER := 0;
ARGvaluE40: intEGEr := 0;
ARGvaluE41: IntegER := 0;
ARgvalUE42: INtegeR := 0;
argVALue43: inteGER := 0;
arGVALue44: intEGEr := 0;
ArgvaLUE45: INTeger := 0;
arGVAlue46: inteGER := 0;
ARgvalUE47: inTEGEr := 0;
ARgvalUE48: intEGER := 0;
ARGvaluE49: InteGER := 0;
aRGValue50: INtegeR := 0;
argvALUe51: intEGEr := 0;
ARGvalUE52: INTegeR := 0;
ARGvaluE53: inTEGer := 0;
ArgvaLUE54: inTEGer := 0;
ARgvalUE55: intEGEr := 0;
argVALue56: INTegeR := 0;
ARGvaluE57: InteGER := 0;
ArgvaLUE58: inteGER := 0;
argvALUe59: IntegER := 0;
argvALUe60: INTeger := 0;
argVALue61: intEGEr := 0;
aRGVAlue62: intEGEr := 0;
ArgvALUe63: iNTEGer := 0;
argvALUe64: intEGEr := 0;
argVALue65: inTEGer := 0;
ARGvalue66: iNTEger := 0;
ArgvALUE67: INtegeR := 0;
aRGValue68: inTEGer := 0;
aRGValue69: intEGEr := 0;
argVALue70: INTegeR := 0;
ArgvaLUE71: inTEGer := 0;
aRGValuE72: IntegER := 0;
ARgvaLUE73: inteGER := 0;
aRGValue74: IntegER := 0;
ArgvaLUE75: INTeger := 0;
ArgvaLUE76: INTEger := 0;
argVALue77: inteGER := 0;
argVALue78: INtegeR := 0;
argvALUe79: INTeger := 0;
ArgvaLUE80: iNTEger := 0;
argvALUe81: iNTEger := 0;
aRGValue82: INtegER := 0;
aRGVAlue83: iNTEger := 0;
ArgvaLUE84: IntegER := 0;
ARGvaluE85: iNTEger := 0;
argvALUe86: InteGER := 0;
argvALUe87: INTeger := 0;
argVALue88: IntegER := 0;
ArgvaLUE89: inteGER := 0;
ARgvalUE90: IntegER := 0;
ARgvalUE91: IntegER := 0;
argVALue92: InteGER := 0;
arGVAlue93: iNTEger := 0;
argVALue94: INtegeR := 0;
argvALUe95: iNTEger := 0;
ArgvALUE96: INTeger := 0;
arGVAlue97: IntegER := 0;
argvALUe98: iNTEger := 0;
ARGvaluE99: IntegER := 0);
port (sYSClk: in Std_lOGIC;
sYSRStn: in STd_loGIC;
pcLK: out Std_LOGic;
PREsetn: out Std_lOGIc;
paddR: out STD_logIC_veCTOr(31 downto 0);
PenabLE: out STD_logIC;
pWRIte: out sTD_logIC;
pwdATA: out Std_lOGIc_vECTor(31 downto 0);
PRData: in STD_logIC_veCTOr(31 downto 0);
PREAdy: in sTD_logIC;
PSLverr: in stD_logiC;
pSEL: out std_LOGic_VECtor(15 downto 0);
inTERrupt: in std_LOGic_VECtor(255 downto 0);
gP_out: out std_LOgic_VEctoR(31 downto 0);
Gp_iN: in STd_loGIC_veCTOr(31 downto 0);
exT_Wr: out std_LOgic;
EXT_rd: out STD_loGIC;
EXt_adDR: out STd_loGIC_veCTOr(31 downto 0);
Ext_dATA: inout std_LOGic_vECTor(31 downto 0);
EXt_waIT: in STD_logIC;
FInishED: out STD_logIC;
fAILed: out STD_logIC);
end component;

component Bfm_aPB2apb
generic (tPD: INtegeR range 0 to 1000 := 1);
port (PClk_pM: in STd_loGIC;
PResetN_Pm: in STD_logIC;
paddR_pm: in std_LOGic_vECTor(31 downto 0);
PWrite_PM: in STd_loGIC;
pENABle_PM: in std_LOGic;
PWData_PM: in STD_loGIC_vecTOr(31 downto 0);
prdATA_pm: out Std_lOGIc_vECTor(31 downto 0);
PreadY_Pm: out sTD_logIC;
PSLverR_Pm: out STD_loGIC;
pcLK_sc: in std_LOgic;
Psel_SC: out Std_lOGIc_veCTOr(15 downto 0);
paddR_sc: out Std_lOGIC_veCTOr(31 downto 0);
pwriTE_sc: out STd_loGIC;
pENAble_SC: out Std_LOGIc;
PWdata_Sc: out Std_lOGIc_vECTor(31 downto 0);
prdaTA_sc: in sTD_logIC_vecTOR(31 downto 0);
PREady_SC: in STd_loGIC;
pslVERr_sc: in STd_loGIC);
end component;
end bfM_packAGE;

package body bfM_packAGE is
function BFMA1OIoi(BFMA1LIoi: stD_Logic_VectOR)
return intEGEr is
variable x: IntegER;
begin
x := To_inTEGer(tO_SignED(BFMA1LIoi));
return (x);
end BFMA1oioI;
function tO_Int_UNSignED(BFMA1lIOI: Std_LOGIc_vECTor)
return INTegeR is
variable x: INtegeR;
begin
x := to_INtegER(TO_unsIGNed(BFMA1Lioi));
return (X);
end To_inT_unsiGNEd;
function to_iNT_sigNED(BFMA1LIOi: STD_logIC_vecTOR)
return intEGEr is
variable X: INtegeR;
begin
x := TO_inteGER(to_sIGNed(BFMA1Lioi));
return (X);
end to_INT_sigNED;
function to_SLV32(x: INTeger)
return STD_loGIC_vecTOr is
variable BFMA1lIOI: STd_loGIC_veCTOr(31 downto 0);
begin
BFMA1Lioi := TO_std_LOgic(To_siGNEd(x,
32));
return (BFMA1LIoi);
end TO_slv32;
function BFMA1l11L(sizE: Std_LOGic_vECTor(2 downto 0);
BFMA1I11l: std_LOgic_VEctoR(1 downto 0);
BFMA1OOOi: Std_LOGic_vECTor(31 downto 0);
BFMA1LOOi: inteGER)
return sTD_logIC_vecTOR is
variable BFMA1OOIi: STD_logIC_veCTOr(31 downto 0);
variable BFMA1Loii: STd_loGIC;
begin
BFMA1OOII := ( others => '0');
BFMA1loII := BFMA1I11l(1);
case BFMA1LOoi is
when 0 =>
case SIze is
when "000" =>
case BFMA1i11L is
when "00" =>
BFMA1OOii(7 downto 0) := BFMA1OOoi(7 downto 0);
when "01" =>
BFMA1OOIi(15 downto 8) := BFMA1oOOI(7 downto 0);
when "10" =>
BFMA1OOii(23 downto 16) := BFMA1OOOi(7 downto 0);
when "11" =>
BFMA1OOII(31 downto 24) := BFMA1oooI(7 downto 0);
when others =>
end case;
when "001" =>
case BFMA1i11L is
when "00" =>
BFMA1OOIi(15 downto 0) := BFMA1oooI(15 downto 0);
when "01" =>
BFMA1Ooii(15 downto 0) := BFMA1Oooi(15 downto 0);
assert faLSE report "BFM: Missaligned AHB Cycle(Half A10=01) ?" severity WARning;
when "10" =>
BFMA1OOIi(31 downto 16) := BFMA1Oooi(15 downto 0);
when "11" =>
BFMA1OOIi(31 downto 16) := BFMA1OOoi(15 downto 0);
assert fALSe report "BFM: Missaligned AHB Cycle(Half A10=11) ?" severity warNINg;
when others =>
end case;
when "010" =>
BFMA1Ooii := BFMA1oOOI;
case BFMA1I11l is
when "00" =>
when "01" =>
assert FALse report "BFM: Missaligned AHB Cycle(Word A10=01) ?" severity WArniNG;
when "10" =>
assert fALSe report "BFM: Missaligned AHB Cycle(Word A10=10) ?" severity warNINg;
when "11" =>
assert FalsE report "BFM: Missaligned AHB Cycle(Word A10=11) ?" severity wARNing;
when others =>
end case;
when others =>
assert FALse report "Unexpected AHB Size setting" severity ErroR;
end case;
when 1 =>
case sizE is
when "000" =>
case BFMA1i11L is
when "00" =>
BFMA1OOii(7 downto 0) := BFMA1OOOi(7 downto 0);
when "01" =>
BFMA1OOii(15 downto 8) := BFMA1oOOI(7 downto 0);
when "10" =>
BFMA1Ooii(7 downto 0) := BFMA1ooOI(7 downto 0);
when "11" =>
BFMA1OOII(15 downto 8) := BFMA1OOoi(7 downto 0);
when others =>
end case;
when "001" =>
BFMA1OOii(15 downto 0) := BFMA1OOOi(15 downto 0);
case BFMA1i11L is
when "00" =>
when "01" =>
assert FAlse report "BFM: Missaligned AHB Cycle(Half A10=01) ?" severity waRNIng;
when "10" =>
assert falSE report "BFM: Missaligned AHB Cycle(Half A10=10) ?" severity warNINg;
when "11" =>
assert FAlse report "BFM: Missaligned AHB Cycle(Half A10=11) ?" severity WarnING;
when others =>
end case;
when others =>
assert FAlse report "Unexpected AHB Size setting" severity eRROr;
end case;
when 2 =>
case siZE is
when "000" =>
BFMA1Ooii(7 downto 0) := BFMA1oOOI(7 downto 0);
when others =>
assert False report "Unexpected AHB Size setting" severity ERror;
end case;
when 8 =>
BFMA1OOII := BFMA1oooi;
when others =>
assert FAlse report "Illegal Alignment mode" severity ERror;
end case;
return (BFMA1ooii);
end BFMA1L11l;
function BFMA1iooI(siZE: STd_loGIC_veCTOr(2 downto 0);
BFMA1i11L: Std_lOGIc_vECTor(1 downto 0);
BFMA1Oooi: std_LOGic_VECtor(31 downto 0);
BFMA1loOI: INtegeR)
return sTD_logIC_vecTOR is
variable BFMA1OOii: STD_loGIC_vecTOr(31 downto 0);
begin
BFMA1OOIi := BFMA1L11l(Size,
BFMA1i11l,
BFMA1OOoi,
BFMA1loOI);
return (BFMA1ooiI);
end BFMA1Iooi;
function BFMA1OLoi(Size: Std_lOGIc_veCTOr(2 downto 0);
BFMA1i11L: Std_LOGIc_vECTor(1 downto 0);
BFMA1oOOI: STD_logIC_vecTOr(31 downto 0);
BFMA1looI: iNTEger)
return stD_LogiC_VectOR is
variable BFMA1OOII: stD_logiC_VectOR(31 downto 0);
variable BFMA1loII: STD_logIC;
begin
if BFMA1looI = 8 then
BFMA1OOii := BFMA1OOoi;
else
BFMA1Ooii := ( others => '0');
BFMA1lOII := BFMA1i11L(1);
case Size is
when "000" =>
case BFMA1i11L is
when "00" =>
BFMA1ooii(7 downto 0) := BFMA1ooOI(7 downto 0);
when "01" =>
BFMA1OOii(7 downto 0) := BFMA1ooOI(15 downto 8);
when "10" =>
BFMA1ooII(7 downto 0) := BFMA1Oooi(23 downto 16);
when "11" =>
BFMA1oOII(7 downto 0) := BFMA1oooi(31 downto 24);
when others =>
end case;
when "001" =>
case BFMA1loII is
when '0' =>
BFMA1ooiI(15 downto 0) := BFMA1ooOI(15 downto 0);
when '1' =>
BFMA1ooiI(15 downto 0) := BFMA1OOOi(31 downto 16);
when others =>
end case;
when "010" =>
BFMA1OOII := BFMA1OOOi;
when others =>
assert False report "Unexpected AHB Size setting" severity ERror;
end case;
end if;
return (BFMA1ooii);
end BFMA1OLOi;
function BFMA1lloI(X: inTEGer)
return CHAracTER is
variable BFMA1IOII: CHAracTER;
begin
BFMA1IOIi := CharaCTER'val(X);
return (BFMA1IOIi);
end BFMA1LLOI;
function BFMA1iloI(sizE: inTEGer)
return cHARacteR is
variable BFMA1IOIi: CharaCTEr;
begin
case SIze is
when 0 =>
BFMA1IOIi := 'b';
when 1 =>
BFMA1ioiI := 'h';
when 2 =>
BFMA1IOii := 'w';
when 3 =>
BFMA1ioII := 'x';
when others =>
BFMA1iOII := '?';
end case;
return (BFMA1ioII);
end BFMA1ilOI;
function BFMA1iLOI(SIze: STd_loGIC_vecTOr)
return CharaCTEr is
variable BFMA1Ioii: CharaCTEr;
variable BFMA1OLIi: sTD_logiC_VectOR(2 downto 0);
begin
BFMA1oliI := siZE(2 downto 0);
case BFMA1olII is
when "000" =>
BFMA1iOII := 'B';
when "001" =>
BFMA1Ioii := 'H';
when "010" =>
BFMA1Ioii := 'W';
when "011" =>
BFMA1IOIi := 'X';
when others =>
BFMA1IOii := '?';
end case;
return (BFMA1ioii);
end BFMA1iLOI;
function BFMA1IIOi(SIze: inteGER;
BFMA1o0OI: INTEger)
return iNTEger is
variable BFMA1Ioii: INTeger;
begin
case Size is
when 0 =>
BFMA1Ioii := 1;
when 1 =>
BFMA1ioiI := 2;
when 2 =>
BFMA1IOIi := 4;
when 3 =>
BFMA1IOIi := BFMA1O0Oi;
when others =>
BFMA1Ioii := 0;
end case;
return (BFMA1IOii);
end BFMA1Iioi;
function BFMA1l0oi(size: iNTEger;
BFMA1i0OI: INtegER)
return stD_Logic_VectOR is
variable BFMA1Ioii: Std_LOGic_vECTor(2 downto 0);
begin
case SIZe is
when 0 =>
BFMA1IOIi := "000";
when 1 =>
BFMA1iOII := "001";
when 2 =>
BFMA1Ioii := "010";
when 3 =>
BFMA1IOIi := tO_std_LOGic(to_UNSigneD(BFMA1i0oI,
3));
when others =>
BFMA1iOII := "XXX";
end case;
return (BFMA1ioiI);
end BFMA1L0oi;
function BFMA1O1oi(BFMA1L1Oi: INTeger;
X,Y: InteGER;
DEbug: INtegER)
return INtegeR is
variable z: inteGER;
variable BFMA1LLIi,BFMA1iLII,BFMA1oiII: sIGNEd(31 downto 0);
variable BFMA1Liii: iNTEger;
variable BFMA1iIII: SigneD(63 downto 0);
constant BFMA1O0ii: signED(31 downto 0) := ( others => '0');
constant BFMA1L0ii: SIGNed(31 downto 0) := (0 => '1', others => '0');
begin
BFMA1lLII := TO_signED(x,
32);
BFMA1ILIi := TO_sigNED(y,
32);
BFMA1liII := y;
BFMA1OIIi := ( others => '0');
case BFMA1l1OI is
when BFMA1l0lL =>
BFMA1OIIi := ( others => '0');
when BFMA1i0LL =>
BFMA1OIIi := BFMA1lLII+BFMA1ILIi;
when BFMA1O1ll =>
BFMA1oiII := BFMA1llII-BFMA1ilII;
when BFMA1L1ll =>
BFMA1iiII := BFMA1LLii*BFMA1iliI;
BFMA1OIii := BFMA1iiII(31 downto 0);
when BFMA1i1ll =>
BFMA1OIii := BFMA1lLII/BFMA1ILII;
when BFMA1iOIL =>
BFMA1OIII := BFMA1LLII and BFMA1iliI;
when BFMA1oLIL =>
BFMA1OIIi := BFMA1LLIi or BFMA1iliI;
when BFMA1lliL =>
BFMA1oIII := BFMA1llII xor BFMA1ilII;
when BFMA1Ilil =>
BFMA1oiii := BFMA1LLii xor BFMA1Ilii;
when BFMA1lIIL =>
if BFMA1liii = 0 then
BFMA1oiII := BFMA1lLII;
else
BFMA1oIII := BFMA1o0II(BFMA1LIIi downto 1)&BFMA1LLIi(31 downto BFMA1LIIi);
end if;
when BFMA1oiil =>
if BFMA1Liii = 0 then
BFMA1Oiii := BFMA1lliI;
else
BFMA1OIIi := BFMA1LLIi(31-BFMA1LIIi downto 0)&BFMA1o0II(BFMA1LIii downto 1);
end if;
when BFMA1loIL =>
BFMA1IIii := BFMA1o0II&BFMA1l0II;
if BFMA1Liii > 0 then
for BFMA1I0Ii in 1 to BFMA1liii
loop
BFMA1Iiii := BFMA1iiII(31 downto 0)*BFMA1Llii;
end loop;
end if;
BFMA1oiii := BFMA1iIII(31 downto 0);
when BFMA1IIIl =>
if BFMA1llII = BFMA1iLII then
BFMA1oiii := BFMA1L0Ii;
end if;
when BFMA1O0il =>
if BFMA1LLIi /= BFMA1iliI then
BFMA1oIII := BFMA1l0II;
end if;
when BFMA1l0il =>
if BFMA1llii > BFMA1ILii then
BFMA1OIIi := BFMA1l0II;
end if;
when BFMA1I0Il =>
if BFMA1lLII < BFMA1ILii then
BFMA1oiII := BFMA1l0II;
end if;
when BFMA1o1IL =>
if BFMA1lliI >= BFMA1ILii then
BFMA1oiII := BFMA1l0ii;
end if;
when BFMA1L1il =>
if BFMA1llII <= BFMA1Ilii then
BFMA1oIII := BFMA1l0ii;
end if;
when BFMA1oOIL =>
BFMA1OIIi := BFMA1llII mod BFMA1ilii;
when BFMA1i1iL =>
if Y <= 31 then
BFMA1Oiii := BFMA1llII;
BFMA1oIII(Y) := '1';
else
assert False report "Bit operation on bit >31" severity FAilurE;
end if;
when BFMA1oo0L =>
if y <= 31 then
BFMA1oiiI := BFMA1Llii;
BFMA1Oiii(y) := '0';
else
assert fALSe report "Bit operation on bit >31" severity FAilurE;
end if;
when BFMA1lo0l =>
if Y <= 31 then
BFMA1OIIi := BFMA1LLii;
BFMA1oiII(y) := not BFMA1oiII(Y);
else
assert falsE report "Bit operation on bit >31" severity FAIlure;
end if;
when BFMA1IO0l =>
if Y <= 31 then
BFMA1Oiii := ( others => '0');
BFMA1oiii(0) := BFMA1llII(Y);
else
assert FALse report "Bit operation on bit >31" severity faILUre;
end if;
when others =>
assert FAlse report "Illegal Maths Operator" severity fAILure;
end case;
Z := to_INTeger(BFMA1oiII);
if (Debug >= 4) then
priNTF("Calculated %d = %d (%d) %d",
FMT(Z)&fMT(x)&fmt(BFMA1l1OI)&FMt(y));
end if;
return (z);
end BFMA1o1OI;
function BFMA1i1oi(X: STD_logIC_vecTOr)
return std_LOgic_VEctoR is
variable BFMA1O1ii: Std_lOGIc_vECTor(X'range );
begin
BFMA1o1II := x;
BFMA1O1Ii := ( others => '0');
for BFMA1I0ii in BFMA1O1Ii'range
loop
if x(BFMA1I0Ii) = '1' then
BFMA1o1iI(BFMA1i0II) := '1';
end if;
end loop;
return (BFMA1O1ii);
end BFMA1i1oi;
function BFMA1lLLI(BFMA1ILLi: inTEGer)
return IntegER is
variable BFMA1l1II: inteGER;
variable BFMA1i1II: IntegER;
variable BFMA1oO0i: intEGEr;
begin
BFMA1I1ii := BFMA1Illi/65536;
BFMA1l1II := BFMA1ILli rem 65536;
BFMA1OO0i := 2+BFMA1l1II+1+((BFMA1I1Ii-1)/4);
return (BFMA1oo0I);
end BFMA1llli;
function BFMA1OOli(BFMA1lolI: InteGER;
BFMA1iOLI: INTeger_ARray;
BFMA1OLLi: inTEGer_aRRAy)
return sTRIng is
variable BFMA1LO0i: sTRIng(1 to 256);
variable BFMA1IO0i: striNG(1 to 256);
variable BFMA1I0ii,BFMA1oL0I,BFMA1LL0i: INtegeR;
variable BFMA1Il0i: unsIGNed(31 downto 0);
variable BFMA1L1ii: InteGER;
variable BFMA1i1II: inteGER;
variable BFMA1illI: inteGER;
begin
BFMA1i1iI := BFMA1Ioli(BFMA1lOLI+1)/65536;
BFMA1L1Ii := BFMA1iolI(BFMA1lOLI+1) rem 65536;
BFMA1ILLi := 2+BFMA1L1Ii+1+((BFMA1I1ii-1)/4);
BFMA1I0ii := BFMA1lolI+2+BFMA1l1iI;
BFMA1LL0i := 3;
for BFMA1oL0I in 1 to BFMA1I1ii
loop
BFMA1il0I := to_unSIGned(BFMA1iOLI(BFMA1I0Ii),
32);
BFMA1lo0i(BFMA1OL0i) := BFMA1lLOI(To_inTEGEr(BFMA1il0i(BFMA1LL0i*8+7 downto BFMA1ll0i*8+0)));
if BFMA1ll0I = 0 then
BFMA1I0Ii := BFMA1i0iI+1;
BFMA1Ll0i := 4;
end if;
BFMA1ll0I := BFMA1LL0i-1;
end loop;
BFMA1lO0I(BFMA1I1ii+1) := Nul;
case BFMA1L1ii is
when 0 =>
sPRIntf(BFMA1IO0i,
BFMA1LO0i);
when 1 =>
spRINtf(BFMA1IO0i,
BFMA1lo0I,
FMT(BFMA1oLLI(2)));
when 2 =>
spRINtf(BFMA1Io0i,
BFMA1lO0I,
fmT(BFMA1OLli(2))&fmT(BFMA1OLLi(3)));
when 3 =>
spRINtf(BFMA1Io0i,
BFMA1LO0i,
Fmt(BFMA1OLli(2))&fmt(BFMA1ollI(3))&fMT(BFMA1OLli(4)));
when 4 =>
sPRIntf(BFMA1io0I,
BFMA1lo0I,
fmT(BFMA1ollI(2))&FMt(BFMA1Olli(3))&Fmt(BFMA1ollI(4))&Fmt(BFMA1OLLi(5)));
when 5 =>
sPRIntf(BFMA1io0I,
BFMA1lo0I,
fmT(BFMA1olli(2))&fmt(BFMA1oLLI(3))&Fmt(BFMA1ollI(4))&fmT(BFMA1olli(5))&FMt(BFMA1olLI(6)));
when 6 =>
SprinTF(BFMA1Io0i,
BFMA1LO0i,
FMt(BFMA1OLLi(2))&fMT(BFMA1oLLI(3))&Fmt(BFMA1olli(4))&fMT(BFMA1OLLi(5))&fMT(BFMA1OLli(6))&fmt(BFMA1ollI(7)));
when 7 =>
spriNTF(BFMA1IO0i,
BFMA1Lo0i,
fmt(BFMA1OLLi(2))&fmt(BFMA1Olli(3))&fmt(BFMA1Olli(4))&FMT(BFMA1OLli(5))&fmT(BFMA1OLli(6))&fmt(BFMA1olLI(7))&Fmt(BFMA1ollI(8)));
when others =>
assert falSE report "String Error" severity FAIlure;
end case;
return (BFMA1io0I);
end BFMA1ooLI;
function BFMA1iILI(BFMA1Lili,x: intEGEr)
return iNTEger is
variable BFMA1Oi0i,BFMA1LI0i: INTeger;
begin
BFMA1LI0i := BFMA1lILI/X;
BFMA1oi0I := BFMA1lILI-BFMA1li0I*x;
return (BFMA1oI0I);
end BFMA1iILI;
function BFMA1OIli(BFMA1LILi,x: IntegER)
return INTeger is
variable BFMA1oi0I,BFMA1LI0i: IntegER;
begin
BFMA1Li0i := BFMA1lILI/X;
BFMA1oI0I := BFMA1lilI-BFMA1LI0i*X;
return (BFMA1LI0i);
end BFMA1OIli;
function BFMA1o0LI(seeD: INTeger)
return intEGEr is
variable BFMA1ii0I: std_LOGic;
variable BFMA1O00i: IntegER;
variable BFMA1l00I: STD_logIC_veCTOr(31 downto 0);
variable BFMA1I00i: sTD_logiC_VectOR(31 downto 0);
begin
BFMA1l00i := to_SLV32(sEED);
BFMA1ii0I := '1';
BFMA1I00i(0) := BFMA1ii0I xor BFMA1L00i(31);
BFMA1I00i(1) := BFMA1II0i xor BFMA1L00i(31)
xor BFMA1L00i(0);
BFMA1i00i(2) := BFMA1II0i xor BFMA1l00I(31)
xor BFMA1l00I(1);
BFMA1i00I(3) := BFMA1l00I(2);
BFMA1I00i(4) := BFMA1ii0i xor BFMA1L00i(31)
xor BFMA1l00I(3);
BFMA1I00i(5) := BFMA1II0i xor BFMA1L00i(31)
xor BFMA1L00i(4);
BFMA1i00i(6) := BFMA1l00I(5);
BFMA1i00I(7) := BFMA1II0i xor BFMA1L00i(31)
xor BFMA1l00I(6);
BFMA1i00I(8) := BFMA1II0i xor BFMA1L00i(31)
xor BFMA1l00I(7);
BFMA1i00i(9) := BFMA1l00I(8);
BFMA1I00i(10) := BFMA1II0i xor BFMA1l00I(31)
xor BFMA1l00i(9);
BFMA1i00I(11) := BFMA1II0i xor BFMA1l00I(31)
xor BFMA1L00i(10);
BFMA1I00i(12) := BFMA1ii0I xor BFMA1L00i(31)
xor BFMA1l00I(11);
BFMA1I00i(13) := BFMA1l00I(12);
BFMA1i00I(14) := BFMA1L00i(13);
BFMA1i00I(15) := BFMA1L00i(14);
BFMA1i00I(16) := BFMA1Ii0i xor BFMA1l00I(31)
xor BFMA1L00i(15);
BFMA1i00I(17) := BFMA1L00i(16);
BFMA1i00I(18) := BFMA1L00i(17);
BFMA1i00i(19) := BFMA1l00I(18);
BFMA1i00I(20) := BFMA1l00I(19);
BFMA1I00i(21) := BFMA1L00i(20);
BFMA1i00i(22) := BFMA1II0i xor BFMA1L00i(31)
xor BFMA1l00i(21);
BFMA1i00i(23) := BFMA1Ii0i xor BFMA1L00i(31)
xor BFMA1l00I(22);
BFMA1I00i(24) := BFMA1l00I(23);
BFMA1i00I(25) := BFMA1L00i(24);
BFMA1I00i(26) := BFMA1ii0I xor BFMA1l00I(31)
xor BFMA1l00I(25);
BFMA1I00i(27) := BFMA1l00I(26);
BFMA1I00i(28) := BFMA1L00i(27);
BFMA1I00i(29) := BFMA1l00I(28);
BFMA1i00I(30) := BFMA1l00I(29);
BFMA1I00i(31) := BFMA1L00i(30);
BFMA1O00i := TO_int_SIgneD(BFMA1I00i);
return (BFMA1o00i);
end BFMA1o0LI;
function BFMA1L0li(SEed: intEGEr;
sIZE: INTeger)
return inTEGer is
variable BFMA1o00I: INtegeR;
variable BFMA1L00i: sTD_logIC_vecTOR(31 downto 0);
begin
BFMA1l00I := to_sLV32(Seed);
if (sIZE < 31) then
BFMA1l00I(31 downto SIZe) := ( others => '0');
end if;
BFMA1o00I := TO_int_SIGned(BFMA1l00I);
return (BFMA1O00i);
end BFMA1L0li;
function BFMA1I0li(Seed: intEGEr;
Size: INTegeR)
return INtegER is
variable BFMA1o00i: INTeger;
variable BFMA1L00i: std_LOGic_vECTor(31 downto 0);
variable BFMA1O10i: iNTEger;
begin
case siZE is
when 1 =>
BFMA1O10i := 0;
when 2 =>
BFMA1o10I := 1;
when 4 =>
BFMA1O10i := 2;
when 8 =>
BFMA1o10I := 3;
when 16 =>
BFMA1O10i := 4;
when 32 =>
BFMA1O10i := 5;
when 64 =>
BFMA1O10i := 6;
when 128 =>
BFMA1O10i := 7;
when 256 =>
BFMA1O10i := 8;
when 512 =>
BFMA1O10i := 9;
when 1024 =>
BFMA1o10I := 10;
when 2048 =>
BFMA1O10i := 11;
when 4096 =>
BFMA1O10i := 12;
when 8192 =>
BFMA1O10i := 13;
when 16384 =>
BFMA1o10I := 14;
when 32768 =>
BFMA1O10i := 15;
when 65536 =>
BFMA1O10i := 16;
when 131072 =>
BFMA1O10i := 17;
when 262144 =>
BFMA1O10i := 18;
when 524288 =>
BFMA1O10i := 19;
when 1048576 =>
BFMA1o10I := 20;
when 2097152 =>
BFMA1O10i := 21;
when 4194304 =>
BFMA1O10i := 22;
when 8388608 =>
BFMA1O10i := 23;
when 16777216 =>
BFMA1o10I := 24;
when 33554432 =>
BFMA1O10i := 25;
when 67108864 =>
BFMA1o10I := 26;
when 134217728 =>
BFMA1o10I := 27;
when 268435456 =>
BFMA1o10I := 28;
when 536870912 =>
BFMA1O10i := 29;
when 1073741824 =>
BFMA1O10i := 30;
when others =>
assert FAlse report "Random function error" severity FailURE;
end case;
BFMA1L00i := To_slV32(seed);
if (BFMA1o10I < 31) then
BFMA1L00i(31 downto BFMA1O10i) := ( others => '0');
end if;
BFMA1O00i := to_INt_siGNEd(BFMA1l00I);
return (BFMA1o00i);
end BFMA1I0li;
function BOund1K(BFMA1o1li: intEGEr;
BFMA1L1li: Std_LOGic_vECTor)
return BooleAN is
variable BFMA1l10I: booLEAn;
begin
BFMA1l10I := FALse;
case BFMA1O1li is
when 0 =>
if BFMA1L1li(9 downto 0) = "0000000000" then
BFMA1L10i := TRue;
end if;
when 1 =>
BFMA1L10i := True;
when 2 =>
when others =>
assert False report "Illegal Burst Boundary Set" severity FailuRE;
end case;
return (BFMA1l10i);
end bOUNd1k;
end BFM_paCKAge;
