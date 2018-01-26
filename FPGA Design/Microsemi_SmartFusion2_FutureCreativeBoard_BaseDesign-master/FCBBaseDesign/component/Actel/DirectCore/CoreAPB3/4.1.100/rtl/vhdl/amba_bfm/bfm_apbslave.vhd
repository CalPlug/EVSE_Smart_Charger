-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
-- Revision Information:
-- SVN Revision Information:
-- SVN $Revision: 11878 $
-- SVN $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $
library IEEE;
use iEEE.Std_lOGIc_1164.all;
use iEEE.NumerIC_std.all;
use Work.bfM_Misc.all;
use WORk.BFM_teXTIo.all;
use woRK.bfm_PACkage.all;
use sTD.TextIO.all;
entity BFM_apbSLAve is
generic (awidTH: intEGEr range 1 to 32;
deptH: iNTEger := 256;
dwidTH: inTEGer range 8 to 32 := 32;
iNITfilE: stRINg := "";
id: iNTEger := 0;
tpd: inTEGer range 0 to 1000 := 1;
enfuNC: INTeger := 0;
debUG: INtegeR range 0 to 1 := 0); port (pclk: in sTD_logIC;
PResetN: in std_Logic;
peNABle: in std_LOGic;
pwrITE: in STd_loGIC;
pseL: in sTD_logIC;
PADdr: in stD_LogiC_VectOR(awIDTh-1 downto 0);
PwdaTA: in std_LOgic_VEctoR(dwiDTH-1 downto 0);
PrdaTA: out std_LOGic_VECtor(dwIDTH-1 downto 0);
prEADy: out Std_LOGIc;
PslveRR: out STD_loGIC);
end bfm_APBslaVE;

architecture BFMA1IO1ol of bFM_apbSLAve is

signal Ext_eN: Std_lOGIc;

signal Ext_wR: std_LOgic;

signal Ext_rD: sTD_logIC;

signal EXt_adDR: sTD_logIC_vecTOR(AWidth-1 downto 0);

signal Ext_dATA: STd_lOGIC_veCTOr(DwidTH-1 downto 0);

begin
Ext_eN <= '0';
ext_WR <= '0';
EXT_rd <= '0';
EXT_addR <= ( others => '0');
EXT_datA <= ( others => 'Z');
BFMA1oiILL: bfm_APBslavEEXt
generic map (AwidTH => awiDTH,
DEpth => DeptH,
DwidTH => DWIdth,
Ext_SIZe => 2,
INitfiLE => InitfILE,
id => ID,
TPd => Tpd,
ENfunc => EnfuNC,
DEBug => Debug)
port map (pclk => pclK,
pRESEtn => PreseTN,
PENable => PENablE,
pwrITE => PwritE,
psEL => PSEl,
PADdr => pADDr,
pwdaTA => pwdATA,
prdaTA => PrdatA,
PREady => pREADy,
PSlverR => PSlverR,
EXT_en => EXt_en,
EXt_wr => Ext_wR,
Ext_rD => Ext_RD,
Ext_aDDR => ext_ADDr,
ext_DATa => EXt_daTA);
end BFMA1io1OL;
