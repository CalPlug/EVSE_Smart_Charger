-- ********************************************************************/ 
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
--
-- SPI Clock Mux
--
--
-- SVN Revision Information:
-- SVN $Revision: 23983 $
-- SVN $Date: 2014-11-28 23:42:46 +0530 (Fri, 28 Nov 2014) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes: 
-- -----
--
-- ********************************************************************/ 
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY spi_clockmux IS
   PORT (
      sel                   : IN STD_LOGIC;
      clka                  : IN STD_LOGIC;
      clkb                  : IN STD_LOGIC;
      clkout                : OUT STD_LOGIC
   );
END spi_clockmux;

ARCHITECTURE trans OF spi_clockmux IS
BEGIN
   
   PROCESS (sel, clka, clkb)
   BEGIN
      CASE sel IS
         WHEN '0' =>
            clkout <= clka;
         WHEN '1' =>
            clkout <= clkb;
         WHEN OTHERS =>
            clkout <= clka;
      END CASE;
   END PROCESS;
   
   
END trans;


