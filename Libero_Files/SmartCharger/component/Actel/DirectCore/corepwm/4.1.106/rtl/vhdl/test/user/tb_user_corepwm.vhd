--/******************************************************************************
--
--    File Name:  tb_user_corepwm.vhd
--      Version:  4.0
--         Date:  July 25th, 2009
--  Description:  Top level test module
--
--      Company:  Actel
--
--
--
-- REVISION HISTORY: 
-- COPYRIGHT 2009 BY ACTEL 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM ACTEL CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- ACTEL FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 
--FUNCTIONAL DESCRIPTION:  
--Refer to the CorePWM Handbook.
--******************************************************************************/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library corepwm_lib;
use     corepwm_lib.corepwm_pkg.all;

ENTITY tb_user_corepwm IS
   GENERIC (
      FAMILY      	   : INTEGER := 17; --range 0 to 21;
      CONFIG_MODE          : INTEGER := 0;   
      PWM_NUM              : INTEGER := 16;
      APB_DWIDTH           : INTEGER := 16;
      FIXED_PRESCALE_EN    : INTEGER := 0;
      FIXED_PRESCALE       : INTEGER := 8;
      FIXED_PERIOD_EN      : INTEGER := 0;
      FIXED_PERIOD         : INTEGER := 8;
      DAC_MODE1            : INTEGER := 0;
      DAC_MODE2            : INTEGER := 0;
      DAC_MODE3            : INTEGER := 0;
      DAC_MODE4            : INTEGER := 0;
      DAC_MODE5            : INTEGER := 0;
      DAC_MODE6            : INTEGER := 0;
      DAC_MODE7            : INTEGER := 0;
      DAC_MODE8            : INTEGER := 0;
      DAC_MODE9            : INTEGER := 0;
      DAC_MODE10           : INTEGER := 0;
      DAC_MODE11           : INTEGER := 0;
      DAC_MODE12           : INTEGER := 0;
      DAC_MODE13           : INTEGER := 0;
      DAC_MODE14           : INTEGER := 0;
      DAC_MODE15           : INTEGER := 0;
      DAC_MODE16           : INTEGER := 0;
      SHADOW_REG_EN1       : INTEGER := 1;
      SHADOW_REG_EN2       : INTEGER := 1;
      SHADOW_REG_EN3       : INTEGER := 1;
      SHADOW_REG_EN4       : INTEGER := 1;
      SHADOW_REG_EN5       : INTEGER := 1;
      SHADOW_REG_EN6       : INTEGER := 1;
      SHADOW_REG_EN7       : INTEGER := 1;
      SHADOW_REG_EN8       : INTEGER := 1;
      SHADOW_REG_EN9       : INTEGER := 1;
      SHADOW_REG_EN10      : INTEGER := 1;
      SHADOW_REG_EN11      : INTEGER := 1;
      SHADOW_REG_EN12      : INTEGER := 1;
      SHADOW_REG_EN13      : INTEGER := 1;
      SHADOW_REG_EN14      : INTEGER := 1;
      SHADOW_REG_EN15      : INTEGER := 1;
      SHADOW_REG_EN16      : INTEGER := 1;
      FIXED_PWM_POS_EN1    : INTEGER := 0;
      FIXED_PWM_POS_EN2    : INTEGER := 0;
      FIXED_PWM_POS_EN3    : INTEGER := 0;
      FIXED_PWM_POS_EN4    : INTEGER := 0;
      FIXED_PWM_POS_EN5    : INTEGER := 0;
      FIXED_PWM_POS_EN6    : INTEGER := 0;
      FIXED_PWM_POS_EN7    : INTEGER := 0;
      FIXED_PWM_POS_EN8    : INTEGER := 0;
      FIXED_PWM_POS_EN9    : INTEGER := 0;
      FIXED_PWM_POS_EN10   : INTEGER := 0;
      FIXED_PWM_POS_EN11   : INTEGER := 0;
      FIXED_PWM_POS_EN12   : INTEGER := 0;
      FIXED_PWM_POS_EN13   : INTEGER := 0;
      FIXED_PWM_POS_EN14   : INTEGER := 0;
      FIXED_PWM_POS_EN15   : INTEGER := 0;
      FIXED_PWM_POS_EN16   : INTEGER := 0;
      FIXED_PWM_POSEDGE1   : INTEGER := 0;
      FIXED_PWM_POSEDGE2   : INTEGER := 0;
      FIXED_PWM_POSEDGE3   : INTEGER := 0;
      FIXED_PWM_POSEDGE4   : INTEGER := 0;
      FIXED_PWM_POSEDGE5   : INTEGER := 0;
      FIXED_PWM_POSEDGE6   : INTEGER := 0;
      FIXED_PWM_POSEDGE7   : INTEGER := 0;
      FIXED_PWM_POSEDGE8   : INTEGER := 0;
      FIXED_PWM_POSEDGE9   : INTEGER := 0;
      FIXED_PWM_POSEDGE10  : INTEGER := 0;
      FIXED_PWM_POSEDGE11  : INTEGER := 0;
      FIXED_PWM_POSEDGE12  : INTEGER := 0;
      FIXED_PWM_POSEDGE13  : INTEGER := 0;
      FIXED_PWM_POSEDGE14  : INTEGER := 0;
      FIXED_PWM_POSEDGE15  : INTEGER := 0;
      FIXED_PWM_POSEDGE16  : INTEGER := 0;
      FIXED_PWM_NEG_EN1    : INTEGER := 0;
      FIXED_PWM_NEG_EN2    : INTEGER := 0;
      FIXED_PWM_NEG_EN3    : INTEGER := 0;
      FIXED_PWM_NEG_EN4    : INTEGER := 0;
      FIXED_PWM_NEG_EN5    : INTEGER := 0;
      FIXED_PWM_NEG_EN6    : INTEGER := 0;
      FIXED_PWM_NEG_EN7    : INTEGER := 0;
      FIXED_PWM_NEG_EN8    : INTEGER := 0;
      FIXED_PWM_NEG_EN9    : INTEGER := 0;
      FIXED_PWM_NEG_EN10   : INTEGER := 0;
      FIXED_PWM_NEG_EN11   : INTEGER := 0;
      FIXED_PWM_NEG_EN12   : INTEGER := 0;
      FIXED_PWM_NEG_EN13   : INTEGER := 0;
      FIXED_PWM_NEG_EN14   : INTEGER := 0;
      FIXED_PWM_NEG_EN15   : INTEGER := 0;
      FIXED_PWM_NEG_EN16   : INTEGER := 0;
      FIXED_PWM_NEGEDGE1   : INTEGER := 0;
      FIXED_PWM_NEGEDGE2   : INTEGER := 0;
      FIXED_PWM_NEGEDGE3   : INTEGER := 0;
      FIXED_PWM_NEGEDGE4   : INTEGER := 0;
      FIXED_PWM_NEGEDGE5   : INTEGER := 0;
      FIXED_PWM_NEGEDGE6   : INTEGER := 0;
      FIXED_PWM_NEGEDGE7   : INTEGER := 0;
      FIXED_PWM_NEGEDGE8   : INTEGER := 0;
      FIXED_PWM_NEGEDGE9   : INTEGER := 0;
      FIXED_PWM_NEGEDGE10  : INTEGER := 0;
      FIXED_PWM_NEGEDGE11  : INTEGER := 0;
      FIXED_PWM_NEGEDGE12  : INTEGER := 0;
      FIXED_PWM_NEGEDGE13  : INTEGER := 0;
      FIXED_PWM_NEGEDGE14  : INTEGER := 0;
      FIXED_PWM_NEGEDGE15  : INTEGER := 0;
      FIXED_PWM_NEGEDGE16  : INTEGER := 0;
      PWM_STRETCH_VALUE1   : INTEGER := 0;
      PWM_STRETCH_VALUE2   : INTEGER := 0;
      PWM_STRETCH_VALUE3   : INTEGER := 0;
      PWM_STRETCH_VALUE4   : INTEGER := 0;
      PWM_STRETCH_VALUE5   : INTEGER := 0;
      PWM_STRETCH_VALUE6   : INTEGER := 0;
      PWM_STRETCH_VALUE7   : INTEGER := 0;
      PWM_STRETCH_VALUE8   : INTEGER := 0;
      PWM_STRETCH_VALUE9   : INTEGER := 0;
      PWM_STRETCH_VALUE10  : INTEGER := 0;
      PWM_STRETCH_VALUE11  : INTEGER := 0;
      PWM_STRETCH_VALUE12  : INTEGER := 0;
      PWM_STRETCH_VALUE13  : INTEGER := 0;
      PWM_STRETCH_VALUE14  : INTEGER := 0;
      PWM_STRETCH_VALUE15  : INTEGER := 0;
      PWM_STRETCH_VALUE16  : INTEGER := 0;
      TACH_NUM             : INTEGER := 16;
      TACH_EDGE1           : INTEGER := 0;
      TACH_EDGE2           : INTEGER := 0;
      TACH_EDGE3           : INTEGER := 0;
      TACH_EDGE4           : INTEGER := 0;
      TACH_EDGE5           : INTEGER := 0;
      TACH_EDGE6           : INTEGER := 0;
      TACH_EDGE7           : INTEGER := 0;
      TACH_EDGE8           : INTEGER := 0;
      TACH_EDGE9           : INTEGER := 0;
      TACH_EDGE10          : INTEGER := 0;
      TACH_EDGE11          : INTEGER := 0;
      TACH_EDGE12          : INTEGER := 0;
      TACH_EDGE13          : INTEGER := 0;
      TACH_EDGE14          : INTEGER := 0;
      TACH_EDGE15          : INTEGER := 0;
      TACH_EDGE16          : INTEGER := 0;
      TACHINT_ACT_LEVEL    : INTEGER := 0;

   -- register values (parameterized for TB clarity)
      PRESCALE_ADR         : INTEGER := 0;
      PERIOD_ADR           : INTEGER := 4;
      ENABLE1_ADR          : INTEGER := 8;
      ENABLE2_ADR          : INTEGER := 12;
      PWM1_POSEDGE_ADR     : INTEGER := 16;
      PWM1_NEGEDGE_ADR     : INTEGER := 20;
      PWM2_POSEDGE_ADR     : INTEGER := 24;
      PWM2_NEGEDGE_ADR     : INTEGER := 28;
      PWM3_POSEDGE_ADR     : INTEGER := 32;
      PWM3_NEGEDGE_ADR     : INTEGER := 36;
      PWM4_POSEDGE_ADR     : INTEGER := 40;
      PWM4_NEGEDGE_ADR     : INTEGER := 44;
      PWM5_POSEDGE_ADR     : INTEGER := 48;
      PWM5_NEGEDGE_ADR     : INTEGER := 52;
      PWM6_POSEDGE_ADR     : INTEGER := 56;
      PWM6_NEGEDGE_ADR     : INTEGER := 60;
      PWM7_POSEDGE_ADR     : INTEGER := 64;
      PWM7_NEGEDGE_ADR     : INTEGER := 68;
      PWM8_POSEDGE_ADR     : INTEGER := 72;
      PWM8_NEGEDGE_ADR     : INTEGER := 76;
      PWM9_POSEDGE_ADR     : INTEGER := 80;
      PWM9_NEGEDGE_ADR     : INTEGER := 84;
      PWM10_POSEDGE_ADR    : INTEGER := 88;
      PWM10_NEGEDGE_ADR    : INTEGER := 92;
      PWM11_POSEDGE_ADR    : INTEGER := 96;
      PWM11_NEGEDGE_ADR    : INTEGER := 100;
      PWM12_POSEDGE_ADR    : INTEGER := 104;
      PWM12_NEGEDGE_ADR    : INTEGER := 108;
      PWM13_POSEDGE_ADR    : INTEGER := 112;
      PWM13_NEGEDGE_ADR    : INTEGER := 116;
      PWM14_POSEDGE_ADR    : INTEGER := 120;
      PWM14_NEGEDGE_ADR    : INTEGER := 124;
      PWM15_POSEDGE_ADR    : INTEGER := 128;
      PWM15_NEGEDGE_ADR    : INTEGER := 132;
      PWM16_POSEDGE_ADR    : INTEGER := 136;
      PWM16_NEGEDGE_ADR    : INTEGER := 140;
      PWM_STRETCH_ADR      : INTEGER := 144;		--6'h24;
      TACHPRESCALE_ADR     : INTEGER := 148;		--6'h25;
      TACHSTATUS_ADR       : INTEGER := 152;		--6'h26;
      TACHIRQMASK_ADR      : INTEGER := 156;		--6'h27;
      TACHMODE_ADR         : INTEGER := 160;		--6'h28;
      TACHPULSEDUR_0_ADR   : INTEGER := 164;		--6'h29;
      TACHPULSEDUR_1_ADR   : INTEGER := 168;		--6'h30;
      TACHPULSEDUR_2_ADR   : INTEGER := 172;		--6'h31;
      TACHPULSEDUR_3_ADR   : INTEGER := 176;		--6'h32;
      TACHPULSEDUR_4_ADR   : INTEGER := 180;		--6'h33;
      TACHPULSEDUR_5_ADR   : INTEGER := 184;		--6'h34;
      TACHPULSEDUR_6_ADR   : INTEGER := 188;		--6'h35;
      TACHPULSEDUR_7_ADR   : INTEGER := 192;		--6'h36;
      TACHPULSEDUR_8_ADR   : INTEGER := 196;		--6'h37;
      TACHPULSEDUR_9_ADR   : INTEGER := 200;		--6'h38;
      TACHPULSEDUR_10_ADR  : INTEGER := 204;		--6'h39;
      TACHPULSEDUR_11_ADR  : INTEGER := 208;		--6'h40;
      TACHPULSEDUR_12_ADR  : INTEGER := 212;		--6'h41;
      TACHPULSEDUR_13_ADR  : INTEGER := 216;		--6'h42;
      TACHPULSEDUR_14_ADR  : INTEGER := 220;		--6'h43;
      TACHPULSEDUR_15_ADR  : INTEGER := 224;		--6'h44;
      SYS_CLK_CYCLE        : INTEGER := 30
);    
 END tb_user_corepwm;

