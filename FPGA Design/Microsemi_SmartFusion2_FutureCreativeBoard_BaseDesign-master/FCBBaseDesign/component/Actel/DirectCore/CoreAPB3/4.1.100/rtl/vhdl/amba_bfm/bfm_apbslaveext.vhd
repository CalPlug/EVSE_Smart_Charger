-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 11878 $
-- SVN $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $
library ieeE;
use Ieee.sTD_logIC_1164.all;
use ieeE.numeRIC_std.all;
use woRK.BFm_mISC.all;
use WOrk.BFM_teXTIo.all;
use Work.BFM_pacKAGe.all;
use sTD.TExtio.all;
entity BFM_apBSLaveeXT is
generic (aWIDth: iNTEGer range 1 to 32;
dEPTh: inTEGer := 256;
dwidTH: IntegER range 8 to 32 := 32;
EXT_sizE: intEGER range 0 to 2 := 2;
initFILe: striNG := "";
ID: intEGEr := 0;
tpD: INTeger range 0 to 1000 := 1;
ENfunc: INtegeR := 0;
DEBUg: InteGER range 0 to 1 := 0); port (pclK: in STd_loGIC;
PREsetn: in stD_LogiC;
PEnablE: in Std_lOGIc;
pWRITe: in std_LOGic;
Psel: in stD_logiC;
paDDR: in STD_loGIC_veCTOr(AwidTH-1 downto 0);
pWDAta: in std_LOGIc_vECTor(DWIdth-1 downto 0);
PRdata: out sTD_logIC_vecTOR(dWIDth-1 downto 0);
prEADy: out sTD_logIC;
PSLverr: out sTD_logIC;
EXt_en: in stD_LogiC;
exT_wr: in std_LOGic;
ext_Rd: in Std_LOGic;
EXT_addR: in std_LOGic_VECtor(AWidth-1 downto 0);
ext_Data: inout std_lOGIc_vECTor(dwidTH-1 downto 0));
end BFm_apBSLaveeXT;

architecture BFMA1io1OL of bfM_ApbsLAVeexT is

type BFMA1o0ILL is array (intEGEr range <> ) of Std_LOGic_vECTor(7 downto 0);

signal BFMA1liiLL: INtegeR := DEbug;

signal BFMA1o0iIL: std_LOGic;

signal BFMA1L0Iil: stD_LogiC;

signal BFMA1i0IIl: std_LOGic;

signal BFMA1o1iiL: std_LOGic;

signal BFMA1l1iIL: std_Logic;

signal BFMA1i1IIl: std_Logic;

signal BFMA1OO0il: Std_lOGIc;

signal BFMA1LO0il: sTD_logIC;

signal BFMA1iO0Il: STd_loGIC;

signal BFMA1OL0il: sTD_logIC_vecTOR(AwidtH-1 downto 0);

signal BFMA1Ll0iL: STD_loGIC_vecTOr(AWidth-1 downto 0);

signal BFMA1iL0Il: Std_lOGIc_veCTor(awiDTH-1 downto 0);

signal BFMA1OI0il: std_LOGic_VECtor(dwidTH-1 downto 0);

signal BFMA1Li0il: sTD_logIC_vecTOR(dwIDTH-1 downto 0);

signal BFMA1ii0IL: sTD_logIC_vecTOR(dwidTH-1 downto 0);

signal BFMA1OOoll: Std_lOGIc_veCTor(31 downto 0);

signal BFMA1o00Il: stD_logiC_VectOR(31 downto 0);

signal BFMA1L00il: STd_loGIC;

signal BFMA1I00iL: sTD_logIC;

signal BFMA1O10il: Std_lOGIC_veCTOr(31 downto 0);

signal BFMA1o0II: std_LOGic_vECtor(31 downto 0);

constant BFMA1OL00: time := tpD*1 ns;

