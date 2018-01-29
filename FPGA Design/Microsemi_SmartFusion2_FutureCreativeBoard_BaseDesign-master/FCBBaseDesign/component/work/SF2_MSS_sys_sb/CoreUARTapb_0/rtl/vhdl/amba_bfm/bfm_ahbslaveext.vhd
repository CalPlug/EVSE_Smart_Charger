-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 6419 $
-- SVN $Date: 2009-02-04 04:34:22 -0800 (Wed, 04 Feb 2009) $
library Ieee;
use ieEE.Std_LOGic_1164.all;
use iEEE.numeRIC_stD.all;
use Work.bFM_misC.all;
use WOrk.Bfm_tEXTio.all;
use wORK.SF2_MSS_sys_sb_CoreUARTapb_0_bfM_packAGE.all;
use std.textIO.all;
entity SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVEext is
generic (awiDTH: intEGEr range 1 to 32;
DEPth: INTeger := 256;
ext_Size: INTegeR range 0 to 2 := 2;
iNITfile: StriNG := "";
id: intEGEr := 0;
eNFUNc: INTeger := 0;
enfiFO: InteGER range 0 to 1024 := 0;
Tpd: INtegeR range 0 to 1000 := 1;
Debug: intEGEr range -1 to 5 := -1); port (Hclk: in stD_LogiC;
hresETN: in sTD_logIC;
HSEl: in stD_logiC;
hWRITe: in stD_LogiC;
haDDR: in Std_LOGIc_vECTor(aWIDth-1 downto 0);
HWData: in Std_LOGic_vECTor(31 downto 0);
hrdaTA: out STd_loGIC_veCTOr(31 downto 0);
HreaDYIn: in STd_loGIC;
hREAdyouT: out Std_LOGIc;
HtraNS: in std_LOGic_VECtor(1 downto 0);
HsizE: in std_LOgic_VEctoR(2 downto 0);
HbursT: in Std_lOGIc_vECTor(2 downto 0);
HMastLOCK: in sTD_logIC;
hproT: in sTD_logIC_vecTOR(3 downto 0);
Hresp: out std_LOgic;
Ext_EN: in stD_logiC;
EXT_wr: in STd_lOGIC;
ext_RD: in sTD_logiC;
ext_ADDr: in Std_lOGIc_veCTOr(awIDTh-1 downto 0);
EXT_daTA: inout STD_logIC_veCTOr(31 downto 0);
TxreADY: out STD_loGIC;
rxrEADy: out STD_logIC);
end SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVEeXT;

architecture BFMA1io1OL of SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVEext is

signal BFMA1lIILl: INtegeR := debuG;

constant BFMA1ol00: tIME := tpd*1 ns;

subtype BFMA1iiILL is STd_loGIC_veCTOr(7 downto 0);

type BFMA1O0ill is array (iNTEger range <> ) of BFMA1IIill;

subtype BFMA1L0Ill is std_LOgic_VEctoR(31 downto 0);

type BFMA1I0Ill is array (INTegeR range <> ) of BFMA1l0ilL;

signal BFMA1O1ill: Std_LOGIc;

signal BFMA1l1ilL: STd_loGIC_veCTOr(1 downto 0);

signal BFMA1i1ILL: STD_logIC_vecTOR(2 downto 0);

signal BFMA1OO0ll: STD_logIC_veCTOr(aWIDth-1 downto 0);

signal BFMA1LO0ll: Std_LOGic;

signal BFMA1IO0ll: sTD_logIC;

signal BFMA1OL0ll: STd_lOGIC_veCTOr(3 downto 0);

signal BFMA1lL0Ll: STd_loGIc_vECTor(2 downto 0);

signal BFMA1il0lL: Std_lOGIC;

signal BFMA1OLlll: std_LOgic;

signal BFMA1Oi0ll: STD_logIC;

signal BFMA1LI0ll: stD_LogiC;

signal BFMA1II0ll: STD_logIC;

signal BFMA1o00LL: BOOLean;

signal BFMA1o0II: sTD_logIC_vecTOR(31 downto 0);

signal BFMA1L00ll: STd_loGIC;

