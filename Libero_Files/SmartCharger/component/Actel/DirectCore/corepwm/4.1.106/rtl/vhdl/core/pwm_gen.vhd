--/******************************************************************************
--
--    File Name:  pwm_gen.vhd
--      Version:  4.0
--         Date:  July 14th, 2009
--  Description:  PWM Generation Module
--
--
-- SVN Revision Information:
-- SVN $Revision: 10769 $
-- SVN $Date: 2009-11-05 15:38:11 -0800 (Thu, 05 Nov 2009) $  
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
   use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY pwm_gen IS
   GENERIC (
      PWM_NUM                        :  integer := 1;    
      APB_DWIDTH                        :  integer := 8;    
      DAC_MODE            : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000"
      );
   PORT (
      PRESETN              : IN STD_LOGIC;
      PCLK                 : IN STD_LOGIC;
      PWM                  : OUT STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
      period_cnt           : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      pwm_enable_reg       : IN STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
      pwm_posedge_reg      : IN STD_LOGIC_VECTOR((PWM_NUM * APB_DWIDTH) DOWNTO 1);
      pwm_negedge_reg      : IN STD_LOGIC_VECTOR((PWM_NUM * APB_DWIDTH) DOWNTO 1);
      sync_pulse           : IN STD_LOGIC
   );
END pwm_gen;

ARCHITECTURE trans OF pwm_gen IS
   
   SIGNAL PWM_int         : STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
   SIGNAL acc             : STD_LOGIC_VECTOR(PWM_NUM * (APB_DWIDTH + 1) DOWNTO 1);
BEGIN
   PWM(PWM_NUM DOWNTO 1) <= PWM_int(PWM_NUM DOWNTO 1);
   PWM_output_select :    FOR z IN 1 TO  PWM_NUM GENERATE
      PWM_output_generation :    
      IF (DAC_MODE(z - 1) = '0') GENERATE
         PROCESS (PRESETN, PCLK)
         BEGIN
            IF ((NOT(PRESETN)) = '1') THEN
               PWM_int(z) <= '0';
            ELSIF (PCLK'EVENT AND PCLK = '1') THEN
               IF (pwm_enable_reg(z) = '0') THEN
                  PWM_int(z) <= '0';
               ELSIF ((pwm_enable_reg(z) = '1') AND (sync_pulse = '1')) THEN
                  IF ((pwm_posedge_reg(z * APB_DWIDTH DOWNTO (z - 1) * APB_DWIDTH + 1) = pwm_negedge_reg(z * APB_DWIDTH DOWNTO (z - 1) * APB_DWIDTH + 1)) AND ((pwm_posedge_reg(z * APB_DWIDTH DOWNTO (z - 1) * APB_DWIDTH + 1)) = period_cnt)) THEN
                     PWM_int(z) <= NOT(PWM_int(z));
                  ELSIF ((pwm_enable_reg(z) = '1') AND (sync_pulse = '1') AND (pwm_posedge_reg(z * APB_DWIDTH DOWNTO (z - 1) * APB_DWIDTH + 1)) = period_cnt) THEN
                     PWM_int(z) <= '1';
                  ELSIF ((pwm_enable_reg(z) = '1') AND (sync_pulse = '1') AND (pwm_negedge_reg(z * APB_DWIDTH DOWNTO (z - 1) * APB_DWIDTH + 1)) = period_cnt) THEN
                     PWM_int(z) <= '0';
                  END IF;
               END IF;
            END IF;
         END PROCESS;
      END GENERATE;
      DAC_output_generation :      IF (NOT(DAC_MODE(z - 1) = '0')) GENERATE
       PROCESS (PRESETN, PCLK)
       BEGIN
          IF ((NOT(PRESETN)) = '1') THEN
             acc(z * (APB_DWIDTH + 1) DOWNTO (z - 1) * (APB_DWIDTH + 1) + 1) <= (others => '0');
             PWM_int(z) <= '0';
          ELSIF (PCLK'EVENT AND PCLK = '1') THEN
             IF (pwm_enable_reg(z) = '0') THEN
                PWM_int(z) <= '0';
             ELSIF (pwm_enable_reg(z) = '1') THEN
					acc(z*(APB_DWIDTH+1) DOWNTO (z-1)*(APB_DWIDTH + 1)+1) <= ('0' & acc((z*(APB_DWIDTH+1))-1 DOWNTO (z-1)*(APB_DWIDTH + 1)+1) + pwm_negedge_reg(z*APB_DWIDTH DOWNTO ((z-1)*APB_DWIDTH) + 1));
                PWM_int(z) <= acc(z * (APB_DWIDTH + 1));
             END IF;
          END IF;
       END PROCESS;
      END GENERATE;
   END GENERATE;
   
   
END trans;
