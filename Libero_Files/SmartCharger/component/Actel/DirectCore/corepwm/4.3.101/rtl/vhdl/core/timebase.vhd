--/******************************************************************************
--
--    File Name:  corepwm_timebase.vhd
--      Version:  4.0
--         Date:  July 14th, 2009
--  Description:  Timebase module
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
   USE ieee.std_logic_unsigned.all;


ENTITY corepwm_timebase IS
   GENERIC ( SYNC_RESET : INTEGER := 0;
             APB_DWIDTH : INTEGER := 8
   );
   PORT (
      PRESETN               : IN STD_LOGIC;
      PCLK                  : IN STD_LOGIC;
      period_reg            : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      prescale_reg          : IN STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      period_cnt            : OUT STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
      sync_pulse            : OUT STD_LOGIC
   );
END corepwm_timebase;

ARCHITECTURE trans OF corepwm_timebase IS
   
   SIGNAL prescale_cnt     	: STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL period_cnt_int	: STD_LOGIC_VECTOR(APB_DWIDTH - 1 DOWNTO 0);
   SIGNAL aresetn           : STD_LOGIC;
   SIGNAL sresetn           : STD_LOGIC;
BEGIN

   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE PRESETN;
   sresetn <= PRESETN WHEN (SYNC_RESET=1) ELSE '1';
   
   PROCESS (aresetn, PCLK)
   BEGIN
      IF ((NOT(aresetn)) = '1') THEN
         prescale_cnt <= (others => '0');
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF ((NOT(sresetn)) = '1') THEN
            prescale_cnt <= (others => '0');
	     ELSE
            IF (prescale_cnt >= prescale_reg) THEN
               prescale_cnt <= (others => '0');
            ELSE
               prescale_cnt <= prescale_cnt + "01";
            END IF;
         END IF;
      END IF;
   END PROCESS;
   
   PROCESS (aresetn, PCLK)
   BEGIN
      IF ((NOT(aresetn)) = '1') THEN
         period_cnt_int <= (others => '0');
      ELSIF (PCLK'EVENT AND PCLK = '1') THEN
         IF ((NOT(sresetn)) = '1') THEN
            period_cnt_int <= (others => '0');
	     ELSE
            IF ((period_cnt_int >= period_reg) AND (prescale_cnt >= prescale_reg)) THEN
               period_cnt_int <= (others => '0');
            ELSIF (prescale_cnt = prescale_reg) THEN
               period_cnt_int <= period_cnt_int + "01";
            END IF;
         END IF;
      END IF;
   END PROCESS;
   period_cnt <= period_cnt_int;
   sync_pulse <= '1' WHEN prescale_cnt >= prescale_reg ELSE
                 '0';
   
END trans;