begin
BFMA1O0Ii <= ( others => '0');
BFMA1I00ll:
process (Hclk,HresETN)
file BFMA1ll00: TExt;
file BFMA1iL00: teXT;
type BFMA1O10ll is (BFMA1L10ll,BFMA1i10LL,ext);
variable BFMA1oo1LL: BFMA1O0ill(0 to deptH-1);
variable BFMA1Lo1ll: InteGER;
variable BFMA1o10OL: iNTEger;
variable BFMA1IO1ll: stD_LogiC_VectOR(31 downto 0);
variable BFMA1ol1LL: STD_logIC_veCTOr(31 downto 0);
variable BFMA1LL1ll: inTEGer;
variable BFMA1IL1ll: inteGER := 0;
variable BFMA1oi1LL: std_Logic;
variable BFMA1LI1ll: stD_logiC;
variable BFMA1ii1Ll: std_Logic_VEctoR(1 downto 0);
variable BFMA1o01LL: STD_logIC_vecTOr(2 downto 0);
variable BFMA1L01ll: sTD_logiC_vectOR(AwidtH-1 downto 0);
variable BFMA1I01lL: sTD_logIC_vecTOR(3 downto 0);
variable BFMA1o11LL: std_LOgic_VEctoR(2 downto 0);
variable BFMA1l11Ll: sTD_logIC;
variable BFMA1i11lL: STD_logIC;
variable BFMA1OOOil: inteGER;
variable BFMA1LOoil: inteGER;
variable BFMA1iooiL: STD_logIC_vecTOr(31 downto 0);
variable BFMA1o1ii: Std_lOGIc_veCTor(7 downto 0);
variable BFMA1OLoil: STD_logIC_vecTOr(31 downto 0);
variable BFMA1llOIL: bOOLEan;
variable BFMA1ILOIl: inteGER;
variable BFMA1I0L1: boolEAN;
variable L: LIne;
variable BFMA1i000: FILe_opEN_staTUs;
variable BFMA1O100: BOoleaN := faLSE;
variable BFMA1O1l1: CHaracTER;
variable v: INtegeR;
variable BFMA1oIOIl: intEGEr;
variable BFMA1lIOIl: intEGEr;
variable BFMA1OLl1: sTRIng(1 to 80);
variable BFMA1iol1: STrinG(1 to 80);
variable BFMA1IIoil: BoolEAN;
variable BFMA1O0Oil: BOOlean;
variable BFMA1L0oil: BOOlean;
variable BFMA1i0OIl: BOOlean;
variable BFMA1O1Oil: BOOleaN;
variable BFMA1L1oiL: STd_loGIC_veCTOr(AWidth-1 downto 0);
variable BFMA1I1oil: IntegER;
variable BFMA1OOLIl: BooleAN;
variable BFMA1lOLIl: BFMA1O10ll;
variable BFMA1ioliL: BFMA1O10ll;
variable BFMA1oLLIl: inteGER;
variable BFMA1lLLIl: InteGER;
variable BFMA1illiL: std_LOgic_VEctoR(31 downto 0);
variable BFMA1OIlil: std_LOgic_VEctoR(31 downto 0);
variable BFMA1LIlil: BFMA1i0ILL(0 to enfiFO);
variable BFMA1iiliL: inTEGer;
variable BFMA1O0lil: INTegeR;
variable BFMA1L0Lil: iNTEger;
variable BFMA1I0lil: InteGER;
variable BFMA1O1Lil: intEGEr;
variable BFMA1L1lil: inteGER;
variable BFMA1I1lil: BFMA1i0ILl(0 to ENFifo);
variable BFMA1oOIIl: InteGER;
variable BFMA1loIIL: INtegeR;
variable BFMA1IOIil: inteGER;
variable BFMA1OLIIl: INTeger;
variable BFMA1Lliil: intEGEr;
variable BFMA1ILIil: intEGEr;
variable BFMA1oIIIl: INtegeR;
begin
if hCLK'Event and HCLk = '1'
and not BFMA1O100 then
if iNITfile'LEngth > 2 then
PRintf("Opening BFM AHB Slave %d Initialisation file %s",
FMt(ID)&fMT(iNITfile));
File_OPen(BFMA1i000,
BFMA1ll00,
iniTFIle);
if not (BFMA1i000 = Open_OK) then
assert fALSe report "Failed to open script file "&InitfILE severity FAIlure;
else
v := 0;
BFMA1i0L1 := fALSe;
while not BFMA1I0l1
loop
BFMA1oo1LL(v) := ( others => '0');
ReaDLIne(BFMA1ll00,
l);
for BFMA1LL0i in 1 to 8
loop
reAD(L,
BFMA1O1l1);
if BFMA1o1L1 = '1' then
BFMA1Oo1lL(V)(8-BFMA1lL0I) := '1';
end if;
end loop;
V := v+1;
BFMA1i0L1 := enDFIle(BFMA1ll00);
end loop;
FIle_CLOSe(BFMA1LL00);
prINTf(" Loaded %d Locations",
FMT(v));
end if;
end if;
BFMA1O100 := True;
end if;
if hreSETn = '0' then
BFMA1oi1lL := '1';
BFMA1iL0Ll <= '0';
HRdata <= ( others => '0');
BFMA1O1Ill <= '0';
BFMA1L1ill <= "00";
BFMA1Lo0ll <= '0';
BFMA1OO0ll <= ( others => '0');
BFMA1i1iLL <= ( others => '0');
BFMA1ollLL <= '1';
eXT_datA <= ( others => 'Z');
BFMA1lI0Ll <= '1';
BFMA1Ii0lL <= '0';
BFMA1lL1Ll := BFMA1IL1ll;
BFMA1ol1lL := ( others => '0');
BFMA1io1LL := ( others => '0');
BFMA1OOOil := 0;
BFMA1looiL := 256;
BFMA1LLOIl := falSE;
BFMA1ilOIL := 0;
BFMA1O0oil := true;
BFMA1l0oIL := fALSE;
BFMA1i0oiL := falsE;
BFMA1L1oil := ( others => '0');
BFMA1o1OIL := fALSe;
BFMA1I1oil := 67;
BFMA1oOLIl := falSE;
BFMA1iilIL := 0;
BFMA1o0liL := 0;
BFMA1L0lil := 0;
BFMA1o1LIl := 0;
BFMA1I0lil := 0;
BFMA1l1LIl := 0;
BFMA1ooIIL := 0;
BFMA1Loiil := 0;
BFMA1IOiil := 0;
BFMA1llIIL := 0;
BFMA1oliiL := 0;
BFMA1ILIil := 0;
BFMA1O00ll <= FalsE;
elsif HClk'eveNT and HClk = '1' then
BFMA1lolIL := BFMA1l10LL;
BFMA1Iolil := BFMA1l10lL;
if hREAdyin = '1' then
BFMA1o1iLL <= HSEl;
BFMA1L1Ill <= htraNS;
BFMA1lO0Ll <= HWrite;
BFMA1OO0ll <= HAddr;
BFMA1I1Ill <= hSIZe;
BFMA1OL0ll <= HPRot;
BFMA1Ll0ll <= HbursT;
BFMA1io0LL <= hmASTlock;
if BFMA1IL1ll >= 256 then
BFMA1i1OIl := BFMA1O0li(BFMA1I1oil);
BFMA1LL1ll := BFMA1i0LI(BFMA1i1OIl,
BFMA1IL1ll mod 256);
else
BFMA1ll1LL := BFMA1il1lL;
end if;
end if;
if hreaDYIn = '1' then
BFMA1LI1ll := Hsel;
BFMA1L01ll := Haddr;
BFMA1Ii1lL := HTrans;
BFMA1o01LL := hsizE;
BFMA1l11ll := HWrite;
BFMA1i01Ll := hproT;
BFMA1o11LL := HBurst;
BFMA1i11LL := HmasTLOCk;
else
BFMA1li1lL := BFMA1o1ILl;
BFMA1L01ll := BFMA1oo0LL;
BFMA1II1ll := BFMA1l1ILl;
BFMA1O01ll := BFMA1i1ILL;
BFMA1l11LL := BFMA1Lo0lL;
BFMA1I01ll := BFMA1OL0ll;
BFMA1o11Ll := BFMA1ll0LL;
BFMA1I11ll := BFMA1io0LL;
end if;
if hrEADyin = '1' and hsEL = '1'
and htrANS(1) = '1' then
if BFMA1iL1Ll >= 256 then
BFMA1I1oil := BFMA1o0lI(BFMA1I1oil);
BFMA1ll1LL := BFMA1i0lI(BFMA1i1OIl,
BFMA1Il1ll mod 256);
else
BFMA1LL1ll := BFMA1IL1ll;
end if;
BFMA1oi1lL := '0';
if BFMA1ilOIL > 0 then
BFMA1iloIL := BFMA1iLOIl-1;
end if;
if BFMA1LLoil and BFMA1ILOil = 0
and BFMA1ll1LL = 0 then
BFMA1ll1LL := 1;
end if;
end if;
if hsEL = '1' and HReadyIN = '1'
and htrANS(1) = '1'
and BFMA1l0OIl then
case hsiZE is
when "000" =>
when "001" =>
if HAddr(0) /= '0' then
BFMA1lloIL := TRue;
BFMA1ILoil := 0;
end if;
when "010" =>
if BFMA1OO0ll(1 downto 0) /= "00" then
BFMA1LLOil := tRUE;
BFMA1iloiL := 0;
end if;
when others =>
BFMA1llOIL := trUE;
end case;
if HWrite = '1' and BFMA1I0Oil
and haddR /= BFMA1L1oil then
BFMA1llOIL := tRUE;
BFMA1ILOil := 0;
end if;
end if;
BFMA1IL0ll <= '0';
if BFMA1ll1LL > 0 then
BFMA1Ll1lL := BFMA1LL1ll-1;
else
if not (BFMA1llOIL and BFMA1Iloil = 0) then
BFMA1OI1ll := '1';
elsif BFMA1IL0ll = '0' then
BFMA1IL0ll <= '1';
BFMA1oi1LL := '0';
else
BFMA1OI1ll := '1';
BFMA1iL0Ll <= '1';
BFMA1lloIL := faLSE;
end if;
end if;
BFMA1IioiL := FalsE;
if BFMA1O1Ill = '1' and BFMA1Lo0ll = '1'
and HReadyIN = '1'
and BFMA1L1Ill(1) = '1' then
BFMA1LO1ll := to_iNTEger(TO_unsIGNed(BFMA1oo0LL(haddR'LEFt downto 2)&"00"));
BFMA1O10ol := to_iNTEger(to_UnsigNED(BFMA1oo0LL(1 downto 0)));
if not (EnfunC > 0 and BFMA1lo1lL >= enfUNC
and BFMA1LO1ll < enFUNc+256) then
case BFMA1I1ill is
when "000" =>
if not BFMA1I0oil then
BFMA1OO1ll(BFMA1LO1ll+BFMA1o10oL) := HWData(BFMA1o10OL*8+7 downto BFMA1o10Ol*8+0);
IfpriNTF((BFMA1LIIll = 1),
"AHBS:%d Byte Write %08u=%02u at %t ns",
FMT(iD)&FMT(BFMA1LO1ll+BFMA1o10OL)&FMt(hwdATA(BFMA1o10Ol*8+7 downto BFMA1o10OL*8+0)));
else
BFMA1IIOil := truE;
IfpriNTF((BFMA1lIILl = 1),
"AHBS:%d Word Write %08u Misaligned or ROM at %t ns",
fmt(ID)&Fmt(BFMA1lo1LL+BFMA1O10ol));
end if;
when "001" =>
if (BFMA1o1OIl or BFMA1oO0Ll(0) = '0') and not BFMA1I0oil then
BFMA1OO1ll(BFMA1lo1LL+BFMA1o10Ol+0) := hwdATA(BFMA1O10oL*8+7 downto BFMA1O10ol*8+0);
BFMA1oO1Ll(BFMA1lo1LL+BFMA1o10OL+1) := HWData(BFMA1o10OL*8+15 downto BFMA1o10OL*8+8);
IFPrintF((BFMA1liilL = 1),
"AHBS:%d Half Write %08u=%02u at %t ns",
Fmt(id)&fmt(BFMA1LO1ll+BFMA1o10OL)&fMT(hwDATA(BFMA1O10ol*8+15 downto BFMA1O10ol*8+0)));
else
BFMA1iIOIl := tRUE;
iFPRintf((BFMA1liiLL = 1),
"AHBS:%d Half Write %08u Misaligned or ROM at %t ns",
fmt(Id)&fMT(BFMA1lo1LL+BFMA1O10ol));
end if;
when "010" =>
if (BFMA1O1oil or BFMA1Oo0ll(1 downto 0) = "00") and not BFMA1i0OIl then
BFMA1oo1LL(BFMA1LO1ll+0) := HwdaTA(7 downto 0);
BFMA1OO1ll(BFMA1LO1ll+1) := hWDAta(15 downto 8);
BFMA1OO1ll(BFMA1lo1LL+2) := hWDAta(23 downto 16);
BFMA1oo1LL(BFMA1LO1ll+3) := HWdata(31 downto 24);
ifpRINtf((BFMA1lIILl = 1),
"AHBS:%d Word Write %08u=%02u at %t ns",
fmT(ID)&Fmt(BFMA1lo1LL+BFMA1O10ol)&fmT(hwDATa));
else
BFMA1IIOil := TRue;
ifPRINtf((BFMA1liiLL = 1),
"AHBS:%d Word Write %08u Misaligned or ROM at %t ns",
fmt(ID)&FMT(BFMA1lo1LL+BFMA1O10ol));
end if;
when others =>
assert falsE report "SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVE: Illegal AHB SIZE Setting during write" severity ERror;
end case;
BFMA1Oioil := BFMA1LO1ll;
BFMA1lioiL := BFMA1OIoi(hwdaTA);
else
BFMA1IOLil := BFMA1i10ll;
BFMA1oLLIl := BFMA1lo1LL-eNFUnc;
BFMA1ILlil := HwdatA;
end if;
BFMA1OLoil := BFMA1O0Ii(31 downto 20)&"00"&BFMA1io0LL&BFMA1LO0ll&'0'&BFMA1ll0LL&BFMA1ol0LL&'0'&BFMA1I1Ill&"00"&BFMA1L1Ill;
end if;
BFMA1OL1ll := ( others => '0');
if BFMA1oOLIl then
BFMA1OL1ll := ( others => 'X');
end if;
if BFMA1oI1Ll = '1' and BFMA1lI1Ll = '1'
and BFMA1iI1Ll(1) = '1'
and BFMA1l11LL = '0' then
BFMA1lo1LL := to_iNTEger(TO_unsIGNed(BFMA1l01Ll(HADDr'Left downto 2)&"00"));
BFMA1O10ol := TO_inteGER(TO_unsiGNEd(BFMA1L01lL(1 downto 0)));
case BFMA1o01LL is
when "000" =>
BFMA1ol1LL(BFMA1o10OL*8+7 downto BFMA1O10ol*8+0) := BFMA1Oo1lL(BFMA1LO1ll+BFMA1O10ol);
IfpriNTF((BFMA1liILL = 1),
"AHBS:%d Byte Read %08u=%02u at %t ns",
fmT(iD)&fMT(BFMA1LO1ll)&fMT(BFMA1oL1Ll(BFMA1O10ol*8+7 downto BFMA1O10ol*8+0)));
when "001" =>
if BFMA1O1oil or BFMA1L01ll(0) = '0' then
BFMA1Ol1ll(BFMA1o10Ol*8+15 downto BFMA1O10ol*8+0) := BFMA1oo1LL(BFMA1LO1ll+BFMA1O10ol+1)&BFMA1OO1ll(BFMA1LO1ll+BFMA1o10Ol+0);
ifPRIntf((BFMA1liiLL = 1),
"AHBS:%d Half Read %08u=%04u at %t ns",
fmT(id)&FMt(BFMA1LO1ll+BFMA1O10ol)&fmt(BFMA1OL1ll(BFMA1O10ol*8+15 downto BFMA1o10oL*8+0)));
else
ifPRIntf((BFMA1Liill = 1),
"AHBS:%d Half Read %08u Misaligned at %t ns",
FMT(Id)&FMt(BFMA1lo1LL));
BFMA1iIOIl := trUE;
BFMA1OL1ll := ( others => '0');
end if;
when "010" =>
if BFMA1O1Oil or BFMA1L01ll(1 downto 0) = "00" then
BFMA1ol1LL := BFMA1OO1ll(BFMA1lo1lL+3)&BFMA1OO1ll(BFMA1lo1LL+2)&BFMA1oo1LL(BFMA1LO1ll+1)&BFMA1oO1Ll(BFMA1lo1LL+0);
ifPRIntf((BFMA1liiLL = 1),
"AHBS:%d Word Read %08u=%08u at %t ns",
FMt(ID)&Fmt(BFMA1Lo1ll)&fmt(BFMA1oL1Ll));
else
ifPRIntf((BFMA1liILL = 1),
"AHBS:%d Word Read %08u Misaligned at %t ns",
Fmt(id)&fmt(BFMA1lo1LL));
BFMA1iIOIl := TRUe;
BFMA1OL1ll := ( others => '0');
end if;
when others =>
assert FALse report "SF2_MSS_sys_sb_CoreUARTapb_0_BFM_AHBSLAVE: Illegal AHB SIZE Setting during read" severity erroR;
end case;
if not (EnfuNC > 0 and BFMA1LO1ll >= ENFunc
and BFMA1LO1ll < enfUNC+256) then
BFMA1OLoil := BFMA1o0iI(31 downto 20)&"00"&BFMA1i11lL&BFMA1L11ll&'0'&BFMA1o11LL&BFMA1I01ll&'0'&BFMA1O01ll&"00"&BFMA1ii1LL;
BFMA1OIOil := BFMA1lo1lL;
BFMA1LIoil := BFMA1OIOi(BFMA1ol1LL);
else
BFMA1Lolil := BFMA1I10ll;
BFMA1Lllil := BFMA1lO1Ll-ENfunc;
BFMA1OILil := BFMA1oL1Ll;
end if;
end if;
if BFMA1IIoil and BFMA1o0OIL then
PRintf("AHBS:%d Misaligned Transfer - %08u",
fmt(ID)&FMt(BFMA1LO1ll+BFMA1O10oL));
assert fALSe report "Misaligned Transfer Detected" severity ERror;
end if;
EXt_daTA <= ( others => 'Z');
if ext_En = '1' and EXT_rd = '1' then
case eXT_sizE is
when 0 =>
BFMA1lo1lL := TO_intEGEr(tO_unsiGNEd(EXt_adDR(ext_ADDr'Left downto 0)));
when 1 =>
BFMA1lo1LL := TO_inteGER(to_UNsigNED(EXt_adDR(ext_ADDr'LEFt downto 1)&'0'));
when 2 =>
BFMA1Lo1ll := To_iNTEger(To_unSIGned(EXt_adDR(ext_Addr'LEFt downto 2)&"00"));
end case;
if not (ENFUnc > 0 and BFMA1lO1ll >= EnfunC
and BFMA1lO1Ll < ENFunc+256) then
case EXt_siZE is
when 0 =>
BFMA1io1LL := BFMA1o0iI(31 downto 8)&BFMA1OO1ll(BFMA1lO1Ll+0);
when 1 =>
BFMA1Io1lL := BFMA1o0II(31 downto 16)&BFMA1OO1ll(BFMA1lo1lL+1)&BFMA1oO1Ll(BFMA1Lo1ll+0);
when 2 =>
BFMA1iO1Ll := BFMA1OO1ll(BFMA1LO1ll+3)&BFMA1OO1ll(BFMA1LO1ll+2)&BFMA1Oo1ll(BFMA1lo1LL+1)&BFMA1oo1LL(BFMA1lo1LL+0);
end case;
IFPrintF(BFMA1LIIll >= 1,
"AHBS: Slot %d Extension Read %04x=%04x ",
fmt(ID)&Fmt(BFMA1lO1Ll)&FMt(BFMA1IO1ll));
Ext_DATa <= BFMA1IO1ll;
else
assert BFMA1LOLil = BFMA1l10LL report "AHBS slave does not allow simultanous EXT and AHB access to control registers" severity ERror;
BFMA1lOLIl := EXT;
BFMA1lllIL := BFMA1lo1lL-EnfunC;
BFMA1OILil := ( others => '0');
end if;
end if;
if eXT_en = '1' and ext_WR = '1' then
case Ext_sIZE is
when 0 =>
BFMA1Lo1ll := to_INtegeR(to_UNsigNED(EXT_adDR(Ext_aDDR'lefT downto 0)));
when 1 =>
BFMA1LO1ll := tO_InteGER(to_UNSigneD(EXt_adDR(Ext_aDDR'lEFT downto 1)&'0'));
when 2 =>
BFMA1Lo1ll := to_INtegER(TO_unsIGNed(Ext_aDDR(EXT_adDR'Left downto 2)&"00"));
end case;
if not (ENFUnc > 0 and BFMA1LO1ll >= ENfunc
and BFMA1LO1ll < enFUNc+256) then
case Ext_sIZE is
when 0 =>
BFMA1oo1LL(BFMA1LO1ll+0) := EXT_datA(7 downto 0);
when 1 =>
BFMA1OO1ll(BFMA1lO1Ll+0) := exT_data(7 downto 0);
BFMA1Oo1lL(BFMA1lo1lL+1) := Ext_DATa(15 downto 8);
when 2 =>
BFMA1OO1ll(BFMA1lo1LL+0) := ext_Data(7 downto 0);
BFMA1oo1LL(BFMA1lo1LL+1) := ext_DAta(15 downto 8);
BFMA1OO1ll(BFMA1lo1LL+2) := EXt_daTA(23 downto 16);
BFMA1oO1Ll(BFMA1lo1LL+3) := EXT_daTA(31 downto 24);
end case;
IfpriNTF(BFMA1LIill >= 1,
"AHBS: Slot %d Extension Write %04x=%04x ",
FMT(Id)&fMT(BFMA1LO1ll)&FMT(exT_Data));
else
assert BFMA1LOlil = BFMA1L10ll report "AHBS slave does not allow simultanous EXT and AHB access" severity erroR;
BFMA1IOLIl := EXT;
BFMA1OLLil := BFMA1lo1LL-EnfuNC;
BFMA1iLLIl := EXT_datA;
end if;
end if;
if BFMA1oooiL > 1 then
BFMA1ooOIL := BFMA1oOOIl-1;
elsif BFMA1ooOIL = 1 then
priNTF("UPDATED %08x  %08x",
FMt(enFUNc+28)&Fmt(BFMA1IOOil));
BFMA1oO1Ll(EnfunC+28+0) := BFMA1IOoil(7 downto 0);
BFMA1OO1ll(enfUNC+28+1) := BFMA1IOOil(15 downto 8);
BFMA1oo1LL(enFUNc+28+2) := BFMA1iooIL(23 downto 16);
BFMA1oo1lL(ENfunc+28+3) := BFMA1IOoil(31 downto 24);
BFMA1OOOil := 0;
end if;
if BFMA1iOLIl /= BFMA1l10lL then
PRintf("AHBS:%d Setting ENFUNC %d %d",
fMT(Id)&fmt(BFMA1OLLil)&FMT(BFMA1illIL));
case BFMA1oLLIl is
when 0 =>
BFMA1llOIL := True;
BFMA1IloiL := BFMA1oIOI(BFMA1ilLIL(7 downto 0));
prINTf("AHBS: HRESP will be set on the %d access",
Fmt(BFMA1Iloil));
when 4 =>
BFMA1il1LL := tO_int_UNSignED(BFMA1Illil(9 downto 0));
BFMA1oI1Ll := '1';
BFMA1LL1ll := 0;
if BFMA1iL1Ll >= 256 then
PRintf("AHBS:HREADY timing random 0 to %d cycles",
fmt(BFMA1il1LL mod 256));
else
pRINtf("AHBS:HREADY timing %d cycles ",
FMT(BFMA1il1lL));
end if;
when 8 =>
BFMA1LIill <= To_inT_unsiGNEd(BFMA1iLLIl(7 downto 0));
when 12 =>
BFMA1Oo1ll := ( others => ( others => '0'));
when 16 =>
for BFMA1I0ii in 0 to deptH-1
loop
BFMA1oO1Ll(BFMA1i0iI) := not tO_Std_LOGic(to_UNSignED(BFMA1I0ii,
32))(7 downto 0);
end loop;
when 24 =>
BFMA1O0Oil := (BFMA1ILlil(0) = '1');
BFMA1l0oIL := (BFMA1ILLil(1) = '1');
BFMA1i0OIl := (BFMA1ILLil(2) = '1');
BFMA1o1oiL := (BFMA1ILLil(3) = '1');
BFMA1l1oiL := BFMA1OO0ll;
PrinTF("AHBS: Misaligned Transfer Detection set to %d",
fmt(hWDAta(2 downto 0)));
when 28 =>
prINTf("AHBS: Delaying write of %08x for %d Clocks",
fMT(BFMA1illIL)&Fmt(BFMA1Looil));
BFMA1IooiL := BFMA1ilLIL;
BFMA1oooIL := BFMA1LOoil;
when 32 =>
BFMA1loOIL := BFMA1OIOi(BFMA1illIL);
when 36 =>
BFMA1o100 := fALSe;
when 40 =>
SpriNTF(BFMA1Oll1,
"image%d.txt",
Fmt(id));
FIle_OPEn(BFMA1i000,
BFMA1Il00,
BFMA1olL1,
WRIte_MODE);
if BFMA1I000 = opeN_ok then
priNTF("AHBS:%d: Dumping to %s",
fmt(ID)&fmt(BFMA1oll1));
else
assert FalsE report "Logfile open failed" severity FailuRE;
end if;
for BFMA1i0II in 0 to dEPTh-1
loop
BFMA1O1ii := ( others => '0');
for BFMA1Ii1l in 0 to 7
loop
if BFMA1Oo1ll(BFMA1i0II)(BFMA1II1l) = '1' then
BFMA1o1II(BFMA1ii1L) := '1';
end if;
end loop;
SpriNTF(BFMA1iol1,
"%08b",
FMt(BFMA1o1ii));
WRIte(L,
BFMA1Iol1);
wRITelinE(BFMA1iL00,
L);
end loop;
File_CLOse(BFMA1il00);
when 52 =>
BFMA1OOlil := (BFMA1ILlil(0) = '1');
PrintF("AHBS: Special Mode Enables set to %d",
Fmt(BFMA1ILLil(2 downto 0)));
when 128 =>
BFMA1lILIl(BFMA1IIlil) := BFMA1illIL;
BFMA1L0Lil := BFMA1l0lIL+1;
if BFMA1Iilil = EnfiFO-1 then
BFMA1iiLIL := 0;
else
BFMA1iilIL := BFMA1Iilil+1;
end if;
if (BFMA1i0liL > 0 and BFMA1l1lIL <= BFMA1I0Lil) or BFMA1li0LL = '0' then
assert FAlse report "AHBS:Detected Write to TXFIFO when iTXREADY=0" severity ERRor;
end if;
BFMA1L1lil := 0;
when 136 =>
BFMA1oiiiL := BFMA1oIOI(BFMA1ILLil);
if BFMA1OIIil = 0 then
BFMA1iILIl := 0;
BFMA1O0lil := 0;
BFMA1l0lIL := 0;
else
end if;
when 140 =>
BFMA1o1LIl := BFMA1oioi(BFMA1ILlil);
when 144 =>
BFMA1i0LIL := BFMA1Oioi(BFMA1ILLil);
BFMA1L1Lil := BFMA1OIOi(BFMA1ilLIL);
when 148 =>
BFMA1O00ll <= (BFMA1IlliL(0) = '1');
when 160 =>
BFMA1I1Lil(BFMA1ooiIL) := BFMA1illIL;
BFMA1IOiil := BFMA1ioiiL+1;
if BFMA1ooIIL = EnfifO-1 then
BFMA1OOIIl := 0;
else
BFMA1OOIil := BFMA1oOIIl+1;
end if;
when 168 =>
BFMA1OIIil := BFMA1oiOI(BFMA1ILlil);
if BFMA1OIiil = 0 then
BFMA1ooIIL := 0;
BFMA1loiiL := 0;
BFMA1iOIIl := 0;
else
end if;
when 172 =>
BFMA1lLIIl := BFMA1Oioi(BFMA1iLLIl);
when 176 =>
BFMA1OLiil := BFMA1OIoi(BFMA1ILlil);
BFMA1iLIIl := BFMA1oIOI(BFMA1ILLil);
when others =>
end case;
end if;
if BFMA1loliL /= BFMA1l10Ll then
case BFMA1Lllil is
when 20 =>
BFMA1oiLIL := BFMA1OLOil;
when 28 =>
PRIntf("ADDR 28   CNT %d",
fMT(BFMA1oooiL));
when 44 =>
BFMA1OILIl := To_sLV32(BFMA1oIOIl);
when 48 =>
BFMA1Oilil := to_sLV32(BFMA1lioIL);
when 132 =>
BFMA1oiLIL := BFMA1LILil(BFMA1o0lIL);
BFMA1L0lil := BFMA1l0Lil-1;
if BFMA1o0LIl = eNFIfo-1 then
BFMA1O0Lil := 0;
else
BFMA1o0lIL := BFMA1o0lIL+1;
end if;
when 136 =>
BFMA1oILIl := to_SLv32(BFMA1L0liL);
when 164 =>
BFMA1oiliL := BFMA1i1LIl(BFMA1LOiil);
BFMA1IOiil := BFMA1IOIil-1;
BFMA1Iliil := 0;
if BFMA1LOiil = EnfifO-1 then
BFMA1loiiL := 0;
else
BFMA1LOiil := BFMA1LOIil+1;
end if;
if (BFMA1OLIil > 0 and BFMA1Iliil <= BFMA1Oliil) or BFMA1ii0LL = '0' then
assert falsE report "AHBS:Detected Read from RXFIFO when iRXREADY=0" severity ErroR;
end if;
when 168 =>
BFMA1OILil := To_sLV32(BFMA1iOIIl);
when others =>
end case;
if BFMA1LOlil = exT then
ext_DAta <= BFMA1OiliL;
end if;
if BFMA1Lolil = BFMA1i10lL then
BFMA1Ol1ll := BFMA1OIlil;
end if;
end if;
if BFMA1L1lil >= BFMA1I0lil then
BFMA1li0LL <= '1';
if BFMA1L0lil = ENfifo then
BFMA1LI0ll <= '0';
end if;
else
if BFMA1l1LIl >= BFMA1o1LIL then
BFMA1lI0Ll <= '0';
end if;
end if;
if BFMA1iliiL >= BFMA1oliiL then
BFMA1II0ll <= '1';
if BFMA1Ioiil = 0 then
BFMA1Ii0ll <= '0';
end if;
else
if BFMA1ilIIL >= BFMA1LLiil then
BFMA1II0ll <= '0';
end if;
end if;
BFMA1l1LIl := BFMA1L1Lil+1;
BFMA1ILIil := BFMA1iliIL+1;
hrDATa <= BFMA1oL1ll after BFMA1Ol00;
BFMA1Ollll <= BFMA1oI1Ll;
end if;
end process;
HresP <= BFMA1il0LL after BFMA1OL00;
HReadyOUT <= BFMA1olllL after BFMA1ol00;
tXREady <= BFMA1LI0ll when not BFMA1o00lL else
BFMA1ii0LL after BFMA1oL00;
rxreADY <= BFMA1ii0lL when not BFMA1o00LL else
BFMA1Li0ll after BFMA1OL00;
BFMA1liIIL:
process (hclk,hresETN)
variable BFMA1iiiiL: booLEAn;
begin
if HReseTN = '0' then
BFMA1L00lL <= '0';
BFMA1oI0Ll <= '0';
elsif Hclk'EVent and HClk = '1' then
BFMA1Iiiil := FAlse;
if HTrans = "00" and hreaDYIn = '1' then
BFMA1L00ll <= '0';
end if;
if HTrans /= "00" then
BFMA1L00ll <= '1';
end if;
if hTRAns = "11" and haDDR(9 downto 0) = BFMA1o0II(9 downto 0) then
PRintF("AHBS: AHB Violation: 1K Boundary Crossed");
BFMA1IIiil := TRUe;
end if;
if HReadYIN = '1' then
BFMA1OI0ll <= '0';
end if;
if HSEl = '1' and HtranS /= "00"
and HreadYIN = '1' then
BFMA1oi0LL <= '1';
end if;
if BFMA1oI0ll = '1' and hrEADyin /= BFMA1oLLLl then
assert False report "AHBS: HREADYIN was not the same as HREADYOUT when selected" severity eRROr;
end if;
if BFMA1IIIil then
assert False report "AHB Violation" severity FAIlure;
end if;
end if;
end process;
end BFMA1io1oL;
