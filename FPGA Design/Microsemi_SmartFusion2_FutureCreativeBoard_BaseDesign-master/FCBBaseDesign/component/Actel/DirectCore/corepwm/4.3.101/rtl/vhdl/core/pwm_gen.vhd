--/******************************************************************************
--
--    File Name:  corepwm_pwm_gen.vhd
--      Version:  4.0
--         Date:  July 14th, 2009
--  Description:  PWM Generation Module
--
--
-- SVN Revision Information:
-- SVN $Revision: 22653 $
-- SVN $Date: 2014-05-19 11:07:07 +0100 (Mon, 19 May 2014) $  
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

ENTITY corepwm_pwm_gen IS
   GENERIC ( SYNC_RESET : integer := 0;
             PWM_NUM    : integer := 1;    
             APB_DWIDTH : integer := 8;    
             DAC_MODE   : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000"
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
END corepwm_pwm_gen;

ARCHITECTURE trans OF corepwm_pwm_gen IS
   
   SIGNAL PWM_int         : STD_LOGIC_VECTOR(PWM_NUM DOWNTO 1);
   SIGNAL acc             : STD_LOGIC_VECTOR(PWM_NUM * (APB_DWIDTH + 1) DOWNTO 1);
   SIGNAL aresetn         : STD_LOGIC;
   SIGNAL sresetn         : STD_LOGIC;
BEGIN
   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
   sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';
   
   PWM(PWM_NUM DOWNTO 1) <= PWM_int(PWM_NUM DOWNTO 1);
   PWM_output_select :    FOR z IN 1 TO  PWM_NUM GENERATE
      PWM_output_generation :    
      IF (DAC_MODE(z - 1) = '0') GENERATE
         PROCESS (aresetn, PCLK)
         BEGIN
            IF ((NOT(aresetn)) = '1') THEN
               PWM_int(z) <= '0';
            ELSIF (PCLK'EVENT AND PCLK = '1') THEN
               IF ((NOT(sresetn)) = '1') THEN
                  PWM_int(z) <= '0';
			   ELSE
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
            END IF;
         END PROCESS;
      END GENERATE;
      DAC_output_generation :      IF (NOT(DAC_MODE(z - 1) = '0')) GENERATE
       PROCESS (aresetn, PCLK)
       BEGIN
          IF ((NOT(aresetn)) = '1') THEN
             acc(z * (APB_DWIDTH + 1) DOWNTO (z - 1) * (APB_DWIDTH + 1) + 1) <= (others => '0');
             PWM_int(z) <= '0';
          ELSIF (PCLK'EVENT AND PCLK = '1') THEN
              IF ((NOT(sresetn)) = '1') THEN
                 acc(z * (APB_DWIDTH + 1) DOWNTO (z - 1) * (APB_DWIDTH + 1) + 1) <= (others => '0');
                 PWM_int(z) <= '0';
		      ELSE
                 IF (pwm_enable_reg(z) = '0') THEN
                    PWM_int(z) <= '0';
                 ELSIF (pwm_enable_reg(z) = '1') THEN
			    		acc(z*(APB_DWIDTH+1) DOWNTO (z-1)*(APB_DWIDTH + 1)+1) <= ('0' & acc((z*(APB_DWIDTH+1))-1 DOWNTO (z-1)*(APB_DWIDTH + 1)+1) + pwm_negedge_reg(z*APB_DWIDTH DOWNTO ((z-1)*APB_DWIDTH) + 1));
                    PWM_int(z) <= acc(z * (APB_DWIDTH + 1));
                 END IF;
              END IF;
          END IF;
       END PROCESS;
      END GENERATE;
   END GENERATE;
   
   
END trans;