ARCHITECTURE translated OF tb_user_corepwm IS

  COMPONENT corepwm IS
   GENERIC (
      FAMILY      	   : INTEGER := 0; --range 0 to 21;
      CONFIG_MODE          : INTEGER := 0; -- 0=PWM only, 1=PWM and Tach; 2=Tach only;
      PWM_NUM              : INTEGER := 1;
      APB_DWIDTH           : INTEGER := 8;
      FIXED_PRESCALE_EN    : INTEGER := 1;
      FIXED_PRESCALE       : INTEGER := 8;
      FIXED_PERIOD_EN      : INTEGER := 0;
      FIXED_PERIOD         : INTEGER := 8;
      DAC_MODE1            : INTEGER := 0;
      DAC_MODE2            : INTEGER := 0;
      DAC_MODE3            : INTEGER := 0;
      DAC_MODE4            : INTEGER := 0;
      DAC_MODE5            : INTEGER := 0;
      DAC_MODE6            : INTEGER := 0;
      DAC_MODE7            : INTEGER := 0;
      DAC_MODE8            : INTEGER := 0;
      DAC_MODE9            : INTEGER := 0;
      DAC_MODE10           : INTEGER := 0;
      DAC_MODE11           : INTEGER := 0;
      DAC_MODE12           : INTEGER := 0;
      DAC_MODE13           : INTEGER := 0;
      DAC_MODE14           : INTEGER := 0;
      DAC_MODE15           : INTEGER := 0;
      DAC_MODE16           : INTEGER := 0;
      SHADOW_REG_EN1       : INTEGER := 0;
      SHADOW_REG_EN2       : INTEGER := 0;
      SHADOW_REG_EN3       : INTEGER := 0;
      SHADOW_REG_EN4       : INTEGER := 0;
      SHADOW_REG_EN5       : INTEGER := 0;
      SHADOW_REG_EN6       : INTEGER := 0;
      SHADOW_REG_EN7       : INTEGER := 0;
      SHADOW_REG_EN8       : INTEGER := 0;
      SHADOW_REG_EN9       : INTEGER := 0;
      SHADOW_REG_EN10      : INTEGER := 0;
      SHADOW_REG_EN11      : INTEGER := 0;
      SHADOW_REG_EN12      : INTEGER := 0;
      SHADOW_REG_EN13      : INTEGER := 0;
      SHADOW_REG_EN14      : INTEGER := 0;
      SHADOW_REG_EN15      : INTEGER := 0;
      SHADOW_REG_EN16      : INTEGER := 0;
      FIXED_PWM_POS_EN1    : INTEGER := 1;
      FIXED_PWM_POS_EN2    : INTEGER := 1;
      FIXED_PWM_POS_EN3    : INTEGER := 1;
      FIXED_PWM_POS_EN4    : INTEGER := 1;
      FIXED_PWM_POS_EN5    : INTEGER := 1;
      FIXED_PWM_POS_EN6    : INTEGER := 1;
      FIXED_PWM_POS_EN7    : INTEGER := 1;
      FIXED_PWM_POS_EN8    : INTEGER := 1;
      FIXED_PWM_POS_EN9    : INTEGER := 1;
      FIXED_PWM_POS_EN10   : INTEGER := 1;
      FIXED_PWM_POS_EN11   : INTEGER := 1;
      FIXED_PWM_POS_EN12   : INTEGER := 1;
      FIXED_PWM_POS_EN13   : INTEGER := 1;
      FIXED_PWM_POS_EN14   : INTEGER := 1;
      FIXED_PWM_POS_EN15   : INTEGER := 1;
      FIXED_PWM_POS_EN16   : INTEGER := 1;
      FIXED_PWM_POSEDGE1   : INTEGER := 0;
      FIXED_PWM_POSEDGE2   : INTEGER := 0;
      FIXED_PWM_POSEDGE3   : INTEGER := 0;
      FIXED_PWM_POSEDGE4   : INTEGER := 0;
      FIXED_PWM_POSEDGE5   : INTEGER := 0;
      FIXED_PWM_POSEDGE6   : INTEGER := 0;
      FIXED_PWM_POSEDGE7   : INTEGER := 0;
      FIXED_PWM_POSEDGE8   : INTEGER := 0;
      FIXED_PWM_POSEDGE9   : INTEGER := 0;
      FIXED_PWM_POSEDGE10  : INTEGER := 0;
      FIXED_PWM_POSEDGE11  : INTEGER := 0;
      FIXED_PWM_POSEDGE12  : INTEGER := 0;
      FIXED_PWM_POSEDGE13  : INTEGER := 0;
      FIXED_PWM_POSEDGE14  : INTEGER := 0;
      FIXED_PWM_POSEDGE15  : INTEGER := 0;
      FIXED_PWM_POSEDGE16  : INTEGER := 0;
      FIXED_PWM_NEG_EN1    : INTEGER := 0;
      FIXED_PWM_NEG_EN2    : INTEGER := 0;
      FIXED_PWM_NEG_EN3    : INTEGER := 0;
      FIXED_PWM_NEG_EN4    : INTEGER := 0;
      FIXED_PWM_NEG_EN5    : INTEGER := 0;
      FIXED_PWM_NEG_EN6    : INTEGER := 0;
      FIXED_PWM_NEG_EN7    : INTEGER := 0;
      FIXED_PWM_NEG_EN8    : INTEGER := 0;
      FIXED_PWM_NEG_EN9    : INTEGER := 0;
      FIXED_PWM_NEG_EN10   : INTEGER := 0;
      FIXED_PWM_NEG_EN11   : INTEGER := 0;
      FIXED_PWM_NEG_EN12   : INTEGER := 0;
      FIXED_PWM_NEG_EN13   : INTEGER := 0;
      FIXED_PWM_NEG_EN14   : INTEGER := 0;
      FIXED_PWM_NEG_EN15   : INTEGER := 0;
      FIXED_PWM_NEG_EN16   : INTEGER := 0;
      FIXED_PWM_NEGEDGE1   : INTEGER := 0;
      FIXED_PWM_NEGEDGE2   : INTEGER := 0;
      FIXED_PWM_NEGEDGE3   : INTEGER := 0;
      FIXED_PWM_NEGEDGE4   : INTEGER := 0;
      FIXED_PWM_NEGEDGE5   : INTEGER := 0;
      FIXED_PWM_NEGEDGE6   : INTEGER := 0;
      FIXED_PWM_NEGEDGE7   : INTEGER := 0;
      FIXED_PWM_NEGEDGE8   : INTEGER := 0;
      FIXED_PWM_NEGEDGE9   : INTEGER := 0;
      FIXED_PWM_NEGEDGE10  : INTEGER := 0;
      FIXED_PWM_NEGEDGE11  : INTEGER := 0;
      FIXED_PWM_NEGEDGE12  : INTEGER := 0;
      FIXED_PWM_NEGEDGE13  : INTEGER := 0;
      FIXED_PWM_NEGEDGE14  : INTEGER := 0;
      FIXED_PWM_NEGEDGE15  : INTEGER := 0;
      FIXED_PWM_NEGEDGE16  : INTEGER := 0;
      PWM_STRETCH_VALUE1   : INTEGER := 0;
      PWM_STRETCH_VALUE2   : INTEGER := 0;
      PWM_STRETCH_VALUE3   : INTEGER := 0;
      PWM_STRETCH_VALUE4   : INTEGER := 0;
      PWM_STRETCH_VALUE5   : INTEGER := 0;
      PWM_STRETCH_VALUE6   : INTEGER := 0;
      PWM_STRETCH_VALUE7   : INTEGER := 0;
      PWM_STRETCH_VALUE8   : INTEGER := 0;
      PWM_STRETCH_VALUE9   : INTEGER := 0;
      PWM_STRETCH_VALUE10  : INTEGER := 0;
      PWM_STRETCH_VALUE11  : INTEGER := 0;
      PWM_STRETCH_VALUE12  : INTEGER := 0;
      PWM_STRETCH_VALUE13  : INTEGER := 0;
      PWM_STRETCH_VALUE14  : INTEGER := 0;
      PWM_STRETCH_VALUE15  : INTEGER := 0;
      PWM_STRETCH_VALUE16  : INTEGER := 0;
      TACH_NUM             : INTEGER := 1;
      TACH_EDGE1           : INTEGER := 0;
      TACH_EDGE2           : INTEGER := 0;
      TACH_EDGE3           : INTEGER := 0;
      TACH_EDGE4           : INTEGER := 0;
      TACH_EDGE5           : INTEGER := 0;
      TACH_EDGE6           : INTEGER := 0;
      TACH_EDGE7           : INTEGER := 0;
      TACH_EDGE8           : INTEGER := 0;
      TACH_EDGE9           : INTEGER := 0;
      TACH_EDGE10          : INTEGER := 0;
      TACH_EDGE11          : INTEGER := 0;
      TACH_EDGE12          : INTEGER := 0;
      TACH_EDGE13          : INTEGER := 0;
      TACH_EDGE14          : INTEGER := 0;
      TACH_EDGE15          : INTEGER := 0;
      TACH_EDGE16          : INTEGER := 0;
      TACHINT_ACT_LEVEL    : INTEGER := 0
      
   );
   PORT (
      PRESETN              : IN STD_LOGIC;
      PCLK                 : IN STD_LOGIC;
      PSEL                 : IN STD_LOGIC;
      PENABLE              : IN STD_LOGIC;
      PWRITE               : IN STD_LOGIC;
      PADDR                : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      PWDATA               : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      PRDATA               : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      PREADY               : OUT STD_LOGIC;
      PSLVERR              : OUT STD_LOGIC;
      TACHIN               : IN STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
      TACHINT              : OUT STD_LOGIC;
      PWM                  : OUT STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1)
   );
  END COMPONENT;

   TYPE xhdl_1 IS ARRAY (0 TO 11) OF std_logic_vector(8 * 79 DOWNTO 1);

