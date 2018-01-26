--/******************************************************************************
--
--    File Name:  corepwm.vhd
--      Version:  4.0
--         Date:  July 5th, 2009
--  Description:  Top level module
--
--
-- SVN Revision Information:
-- SVN $Revision: 10225 $
-- SVN $Date: 2009-10-14 10:36:41 -0700 (Wed, 14 Oct 2009) $  
--
--
--
-- COPYRIGHT 2009 BY ACTEL 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM ACTEL CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- ACTEL FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 
--FUNCTIONAL DESCRIPTION:  
--Refer to the CorePWM Handbook.
--******************************************************************************/

LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;
   USE work.t_corepwm_pkg.all;

ENTITY corepwm IS
   GENERIC (
      FAMILY               : INTEGER := 0; --range 0 to 21;
      CONFIG_MODE          : INTEGER := 1; -- 0=PWM only, 1=PWM and Tach; 2=Tach only;
      PWM_NUM              : INTEGER := 16;
      APB_DWIDTH           : INTEGER := 32;
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
      SEPARATE_PWM_CLK     : INTEGER := 0
      
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
      PWM                  : OUT STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
      PWM_CLK              : IN STD_LOGIC
   );
END corepwm;

ARCHITECTURE trans OF corepwm IS
   COMPONENT corepwm_reg_if IS
      GENERIC (
		 SYNC_RESET           : INTEGER := 0;
         PWM_NUM              : INTEGER := 8;
         APB_DWIDTH           : INTEGER := 8;
         FIXED_PRESCALE_EN    : INTEGER := 0;
         FIXED_PRESCALE       : INTEGER := 8;
         FIXED_PERIOD_EN      : INTEGER := 0;
         FIXED_PERIOD         : INTEGER := 8;
         DAC_MODE             : STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";
         SHADOW_REG_EN        : STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";
         FIXED_PWM_POS_EN     : STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";
         FIXED_PWM_POSEDGE    : STD_LOGIC_VECTOR(511 DOWNTO 0):= (others => '0');
         FIXED_PWM_NEG_EN     : STD_LOGIC_VECTOR(15 DOWNTO 0):= "0000000000000000";
         FIXED_PWM_NEGEDGE    : STD_LOGIC_VECTOR(511 DOWNTO 0):= (others => '0')
      );
      PORT (
         PCLK                 : IN STD_LOGIC;
         PRESETN              : IN STD_LOGIC;
         PSEL                 : IN STD_LOGIC;
         PENABLE              : IN STD_LOGIC;
         PWRITE               : IN STD_LOGIC;
         PADDR                : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
         PWDATA               : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         PWM_STRETCH          : IN STD_LOGIC_VECTOR(PWM_NUM - 1 DOWNTO 0);
         PRDATA_regif         : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         period_cnt           : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         sync_pulse           : IN STD_LOGIC;
         period_out_wire_o    : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         prescale_out_wire_o  : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         pwm_enable_out_wire_o: OUT STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
         pwm_posedge_out_wire_o: OUT STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
         pwm_negedge_out_wire_o: OUT STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1)
      );
   END COMPONENT;
   
   COMPONENT corepwm_timebase IS
      GENERIC (
	     SYNC_RESET           : INTEGER := 0;
         APB_DWIDTH           : INTEGER := 8
      );
      PORT (
         PRESETN              : IN STD_LOGIC;
         PCLK                 : IN STD_LOGIC;
         period_reg           : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         prescale_reg         : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         period_cnt           : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         sync_pulse           : OUT STD_LOGIC
      );
   END COMPONENT;
   
   COMPONENT corepwm_pwm_gen IS
      GENERIC (
	     SYNC_RESET           : INTEGER := 0;
         PWM_NUM              : INTEGER := 8;
         APB_DWIDTH           : INTEGER := 8;
         DAC_MODE             : STD_LOGIC_VECTOR(15 DOWNTO 0)

      );
      PORT (
         PRESETN              : IN STD_LOGIC;
         PCLK                 : IN STD_LOGIC;
         PWM                  : OUT STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
         period_cnt           : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
         pwm_enable_reg       : IN STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
         pwm_posedge_reg      : IN STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
         pwm_negedge_reg      : IN STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
         sync_pulse           : IN STD_LOGIC
      );
   END COMPONENT;

  -- TACH IF
   COMPONENT corepwm_tach_if IS
   GENERIC (
      SYNC_RESET           : INTEGER := 0;
      TACH_NUM             : INTEGER := 1
   );
   PORT (
      PCLK                 : IN STD_LOGIC;
      PRESETN              : IN STD_LOGIC;
      TACHIN               : IN STD_LOGIC;
      TACHMODE             : IN STD_LOGIC;
      TACH_EDGE            : IN STD_LOGIC;
      TACHSTATUS           : IN STD_LOGIC;
      status_clear         : IN STD_LOGIC;
      tach_cnt_clk         : IN STD_LOGIC;
      TACHPULSEDUR         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      update_status        : OUT STD_LOGIC
   );
   END COMPONENT;
  
   TYPE type_xhdl0 IS ARRAY (TACH_NUM - 1 DOWNTO 0) OF STD_LOGIC_VECTOR(15 DOWNTO 0);

   SIGNAL prescale_reg    : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL period_reg      : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL period_cnt      : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL pwm_enable_reg  : STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
   SIGNAL pwm_posedge_reg : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL pwm_negedge_reg : STD_LOGIC_VECTOR(PWM_NUM * APB_DWIDTH DOWNTO 1);
   SIGNAL sync_pulse      : STD_LOGIC;
   SIGNAL PWM_int               : STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
   SIGNAL PRDATA_TACH           : STD_LOGIC_VECTOR(15 DOWNTO 0);
   SIGNAL PWM_STRETCH_VALUE_int : STD_LOGIC_VECTOR(PWM_NUM - 1 DOWNTO 0);
   SIGNAL TACH_EDGE             : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
   SIGNAL tachint_mask          : STD_LOGIC;
   SIGNAL TACHPRESCALE          : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL PWM_STRETCH           : STD_LOGIC_VECTOR(PWM_NUM - 1 DOWNTO 0);
   SIGNAL TACHIRQMASK           : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
   SIGNAL TACHMODE              : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
   SIGNAL TACHSTATUS            : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
   SIGNAL tach_prescale_cnt     : STD_LOGIC_VECTOR(10 DOWNTO 0);
   SIGNAL tach_prescale_value   : STD_LOGIC_VECTOR(10 DOWNTO 0);
   SIGNAL prescale_decode_value : STD_LOGIC_VECTOR(10 DOWNTO 0);
   SIGNAL tach_cnt_clk          : STD_LOGIC;
   SIGNAL TACHPULSEDUR          : type_xhdl0;
   SIGNAL update_status         : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
   SIGNAL status_clear          : STD_LOGIC_VECTOR(TACH_NUM - 1 DOWNTO 0);
   SIGNAL PRDATA_regif          : STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL pwm_clk_int           : STD_LOGIC;
   SIGNAL aresetn               : STD_LOGIC;
   SIGNAL sresetn               : STD_LOGIC;
   
   CONSTANT SYNC_RESET : INTEGER := SYNC_MODE_SEL(FAMILY);
   CONSTANT all_ones   : STD_LOGIC_VECTOR(511 DOWNTO 0) := (others => '1');
   CONSTANT all_zeros  : STD_LOGIC_VECTOR(511 DOWNTO 0) := (others => '0');
   CONSTANT DAC_MODE   : STD_LOGIC_VECTOR(15 DOWNTO 0)  := 
														   (std_logic_vector(to_unsigned(DAC_MODE16,1)) &
      														std_logic_vector(to_unsigned(DAC_MODE15,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE14,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE13,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE12,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE11,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE10,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE9 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE8 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE7 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE6 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE5 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE4 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE3 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE2 ,1)) & 
      														std_logic_vector(to_unsigned(DAC_MODE1 ,1)) );
   CONSTANT         SHADOW_REG_EN        : STD_LOGIC_VECTOR(15 DOWNTO 0)	:= 
														   (std_logic_vector(to_unsigned(SHADOW_REG_EN16,1)) &
      														std_logic_vector(to_unsigned(SHADOW_REG_EN15,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN14,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN13,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN12,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN11,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN10,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN9 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN8 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN7 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN6 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN5 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN4 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN3 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN2 ,1)) & 
      														std_logic_vector(to_unsigned(SHADOW_REG_EN1 ,1)) );

   CONSTANT         FIXED_PWM_POS_EN     : STD_LOGIC_VECTOR(15 DOWNTO 0)	:= 
														   (std_logic_vector(to_unsigned(FIXED_PWM_POS_EN16,1)) &
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN15,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN14,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN13,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN12,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN11,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN10,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN9 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN8 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN7 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN6 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN5 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN4 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN3 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN2 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POS_EN1 ,1)) );
   CONSTANT         FIXED_PWM_POSEDGE    : STD_LOGIC_VECTOR(511 DOWNTO 0)	:= (all_zeros((32-APB_DWIDTH)*16 -1 DOWNTO 0) &
														    std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE16,APB_DWIDTH)) &
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE15,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE14,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE13,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE12,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE11,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE10,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE9 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE8 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE7 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE6 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE5 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE4 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE3 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE2 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_POSEDGE1 ,APB_DWIDTH)) );

   CONSTANT         FIXED_PWM_NEG_EN     : STD_LOGIC_VECTOR(15 DOWNTO 0)	:= 
														   (std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN16,1)) &
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN15,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN14,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN13,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN12,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN11,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN10,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN9 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN8 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN7 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN6 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN5 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN4 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN3 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN2 ,1)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEG_EN1 ,1)) );

   CONSTANT         FIXED_PWM_NEGEDGE    : STD_LOGIC_VECTOR(511 DOWNTO 0)	:= (all_zeros((32-APB_DWIDTH)*16 -1 DOWNTO 0) &
														    std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE16,APB_DWIDTH)) &
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE15,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE14,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE13,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE12,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE11,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE10,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE9 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE8 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE7 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE6 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE5 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE4 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE3 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE2 ,APB_DWIDTH)) & 
      														std_logic_vector(to_unsigned(FIXED_PWM_NEGEDGE1 ,APB_DWIDTH)) );

												
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
 
