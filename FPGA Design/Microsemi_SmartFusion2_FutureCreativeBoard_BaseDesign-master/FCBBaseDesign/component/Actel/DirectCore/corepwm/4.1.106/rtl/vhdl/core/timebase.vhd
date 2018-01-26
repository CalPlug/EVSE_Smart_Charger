--/******************************************************************************
--
--    File Name:  timebase.vhd
--      Version:  4.0
--         Date:  July 14th, 2009
--  Description:  Timebase module
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
   USE ieee.std_logic_unsigned.all;


ENTITY timebase IS
   GENERIC (
      APB_DWIDTH            : INTEGER := 8
   );
   PORT (
      PRESETN               : IN STD_LOGIC;
      PCLK                  : IN STD_LOGIC;
      period_reg            : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      prescale_reg          : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      period_cnt            : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      sync_pulse            : OUT STD_LOGIC
   );
END timebase;

ARCHITECTURE trans OF timebase IS
   
   SIGNAL prescale_cnt     	: STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL period_cnt_int	: STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
BEGIN
   
   PROCESS (PRESETN, PCLK)
   BEGIN
      IF ((NOT(PRESETN)) = '1') THEN
         prescale_cnt <= (others => '0');
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF (prescale_cnt >= prescale_reg) THEN
            prescale_cnt <= (others => '0');
         ELSE
            prescale_cnt <= prescale_cnt + "01";
         END IF;
      END IF;
   END PROCESS;
   
   PROCESS (PRESETN, PCLK)
   BEGIN
      IF ((NOT(PRESETN)) = '1') THEN
         period_cnt_int <= (others => '0');
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF ((period_cnt_int >= period_reg) AND (prescale_cnt >= prescale_reg)) THEN
            period_cnt_int <= (others => '0');
         ELSIF (prescale_cnt = prescale_reg) THEN
            period_cnt_int <= period_cnt_int + "01";
         END IF;
      END IF;
   END PROCESS;
   period_cnt <= period_cnt_int;
   sync_pulse <= '1' WHEN prescale_cnt >= prescale_reg ELSE
                 '0';
   
END trans;