begin
BFMA1O0Ii <= ( others => '0');
BFMA1i00Ll:
process (Pclk,PResetN)
file BFMA1LL00: tEXT;
file BFMA1il00: TExt;
variable BFMA1oO1ll: BFMA1o0ILL(0 to DEPth-1);
variable BFMA1LO1ll: iNTEger := 0;
variable BFMA1Ol1lL: std_LOGic_vECTor(31 downto 0);
variable BFMA1OI1ll: STD_logIC;
variable BFMA1oOOIl: IntegER;
variable BFMA1LooiL: inteGER;
variable BFMA1IOOil: Std_lOGIC_veCTOr(31 downto 0);
variable BFMA1lloIL: BOoleaN;
variable BFMA1iloiL: INTegeR;
variable BFMA1IL1ll: intEGEr := 0;
variable BFMA1Ll1ll: inteGER;
variable BFMA1O1ii: Std_LOGIc_vECTor(7 downto 0);
variable BFMA1i0L1: BOoleAN;
variable l: Line;
variable BFMA1I000: FILe_opEN_stATUs;
variable BFMA1O100: BooleAN := falSE;
variable BFMA1o1L1: CHaracTER;
variable v: inteGER;
variable BFMA1Oioil: inTEGer;
variable BFMA1LIOil: integER;
variable BFMA1oLL1: STRing(1 to 80);
variable BFMA1iol1: STRing(1 to 80);
variable BFMA1I1Oil: INtegeR;
variable BFMA1l10iL: INTeger;
variable BFMA1OOlil: bOOLean;
begin
if pcLK'EVEnt and pclk = '1'
and not BFMA1O100 then
if INitfILE'LENGth > 2 then
PrinTF("Opening BFM APB Slave %d Initialisation file %s",
Fmt(id)&FMt(InitFILE));
filE_Open(BFMA1I000,
BFMA1LL00,
INitfiLE);
if not (BFMA1I000 = opeN_ok) then
assert FALse report "Failed to open script file "&inITFile severity faILURe;
else
v := 0;
BFMA1I0l1 := falsE;
while not BFMA1I0l1
loop
BFMA1OO1ll(v) := ( others => '0');
reaDLIne(BFMA1ll00,
L);
for BFMA1lL0I in 1 to 8
loop
reAD(L,
BFMA1o1l1);
if BFMA1o1l1 = '1' then
BFMA1Oo1lL(V)(8-BFMA1Ll0i) := '1';
end if;
end loop;
V := V+1;
BFMA1I0L1 := eNDFile(BFMA1lL00);
end loop;
FIle_cLOSe(BFMA1ll00);
priNTF(" Loaded %d Locations",
FMT(V));
end if;
end if;
BFMA1o100 := TRUe;
end if;
if PREsetn = '0' then
BFMA1OooiL := 0;
BFMA1lOOIl := 256;
BFMA1lloIL := falSE;
BFMA1iloiL := 0;
BFMA1il1lL := 0;
BFMA1Oi1ll := '0';
BFMA1L00il <= '0';
BFMA1i00Il <= '0';
BFMA1i1oIL := 69;
BFMA1OOlil := FAlse;
BFMA1o10IL <= ( others => '0');
exT_data <= ( others => 'Z');
elsif Pclk'EVent and pclK = '1' then
BFMA1OI1ll := '0';
BFMA1I00il <= '0';
if pseL = '1' then
BFMA1LO1ll := to_INTeger(to_uNSIgneD(pADDr(Paddr'Left downto 2)&"00"));
if pseL = '1' and PenabLE = '0' then
if BFMA1il1LL >= 256 then
BFMA1I1Oil := BFMA1o0lI(BFMA1I1oiL);
BFMA1L10il := BFMA1I0Li(BFMA1I1Oil,
BFMA1il1LL mod 256);
else
BFMA1L10il := BFMA1iL1Ll;
end if;
BFMA1ll1LL := BFMA1L10il-1;
if BFMA1l10il = 0 then
BFMA1oi1LL := '1';
BFMA1LL1ll := 0;
end if;
end if;
if PSel = '1' and PENable = '1'
and BFMA1IL1ll > 0 then
if BFMA1LL1ll > 0 then
BFMA1LL1ll := BFMA1ll1lL-1;
elsif BFMA1L00il = '0' then
BFMA1oi1lL := '1';
if BFMA1IL1ll >= 256 then
BFMA1I1Oil := BFMA1o0lI(BFMA1i1oIL);
BFMA1ll1LL := BFMA1i0LI(BFMA1i1OIl,
BFMA1IL1ll mod 256);
else
BFMA1LL1ll := BFMA1iL1Ll;
end if;
else
BFMA1OI1ll := '0';
end if;
end if;
if psel = '1' and BFMA1OI1ll = '1' then
if BFMA1LLOIl then
if BFMA1Iloil > 1 then
BFMA1ilOIL := BFMA1ILOil-1;
else
BFMA1lLOIL := FAlse;
BFMA1I00il <= '1';
end if;
end if;
end if;
if (peNABle = '1' and PWRite = '1'
and BFMA1l00Il = '1') or (exT_wr = '1') then
if not (enfuNC > 0 and BFMA1LO1ll >= ENfunc
and BFMA1lo1LL < enfUNC+256) then
BFMA1oO1Ll(BFMA1Lo1lL+0) := BFMA1OOOll(7 downto 0);
BFMA1oo1LL(BFMA1LO1ll+1) := BFMA1OOOLl(15 downto 8);
BFMA1oo1lL(BFMA1Lo1lL+2) := BFMA1oooLL(23 downto 16);
BFMA1oo1lL(BFMA1lo1LL+3) := BFMA1oooLL(31 downto 24);
IfprINTF(BFMA1liiLL >= 1,
"APBS:%d Write %04x=%04x ",
fmt(ID)&Fmt(BFMA1LO1ll)&Fmt(PwdaTA));
BFMA1Oioil := BFMA1lo1LL;
BFMA1Lioil := BFMA1oioi(pwdaTA);
else
if (enfuNC > 0 and BFMA1lo1lL >= enfUNC
and BFMA1lo1LL < ENfunC+256) then
prinTF("APBS:%d Setting ENFUNC %d %d",
FMT(id)&fmt(BFMA1lo1lL-ENfunc)&fmT(pWDAta));
case BFMA1Lo1lL-ENfunC is
when 0 =>
BFMA1lloIL := TRUe;
BFMA1ILoil := BFMA1oioi(pwdaTA(7 downto 0));
PRintf("APBS: PSLVERR  will be set on the %d access",
fmt(BFMA1ILoil));
when 4 =>
BFMA1iL1Ll := to_iNT_unsIGned(PWdatA(9 downto 0));
BFMA1oI1Ll := '1';
BFMA1ll1LL := 0;
if BFMA1il1LL >= 256 then
PrintF("APBS:PREADY timing random 0 to %d cycles",
fmT(BFMA1il1LL mod 256));
else
prINTf("APBS:PREADY timing %d cycles ",
fMT(BFMA1IL1ll));
end if;
when 8 =>
BFMA1liiLL <= BFMA1OIoi(PWData(7 downto 0));
when 12 =>
BFMA1Oo1ll := ( others => ( others => '0'));
when 16 =>
for BFMA1I0Ii in 0 to dEPTh-1
loop
BFMA1OO1ll(BFMA1i0iI) := not To_sTD_logIC(TO_unsIGNed(BFMA1I0Ii,
32))(7 downto 0);
end loop;
when 28 =>
BFMA1IOOil := BFMA1oooLL;
BFMA1oooIL := BFMA1LOoil;
when 32 =>
BFMA1looiL := BFMA1oioi(pwDATa);
when 36 =>
BFMA1o100 := fALSe;
when 40 =>
SprinTF(BFMA1olL1,
"image%d.txt",
fMT(id));
File_Open(BFMA1I000,
BFMA1iL00,
BFMA1oll1,
WritE_Mode);
if BFMA1I000 = Open_OK then
priNTF("APBS:%d: Dumping to %s",
fmt(id)&FMt(BFMA1oll1));
else
assert FALse report "Logfile open failed" severity faILURe;
end if;
for BFMA1i0ii in 0 to dEPTh-1
loop
BFMA1o1iI := ( others => '0');
for BFMA1II1l in 0 to 7
loop
if BFMA1oo1LL(BFMA1I0Ii)(BFMA1Ii1l) = '1' then
BFMA1o1iI(BFMA1ii1L) := '1';
end if;
end loop;
SPRintf(BFMA1iol1,
"%08b",
fmt(BFMA1O1ii));
WRIte(l,
BFMA1iOL1);
WRitelINE(BFMA1il00,
L);
end loop;
File_CLOse(BFMA1iL00);
when 52 =>
BFMA1oolIL := (pwdATA(0) = '1');
PRintF("APBS: Special Mode Enables set to %d",
fMT(pWDATa(2 downto 0)));
if BFMA1OOlil then
BFMA1O10il <= ( others => 'X');
else
BFMA1o10Il <= ( others => '0');
end if;
when others =>
end case;
end if;
end if;
end if;
if Psel = '1' and pwRITe = '0'
and BFMA1OI1ll = '1' then
BFMA1OL1ll := BFMA1OO1ll(BFMA1LO1ll+3)&BFMA1OO1ll(BFMA1lo1lL+2)&BFMA1OO1ll(BFMA1lo1LL+1)&BFMA1oo1LL(BFMA1lo1LL+0);
if not (ENfunc > 0 and BFMA1lo1lL >= enfuNC
and BFMA1LO1ll < enFUNc+256) then
BFMA1oioIL := BFMA1Lo1lL;
BFMA1lIOIl := BFMA1OIoi(BFMA1OL1ll);
else
case BFMA1LO1ll-enFUNc is
when 44 =>
BFMA1Ol1ll := to_SLV32(BFMA1oiOIL);
when 48 =>
BFMA1ol1LL := TO_slV32(BFMA1lioiL);
when others =>
end case;
end if;
BFMA1O00il <= BFMA1OL1ll;
end if;
if pSEL = '1' and PwritE = '0'
and PEnablE = '1'
and BFMA1l00iL = '1' then
IfpriNTF(BFMA1Liill >= 1,
"APBS:%d Read %04x=%04x ",
fmt(id)&FMT(BFMA1lO1Ll)&fMT(BFMA1OL1ll));
end if;
end if;
BFMA1L00il <= BFMA1OI1ll;
if BFMA1OOoil > 1 then
BFMA1oooiL := BFMA1OOoil-1;
elsif BFMA1OOOil = 1 then
BFMA1Oo1ll(enFUNC+28+0) := BFMA1IOOil(7 downto 0);
BFMA1oo1LL(eNFUnc+28+1) := BFMA1iooIL(15 downto 8);
BFMA1Oo1lL(ENFunc+28+2) := BFMA1iOOIl(23 downto 16);
BFMA1oO1Ll(EnfunC+28+3) := BFMA1ioOIL(31 downto 24);
BFMA1OOOil := 0;
end if;
exT_Data <= ( others => 'Z');
if exT_en = '1' and exT_rd = '1' then
case exT_Size is
when 0 =>
BFMA1LO1ll := to_inTEGer(tO_UnsigNED(eXT_addR(EXt_adDR'lefT downto 0)));
BFMA1Ol1lL := BFMA1o0II(31 downto 8)&BFMA1Oo1ll(BFMA1Lo1lL+0);
when 1 =>
BFMA1LO1ll := to_INtegER(to_UNsigNED(eXT_addR(Ext_aDDR'leFT downto 1)&'0'));
BFMA1oL1Ll := BFMA1O0ii(31 downto 16)&BFMA1OO1ll(BFMA1lO1Ll+1)&BFMA1Oo1ll(BFMA1LO1ll+0);
when 2 =>
BFMA1lo1lL := to_iNTEger(To_unSIGned(Ext_aDDR(exT_Addr'lefT downto 2)&"00"));
BFMA1OL1ll := BFMA1OO1ll(BFMA1LO1ll+3)&BFMA1oo1LL(BFMA1LO1ll+2)&BFMA1oo1LL(BFMA1lO1Ll+1)&BFMA1oo1LL(BFMA1lo1lL+0);
end case;
iFPRintf(BFMA1lIILl >= 1,
"APBS:%d Extension Read %04x=%04x ",
fmT(id)&fMT(BFMA1LO1ll)&FMT(BFMA1ol1LL));
ext_Data <= BFMA1OL1ll;
end if;
if ext_En = '1' and EXT_wr = '1' then
case EXt_siZE is
when 0 =>
BFMA1lo1LL := to_iNTEger(to_uNSIgned(ext_ADdr(EXt_adDR'left downto 0)));
BFMA1oo1LL(BFMA1Lo1lL+0) := EXT_datA(7 downto 0);
when 1 =>
BFMA1lo1LL := to_INTeger(TO_unsIGNed(EXT_addR(ext_ADDr'leFT downto 1)&'0'));
BFMA1oO1Ll(BFMA1LO1ll+0) := Ext_DATa(7 downto 0);
BFMA1oo1LL(BFMA1LO1ll+1) := EXT_datA(15 downto 8);
when 2 =>
BFMA1lo1lL := to_INTeger(to_UNsignED(exT_Addr(Ext_aDDR'LEFt downto 2)&"00"));
BFMA1OO1ll(BFMA1LO1ll+0) := ext_DATa(7 downto 0);
BFMA1OO1ll(BFMA1lo1LL+1) := ext_DATa(15 downto 8);
BFMA1OO1ll(BFMA1LO1ll+2) := EXT_datA(23 downto 16);
BFMA1OO1ll(BFMA1lo1LL+3) := Ext_dATA(31 downto 24);
end case;
IfprINTf(BFMA1liiLL >= 1,
"APBS:%d Extension Write %04x=%04x ",
Fmt(id)&FMt(BFMA1lO1Ll)&Fmt(eXT_datA));
end if;
end if;
end process;
prdATA <= BFMA1o00Il(dwidTH-1 downto 0) when PenabLE = '1' else
BFMA1O10il(dWIDth-1 downto 0) after BFMA1Ol00;
prEADy <= BFMA1l00Il after BFMA1ol00;
PslveRR <= BFMA1i00IL after BFMA1OL00;
process (PWData)
begin
BFMA1oooLL <= ( others => '0');
BFMA1Oooll(DwidTH-1 downto 0) <= pwDATa;
end process;
BFMA1o0IIl <= penaBLE;
BFMA1o1iIL <= PwritE;
BFMA1OO0il <= PSel;
BFMA1ol0iL <= BFMA1i1oI(Paddr);
BFMA1oi0iL <= BFMA1I1Oi(PwdatA);
process (Pclk)
variable BFMA1IIIil: BOOleaN;
begin
if PCLk'eveNT and pclK = '1'
and PreseTN = '1' then
BFMA1l0iIL <= BFMA1o0iIL;
BFMA1I0Iil <= BFMA1l0IIl;
BFMA1L1iil <= BFMA1O1iil;
BFMA1I1Iil <= BFMA1l1iIL;
BFMA1LO0il <= BFMA1OO0il;
BFMA1IO0il <= BFMA1LO0il;
BFMA1ll0iL <= BFMA1OL0il;
BFMA1iL0Il <= BFMA1LL0il;
BFMA1LI0il <= BFMA1oi0IL;
BFMA1ii0IL <= BFMA1li0IL;
BFMA1IIIil := fALSe;
if BFMA1o0IIl = '1' and BFMA1oo0IL = '1' then
if BFMA1OL0il /= BFMA1LL0il then
pRINtf("APM:%d Address not stable in both cycles",
Fmt(id));
BFMA1iIIil := true;
end if;
if BFMA1o1IIL /= BFMA1L1iiL then
pRINtf("APM:%d PWRITE not stable in both cycles",
fmT(id));
BFMA1IIIil := tRUE;
end if;
if BFMA1Oo0il /= BFMA1lo0IL then
PrintF("APM:%d PSEL not stable in both cycles",
fmt(Id));
BFMA1iiiIL := true;
end if;
if BFMA1oI0Il /= BFMA1Li0iL and BFMA1o1IIL = '1' then
PrinTF("APM:%d PWDATA not stable in both cycles",
fMT(iD));
BFMA1iiiIL := TRUe;
end if;
if BFMA1LO0il /= '1' then
pRINtf("APM:%d PSEL was not active in cycle before PENABLE",
FMT(ID));
BFMA1iiiiL := tRUE;
end if;
end if;
if BFMA1IIIil then
assert fALSE report "APB Protocol violation" severity ERRor;
end if;
end if;
end process;
end BFMA1IO1ol;
