-- *********************************************************************/
-- Copyright (c) 2008 Actel Corporation.  All rights reserved.
-- ******************************************************************************
--
--    File Name:  i2c_spk.vhd
--      Version:  5.0
--         Date:  Aug 20th, 2008
--  Description:  spike generator
--
--      Company:  Actel
--
--   SVN Revision Information:
--   SVN $Revision: 10646 $
--   SVN $Date: 2009-11-04 04:05:34 +0530 (Wed, 04 Nov 2009) $
--
--
-- REVISION HISTORY:
-- COPYRIGHT 2008 BY ACTEL
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS
-- FROM ACTEL CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM
-- ACTEL FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND
-- NO BACK-UP OF THE FILE SHOULD BE MADE.
--
-- FUNCTIONAL DESCRIPTION:
-- Refer to the CoreI2C Handbook.
--******************************************************************************/

LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;


ENTITY i2c_spk IS
 GENERIC (
      SPIKE_CYCLE_WIDTH     : INTEGER := 0
	);
   PORT (
      PCLK                     : IN STD_LOGIC;
      PRESETN                  : IN STD_LOGIC;
      scl                      : INOUT STD_LOGIC;
      sda                      : INOUT STD_LOGIC
   );
END i2c_spk;

ARCHITECTURE trans OF i2c_spk IS
   SIGNAL sclo                    : STD_LOGIC;
   SIGNAL sdao                    : STD_LOGIC;
   SIGNAL scli                    : STD_LOGIC;
   SIGNAL sdai                    : STD_LOGIC;   
   SIGNAL counter                 : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
   scl <= '0' WHEN sclo = '0' ELSE
          'Z';
   sda <= '0' WHEN sdao = '0' ELSE
          'Z';
   scli <= scl;
   sdai <= sda;
   
   PROCESS (PCLK, PRESETN)
   BEGIN
      IF (PRESETN = '0') THEN
         counter <= "00000";
      ELSIF (PCLK'EVENT AND PCLK = '0') THEN
         counter <= counter + "00001";
      END IF;
   END PROCESS;
   
   sclo <= '0' WHEN counter < SPIKE_CYCLE_WIDTH ELSE
           '1';
   sdao <= '1';
   
END trans;


