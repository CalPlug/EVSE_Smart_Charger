-- ********************************************************************/ 
-- Actel Corporation Proprietary and Confidential
-- Copyright 2008 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.  
--  
-- Description: AMBA BFMs
--              AHB Lite BFM  
--
-- Revision Information:
-- Date     Description
-- 01Sep07  Initial Release 
-- 14Sep07  Updated for 1.2 functionality
-- 25Sep07  Updated for 1.3 functionality
-- 09Nov07  Updated for 1.4 functionality
-- 08May08  2.0 for Soft IP Usage
--
--
-- SVN Revision Information:
-- SVN $Revision: 11878 $
-- SVN $Date: 2010-01-22 20:01:17 +0000 (Fri, 22 Jan 2010) $
--
--
-- Resolved SARs
-- SAR      Date     Who  Description
--
--
-- Notes: 
--        
-- *********************************************************************/ 


library IEEE;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


package bfm_misc is

type INTEGER_ARRAY is array ( INTEGER range <>) of INTEGER;

subtype NIBBLE     is UNSIGNED ( 3 downto 0);
subtype BYTE       is UNSIGNED ( 7 downto 0);
subtype WORD       is UNSIGNED (15 downto 0);
subtype DWORD      is UNSIGNED (31 downto 0);
subtype QWORD      is UNSIGNED (63 downto 0);

type BYTE_ARRAY    is array ( INTEGER range <>) of BYTE;
type WORD_ARRAY    is array ( INTEGER range <>) of WORD;
type DWORD_ARRAY   is array ( INTEGER range <>) of DWORD;
type TIME_ARRAY    is array ( INTEGER range <>) of TIME;
type BOOLEAN_ARRAY is array ( INTEGER range <>) of BOOLEAN;

type BOOLEAN_VECTOR is array ( INTEGER range <>) of BOOLEAN;

constant ZERO    : DWORD := (others => '0');
constant ZERO16  : WORD := (others => '0');
constant ALLONES : std_logic_vector (31 downto 0) := (others => '0');
constant UNKNOWN : std_logic_vector (31 downto 0) := (others => 'U');

   procedure waitclocks(signal clock : std_logic; N : INTEGER);

   function to_std_logic( x: UNSIGNED ) return std_logic_vector;
   function to_std_logic( x: SIGNED ) return std_logic_vector;
   function to_unsigned( x: std_logic_vector ) return UNSIGNED;
   function to_signed( x: std_logic_vector ) return SIGNED;


   function to_std_logic( tmp : INTEGER ) return std_logic;
   function to_std_logic_invert( tmp : INTEGER ) return std_logic;
   function to_std_logic( tmp : BOOLEAN ) return std_logic;
   function to_std_logic_invert( tmp : BOOLEAN ) return std_logic;
   function to_boolean( tmp : integer ) return BOOLEAN;
   function to_boolean( tmp : std_logic ) return BOOLEAN;
   function to_boolean_invert( tmp : std_logic ) return BOOLEAN;
   function to_integer( tmp : boolean ) return INTEGER;

   function to_byte  ( x : INTEGER ) return BYTE;
   function to_word  ( x : INTEGER ) return WORD;
   function to_dword ( x : INTEGER ) return DWORD;

   function to_byte  ( str : STRING ) return BYTE;
   function to_word  ( str : STRING ) return WORD;
   function to_dword ( str : STRING ) return DWORD;

   function to_dword_signed ( str : STRING ) return SIGNED;

   function init_data( seed : INTEGER; size : INTEGER) return DWORD_ARRAY;
   function init_data( seed : STRING; size : INTEGER) return DWORD_ARRAY;

   function maxval (a,b : integer) return integer;
   function minval (a,b : integer) return integer;
   function absval (a   : integer) return integer;
   
   function muxop ( s: boolean; a,b   : integer) return integer;
  
   function is_hex( str : STRING ) return BOOLEAN;
   function to_uppercase( c : character) return character;
   function onoff( x : boolean) return string;
   function notonoff( x : boolean) return string;
   
   function decode_params( str : string ) return INTEGER_ARRAY;
   procedure getstring( para : out string; str : string;  pos : inout integer);
   
end bfm_misc;


package body bfm_misc is

---------------------------------------------------------------------
-- Handle SIGNED and UNSIGNED to std_logic_vector conversions
--

