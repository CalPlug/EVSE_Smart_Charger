-- ********************************************************************
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
--
-- Description: Package for CoreSPI
--
--
-- SVN Revision Information:
-- SVN $Revision: 28015 $
-- SVN $Date: 2016-11-24 20:45:11 +0530 (Thu, 24 Nov 2016) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes:
-- best viewed with tabstops set to "4"
-- *******************************************************************
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.numeric_std.all;

package corespi_pkg is


---------------------------------------------------------------------------


constant MAXSTRLEN : INTEGER := 256;
type     T_NUMTYPE is ( NONE, INT, VECT, STRG);

constant MAXBYTES : integer := 256;
subtype QWORD      is std_logic_vector ((MAXBYTES*8)-1 downto 0);


FUNCTION SYNC_MODE_SEL( FAMILY: INTEGER) RETURN INTEGER;
FUNCTION SPS_SET(CFG_MODE,CFG_MOT_SSEL,CFG_TI_NSC_CUSTOM,CFG_NSC_OPERATION: INTEGER) RETURN INTEGER;
FUNCTION SPO_SET(CFG_MODE,CFG_MOT_MODE,CFG_TI_NSC_CUSTOM,CFG_TI_NSC_FRC: INTEGER) RETURN INTEGER;
FUNCTION SPH_SET(CFG_MODE,CFG_MOT_MODE,CFG_TI_NSC_CUSTOM,CFG_TI_JMB_FRAMES,CFG_NSC_OPERATION: INTEGER) RETURN INTEGER;
function sl2int	(s: std_logic_vector) return integer;
function int2slv (val: in integer; len: in integer) return std_logic_vector;
function int2sl (val: in integer) return std_logic;
-- character to natural

function log2 (N: in positive) return natural;

end corespi_pkg;

---------------------------------- Pkg Body ----------------------------------

package body corespi_pkg is

    FUNCTION SYNC_MODE_SEL (FAMILY: INTEGER) RETURN INTEGER IS
        VARIABLE return_val : INTEGER := 0;
        BEGIN
        IF(FAMILY = 25) THEN
            return_val := 1;
        ELSE
            return_val := 0;
        END IF;
        RETURN return_val;
    END SYNC_MODE_SEL;
   
    FUNCTION SPS_SET(CFG_MODE,CFG_MOT_SSEL,CFG_TI_NSC_CUSTOM,CFG_NSC_OPERATION: INTEGER) RETURN INTEGER IS
        VARIABLE return_val : INTEGER := 0;
        BEGIN
        IF(((CFG_MODE = 0) AND (CFG_MOT_SSEL = 1)) OR ((CFG_MODE = 2) AND (CFG_TI_NSC_CUSTOM = 1) AND (CFG_NSC_OPERATION = 2)))THEN
            return_val := 1;
        ELSE
            return_val := 0;
        END IF;
        RETURN return_val;
    END SPS_SET;
    
    FUNCTION SPO_SET(CFG_MODE,CFG_MOT_MODE,CFG_TI_NSC_CUSTOM,CFG_TI_NSC_FRC: INTEGER) RETURN INTEGER IS
        VARIABLE return_val : INTEGER := 0;
        BEGIN
		IF(((CFG_MODE = 0) AND ((CFG_MOT_MODE = 2) OR (CFG_MOT_MODE = 3))) OR (((CFG_MODE = 1) OR (CFG_MODE = 2)) AND (CFG_TI_NSC_CUSTOM = 1) AND (CFG_TI_NSC_FRC = 1)))THEN
            return_val := 1;
        ELSE
            return_val := 0;
        END IF;
        RETURN return_val;
    END SPO_SET;
   
    FUNCTION SPH_SET(CFG_MODE,CFG_MOT_MODE,CFG_TI_NSC_CUSTOM,CFG_TI_JMB_FRAMES,CFG_NSC_OPERATION: INTEGER) RETURN INTEGER IS
        VARIABLE return_val : INTEGER := 0;
        BEGIN
        IF(((CFG_MODE = 0) AND ((CFG_MOT_MODE = 1) OR (CFG_MOT_MODE = 3))) OR (((CFG_MODE = 1) AND (CFG_TI_NSC_CUSTOM = 1) AND (CFG_TI_JMB_FRAMES = 1)) OR ((CFG_MODE = 2) AND (CFG_TI_NSC_CUSTOM = 1) AND (CFG_NSC_OPERATION = 1)))) THEN
            return_val := 1;
        ELSE
            return_val := 0;
        END IF;
        RETURN return_val;
    END SPH_SET;
    
-- small function to convert std_logic and std_logic_vector to integer
-- Note: only good for vectors < 32 bits!
function sl2int	(s: std_logic_vector) return integer is
variable i: integer;

begin
	i	:= 0;
	for j in s'range loop
		if (s(j) = '1') then
			i := i + (2 ** j);
		end if;
	end loop;
	return i;
end sl2int;
function sl2int	(s: std_logic) return integer is
variable i: integer;
begin
	if (s = '1') then
		i := 1;
	else
		i := 0;
	end if;
	return i;
end sl2int;

function int2sl (val: in integer) return std_logic is
variable i: std_logic;
begin
  if(val = 0) then
    i := '0';
  else
    i := '1';
  end if;
  return i;
end int2sl;

-- small function to convert integer to std_logic_vector
function int2slv (val: in integer; len: in integer) return std_logic_vector is
variable rtn	: std_logic_vector(len-1 downto 0) := (others => '0');
variable num	: integer := val;
variable r		: integer;
begin
	for i in 0 to len-1 loop
		r	:= num rem 2;
		num	:= num/2;
		if (r = 1) then
			rtn(i) := '1';
		else
			rtn(i) := '0';
		end if;
	end loop;
	return(rtn);
end int2slv;

-- log2 function
function log2 (N: in positive) return natural is
variable tmp, res : integer;
begin
    tmp := 1;
    res := 0;
    while tmp < N loop
        tmp := tmp*2;
        res := res+1;
    end loop;
    return res;
end log2;



end corespi_pkg;

