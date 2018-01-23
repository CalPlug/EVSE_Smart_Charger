-- ********************************************************************
-- Actel Corporation Proprietary and Confidential
--  Copyright 2008 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description: Testbench package for coregpio
--
--  Revision Information:
-- Date     Description
-- 30July07  Revision:2.1
-- 02June08   Revision:3.0

-- SVN Revision Information:
-- SVN $Revision: 5596 $
-- SVN $Date: 2008-12-23 15:21:48 -0800 (Tue, 23 Dec 2008) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes:
-- best viewed with tabstops set to "4"
--
-- History:			4/02/03 - TFB created
-- *******************************************************************
library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;
library std;
use     std.textio.all;

package coregpio_pkg is

---------------------------------------------------------------------------

constant MAXSTRLEN : INTEGER := 256;
type     T_NUMTYPE is ( NONE, INT, VECT, STRG);

-- Made this bigger for huge SDLC frames ... I'm too lazy to recode the printf
-- subroutines!
--subtype QWORD      is std_logic_vector (63 downto 0);
constant MAXBYTES : integer := 256;
subtype QWORD      is std_logic_vector ((MAXBYTES*8)-1 downto 0);


function SYNC_MODE_SEL(FAMILY: integer) return integer;
function sl2int	(s: std_logic_vector) return integer;
function int2slv (val: in integer; len: in integer) return std_logic_vector;
-- character to natural

end coregpio_pkg;

---------------------------------- Pkg Body ----------------------------------

package body coregpio_pkg is

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

end coregpio_pkg;