BEGIN
      aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
      sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';
	  
      pwm1 : IF (SEPARATE_PWM_CLK = 1) GENERATE pwm_clk_int <= PWM_CLK; END GENERATE;
      pwm2 : IF (SEPARATE_PWM_CLK = 0) GENERATE pwm_clk_int <= PCLK; END GENERATE;
      
      xhdl1 : IF (CONFIG_MODE > 0) GENERATE
      -- APB write to tach prescale
      PROCESS (aresetn, PCLK)
      BEGIN
         IF ((NOT(aresetn)) = '1') THEN
            TACHPRESCALE <= "0000";
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
             IF ((NOT(sresetn)) = '1') THEN
                TACHPRESCALE <= "0000";
		     ELSE
                IF ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) THEN
                   CASE PADDR(7 DOWNTO 2) IS
                      WHEN "100101" =>
                         TACHPRESCALE <= PWDATA(3 DOWNTO 0);
             WHEN OTHERS =>
                         TACHPRESCALE <= TACHPRESCALE;
                   END CASE;
                END IF;
             END IF;
         END IF;
      END PROCESS;
      
      
      -- APB write to TACHIRQMASK and TACHMODE
      PROCESS (aresetn, PCLK)
      BEGIN
         IF ((NOT(aresetn)) = '1') THEN
            TACHIRQMASK <= (others => '0');
            TACHMODE <= (others => '0');
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
             IF ((NOT(sresetn)) = '1') THEN
                TACHIRQMASK <= (others => '0');
                TACHMODE <= (others => '0');
		     ELSE
                IF ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) THEN
                   CASE PADDR(7 DOWNTO 2) IS
                      WHEN "100111" =>
                         TACHIRQMASK <= PWDATA(TACH_NUM - 1 DOWNTO 0);
                      WHEN "101000" =>
                         TACHMODE <= PWDATA(TACH_NUM - 1 DOWNTO 0);
                      WHEN OTHERS =>
                         TACHIRQMASK <= TACHIRQMASK;
                         TACHMODE <= TACHMODE;
                   END CASE;
                END IF;
             END IF;
         END IF;
      END PROCESS;
      
      
      -- Preload value
      -- decode tach_prescale value
      PROCESS (TACHPRESCALE)
      BEGIN
         CASE TACHPRESCALE IS
            WHEN "0000" =>
               prescale_decode_value <= "00000000000";
            WHEN "0001" =>
               prescale_decode_value <= "00000000001";
            WHEN "0010" =>
               prescale_decode_value <= "00000000011";
            WHEN "0011" =>
               prescale_decode_value <= "00000000111";
            WHEN "0100" =>
               prescale_decode_value <= "00000001111";
            WHEN "0101" =>
               prescale_decode_value <= "00000011111";
            WHEN "0110" =>
               prescale_decode_value <= "00000111111";
            WHEN "0111" =>
               prescale_decode_value <= "00001111111";
            WHEN "1000" =>
               prescale_decode_value <= "00011111111";
            WHEN "1001" =>
               prescale_decode_value <= "00111111111";
            WHEN "1010" =>
               prescale_decode_value <= "01111111111";
            WHEN "1011" =>
               prescale_decode_value <= "11111111111";
            WHEN OTHERS =>
               prescale_decode_value <= "11111111111";
         END CASE;
      END PROCESS;
      
      
      -- generate tach_prescale_cnt and tach_cnt_clk
      PROCESS (aresetn, PCLK)
      BEGIN
         IF ((NOT(aresetn)) = '1') THEN
            tach_prescale_cnt <= "00000000000";
            tach_prescale_value <= "00000000000";
            tach_cnt_clk <= '0';
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
             IF ((NOT(sresetn)) = '1') THEN
                tach_prescale_cnt <= "00000000000";
                tach_prescale_value <= "00000000000";
                tach_cnt_clk <= '0';
		     ELSE
                IF (tach_prescale_cnt >= tach_prescale_value) THEN		--reset tach_prescale_cnt
                   tach_prescale_cnt <= "00000000000";
                   tach_prescale_value <= prescale_decode_value;
                   tach_cnt_clk <= '1';
                ELSE
                   tach_prescale_cnt <= tach_prescale_cnt + "00000000001";
                   tach_cnt_clk <= '0';
                END IF;
             END IF;
         END IF;
      END PROCESS;
      
      -- tach_misc
   END GENERATE;
   
   -- Update STATUS register
   -- Write process parameter-based addresses
   gen_blk_tach : IF (CONFIG_MODE>0) GENERATE
       gen_tachstatus : FOR x IN 0 TO  (TACH_NUM - 1) GENERATE
          PROCESS (aresetn, PCLK)
          BEGIN
             IF ((NOT(aresetn)) = '1') THEN
                TACHSTATUS(x) <= '0';
                status_clear(x) <= '1';
             ELSIF (PCLK'EVENT AND PCLK = '1') THEN
                IF ((NOT(sresetn)) = '1') THEN
                   TACHSTATUS(x) <= '0';
                   status_clear(x) <= '1';
			    ELSE
                   IF ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1') AND (PADDR(7 DOWNTO 2) = "100110")) THEN
                      IF (PWDATA(x) = '1') THEN
                         TACHSTATUS(x) <= '0';
                         status_clear(x) <= '1';
                      END IF;
                   ELSE
                      IF (update_status(x) = '1') THEN
                         TACHSTATUS(x) <= '1';
                         status_clear(x) <= '0';
                      END IF;
                   END IF;
                END IF;
             END IF;
          END PROCESS;
          
       END GENERATE;
   END GENERATE;
   
   xhdl2 : IF (CONFIG_MODE > 0) GENERATE
      TACHINT <= (tachint_mask) WHEN (TACHINT_ACT_LEVEL /= 0) ELSE NOT(tachint_mask);
   END GENERATE;
   
   -- Flatten PWM_STRETCH to create PWM_STRETCH arrary 
   
   xhdl3 : IF ((PWM_NUM > 0) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(0) <= to_stdlogic(PWM_STRETCH_VALUE1);
   END GENERATE;
   xhdl4 : IF ((PWM_NUM > 1) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(1) <= to_stdlogic(PWM_STRETCH_VALUE2);
   END GENERATE;
   xhdl5 : IF ((PWM_NUM > 2) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(2) <= to_stdlogic(PWM_STRETCH_VALUE3);
   END GENERATE;
   xhdl6 : IF ((PWM_NUM > 3) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(3) <= to_stdlogic(PWM_STRETCH_VALUE4);
   END GENERATE;
   xhdl7 : IF ((PWM_NUM > 4) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(4) <= to_stdlogic(PWM_STRETCH_VALUE5);
   END GENERATE;
   xhdl8 : IF ((PWM_NUM > 5) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(5) <= to_stdlogic(PWM_STRETCH_VALUE6);
   END GENERATE;
   xhdl9 : IF ((PWM_NUM > 6) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(6) <= to_stdlogic(PWM_STRETCH_VALUE7);
   END GENERATE;
   xhdl10 : IF ((PWM_NUM > 7) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(7) <= to_stdlogic(PWM_STRETCH_VALUE8);
   END GENERATE;
   xhdl11 : IF ((PWM_NUM > 8) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(8) <= to_stdlogic(PWM_STRETCH_VALUE9);
   END GENERATE;
   xhdl12 : IF ((PWM_NUM > 9) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(9) <= to_stdlogic(PWM_STRETCH_VALUE10);
   END GENERATE;
   xhdl13 : IF ((PWM_NUM > 10) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(10) <= to_stdlogic(PWM_STRETCH_VALUE11);
   END GENERATE;
   xhdl14 : IF ((PWM_NUM > 11) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(11) <= to_stdlogic(PWM_STRETCH_VALUE12);
   END GENERATE;
   xhdl15 : IF ((PWM_NUM > 12) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(12) <= to_stdlogic(PWM_STRETCH_VALUE13);
   END GENERATE;
   xhdl16 : IF ((PWM_NUM > 13) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(13) <= to_stdlogic(PWM_STRETCH_VALUE14);
   END GENERATE;
   xhdl17 : IF ((PWM_NUM > 14) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(14) <= to_stdlogic(PWM_STRETCH_VALUE15);
   END GENERATE;
   xhdl18 : IF ((PWM_NUM > 15) AND (CONFIG_MODE > 0)) GENERATE
      PWM_STRETCH_VALUE_int(15) <= to_stdlogic(PWM_STRETCH_VALUE16);
   END GENERATE;
   
   -- concatenate PWM_STRETCH_VALUE and tach mask interrupt
   xhdl19 : IF ((TACH_NUM = 1) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE(0) <= (to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= (TACHSTATUS(0) AND TACHIRQMASK(0));
   END GENERATE;
   xhdl20 : IF ((TACH_NUM = 2) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= (((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl21 : IF ((TACH_NUM = 3) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= (((TACHSTATUS(2) AND TACHIRQMASK(2))) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl22 : IF ((TACH_NUM = 4) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= (((TACHSTATUS(3) AND TACHIRQMASK(3))) OR ((TACHSTATUS(2) AND TACHIRQMASK(2))) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl23 : IF ((TACH_NUM = 5) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl24 : IF ((TACH_NUM = 6) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl25 : IF ((TACH_NUM = 7) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl26 : IF ((TACH_NUM = 8) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl27 : IF ((TACH_NUM = 9) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl28 : IF ((TACH_NUM = 10) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(9) AND TACHIRQMASK(9)) OR (TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl29 : IF ((TACH_NUM = 11) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(10) AND TACHIRQMASK(10)) OR (TACHSTATUS(9) AND TACHIRQMASK(9)) OR (TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl30 : IF ((TACH_NUM = 12) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(11) AND TACHIRQMASK(11)) OR (TACHSTATUS(10) AND TACHIRQMASK(10)) OR (TACHSTATUS(9) AND TACHIRQMASK(9)) OR (TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl31 : IF ((TACH_NUM = 13) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE13) & to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(12) AND TACHIRQMASK(12)) OR (TACHSTATUS(11) AND TACHIRQMASK(11)) OR (TACHSTATUS(10) AND TACHIRQMASK(10)) OR (TACHSTATUS(9) AND TACHIRQMASK(9)) OR (TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl32 : IF ((TACH_NUM = 14) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE14) & to_stdlogic(TACH_EDGE13) & to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(13) AND TACHIRQMASK(13)) OR (TACHSTATUS(12) AND TACHIRQMASK(12)) OR (TACHSTATUS(11) AND TACHIRQMASK(11)) OR (TACHSTATUS(10) AND TACHIRQMASK(10)) OR (TACHSTATUS(9) AND TACHIRQMASK(9)) OR (TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl33 : IF ((TACH_NUM = 15) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE15) & to_stdlogic(TACH_EDGE14) & to_stdlogic(TACH_EDGE13) & to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(14) AND TACHIRQMASK(14)) OR (TACHSTATUS(13) AND TACHIRQMASK(13)) OR (TACHSTATUS(12) AND TACHIRQMASK(12)) OR (TACHSTATUS(11) AND TACHIRQMASK(11)) OR (TACHSTATUS(10) AND TACHIRQMASK(10)) OR (TACHSTATUS(9) AND TACHIRQMASK(9)) OR (TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   xhdl34 : IF ((TACH_NUM = 16) AND (CONFIG_MODE > 0)) GENERATE
      TACH_EDGE <= (to_stdlogic(TACH_EDGE16) & to_stdlogic(TACH_EDGE15) & to_stdlogic(TACH_EDGE14) & to_stdlogic(TACH_EDGE13) & to_stdlogic(TACH_EDGE12) & to_stdlogic(TACH_EDGE11) & to_stdlogic(TACH_EDGE10) & to_stdlogic(TACH_EDGE9) & to_stdlogic(TACH_EDGE8) & to_stdlogic(TACH_EDGE7) & to_stdlogic(TACH_EDGE6) & to_stdlogic(TACH_EDGE5) & to_stdlogic(TACH_EDGE4) & to_stdlogic(TACH_EDGE3) & to_stdlogic(TACH_EDGE2) & to_stdlogic(TACH_EDGE1));
      -- Mask interrupt
      tachint_mask <= ((TACHSTATUS(15) AND TACHIRQMASK(15)) OR (TACHSTATUS(14) AND TACHIRQMASK(14)) OR (TACHSTATUS(13) AND TACHIRQMASK(13)) OR (TACHSTATUS(12) AND TACHIRQMASK(12)) OR (TACHSTATUS(11) AND TACHIRQMASK(11)) OR (TACHSTATUS(10) AND TACHIRQMASK(10)) OR (TACHSTATUS(9) AND TACHIRQMASK(9)) OR (TACHSTATUS(8) AND TACHIRQMASK(8)) OR (TACHSTATUS(7) AND TACHIRQMASK(7)) OR (TACHSTATUS(6) AND TACHIRQMASK(6)) OR (TACHSTATUS(5) AND TACHIRQMASK(5)) OR (TACHSTATUS(4) AND TACHIRQMASK(4)) OR (TACHSTATUS(3) AND TACHIRQMASK(3)) OR (TACHSTATUS(2) AND TACHIRQMASK(2)) OR ((TACHSTATUS(1) AND TACHIRQMASK(1)) OR (TACHSTATUS(0) AND TACHIRQMASK(0))));
   END GENERATE;
   
   -- APB Data read mux
   xhdl35 : IF ((TACH_NUM = 1) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("000000000000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("000000000000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("000000000000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl36 : IF ((TACH_NUM = 2) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("00000000000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("00000000000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("00000000000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl37 : IF ((TACH_NUM = 3) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("0000000000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("0000000000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("0000000000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl38 : IF ((TACH_NUM = 4) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("000000000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("000000000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("000000000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl39 : IF ((TACH_NUM = 5) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("00000000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("00000000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("00000000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl40 : IF ((TACH_NUM = 6) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("0000000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("0000000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("0000000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl41 : IF ((TACH_NUM = 7) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("000000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("000000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("000000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl42 : IF ((TACH_NUM = 8) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("00000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("00000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("00000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl43 : IF ((TACH_NUM = 9) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("0000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("0000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("0000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl44 : IF ((TACH_NUM = 10) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("000000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("000000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("000000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN "110010" =>
               PRDATA_TACH <= TACHPULSEDUR(9);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl45 : IF ((TACH_NUM = 11) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("00000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("00000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("00000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN "110010" =>
               PRDATA_TACH <= TACHPULSEDUR(9);
            WHEN "110011" =>
               PRDATA_TACH <= TACHPULSEDUR(10);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl46 : IF ((TACH_NUM = 12) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("0000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("0000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("0000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN "110010" =>
               PRDATA_TACH <= TACHPULSEDUR(9);
            WHEN "110011" =>
               PRDATA_TACH <= TACHPULSEDUR(10);
            WHEN "110100" =>
               PRDATA_TACH <= TACHPULSEDUR(11);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl47 : IF ((TACH_NUM = 13) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("000" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("000" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("000" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN "110010" =>
               PRDATA_TACH <= TACHPULSEDUR(9);
            WHEN "110011" =>
               PRDATA_TACH <= TACHPULSEDUR(10);
            WHEN "110100" =>
               PRDATA_TACH <= TACHPULSEDUR(11);
            WHEN "110101" =>
               PRDATA_TACH <= TACHPULSEDUR(12);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl48 : IF ((TACH_NUM = 14) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("00" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("00" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("00" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN "110010" =>
               PRDATA_TACH <= TACHPULSEDUR(9);
            WHEN "110011" =>
               PRDATA_TACH <= TACHPULSEDUR(10);
            WHEN "110100" =>
               PRDATA_TACH <= TACHPULSEDUR(11);
            WHEN "110101" =>
               PRDATA_TACH <= TACHPULSEDUR(12);
            WHEN "110110" =>
               PRDATA_TACH <= TACHPULSEDUR(13);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl49 : IF ((TACH_NUM = 15) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= ("0" & TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= ("0" & TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= ("0" & TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN "110010" =>
               PRDATA_TACH <= TACHPULSEDUR(9);
            WHEN "110011" =>
               PRDATA_TACH <= TACHPULSEDUR(10);
            WHEN "110100" =>
               PRDATA_TACH <= TACHPULSEDUR(11);
            WHEN "110101" =>
               PRDATA_TACH <= TACHPULSEDUR(12);
            WHEN "110110" =>
               PRDATA_TACH <= TACHPULSEDUR(13);
            WHEN "110111" =>
               PRDATA_TACH <= TACHPULSEDUR(14);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   xhdl50 : IF ((TACH_NUM = 16) AND (CONFIG_MODE > 0)) GENERATE
      PROCESS (PADDR, PWM_STRETCH, TACHPRESCALE, TACHSTATUS, TACHIRQMASK, TACHMODE, TACHPULSEDUR)
      BEGIN
         CASE PADDR(7 DOWNTO 2) IS
            WHEN "100101" =>
               PRDATA_TACH <= ("000000000000" & TACHPRESCALE(3 DOWNTO 0));
            WHEN "100110" =>
               PRDATA_TACH <= (TACHSTATUS(TACH_NUM - 1 DOWNTO 0));
            WHEN "100111" =>
               PRDATA_TACH <= (TACHIRQMASK(TACH_NUM - 1 DOWNTO 0));
            WHEN "101000" =>
               PRDATA_TACH <= (TACHMODE(TACH_NUM - 1 DOWNTO 0));
            WHEN "101001" =>
               PRDATA_TACH <= TACHPULSEDUR(0);
            WHEN "101010" =>
               PRDATA_TACH <= TACHPULSEDUR(1);
            WHEN "101011" =>
               PRDATA_TACH <= TACHPULSEDUR(2);
            WHEN "101100" =>
               PRDATA_TACH <= TACHPULSEDUR(3);
            WHEN "101101" =>
               PRDATA_TACH <= TACHPULSEDUR(4);
            WHEN "101110" =>
               PRDATA_TACH <= TACHPULSEDUR(5);
            WHEN "101111" =>
               PRDATA_TACH <= TACHPULSEDUR(6);
            WHEN "110000" =>
               PRDATA_TACH <= TACHPULSEDUR(7);
            WHEN "110001" =>
               PRDATA_TACH <= TACHPULSEDUR(8);
            WHEN "110010" =>
               PRDATA_TACH <= TACHPULSEDUR(9);
            WHEN "110011" =>
               PRDATA_TACH <= TACHPULSEDUR(10);
            WHEN "110100" =>
               PRDATA_TACH <= TACHPULSEDUR(11);
            WHEN "110101" =>
               PRDATA_TACH <= TACHPULSEDUR(12);
            WHEN "110110" =>
               PRDATA_TACH <= TACHPULSEDUR(13);
            WHEN "110111" =>
               PRDATA_TACH <= TACHPULSEDUR(14);
            WHEN "111000" =>
               PRDATA_TACH <= TACHPULSEDUR(15);
            WHEN OTHERS =>
               PRDATA_TACH <= "0000000000000000";
         END CASE;
      END PROCESS;
      
   END GENERATE;
   
   -- APB Read data
   xhdl51 : IF (APB_DWIDTH = 32) GENERATE
      PRDATA <= PRDATA_regif WHEN ((PADDR(7 DOWNTO 2) <= "100100") OR (PADDR(7 DOWNTO 2) = "111001")) ELSE
                ("0000000000000000" & PRDATA_TACH(15 DOWNTO 0));
   END GENERATE;
      xhdl53 : IF (APB_DWIDTH = 16) GENERATE
         PRDATA <= PRDATA_regif WHEN ((PADDR(7 DOWNTO 2) <= "100100") OR (PADDR(7 DOWNTO 2) = "111001")) ELSE
                   PRDATA_TACH(15 DOWNTO 0);
      END GENERATE;
      xhdl54 : IF (APB_DWIDTH = 8) GENERATE
         PRDATA <= PRDATA_regif;
      END GENERATE;
  
-- APB write to PWM_STRETCH 
      PROCESS (aresetn, PCLK)
      BEGIN
         IF ((NOT(aresetn)) = '1') THEN
            PWM_STRETCH <= (others => '0');
         ELSIF (PCLK'EVENT AND PCLK = '1') THEN
            IF ((NOT(sresetn)) = '1') THEN
               PWM_STRETCH <= (others => '0');
		    ELSE
               IF ((PSEL = '1') AND (PWRITE = '1') AND (PENABLE = '1')) THEN
                  CASE PADDR(7 DOWNTO 2) IS
                     WHEN "100100" =>
                        PWM_STRETCH <= PWDATA(PWM_NUM - 1 DOWNTO 0);
                     WHEN OTHERS =>
                        PWM_STRETCH <= PWM_STRETCH;
                  END CASE;
               END IF;
            END IF;
         END IF;
      END PROCESS;

   -- force PWM output based on PWM_STRETCH
   -- Write process parameter-based addresses
   pwm_out_mux : FOR l IN 1 TO  (PWM_NUM) GENERATE
      xhdl55 : IF (CONFIG_MODE = 0) GENERATE
         PWM(l) <= PWM_int(l);
      END GENERATE;
      xhdl56 : IF (NOT(CONFIG_MODE = 0)) GENERATE
         xhdl57 : IF (CONFIG_MODE = 1) GENERATE
            PWM(l) <= PWM_STRETCH_VALUE_int(l - 1) WHEN ((PWM_STRETCH(l - 1)) = '1') ELSE
                      PWM_int(l);
         END GENERATE;
      END GENERATE;
   END GENERATE;

   --sub-module instantiations
   xhdl58 : IF (CONFIG_MODE < 2) GENERATE

   reg_if_inst : corepwm_reg_if
      GENERIC MAP ( SYNC_RESET => SYNC_RESET,
                    PWM_NUM => PWM_NUM,
                    APB_DWIDTH => APB_DWIDTH,
                    FIXED_PRESCALE_EN => FIXED_PRESCALE_EN,
                    FIXED_PRESCALE => FIXED_PRESCALE,
                    FIXED_PERIOD_EN => FIXED_PERIOD_EN,
                    FIXED_PERIOD => FIXED_PERIOD,
                    DAC_MODE => DAC_MODE,
                    SHADOW_REG_EN => SHADOW_REG_EN,
                    FIXED_PWM_POS_EN => FIXED_PWM_POS_EN,
                    FIXED_PWM_POSEDGE => FIXED_PWM_POSEDGE,
                    FIXED_PWM_NEG_EN => FIXED_PWM_NEG_EN,
                    FIXED_PWM_NEGEDGE => FIXED_PWM_NEGEDGE
      )
      PORT MAP (
         PCLK                  => PCLK,
         PRESETN               => PRESETN,
         PSEL                  => PSEL,
         PENABLE               => PENABLE,
         PWRITE                => PWRITE,
         PADDR                 => PADDR(7 DOWNTO 2),
         PWDATA                => PWDATA,
         PWM_STRETCH           => PWM_STRETCH,
         PRDATA_regif          => PRDATA_regif,
         pwm_posedge_out_wire_o=> pwm_posedge_reg,
         pwm_negedge_out_wire_o=> pwm_negedge_reg,
         prescale_out_wire_o   => prescale_reg,
         period_out_wire_o     => period_reg,
         period_cnt            => period_cnt,
         pwm_enable_out_wire_o => pwm_enable_reg,
         sync_pulse            => sync_pulse
      );
   
    END GENERATE;
   
        G0a: IF ((SHADOW_REG_EN(PWM_NUM - 1 DOWNTO 0) = all_zeros(PWM_NUM - 1 DOWNTO 0)) AND (DAC_MODE(PWM_NUM - 1 DOWNTO 0) = all_ones(PWM_NUM - 1 DOWNTO 0)) 
                --AND ((FAMILY /= 12) AND (FAMILY /= 13))
                ) GENERATE
  		period_cnt <= (others => '0');
  		sync_pulse <= '0';
        END GENERATE;
--        G0b: IF (NOT((SHADOW_REG_EN(PWM_NUM - 1 DOWNTO 0) = all_zeros(PWM_NUM - 1 DOWNTO 0)) AND (DAC_MODE(PWM_NUM - 1 DOWNTO 0) = all_ones(PWM_NUM - 1 DOWNTO 0)))) GENERATE
        G0b: IF ((NOT((SHADOW_REG_EN(PWM_NUM - 1 DOWNTO 0) = all_zeros(PWM_NUM - 1 DOWNTO 0)) AND (DAC_MODE(PWM_NUM - 1 DOWNTO 0) = all_ones(PWM_NUM - 1 DOWNTO 0)) AND (CONFIG_MODE < 2)) 
                --AND ((FAMILY /= 12) AND (FAMILY /= 13)))
                )) GENERATE
			
   		timebase_inst : corepwm_timebase
      	GENERIC MAP ( SYNC_RESET => SYNC_RESET,
      	              APB_DWIDTH => APB_DWIDTH
      	)
      	PORT MAP (
         PCLK          => pwm_clk_int,
         PRESETN       => PRESETN,
         prescale_reg  => prescale_reg,
         period_reg    => period_reg,
         period_cnt    => period_cnt,
         sync_pulse    => sync_pulse
      	);
       END GENERATE;


   xhdl59 : IF ((CONFIG_MODE > 0) AND (APB_DWIDTH > 15)) GENERATE
      tach_interface : FOR t IN 0 TO  (TACH_NUM - 1) GENERATE
         
         
         tach_if_inst : corepwm_tach_if
            GENERIC MAP ( SYNC_RESET => SYNC_RESET,
                          tach_num  => TACH_NUM
            )
            PORT MAP (
               --microcontroller IF
               pclk           => PCLK,
               presetn        => PRESETN,
               -- TACH IF
               tachstatus    => TACHSTATUS(t),
               tach_edge      => TACH_EDGE(t),
               tachin         => TACHIN(t),
               tachmode       => TACHMODE(t),
               status_clear   => status_clear(t),
               tach_cnt_clk   => tach_cnt_clk,
               tachpulsedur   => TACHPULSEDUR(t),
               update_status  => update_status(t)
            );
      END GENERATE;
   END GENERATE;
   

  -- APB Ready and Slave Error signals
   PREADY <= '1';
   PSLVERR <= '0';

  xhdl63 : IF (CONFIG_MODE < 2) GENERATE  

   pwm_gen_inst : corepwm_pwm_gen
      GENERIC MAP ( SYNC_RESET => SYNC_RESET,
                    PWM_NUM => PWM_NUM,
                    APB_DWIDTH => APB_DWIDTH,
                    DAC_MODE => DAC_MODE
      )
      PORT MAP (
         PCLK             => pwm_clk_int,
         PRESETN          => PRESETN,
         PWM              => PWM_int,
         period_cnt       => period_cnt,
         pwm_enable_reg   => pwm_enable_reg,
         pwm_posedge_reg  => pwm_posedge_reg,
         pwm_negedge_reg  => pwm_negedge_reg,
         sync_pulse       => sync_pulse
      );
  END GENERATE;
   
END trans;





