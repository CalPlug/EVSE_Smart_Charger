--
--
-- SVN Revision Information:
-- SVN $Revision: 23027 $
-- SVN $Date: 2014-06-30 11:05:22 +0100 (Mon, 30 Jun 2014) $  
--
--
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package components is
 component corepwm IS
   GENERIC (
      FAMILY      	   : INTEGER := 0; --range 0 to 25;
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
END component;

end components;