constant      PERIOD_DATA   : INTEGER := (2 ** 16) - 3;
constant      ENABLE_DATA   : INTEGER := (2 ** PWM_NUM) - 1;
constant      TIMEOUT       : INTEGER := 4 * (2 ** 16) ;

constant dash_str			:string(1 to 77)	:=
"-----------------------------------------------------------------------------";
constant uline_str			:string(1 to 77)	:=
"_____________________________________________________________________________";
constant pound_str			:string(1 to 77)	:=
"#############################################################################";
constant space77_str		:string(1 to 77)	:=
"                                                                             ";
constant copyright_str		:string(1 to 77)	:=
"(c) Copyright 2008 Actel Corporation. All rights reserved.                   ";
constant tb_name_str		:string(1 to 77)	:=
"Testbench for: CorePWM                                                       ";
constant tb_ver_str			:string(1 to 77)	:=
"Version: 3.0.100 May 6th, 2008                                               ";
constant lsb_str			:string(1 to 3)		:= "LSB";
constant msb_str			:string(1 to 3)		:= "MSB";

type STR_ARRAY1 is array (integer range 0 to 11) of string (1 to 77);

-- initialization of testbench string
constant init_str_mem		:STR_ARRAY1			:= (
space77_str,space77_str,uline_str,space77_str,copyright_str,space77_str,
tb_name_str,tb_ver_str,uline_str,space77_str,space77_str,space77_str
);

   SIGNAL PCLK                     :  std_logic;   
   SIGNAL PRESETN                 :  std_logic;   
   SIGNAL PSEL                     :  std_logic;   
   SIGNAL PENABLE                  :  std_logic;   
   SIGNAL PWRITE                   :  std_logic;   
   SIGNAL PADDR                    :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL PWDATA                   :  std_logic_vector(APB_DWIDTH-1 DOWNTO 0);   
   SIGNAL PRDATA                   :  std_logic_vector(APB_DWIDTH-1 DOWNTO 0);   
   SIGNAL PWM                      :  std_logic_vector(PWM_NUM DOWNTO 1);  
   SIGNAL TACHIN        : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
   SIGNAL TACH_EDGE     : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0); 
   SIGNAL simerrors                :  integer;   
   SIGNAL count_high               :  integer;   
   SIGNAL count_low                :  integer;   
   SIGNAL real_error               :  integer;   
   SIGNAL sum                      :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL pwm_diff                 :  std_logic;   
   SIGNAL stopsim				:boolean;
   SIGNAL my_scale_tmp			: unsigned (7 downto 0); 

   SIGNAL PREADY        : STD_LOGIC;
   SIGNAL PSLVERR       : STD_LOGIC;
   SIGNAL TACHINT       : STD_LOGIC;

   SIGNAL SET_PWM_STRETCH        :  std_logic_vector(TACH_NUM - 1 DOWNTO 0);   
   SIGNAL SET_TACHSTATUS        :  std_logic_vector(TACH_NUM - 1 DOWNTO 0);   
   SIGNAL SET_TACHIRQMASK        :  std_logic_vector(TACH_NUM - 1 DOWNTO 0);   
   SIGNAL SET_TACHMODE        :  std_logic_vector(TACH_NUM - 1 DOWNTO 0);   
   SIGNAL SET_TACHSTATUS_INV  :  std_logic_vector(TACH_NUM - 1 DOWNTO 0);   
   SIGNAL SET_TACHPRESCALE  :  std_logic_vector(3 DOWNTO 0);   
   SIGNAL SET_TACHPULSEDUR_ADR  :  std_logic_vector(7 DOWNTO 0);   
   
 FUNCTION to_stdlogic ( x : integer) return std_logic is
  variable y  : std_logic;
  begin
    if x = 0 then
      y := '0';
    else
      y := '1';
    end if;
    return y;
  end to_stdlogic;

    FUNCTION to_stdlogicvector (
      val      : IN integer;
      len      : IN integer) RETURN std_logic_vector IS
      
      VARIABLE rtn      : std_logic_vector(len-1 DOWNTO 0) := (OTHERS => '0');
      VARIABLE num  : integer := val;
      VARIABLE r       : integer;
   BEGIN
      FOR index IN 0 TO len-1 LOOP
         r := num rem 2;
         num := num/2;
         IF (r = 1) THEN
            rtn(index) := '1';
         ELSE
            rtn(index) := '0';
         END IF;
      END LOOP;
      RETURN(rtn);
   END to_stdlogicvector;


