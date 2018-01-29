-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 6419 $
-- SVN $Date: 2009-02-04 04:34:22 -0800 (Wed, 04 Feb 2009) $
library ieeE;
use Ieee.STd_loGIC_1164.all;
use iEEE.NUmeriC_Std.all;
use work.bfm_MISc.all;
use work.BFm_teXTIo.all;
use WORk.SF2_MSS_sys_sb_CoreUARTapb_0_bfM_packAGE.all;
entity SF2_MSS_sys_sb_CoreUARTapb_0_BFM_APB2APB is
generic (TPD: inTEGEr range 0 to 1000 := 1); port (PCLk_pM: in std_Logic;
PresETN_pm: in stD_LogiC;
PADdr_pM: in stD_LogiC_VectOR(31 downto 0);
pWRIte_pM: in std_LOGic;
peNABle_PM: in std_LOGic;
pwDATa_pm: in sTD_logIC_vecTOR(31 downto 0);
PRData_PM: out std_LOGic_vECTor(31 downto 0);
PReady_Pm: out sTD_logIC;
PSlveRR_pm: out std_LOGic;
PClk_sC: in STd_loGIC;
Psel_SC: out STD_logIC_vecTOr(15 downto 0);
padDR_sc: out Std_lOGIC_veCTOr(31 downto 0);
pwrITE_sc: out std_LOGic;
PenaBLE_sc: out stD_logiC;
pwdATA_sc: out stD_LogiC_VectOR(31 downto 0);
pRDATa_sC: in stD_LogiC_VectOR(31 downto 0);
PREady_SC: in Std_lOGIc;
PslveRR_sc: in std_LOgic);
end SF2_MSS_sys_sb_CoreUARTapb_0_BFM_APB2APB;

architecture BFMA1io1oL of SF2_MSS_sys_sb_CoreUARTapb_0_BFM_APB2APB is

type BFMA1i0llL is (BFMA1iiLOL,acTIVe);

signal BFMA1o1LLl: BFMA1I0lll;

type BFMA1l1lLL is (BFMA1ll1oL,BFMA1I1lll,BFMA1il1OL);

signal BFMA1Ooill: BFMA1l1LLl;

signal BFMA1I01ol: sTD_logIC_vecTOR(15 downto 0);

signal BFMA1o11OL: std_LOGic_VECtor(31 downto 0);

signal BFMA1l11OL: std_LOgic;

signal BFMA1I11ol: STD_logIC;

signal BFMA1oooLL: Std_lOGIc_vECTor(31 downto 0);

signal BFMA1OlolL: STd_lOGIc;

signal BFMA1LOill: STD_loGIC_veCTOr(31 downto 0);

signal BFMA1IOIll: std_LOgic;

signal BFMA1OLIll: STd_loGIC;

signal BFMA1llILL: Std_LOGic;

signal BFMA1L0lol: std_LOgic;

constant BFMA1ol00: time := tpD*1 nS;

begin
process (pcLK_pm,presETN_pm)
begin
if pRESEtn_PM = '0' then
BFMA1O1lll <= BFMA1iiLOL;
BFMA1lLILl <= '0';
PreaDY_pm <= '0';
pslVERr_pm <= '0';
prdATA_pm <= ( others => '0');
BFMA1OLill <= '0';
elsif pclk_Pm = '1' and Pclk_PM'Event then
PREady_PM <= '0';
BFMA1OLill <= pENAble_PM;
case BFMA1o1lLL is
when BFMA1IiloL =>
if PEnablE_Pm = '1' and BFMA1olilL = '0' then
BFMA1Llill <= '1';
BFMA1o1LLL <= ACtive;
end if;
when ActivE =>
if BFMA1l0lOL = '1' then
BFMA1o1lLL <= BFMA1iilOL;
BFMA1LLill <= '0';
preADY_pm <= '1';
pslVERr_pm <= BFMA1IOILl;
prdaTA_pm <= BFMA1loiLL;
end if;
end case;
end if;
end process;
process (pCLK_sc,BFMA1Llill)
begin
if BFMA1LLIll = '0' then
BFMA1OOill <= BFMA1ll1OL;
BFMA1l0LOL <= '0';
BFMA1Loill <= ( others => '0');
BFMA1ioiLL <= '0';
BFMA1oloLL <= '0';
BFMA1I11ol <= '0';
BFMA1o11ol <= ( others => '0');
BFMA1OOOll <= ( others => '0');
BFMA1l11oL <= '0';
elsif pclK_sc = '1' and pCLK_sc'EVEnt then
case BFMA1ooiLL is
when BFMA1LL1ol =>
BFMA1OOill <= BFMA1i1llL;
BFMA1O11ol <= padDR_pm;
BFMA1OOoll <= pwDATA_pm;
BFMA1l11Ol <= pwrITE_pm;
BFMA1OLoll <= '1';
BFMA1I11ol <= '0';
BFMA1L0lol <= '0';
when BFMA1i1LLL =>
BFMA1OoilL <= BFMA1IL1ol;
BFMA1i11Ol <= '1';
when BFMA1IL1ol =>
if prEADy_sC = '1' then
BFMA1L0lol <= '1';
BFMA1loilL <= prdATA_sc;
BFMA1IOIll <= psLVErr_sC;
BFMA1OlolL <= '0';
BFMA1i11OL <= '0';
BFMA1o11OL <= ( others => '0');
BFMA1ooolL <= ( others => '0');
BFMA1L11oL <= '0';
end if;
end case;
end if;
end process;
process (BFMA1O11ol,BFMA1olOLL)
begin
BFMA1i01OL <= ( others => '0');
if BFMA1OLOll = '1' then
for BFMA1I0ii in 0 to 15
loop
BFMA1i01OL(BFMA1i0II) <= To_stD_LogiC(tO_IntegER((tO_UnsigNED(BFMA1o11OL(27 downto 24)))) = BFMA1i0II);
end loop;
end if;
end process;
psel_SC <= BFMA1i01Ol after BFMA1ol00;
PAddr_SC <= BFMA1O11oL after BFMA1oL00;
pwriTE_sc <= BFMA1L11ol after BFMA1OL00;
penABLe_sc <= BFMA1I11ol after BFMA1OL00;
pwdaTA_sc <= BFMA1OOOll after BFMA1ol00;
end BFMA1io1OL;