function to_std_logic( x: UNSIGNED ) return std_logic_vector is
variable y: std_logic_vector(x'range);
begin
   for i in x'range loop
     y(i) := x(i);
   end loop;
   return(y);
end to_std_logic;

function to_unsigned( x: std_logic_vector ) return UNSIGNED is
variable y: UNSIGNED(x'range);
begin
   for i in x'range loop
     y(i) := x(i);
   end loop;
   return(y);
end to_unsigned;

function to_std_logic( x: SIGNED ) return std_logic_vector is
variable y: std_logic_vector(x'range);
begin
   for i in x'range loop
     y(i) := x(i);
   end loop;
   return(y);
end to_std_logic;

function to_signed( x: std_logic_vector ) return SIGNED is
variable y: SIGNED(x'range);
begin
   for i in x'range loop
     y(i) := x(i);
   end loop;
   return(y);
end to_signed;


---------------------------------------------------------------------
-- Miscellanous Conversions
--

function to_integer( tmp : boolean ) return INTEGER is
 begin
   if tmp then return (1);
          else return (0);
   end if;
end to_integer;

function to_std_logic_invert( tmp : INTEGER ) return std_logic is
 begin
   if tmp=1 then return ('0');
            else return ('1');
   end if;
 end to_std_logic_invert;

function to_std_logic( tmp : INTEGER ) return std_logic is
 begin
   if tmp=1 then return ('1');
            else return ('0');
   end if;
 end to_std_logic;

function to_std_logic_invert( tmp : BOOLEAN ) return std_logic is
 begin
   if tmp then return ('0');
          else return ('1');
   end if;
 end to_std_logic_invert;

function to_std_logic( tmp : BOOLEAN ) return std_logic is
 begin
   if tmp then return ('1');
          else return ('0');
   end if;
 end to_std_logic;

function to_boolean_invert( tmp : std_logic ) return BOOLEAN is
 begin
   if to_X01(tmp)='0' then return (TRUE);
                      else return (FALSE);
   end if;
 end to_boolean_invert;

function to_boolean( tmp : std_logic ) return BOOLEAN is
 begin
   if to_X01(tmp)='1' then return (TRUE);
                      else return (FALSE);
   end if;
 end to_boolean;

function to_boolean( tmp : integer ) return BOOLEAN is
 begin
   if tmp/=0 then return (TRUE);
             else return (FALSE);
   end if;
 end to_boolean;
 
 
 
 

procedure waitclocks(signal clock : std_logic;
                     N : INTEGER) is
 begin
  if N>0 then      
    for i in 1 to N loop
     wait until clock'event and clock='0';
    end loop;
  end if;
 end waitclocks;

function to_byte ( x : INTEGER ) return BYTE is
 variable x1 : BYTE;
 begin
   x1 := to_unsigned( x,8);
   return(x1);
 end to_byte;

function to_word ( x : INTEGER ) return WORD is
 variable x1 : WORD;
 begin
   x1 := to_unsigned( x,16);
   return(x1);
 end to_word;

function to_dword ( x : INTEGER ) return DWORD is
 variable x1 : DWORD;
 begin
   x1 := to_unsigned( x,32);
   return(x1);
  return(x1);
 end to_dword;


function to_byte( str : STRING ) return BYTE is
 variable str1 : string ( 1 to 2);
 variable x  : INTEGER;
 variable dw : byte;
 begin
  str1 := str;
  for i in 1 to 2 loop 
     case str1(i) is
      when '0' to '9' => x:= CHARACTER'POS(str1(i)) - CHARACTER'POS('0');
      when 'A' to 'F' => x:= 10 + CHARACTER'POS(str1(i)) - CHARACTER'POS('A');
      when 'a' to 'z' => x:= 10 + CHARACTER'POS(str1(i)) - CHARACTER'POS('a');
      when others => assert  FALSE
                        report "Illegal Character in the Hex String"
                        severity failure;
     end case;
     dw(11- (i*4)  downto 8 - (i*4) ) := to_unsigned(x,4);
  end loop;
  return(dw);
 end to_byte;

function to_word( str : STRING ) return WORD is
 variable str1 : string (1 to 4);
 variable dw : word;
 begin
  str1 := str;
  dw(15 downto 8) := to_byte( str1(1 to 2));
  dw( 7 downto 0) := to_byte( str1(3 to 4));
  return(dw);
 end to_word;

function to_dword( str : STRING ) return DWORD is
 variable str1 : string (1 to 8);
 variable dw : dword;
 begin
  str1 := str;
  dw(31 downto 16) := to_word( str1(1 to 4));
  dw(15 downto  0) := to_word( str1(5 to 8));
  return(dw);
 end to_dword;



function to_dword_signed ( str : STRING ) return SIGNED is
variable r_sign    : SIGNED(31 downto 0);
variable r_unsign  : UNSIGNED(31 downto 0);
begin
  r_unsign := to_dword(str);
  for i in r_sign'range loop
    r_sign(i) := r_unsign(i);
  end loop;
  return(r_sign);
end to_dword_signed;	
  


function init_data( seed : INTEGER; size : INTEGER) return DWORD_ARRAY is
 variable xdata : DWORD_ARRAY (0 to 255);
 begin
  -- In case there are any 16#FFFFFFFF# type constants Causes VSS to complain
  assert seed>=0
    report "INIT_DATA with integer Seed cannot be negative"
    severity failure;
  for i in 0 to size-1 loop
    xdata(i) := to_dword(seed+i);
  end loop;
  return(xdata(0 to size-1));
end init_data;

function init_data( seed : STRING; size : INTEGER) return DWORD_ARRAY is
 variable xdata  : DWORD_ARRAY (0 to 255);
 variable seedxx : DWORD;
 begin
  seedxx := to_dword(seed);
  for i in 0 to size-1 loop
    xdata(i) := seedxx +i ;
  end loop;
  return(xdata(0 to size-1));
end init_data;


function maxval( a,b : integer) return integer is
 begin
  if (a>b) then return(a);
   else return(b);
  end if;
end maxval;

function minval( a,b : integer) return integer is
 begin
  if (a<b) then return(a);
   else return(b);
  end if;
end minval;

function absval( a : integer) return integer is
 begin
  if (a>0) then return(a);
   else return(-a);
  end if;
end absval;

function muxop ( s: boolean; a,b   : integer) return integer is
 begin
   if s then return(a);
        else return(b);
   end if;
end muxop;



function is_hex( str : STRING ) return BOOLEAN is
variable ok   : boolean;
variable str1 : string ( 1 to 2);
begin
  ok   := TRUE;
  str1 := str;
  for i in 1 to 2 loop 
     case str1(i) is
      when '0' to '9' => 
      when 'A' to 'F' => 
      when 'a' to 'z' => 
      when others     => OK := FALSE;
     end case;
  end loop;
  return(ok);
end is_hex;


function to_uppercase( c : character) return character is
variable ok   : boolean;
variable cuc  : character;
begin
  case c is
      when 'a' to 'z' => cuc := character'val(character'pos(c)-32);
      when others     => cuc := c;
  end case;
  return(cuc);
end to_uppercase;


function onoff( x : boolean) return string is
 begin
  if X then return("On");
       else return("Off");
  end if;
end onoff;

function notonoff( x : boolean) return string is
 begin
  if not X then return("On");
       else return("Off");
  end if;
end notonoff;

--------------------------------------------------------------------
-- returns no of params, para1, para2 etc

function decode_params( str : string) return INTEGER_ARRAY is
variable pos    : INTEGER;
variable PARAMS : INTEGER_ARRAY(0 to 9);
variable i,x    : INTEGER;
variable ERR    : BOOLEAN;
variable BASE   : INTEGER;
variable c      : Character;
begin
 pos := 2;
 i   := 0;
 ERR := FALSE;
 PARAMS := ( others => 0 );
 while str(pos)/=NUL and not ERR loop
   while str(pos)=' ' loop
     pos := pos+1;
   end loop;
   x := 0;
   BASE := 10;
   c := str(pos); 
   while c/=' ' and c/=NUL and  c/=',' and not ERR loop
     case str(pos) is
      when '0' to '9' =>  x :=x * BASE + character'pos(c) - character'pos('0');
      when 'A' to 'F' =>  BASE := 16;
                          x :=x * BASE + 10 + character'pos(c) - character'pos('A');
      when 'a' to 'f' =>  BASE := 16;
                          x :=x * BASE + 10 + character'pos(c) - character'pos('a');
      when '#'        => BASE := 16;
      when others => ERR := TRUE;
                     --printf("Illegal character POS %d:",fmt(pos)&fmt(str));
     end case;
     pos := pos +1;
     c := str(pos); 
   end loop;
   i := i + 1;
   PARAMS(i) := x;
 end loop;
 if ERR then
   PARAMS(0) := 0;
 else
   PARAMS(0) := i;
 end if;
-- for i in 0 to PARAMS(0) loop
--  printf("Got %d",fmt(params(i)));
-- end loop;
 
 return(PARAMS);
end decode_params;



procedure getstring( para : out string; str : string;  pos : inout integer) is
variable i,x    : INTEGER;
variable ERR    : BOOLEAN;
variable BASE   : INTEGER;
variable c      : Character;
begin
 i   := 1;
 ERR := FALSE;
 for i in para'range loop
   para(i) :=  NUL;
 end loop;
 while str(pos)=' ' loop
   pos := pos+1;
 end loop;
 while str(pos) /= ' ' and str(pos)/=',' and str(pos)/=NUL and str(pos)/=';'  loop
   para(i) := str(pos);
   i := i + 1;
   pos := pos + 1;
 end loop;
end getstring;

end bfm_misc;