BEGIN

-- generate the system clock
	PCLK_proc: process
	begin
		if (stopsim) then
			wait;	-- end simulation
		else
			PCLK <= '0';
			wait for ((SYS_CLK_CYCLE * 1 ns)/2);
			PCLK <= '1';
			wait for ((SYS_CLK_CYCLE * 1 ns)/2);
		end if;
	end process; 
   
   corepwm_xhdl12 : corepwm 
   GENERIC MAP(
      FAMILY              => FAMILY      		,
      CONFIG_MODE         => CONFIG_MODE            ,
      PWM_NUM             => PWM_NUM            ,
      APB_DWIDTH          => APB_DWIDTH         ,
      FIXED_PRESCALE_EN   => FIXED_PRESCALE_EN  ,
      FIXED_PRESCALE      => FIXED_PRESCALE     ,
      FIXED_PERIOD_EN     => FIXED_PERIOD_EN    ,
      FIXED_PERIOD        => FIXED_PERIOD       ,
      DAC_MODE1           => DAC_MODE1          ,
      DAC_MODE2           => DAC_MODE2          ,
      DAC_MODE3           => DAC_MODE3          ,
      DAC_MODE4           => DAC_MODE4          ,
      DAC_MODE5           => DAC_MODE5          ,
      DAC_MODE6           => DAC_MODE6          ,
      DAC_MODE7           => DAC_MODE7          ,
      DAC_MODE8           => DAC_MODE8          ,
      DAC_MODE9           => DAC_MODE9          ,
      DAC_MODE10          => DAC_MODE10         ,
      DAC_MODE11          => DAC_MODE11         ,
      DAC_MODE12          => DAC_MODE12         ,
      DAC_MODE13          => DAC_MODE13         ,
      DAC_MODE14          => DAC_MODE14         ,
      DAC_MODE15          => DAC_MODE15         ,
      DAC_MODE16          => DAC_MODE16         ,
      SHADOW_REG_EN1      => SHADOW_REG_EN1     ,
      SHADOW_REG_EN2      => SHADOW_REG_EN2     ,
      SHADOW_REG_EN3      => SHADOW_REG_EN3     ,
      SHADOW_REG_EN4      => SHADOW_REG_EN4     ,
      SHADOW_REG_EN5      => SHADOW_REG_EN5     ,
      SHADOW_REG_EN6      => SHADOW_REG_EN6     ,
      SHADOW_REG_EN7      => SHADOW_REG_EN7     ,
      SHADOW_REG_EN8      => SHADOW_REG_EN8     ,
      SHADOW_REG_EN9      => SHADOW_REG_EN9     ,
      SHADOW_REG_EN10     => SHADOW_REG_EN10    ,
      SHADOW_REG_EN11     => SHADOW_REG_EN11    ,
      SHADOW_REG_EN12     => SHADOW_REG_EN12    ,
      SHADOW_REG_EN13     => SHADOW_REG_EN13    ,
      SHADOW_REG_EN14     => SHADOW_REG_EN14    ,
      SHADOW_REG_EN15     => SHADOW_REG_EN15    ,
      SHADOW_REG_EN16     => SHADOW_REG_EN16    ,
      FIXED_PWM_POS_EN1   => FIXED_PWM_POS_EN1  ,
      FIXED_PWM_POS_EN2   => FIXED_PWM_POS_EN2  ,
      FIXED_PWM_POS_EN3   => FIXED_PWM_POS_EN3  ,
      FIXED_PWM_POS_EN4   => FIXED_PWM_POS_EN4  ,
      FIXED_PWM_POS_EN5   => FIXED_PWM_POS_EN5  ,
      FIXED_PWM_POS_EN6   => FIXED_PWM_POS_EN6  ,
      FIXED_PWM_POS_EN7   => FIXED_PWM_POS_EN7  ,
      FIXED_PWM_POS_EN8   => FIXED_PWM_POS_EN8  ,
      FIXED_PWM_POS_EN9   => FIXED_PWM_POS_EN9  ,
      FIXED_PWM_POS_EN10  => FIXED_PWM_POS_EN10 ,
      FIXED_PWM_POS_EN11  => FIXED_PWM_POS_EN11 ,
      FIXED_PWM_POS_EN12  => FIXED_PWM_POS_EN12 ,
      FIXED_PWM_POS_EN13  => FIXED_PWM_POS_EN13 ,
      FIXED_PWM_POS_EN14  => FIXED_PWM_POS_EN14 ,
      FIXED_PWM_POS_EN15  => FIXED_PWM_POS_EN15 ,
      FIXED_PWM_POS_EN16  => FIXED_PWM_POS_EN16 ,
      FIXED_PWM_POSEDGE1  => FIXED_PWM_POSEDGE1 ,
      FIXED_PWM_POSEDGE2  => FIXED_PWM_POSEDGE2 ,
      FIXED_PWM_POSEDGE3  => FIXED_PWM_POSEDGE3 ,
      FIXED_PWM_POSEDGE4  => FIXED_PWM_POSEDGE4 ,
      FIXED_PWM_POSEDGE5  => FIXED_PWM_POSEDGE5 ,
      FIXED_PWM_POSEDGE6  => FIXED_PWM_POSEDGE6 ,
      FIXED_PWM_POSEDGE7  => FIXED_PWM_POSEDGE7 ,
      FIXED_PWM_POSEDGE8  => FIXED_PWM_POSEDGE8 ,
      FIXED_PWM_POSEDGE9  => FIXED_PWM_POSEDGE9 ,
      FIXED_PWM_POSEDGE10 => FIXED_PWM_POSEDGE10,
      FIXED_PWM_POSEDGE11 => FIXED_PWM_POSEDGE11,
      FIXED_PWM_POSEDGE12 => FIXED_PWM_POSEDGE12,
      FIXED_PWM_POSEDGE13 => FIXED_PWM_POSEDGE13,
      FIXED_PWM_POSEDGE14 => FIXED_PWM_POSEDGE14,
      FIXED_PWM_POSEDGE15 => FIXED_PWM_POSEDGE15,
      FIXED_PWM_POSEDGE16 => FIXED_PWM_POSEDGE16,
      FIXED_PWM_NEG_EN1   => FIXED_PWM_NEG_EN1  ,
      FIXED_PWM_NEG_EN2   => FIXED_PWM_NEG_EN2  ,
      FIXED_PWM_NEG_EN3   => FIXED_PWM_NEG_EN3  ,
      FIXED_PWM_NEG_EN4   => FIXED_PWM_NEG_EN4  ,
      FIXED_PWM_NEG_EN5   => FIXED_PWM_NEG_EN5  ,
      FIXED_PWM_NEG_EN6   => FIXED_PWM_NEG_EN6  ,
      FIXED_PWM_NEG_EN7   => FIXED_PWM_NEG_EN7  ,
      FIXED_PWM_NEG_EN8   => FIXED_PWM_NEG_EN8  ,
      FIXED_PWM_NEG_EN9   => FIXED_PWM_NEG_EN9  ,
      FIXED_PWM_NEG_EN10  => FIXED_PWM_NEG_EN10 ,
      FIXED_PWM_NEG_EN11  => FIXED_PWM_NEG_EN11 ,
      FIXED_PWM_NEG_EN12  => FIXED_PWM_NEG_EN12 ,
      FIXED_PWM_NEG_EN13  => FIXED_PWM_NEG_EN13 ,
      FIXED_PWM_NEG_EN14  => FIXED_PWM_NEG_EN14 ,
      FIXED_PWM_NEG_EN15  => FIXED_PWM_NEG_EN15 ,
      FIXED_PWM_NEG_EN16  => FIXED_PWM_NEG_EN16 ,
      FIXED_PWM_NEGEDGE1  => FIXED_PWM_NEGEDGE1 ,
      FIXED_PWM_NEGEDGE2  => FIXED_PWM_NEGEDGE2 ,
      FIXED_PWM_NEGEDGE3  => FIXED_PWM_NEGEDGE3 ,
      FIXED_PWM_NEGEDGE4  => FIXED_PWM_NEGEDGE4 ,
      FIXED_PWM_NEGEDGE5  => FIXED_PWM_NEGEDGE5 ,
      FIXED_PWM_NEGEDGE6  => FIXED_PWM_NEGEDGE6 ,
      FIXED_PWM_NEGEDGE7  => FIXED_PWM_NEGEDGE7 ,
      FIXED_PWM_NEGEDGE8  => FIXED_PWM_NEGEDGE8 ,
      FIXED_PWM_NEGEDGE9  => FIXED_PWM_NEGEDGE9 ,
      FIXED_PWM_NEGEDGE10 => FIXED_PWM_NEGEDGE10,
      FIXED_PWM_NEGEDGE11 => FIXED_PWM_NEGEDGE11,
      FIXED_PWM_NEGEDGE12 => FIXED_PWM_NEGEDGE12,
      FIXED_PWM_NEGEDGE13 => FIXED_PWM_NEGEDGE13,
      FIXED_PWM_NEGEDGE14 => FIXED_PWM_NEGEDGE14,
      FIXED_PWM_NEGEDGE15 => FIXED_PWM_NEGEDGE15,
      FIXED_PWM_NEGEDGE16 => FIXED_PWM_NEGEDGE16,
      PWM_STRETCH_VALUE1 => PWM_STRETCH_VALUE1,
      PWM_STRETCH_VALUE2 => PWM_STRETCH_VALUE2,
      PWM_STRETCH_VALUE3 => PWM_STRETCH_VALUE3,
      PWM_STRETCH_VALUE4 => PWM_STRETCH_VALUE4,
      PWM_STRETCH_VALUE5 => PWM_STRETCH_VALUE5,
      PWM_STRETCH_VALUE6 => PWM_STRETCH_VALUE6,
      PWM_STRETCH_VALUE7 => PWM_STRETCH_VALUE7,
      PWM_STRETCH_VALUE8 => PWM_STRETCH_VALUE8,
      PWM_STRETCH_VALUE9 => PWM_STRETCH_VALUE9,
      PWM_STRETCH_VALUE10 => PWM_STRETCH_VALUE10,
      PWM_STRETCH_VALUE11 => PWM_STRETCH_VALUE11,
      PWM_STRETCH_VALUE12 => PWM_STRETCH_VALUE12,
      PWM_STRETCH_VALUE13 => PWM_STRETCH_VALUE13,
      PWM_STRETCH_VALUE14 => PWM_STRETCH_VALUE14,
      PWM_STRETCH_VALUE15 => PWM_STRETCH_VALUE15,
      PWM_STRETCH_VALUE16 => PWM_STRETCH_VALUE16,
      TACH_NUM => TACH_NUM,
      TACH_EDGE1 => TACH_EDGE1,
      TACH_EDGE2 => TACH_EDGE2,
      TACH_EDGE3 => TACH_EDGE3,
      TACH_EDGE4 => TACH_EDGE4,
      TACH_EDGE5 => TACH_EDGE5,
      TACH_EDGE6 => TACH_EDGE6,
      TACH_EDGE7 => TACH_EDGE7,
      TACH_EDGE8 => TACH_EDGE8,
      TACH_EDGE9 => TACH_EDGE9,
      TACH_EDGE10 => TACH_EDGE10,
      TACH_EDGE11 => TACH_EDGE11,
      TACH_EDGE12 => TACH_EDGE12,
      TACH_EDGE13 => TACH_EDGE13,
      TACH_EDGE14 => TACH_EDGE14,
      TACH_EDGE15 => TACH_EDGE15,
      TACH_EDGE16 => TACH_EDGE16,
      TACHINT_ACT_LEVEL => TACHINT_ACT_LEVEL
   )
   PORT MAP(
      PRESETN => PRESETN,
      PCLK    => PCLK   ,
      PSEL    => PSEL   ,
      PENABLE => PENABLE,
      PWRITE  => PWRITE ,
      PADDR   => PADDR  ,
      PWDATA  => PWDATA ,
      PRDATA  => PRDATA ,
      PREADY   => PREADY,
      PSLVERR  => PSLVERR,
      TACHIN   => TACHIN,
      TACHINT  => TACHINT,
      PWM     => PWM    
   );

      -- Flatten PWM_STRETCH to create PWM_STRETCH arrary 
   
   xhdl1 : IF ((TACH_NUM > 0) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("000000000000000" & to_stdlogic(TACH_EDGE1));
   END GENERATE;
   xhdl2 : IF ((TACH_NUM > 1) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("000000000000000" & to_stdlogic(TACH_EDGE1));
   END GENERATE;
   xhdl3 : IF ((TACH_NUM > 2) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("00000000000000" & (to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl4 : IF ((TACH_NUM > 3) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("0000000000000" & (to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl5 : IF ((TACH_NUM > 4) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("000000000000" & (to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl6 : IF ((TACH_NUM > 5) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("00000000000" & (to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl7 : IF ((TACH_NUM > 6) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("0000000000" & (to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl8 : IF ((TACH_NUM > 7) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("000000000" & (to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl9 : IF ((TACH_NUM > 8) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("00000000" & (to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl10 : IF ((TACH_NUM > 9) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("0000000" & (to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl11 : IF ((TACH_NUM > 10) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("000000" & (to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl12 : IF ((TACH_NUM > 11) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("00000" & (to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl13 : IF ((TACH_NUM > 12) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("0000" & (to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl14 : IF ((TACH_NUM > 13) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("000" & (to_stdlogic(TACH_EDGE13) & to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl15 : IF ((TACH_NUM > 14) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ("00" & (to_stdlogic(TACH_EDGE14) & to_stdlogic(TACH_EDGE13) & to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   xhdl16 : IF ((TACH_NUM > 15) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= ('0' & (to_stdlogic(TACH_EDGE15) & to_stdlogic(TACH_EDGE14) & to_stdlogic(TACH_EDGE13) & to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1)));
   END GENERATE;
   
   testing : PROCESS
      VARIABLE i                      :  integer;   
      VARIABLE j                      :  integer;   
      VARIABLE k                      :  integer;   
      VARIABLE l                      :  integer;   
      VARIABLE t                      :  integer;   
      VARIABLE lmsb_str               :  std_logic_vector(8 * 79 DOWNTO 1);   
      VARIABLE dtmp                   :  std_logic_vector(7 DOWNTO 0);   
      VARIABLE fixed_enable_var       :  std_logic_vector(7 DOWNTO 0);   
      VARIABLE fixed_int_mask_var     :  std_logic_vector(7 DOWNTO 0);   
      variable simerrorsv			  :  natural range 0 to 2047;
      variable sum_count			  :  natural range 0 to 2047;
      variable scale_tmp              :  unsigned (7 downto 0);   


           ---------------------------------------------------------------------
      -- Emulate task of cpu writing data to peripheral (IP macro)
      ---------------------------------------------------------------------
      PROCEDURE cpu_write(
         addr                 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         -- only 5 LSB bits used
         d                    : IN STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0)) IS
      BEGIN
         PSEL <= '1';
         PADDR <= addr;
         PWRITE <= '1';
         PENABLE <= '0';
         PWDATA <= d;
	 WAIT FOR SYS_CLK_CYCLE *1 ns;
         PENABLE <= '1';
	 WAIT FOR SYS_CLK_CYCLE *1 ns;
	 --wait for negedge PCLK);
	 WAIT UNTIL (PCLK'EVENT AND PCLK = '0');
         PADDR <= "00000000";
         PWRITE <= '0';
         PSEL <= '0';
         PENABLE <= '0';
         PADDR <= "00000000";
         PWDATA <= "00000000000000000000000000000000";
      END cpu_write;
      
      
      ---------------------------------------------------------------------
      -- Emulate task of cpu reading data from peripheral (IP macro)
      ---------------------------------------------------------------------
      PROCEDURE cpu_read(
         addr                 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         -- only 5 LSB bits used
         d                    : IN STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0)) IS
      BEGIN
         PSEL <= '1';
         PADDR <= addr;
         PWRITE <= '0';
         PENABLE <= '0';
	 WAIT FOR SYS_CLK_CYCLE *1 ns;
         PENABLE <= '1';
	 WAIT FOR SYS_CLK_CYCLE *1 ns;
	 --wait for negedge PCLK);
	WAIT UNTIL (PCLK'EVENT AND PCLK = '0');
         -- $display("Read Address = 0x%0x, Expected PRDATA = 0x%0x", ("000000000000000000000000" & addr), d);
        IF (PRDATA /= d) THEN
            -- $display("At time: %0t", NOW);
            -- $display("Expected value was: 0x%0x, observed value is: 0x%0x", PRDATA, d);
            -- $display("");
            simerrors <= simerrors + 1;
	    WAIT FOR SYS_CLK_CYCLE*1 ns;
         END IF;
         PADDR <= "00000000";
         PWRITE <= '0';
         PSEL <= '0';
         PENABLE <= '0';
         PADDR <= "00000000";
      END cpu_read;

      
   BEGIN
         i := 0;
         j := 0;    
         k := 0;    
         l := 0;    
         t := 0;    
         dtmp := "00000000";    
         fixed_enable_var := "00000000";    
         fixed_int_mask_var := "00000000";    
         simerrors <= simerrorsv;    
         simerrorsv := 0;    
         sum <= "00000000";    
         sum_count := 0;    
         pwm_diff <= '0';    
         count_high <= 0;    
         count_low <= 0;    
         real_error <= 0;    
         scale_tmp := "00000000";  
         my_scale_tmp <= "00000000";  
         i := 0;
         WHILE (i < 12) LOOP
            printf( init_str_mem(i));   
            i := i + 1;
         END LOOP;
         PRESETN <= '0';    
         PSEL <= '0';    
         PWDATA <= (others => '0');    
         PADDR <= (others => '0');    
         PWRITE <= '0';    
         PENABLE <= '0';    
         WAIT UNTIL (PCLK'EVENT AND PCLK = '1');
         PRESETN <= '1';
    IF (CONFIG_MODE < 2) THEN
      printf("PWM outputs set to %0d", fmt(PWM_NUM));
      printf("\nCorePWM tests beginning:\n\n");
      printf("Writing PWM Registers\n");
	      IF (APB_DWIDTH = 8) THEN
		 cpu_wr(to_bitvector(std_logic_vector(to_unsigned(228, 8))),to_bitvector(std_logic_vector(to_unsigned(1, 8))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
		 ELSIF (APB_DWIDTH = 16) THEN
		 cpu_wr16(to_bitvector(std_logic_vector(to_unsigned(228, 8))),to_bitvector(std_logic_vector(to_unsigned(1, 16))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
		 ELSE 
		 cpu_wr32(to_bitvector(std_logic_vector(to_unsigned(228, 8))),to_bitvector(std_logic_vector(to_unsigned(1, 32))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	      END IF;
      i := 0;
      WHILE (i < PWM16_NEGEDGE_ADR) LOOP
	      IF (APB_DWIDTH = 8) THEN
		 cpu_wr(to_bitvector(std_logic_vector(to_unsigned(i, 8))),to_bitvector(std_logic_vector(to_unsigned(i, 8))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
		 ELSIF (APB_DWIDTH = 16) THEN
		 cpu_wr16(to_bitvector(std_logic_vector(to_unsigned(i, 8))),to_bitvector(std_logic_vector(to_unsigned(i, 16))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
		 ELSE 
		 cpu_wr32(to_bitvector(std_logic_vector(to_unsigned(i, 8))),to_bitvector(std_logic_vector(to_unsigned(i, 32))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	      END IF;
         i := i + 4;
      END LOOP;
      printf("Reading all Registers\n");
	   IF (APB_DWIDTH = 8) THEN
            cpu_rd(to_bitvector(std_logic_vector(to_unsigned(228, 8))), to_bitvector(std_logic_vector(to_unsigned(1, 8))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
		 ELSIF (APB_DWIDTH = 16) THEN
            cpu_rd16(to_bitvector(std_logic_vector(to_unsigned(228, 8))), to_bitvector(std_logic_vector(to_unsigned(1, 16))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
		 ELSE 
            cpu_rd32(to_bitvector(std_logic_vector(to_unsigned(228, 8))), to_bitvector(std_logic_vector(to_unsigned(1, 32))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
	   END IF;
      i := 0;
      WHILE (i < PWM16_NEGEDGE_ADR) LOOP
         IF (i = PWM4_POSEDGE_ADR AND FIXED_PWM_POS_EN4 = 0) THEN
	   IF (APB_DWIDTH = 8) THEN
            cpu_rd(to_bitvector(std_logic_vector(to_unsigned(i, 8))), to_bitvector(std_logic_vector(to_unsigned(i, 8))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
		 ELSIF (APB_DWIDTH = 16) THEN
            cpu_rd16(to_bitvector(std_logic_vector(to_unsigned(i, 8))), to_bitvector(std_logic_vector(to_unsigned(i, 16))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
		 ELSE 
            cpu_rd32(to_bitvector(std_logic_vector(to_unsigned(i, 8))), to_bitvector(std_logic_vector(to_unsigned(i, 32))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
	   END IF;
            simerrors <= simerrorsv;
         ELSE
	   IF (APB_DWIDTH = 8) THEN
            cpu_rd(to_bitvector(std_logic_vector(to_unsigned(i, 8))), to_bitvector(std_logic_vector(to_unsigned(i, 8))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
	   ELSIF (APB_DWIDTH = 16) THEN
            cpu_rd16(to_bitvector(std_logic_vector(to_unsigned(i, 8))), to_bitvector(std_logic_vector(to_unsigned(i, 16))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
           ELSE 
            cpu_rd32(to_bitvector(std_logic_vector(to_unsigned(i, 8))), to_bitvector(std_logic_vector(to_unsigned(i, 32))),PCLK,  PADDR,  PRDATA, PSEL,PWRITE,PENABLE,simerrorsv);   
	   END IF;
            simerrors <= simerrorsv;
         END IF;
         i := i + 4;
      END LOOP;
      printf("Configuring Channels\n");
	 IF (APB_DWIDTH = 8) THEN
	  cpu_wr(to_bitvector(std_logic_vector(to_unsigned(PRESCALE_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(1, 8))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr(to_bitvector(std_logic_vector(to_unsigned(PERIOD_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(PERIOD_DATA, 8))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr(to_bitvector(std_logic_vector(to_unsigned(ENABLE1_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(511, 8))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr(to_bitvector(std_logic_vector(to_unsigned(ENABLE2_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(511, 8))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	 ELSIF (APB_DWIDTH = 16) THEN
	  cpu_wr16(to_bitvector(std_logic_vector(to_unsigned(PRESCALE_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(1, 16))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr16(to_bitvector(std_logic_vector(to_unsigned(PERIOD_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(PERIOD_DATA, 16))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr16(to_bitvector(std_logic_vector(to_unsigned(ENABLE1_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(511, 16))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr16(to_bitvector(std_logic_vector(to_unsigned(ENABLE2_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(511, 16))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
         ELSE 
	  cpu_wr32(to_bitvector(std_logic_vector(to_unsigned(PRESCALE_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(1, 32))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr32(to_bitvector(std_logic_vector(to_unsigned(PERIOD_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(PERIOD_DATA, 32))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr32(to_bitvector(std_logic_vector(to_unsigned(ENABLE1_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(511, 32))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	  cpu_wr32(to_bitvector(std_logic_vector(to_unsigned(ENABLE2_ADR, 8))),to_bitvector(std_logic_vector(to_unsigned(511, 32))),PCLK,  PADDR,  PWDATA, PSEL,PWRITE,PENABLE);
	 END IF;
	iloop: for i in 1 to PWM_NUM loop
         printf("Waiting for PWM%0d Output to Change....", fmt(i));
 	    tloop: for t in 1 to TIMEOUT loop
        wait for SYS_CLK_CYCLE * 1 ns ;
            IF (PWM(i) = '1') THEN
               printf("....................Change Detected...\n");
               exit tloop;
            END IF;
            IF (t = TIMEOUT) THEN
               printf("*** Error: Timed Out Waiting For Change \n");
               simerrorsv := simerrorsv + 1;
               simerrors <= simerrorsv;
            END IF;
         END LOOP tloop;
      END LOOP iloop;
      printf(" ");
      printf("All tests for PWM = %0d complete with:", fmt(PWM_NUM));
      END IF;

        IF (CONFIG_MODE > 0) THEN
         printf("Start TACH testing :\n\n");
         printf("No. of TACH inputs set to %0d", fmt(TACH_NUM));
         SET_PWM_STRETCH <= (others => '0');
         SET_TACHSTATUS <= (others => '0');
         SET_TACHIRQMASK <= (others => '0');
         SET_TACHMODE <= (others => '0');
         TACHIN <= (others => '0');
         FOR l IN 0 TO  TACH_NUM - 1 LOOP
            SET_PWM_STRETCH(l) <= '1';
            SET_TACHSTATUS(l) <= '1';
            SET_TACHSTATUS_INV(l) <= '0';
            SET_TACHIRQMASK(l) <= '1';
            SET_TACHMODE(l) <= '1';
         END LOOP;
         -- $display("Writing TACH Registers\n");
         cpu_write(to_stdlogicvector(PWM_STRETCH_ADR,8), SET_PWM_STRETCH);
         cpu_write(to_stdlogicvector(TACHPRESCALE_ADR,8), to_stdlogicvector(4,APB_DWIDTH));
         cpu_write(to_stdlogicvector(TACHSTATUS_ADR,8), SET_TACHSTATUS);
         cpu_write(to_stdlogicvector(TACHIRQMASK_ADR,8), SET_TACHIRQMASK);
         cpu_write(to_stdlogicvector(TACHMODE_ADR,8), SET_TACHMODE);
         i := 164;
         WHILE (i < TACHPULSEDUR_15_ADR + 4) LOOP
            cpu_write(to_stdlogicvector(i,8), to_stdlogicvector(i,APB_DWIDTH));
	    WAIT FOR SYS_CLK_CYCLE * 1 ns;
            i := i + 4;
         END LOOP;
         -- $display("Reading TACH Registers\n");
--         cpu_read(to_stdlogicvector(PWM_STRETCH_ADR,8), SET_PWM_STRETCH);
         cpu_read(to_stdlogicvector(TACHPRESCALE_ADR,8), to_stdlogicvector(4,APB_DWIDTH));
         cpu_read(to_stdlogicvector(TACHSTATUS_ADR,8), SET_TACHSTATUS_INV);
         cpu_read(to_stdlogicvector(TACHIRQMASK_ADR,8), SET_TACHIRQMASK);
         cpu_read(to_stdlogicvector(TACHMODE_ADR,8), SET_TACHMODE);
         i := 164;
         WHILE (i < TACHPULSEDUR_15_ADR + 4) LOOP
            cpu_read(to_stdlogicvector(i,8), to_stdlogicvector(0,APB_DWIDTH));
	    WAIT FOR SYS_CLK_CYCLE *1 ns;
            i := i + 4;
         END LOOP;
         FOR k IN 0 TO  TACH_NUM - 1 LOOP
            SET_TACHSTATUS(k) <= '1';
            SET_TACHIRQMASK(k) <= '1';
            SET_TACHMODE(k) <= '0';
         END LOOP;
         SET_TACHPRESCALE <= "0010";
         cpu_write(to_stdlogicvector(TACHPRESCALE_ADR,8), ("000000000000" & SET_TACHPRESCALE));
         cpu_write(to_stdlogicvector(TACHSTATUS_ADR,8), SET_TACHSTATUS);
         cpu_write(to_stdlogicvector(TACHIRQMASK_ADR,8), SET_TACHIRQMASK);
         cpu_write(to_stdlogicvector(TACHMODE_ADR,8), SET_TACHMODE);
	 WAIT FOR SYS_CLK_CYCLE *25 ns;
         printf("TACH interrupt test beginning:\n\n");
         FOR j IN 0 TO  TACH_NUM - 1 LOOP
            IF (TACH_EDGE(j) = '1') THEN
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *120 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *120 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *120 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *125 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *125 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *130 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *130 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *135 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *135 ns;
               IF (TACHINT_ACT_LEVEL = 1) THEN
                  IF (TACHINT = '1') THEN
                     SET_TACHPULSEDUR_ADR <= to_stdlogicvector((165 + (j*4)), 8);
                     cpu_read(SET_TACHPULSEDUR_ADR, to_stdlogicvector(65,APB_DWIDTH));
                     cpu_write(to_stdlogicvector(152,8), SET_TACHSTATUS);
                  END IF;
               ELSE
                  IF (TACHINT = '0') THEN
                     SET_TACHPULSEDUR_ADR <= to_stdlogicvector((165 + (j*4)), 8);
                     cpu_read(SET_TACHPULSEDUR_ADR, to_stdlogicvector(65,APB_DWIDTH));
                     cpu_write(to_stdlogicvector(152,8), SET_TACHSTATUS);
                  END IF;
               END IF;
            ELSE
               IF (TACH_EDGE(j) = '1') THEN
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *120 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *120 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *120 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *125 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *125 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *130 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *130 ns;
               TACHIN(j) <= '1';
	       WAIT FOR SYS_CLK_CYCLE *135 ns;
               TACHIN(j) <= '0';
	       WAIT FOR SYS_CLK_CYCLE *135 ns;
               IF (TACHINT_ACT_LEVEL = 1) THEN
                  IF (TACHINT = '1') THEN
                     SET_TACHPULSEDUR_ADR <= to_stdlogicvector((165 + (j*4)), 8);
                     cpu_read(SET_TACHPULSEDUR_ADR, to_stdlogicvector(65,APB_DWIDTH));
                     cpu_write(to_stdlogicvector(152,8), SET_TACHSTATUS);
                  END IF;
               ELSE
                  IF (TACHINT = '0') THEN
                     SET_TACHPULSEDUR_ADR <= to_stdlogicvector((165 + (j*4)), 8);
                     cpu_read(SET_TACHPULSEDUR_ADR, to_stdlogicvector(65,APB_DWIDTH));
                     cpu_write(to_stdlogicvector(152,8), SET_TACHSTATUS);
                  END IF;
               END IF;
            END IF;
            END IF;
         END LOOP;
         
         printf("TACH tests finished:\n\n");
      END IF;

      printf("%0d Errors.", fmt(simerrors));
      printf(" ");
         ASSERT (FALSE) REPORT "ending simulation" SEVERITY WARNING;   
	stopsim	<= true;
	wait;
   END PROCESS;
END translated;
