-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 11878 $
-- SVN $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $
library Ieee;
use ieee.stD_LogiC_1164.all;
use ieEE.NUMeric_Std.all;
use Work.BFM_misC.all;
use work.bfm_TEXtio.all;
use Work.Bfm_pACKage.all;
entity BFMA1i1lI is
generic (tpD: IntegER range 0 to 1000 := 1); port (Hclk: in std_LOGic;
HreseTN: in std_LOgic;
hSEL: in STd_lOGIc;
hwRITe: in sTD_logIC;
HaddR: in STD_loGIC_vecTOr(31 downto 0);
hwDATa: in STD_logIC_veCTOr(31 downto 0);
HRdata: out STd_loGIC_veCTOr(31 downto 0);
HreaDYIN: in Std_LOGic;
hrEADyout: out Std_LOGic;
hTRAns: in std_LOGic_VECtor(1 downto 0);
hSIZe: in std_LOgic_VEctoR(2 downto 0);
HbursT: in std_LOGic_VECtor(2 downto 0);
hMAStlocK: in std_LOGic;
hPROt: in std_LOgic_VEctoR(3 downto 0);
Hresp: out sTD_logIC;
pseL: out std_LOGic_vECTor(15 downto 0);
pADDr: out STd_loGIC_veCTOr(31 downto 0);
PwriTE: out sTD_logIC;
penABLe: out STd_loGIC;
PWData: out STD_logIC_veCTOr(31 downto 0);
PRdatA: in std_LOGic_vECTor(31 downto 0);
PreadY: in std_LOgic;
PSLverr: in Std_LOGIc);
end BFMA1I1Li;

architecture BFMA1IO1ol of BFMA1i1LI is

type BFMA1ol1oL is (BFMA1LL1ol,BFMA1il1OL,BFMA1oI1Ol,BFMA1Li1oL);

signal BFMA1II1ol: BFMA1ol1oL;

signal BFMA1O01ol: STD_loGIC;

signal BFMA1L01ol: STd_lOGIc;

signal BFMA1I01ol: Std_lOGIc_vECTor(15 downto 0);

signal BFMA1O11ol: stD_LogiC_VectOR(31 downto 0);

signal BFMA1l11OL: stD_logiC;

signal BFMA1I11oL: STd_loGIC;

signal BFMA1oOOLl: stD_LogiC_VectOR(31 downto 0);

signal BFMA1LOOll: std_LOGic_vECtor(31 downto 0);

signal BFMA1iOOLl: std_LOGic;

signal BFMA1olOLL: STd_loGIC;

constant BFMA1ol00: tIME := tpD*1 ns;

begin
process (hclk,HResetN)
begin
if hrESEtn = '0' then
BFMA1II1ol <= BFMA1LL1ol;
BFMA1o01ol <= '1';
BFMA1O11ol <= ( others => '0');
BFMA1Oooll <= ( others => '0');
BFMA1l11OL <= '0';
BFMA1i11OL <= '0';
BFMA1L01ol <= '0';
BFMA1iooLL <= '0';
BFMA1Ololl <= '0';
elsif hCLK = '1' and HClk'EVEnt then
BFMA1l01Ol <= '0';
BFMA1O01ol <= '0';
BFMA1IOOll <= '0';
case BFMA1ii1oL is
when BFMA1LL1ol =>
if Hsel = '1' and hreaDYIn = '1'
and HtraNS(1) = '1' then
BFMA1Ii1ol <= BFMA1Il1oL;
BFMA1o11OL <= HADdr;
BFMA1L11ol <= HWrite;
BFMA1I11ol <= '0';
BFMA1IOoll <= HWRite;
BFMA1oloLL <= '1';
else
BFMA1o01OL <= '1';
end if;
when BFMA1il1OL =>
BFMA1I11ol <= '1';
BFMA1iI1Ol <= BFMA1OI1ol;
when BFMA1oI1Ol =>
if PREady = '1' then
BFMA1I11ol <= '0';
BFMA1Ololl <= '0';
if PSLverr = '0' then
BFMA1II1ol <= BFMA1ll1OL;
if hsel = '1' and HREadyiN = '1'
and HTRans(1) = '1' then
BFMA1ii1oL <= BFMA1iL1Ol;
BFMA1o11oL <= haDDR;
BFMA1l11OL <= HWrite;
BFMA1iOOLl <= hWRIte;
BFMA1oLOLl <= '1';
end if;
else
BFMA1l01OL <= '1';
BFMA1ii1OL <= BFMA1li1OL;
end if;
end if;
when BFMA1li1OL =>
BFMA1L01ol <= '1';
BFMA1o01Ol <= '1';
BFMA1Ii1ol <= BFMA1lL1Ol;
end case;
if BFMA1ioolL = '1' then
BFMA1oOOLl <= HwdatA;
end if;
end if;
end process;
process (BFMA1o11Ol,BFMA1oLOLl)
begin
BFMA1I01ol <= ( others => '0');
if BFMA1olOLL = '1' then
for BFMA1I0Ii in 0 to 15
loop
BFMA1I01oL(BFMA1I0Ii) <= TO_std_LOgic(TO_intEGEr((TO_unsIGNEd(BFMA1o11OL(27 downto 24)))) = BFMA1i0ii);
end loop;
end if;
end process;
BFMA1lOOLl <= hwdaTA when (BFMA1iooLL = '1') else
BFMA1Oooll;
HRData <= prdATA after BFMA1oL00;
hreADYout <= BFMA1o01OL or (PREady and BFMA1olOLL
and BFMA1i11OL
and not pslVERr) after BFMA1Ol00;
HresP <= BFMA1L01ol after BFMA1OL00;
PSel <= BFMA1i01Ol after BFMA1OL00;
PaddR <= BFMA1O11ol after BFMA1ol00;
pwRITe <= BFMA1L11ol after BFMA1OL00;
peNABle <= BFMA1i11Ol after BFMA1OL00;
pwdaTA <= BFMA1loOLL after BFMA1ol00;
end BFMA1io1OL;
