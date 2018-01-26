-----------------------------------------------------------------------------
-- (c) Copyright 2005 Actel Corporation
--
-- name:		corepwm_pkg.vhd
-- function:	Testbench package for CorePWM
-- comments:	best viewed with tabstops set to "4"
-- history:		05/05/03 - TFB created
--
-- Rev:			3.0 23May08 SMT - Production
--
-----------------------------------------------------------------------------

library ieee;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;
library std;
use     std.textio.all;

package corepwm_pkg is


-- functions, procedures, constants, etc...

---------------------------------------------------------------------------
-- TFB 4/29/03 - created various procedures for CPU operations

procedure cpu_wr	(
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(7 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		do:			out		std_logic_vector (7 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic
);

procedure cpu_wr16	(
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(15 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		do:			out		std_logic_vector (15 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic
);

procedure cpu_wr32	(
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(31 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		do:			out		std_logic_vector (31 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic
);

procedure cpu_rd	(
	-- only 2 LSB bits used out of 8 legacy
--	constant	addr:		in		bit_vector(7 downto 0);
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(7 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		di:			in		std_logic_vector (7 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic;
				simerrors:	inout	integer
);

procedure cpu_rd16	(
	-- only 2 LSB bits used out of 8 legacy
--	constant	addr:		in		bit_vector(7 downto 0);
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(15 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		di:			in		std_logic_vector (15 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic;
				simerrors:	inout	integer
);

procedure cpu_rd32	(
	-- only 2 LSB bits used out of 8 legacy
--	constant	addr:		in		bit_vector(7 downto 0);
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(31 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		di:			in		std_logic_vector (31 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic;
				simerrors:	inout	integer
);

---------------------------------------------------------------------------


constant MAXSTRLEN : INTEGER := 256;
type     T_NUMTYPE is ( NONE, INT, VECT, STRG);

--subtype QWORD      is std_logic_vector (63 downto 0);
constant MAXBYTES : integer := 256;
subtype QWORD      is std_logic_vector ((MAXBYTES*8)-1 downto 0);


type T_FMT is record
   f_type      : T_NUMTYPE;
   f_integer   : INTEGER;
   f_vector    : QWORD;
   f_length    : INTEGER;
   f_string    : STRING (1 to MAXSTRLEN);
end record;

type T_FMT_ARRAY is array ( integer range <> ) of T_FMT;

function is01 ( v: std_logic) return BOOLEAN;
function is01 ( v: std_logic_vector; len : INTEGER) return BOOLEAN;

function strlen( str: STRING) return INTEGER;
function strcopy ( instr : STRING) return STRING;

procedure printf( str : STRING; params : T_FMT_ARRAY);
procedure printf( str : STRING; params : T_FMT);
procedure printf( str : STRING );

procedure ifprintf( enable : BOOLEAN; str : STRING; params : T_FMT_ARRAY);
procedure ifprintf( enable : BOOLEAN; str : STRING; params : T_FMT);
procedure ifprintf( enable : BOOLEAN; str : STRING );

function fmt ( x : INTEGER) return T_FMT;
function fmt ( x : std_logic_vector) return T_FMT;
function fmt ( x : string ) return T_FMT;
function fmt ( x : boolean ) return T_FMT;
function fmt ( x : std_logic) return T_FMT;

procedure fprintf( FSTR : out text; str : STRING; params : T_FMT_ARRAY);
procedure fprintf( FSTR : out text; str : STRING; params : T_FMT);
procedure fprintf( FSTR : out text; str : STRING );


function inttostr( value : INTEGER; base : INTEGER;
                   numlen : INTEGER :=0; zeros: BOOLEAN:=FALSE) return STRING;

-- Check value of signal (expected output) & print message if mis-match
procedure checksig (
d:			std_logic;
sig_name:	string;
v:			bit;
ERRCNT:		inout	integer
);

-- Check value of signal (expected output) & print message if mis-match
procedure checksig (
d:			std_logic_vector;
sig_name:	string;
v:			bit_vector;
ERRCNT:		inout	integer
);

function sl2int	(s: std_logic) return integer;
function sl2int	(s: std_logic_vector) return integer;
function int2slv(val: in integer; len: in integer) return std_logic_vector;
function sl2x01z(s: std_logic) return std_logic;
--function vlg2x01z(s: character) return std_logic;
function vlg2x01z(s: string(1 to 1)) return std_logic;
function slv2x01z(s: std_logic_vector) return std_logic_vector;

function hex2sl(s: character) return std_logic;
function hexv2slv(s: string) return std_logic_vector;

-- expected vector types
type evbit is ('0','1','2','3','4','5','6','7','8');
type evvec is array (integer range <>) of evbit;
subtype evbyte is evvec(7 downto 0);
function ev2sl(e: evbit) return std_logic;
function evv2slv(e: evbyte) return std_logic_vector;
function to_evbit(c: character) return evbit;

-- small function to do hex numbers for std_logic_vector
function hx	(b: bit_vector) return std_logic_vector;

-- store simulation vectors for DUT

subtype BV128 is bit_vector (127 downto 0);
type SVEC1_WORD is array (integer range 0 to 2) of BV128;
type SVEC1_STORE is array (integer range <>) of SVEC1_WORD;


end corepwm_pkg;

---------------------------------- Pkg Body ----------------------------------

package body corepwm_pkg is


---------------------------------------------------------------------------
-- Basic Character Converters
--

function to_char( x : INTEGER range 0 to 15) return character is
 begin
  case x is
    when 0 => return('0');
    when 1 => return('1');   
    when 2 => return('2');    
    when 3 => return('3');
    when 4 => return('4');
    when 5 => return('5');   
    when 6 => return('6');    
    when 7 => return('7');
    when 8 => return('8');
    when 9 => return('9');                     
    when 10 => return('A');    
    when 11 => return('B');
    when 12 => return('C');
    when 13 => return('D');   
    when 14 => return('E');    
    when 15 => return('F');
  end case;
end to_char;

function to_char( v : std_logic ) return CHARACTER is
 begin
   case v is
    when '0' => return('0');
    when '1' => return('1');
    when 'L' => return('L');
    when 'H' => return('H');
    when 'Z' => return('Z');
    when 'X' => return('X');
    when 'U' => return('U');
    when '-' => return('-');
    when 'W' => return('W');
   end case;
 end to_char;

---------------------------------------------------------------------------
-- special std_logic_vector handling
--

function is01 ( v: std_logic) return BOOLEAN is
 begin
  return ( v='0' or v='1');
 end is01;

function is01 ( v: std_logic_vector; len : INTEGER) return BOOLEAN is
 variable ok : BOOLEAN;
 begin
  ok := TRUE;
  for i in 0 to len-1 loop
    ok := ok and is01( v(i));
  end loop;
  return (ok);
 end is01;

---------------------------------------------------------------------------
-- String Functions
--

function strlen( str: STRING) return INTEGER is
 variable i: INTEGER;
 begin
  i:=1;
  while i<= MAXSTRLEN and str(i)/=NUL loop
   i:=i+1;
  end loop;
  return(i-1);
 end strlen;

function strcopy ( instr : STRING) return STRING is
 variable outstr : STRING (1 to MAXSTRLEN);
 variable i: INTEGER;
 begin
  outstr(1 to instr'length) := instr;
  outstr(instr'length+1) := NUL;
  return(outstr);
 end strcopy;

---------------------------------------------------------------------------
-- Number Printing Routines
--

function hexchar ( vect : std_logic_vector) return character is
 variable v : std_logic_vector ( 3 downto 0);
 variable char : CHARACTER;
 begin
   v := vect;
   if is01(v(0)) and is01(v(1)) and is01(v(2)) and is01(v(3)) then
      char := to_char (conv_integer(v));
   elsif v(0)=v(1) and v(0)=v(2) and v(0)=v(3) then
      char:= to_char(v(0));
   else 
      char:='?';
   end if;
   return(char);
 end hexchar;

function inttostr( value : INTEGER; base : INTEGER;
                   numlen : INTEGER :=0; zeros: BOOLEAN:=FALSE) return STRING is
 variable str : STRING (1 to MAXSTRLEN);
 variable s1  : STRING (MAXSTRLEN downto 1);
 variable pos,x,xn,x1 : INTEGER;
 begin
  if value=-2147483648 then
    str(1 to 9) := "UNDERFLOW";
    str(10) := NUL;
  else
    x := abs(value);
    pos := 0;
    while x>0 or pos=0 loop
      pos:=pos+1;
      xn := x / base;
      x1 := x - xn * base ;
      x  := xn;
      s1(pos) := to_char(x1);
    end loop;
    if value<0  then
      pos:=pos+1;
      s1(pos):='-';
    end if;
    if pos>numlen then
      str(1 to pos) := s1 (pos downto 1);
      str(pos+1) := NUL;
    else
      case ZEROS is
        when TRUE  => str := (others => '0');
        when FALSE => str := (others => ' ');
      end case;  
      str( (1+numlen-pos) to numlen) := s1(pos downto 1);
      str(numlen+1) := NUL;
    end if;
  end if;
  return(str);
 end inttostr;


function vecttostr( value : std_logic_vector; len : INTEGER; base : INTEGER; 
                    numlen : INTEGER :=0; 
                    zeros: BOOLEAN:=FALSE) return STRING is
 variable str : STRING (1 to MAXSTRLEN);
 variable s1  : STRING (MAXSTRLEN downto 1);
 variable pos, len4 : INTEGER;
 variable x : QWORD;
 variable vect4 : std_logic_vector(3 downto 0);
 begin
  x:=value;
  if len<64 then
    x(63 downto len) := (others =>'0');
  end if;
  case base is
   when 2   => for i in 0 to len-1 loop
                   s1(i+1) := to_char(value(i));
               end loop;
               pos:=len;
   when 16  => len4 := ((len+3)/4);
               for i in 0 to len4-1 loop
                 vect4 := x( 3+(4*i) downto 4*i);
                 s1(i+1) := hexchar(vect4);
               end loop;
               pos:=len4;
   when others =>  s1:=strcopy("ESAB LAGELLI");
  end case;
  if pos>numlen then
    str(1 to pos) := s1 (pos downto 1);
    str(pos+1) := NUL;
  else
    case ZEROS is
      when TRUE  => str := (others => '0');
      when FALSE => str := (others => ' ');
    end case;  
    str( (1+numlen-pos) to numlen) := s1(pos downto 1);
    str(numlen+1) := NUL;
  end if;
  return(str); 
 end vecttostr;

---------------------------------------------------------------------------
-- Multi Type input handlers
--

function fmt ( x : BOOLEAN) return T_FMT is
 variable fm : T_FMT;
 begin
  fm.f_type := INT;
  if x then fm.f_integer := 1;
       else fm.f_integer := 0;
  end if;
  return(fm);
 end fmt;

function fmt ( x : INTEGER) return T_FMT is
 variable fm : T_FMT;
 begin
  fm.f_type := INT;
  fm.f_integer := x;
  return(fm);
 end fmt;

function fmt ( x : std_logic_vector) return T_FMT is
 variable fm : T_FMT;
 begin
  fm.f_type   := VECT;
  fm.f_vector(x'length-1 downto 0) := x;
  fm.f_length := x'length;
  return(fm);
 end fmt;

function fmt ( x : string ) return T_FMT is
 variable fm : T_FMT;
 begin
  fm.f_type   := STRG;
  fm.f_string(x'range) := x;
  if x'length+1<MAXSTRLEN then
    fm.f_string(x'length+1) := NUL;
  end if;
  fm.f_length := x'length;
  return(fm);
 end fmt;

function fmt ( x : std_logic) return T_FMT is
 variable fm : T_FMT;
 variable x1 : std_logic_vector ( 0 downto 0);
 begin
  x1(0) := x;
  fm.f_type   := VECT;
  fm.f_vector(x1'length-1 downto 0) := x1;
  fm.f_length := x1'length;
  return(fm);
 end fmt;

---------------------------------------------------------------------------
-- The Main Print Routine
--

procedure printf( str    : STRING; 
                  Params : T_FMT_ARRAY ) is
 file FSTR : TEXT is out "STD_OUTPUT";
 variable ll : LINE;
 variable str1,pstr : STRING (1 to MAXSTRLEN); 
 variable ip,op,pp,iplen : INTEGER;
 variable numlen : INTEGER;
 variable zeros  : BOOLEAN;
 variable more   : BOOLEAN;
 variable intval : INTEGER;
 variable vectval: QWORD;
 variable len    : INTEGER;
 variable ftype  : T_NUMTYPE;
 variable tnow   : INTEGER;
 begin
   iplen := str'length;
   ip:=1; op:=0; pp:=params'low;
   while ip<= iplen and str(ip)/=NUL loop
     if str(ip) = '%' then
       more:=TRUE;
       numlen:=0; zeros:=FALSE; 
       while more loop
          more:=FALSE;
          ip:=ip+1;
          ftype  := params(pp).f_type;
          intval := params(pp).f_integer;
          vectval:= params(pp).f_vector;
          len    := params(pp).f_length;
          case str(ip) is 
            when '0'     => ZEROS:=TRUE;
                            more:=TRUE;
            when '1' to '9' => 
                            numlen:= 10* numlen + character'pos(str(ip))-48;
                            more := TRUE;
            when '%'     => pstr := strcopy("%");
            when 'd'     => case ftype is
                              when INT  => pstr := 
                                           inttostr(intval,10,numlen,zeros);
                              when VECT => if is01(vectval,len) then
                                             intval:= 
                                         conv_integer(vectval(len-1 downto 0));
                                             pstr := 
                                         inttostr(intval,10,numlen,zeros);
                                           end if;
                              when others => pstr :=
                                         strcopy("INVALID PRINTF d:" & str);
                            end case;
                            pp:=pp+1;
            when 't'     => tnow := NOW / 1 ns;
                            pstr := inttostr(tnow,10,numlen,zeros);
            when 'h'     => case ftype is
                              when INT  => pstr := 
                                            inttostr(intval,16,numlen,zeros);
                              when VECT => if is01(vectval,len) then
                                             intval:= 
                                       conv_integer(vectval(len-1 downto 0));
                                             pstr := 
                                       inttostr(intval,16,numlen,zeros);
                                           end if;
                              when others => pstr :=
                                       strcopy("INVALID PRINTF h:" & str);
                            end case;
                            pp:=pp+1;
            when 'b'     => case ftype is
                              when INT    => vectval := ( others => '0');
                                             vectval(31 downto 0) :=
                                              conv_std_logic_vector(intval,32);
                                             len:=1;
                                             for i in 1 to 31 loop
                                             if vectval(i)='1' then
                                               len:=i;
                                             end if;
                                             end loop;
                                             pstr := 
                                        vecttostr(vectval,len,2,numlen,zeros);
                              when VECT   => pstr :=
                                        vecttostr(vectval,len,2,numlen,zeros);
                              when others => pstr := 
                                        strcopy("INVALID PRINTF b:" & str);
                            end case;
                            pp:=pp+1;
            when 'x'     => case ftype is
                              when INT  => pstr :=
                                      inttostr(intval,16,numlen,zeros);
                              when VECT => pstr :=
                                      vecttostr(vectval,len,16,numlen,zeros);
                              when others => pstr :=
                                      strcopy("INVALID PRINTF x:" & str);
                            end case;
                            pp:=pp+1;
            when 's'     => case ftype is
                              when STRG   => pstr:=params(pp).f_string;
                              when others => pstr :=
                                      strcopy("INVALID PRINTF s:" & str);
                            end case;
                            pp:=pp+1;
            when others  => pstr := strcopy("ILLEGAL FORMAT");
                            assert FALSE
                             report "TEXTIO Processing Problem"
                             severity FAILURE;
          end case;
       end loop;
       len := strlen(pstr);
       for i in 1 to len loop
          str1(op+i) := pstr(i);
       end loop;
       ip:=ip+1;
       op:=op+len;
     elsif str(ip)='\' then
       case str(ip+1) is
         when 'n' => str1(op+1):= NUL;
                     write( ll , str1 );
                     writeline( FSTR, ll);
                     op := 0; ip:=ip+1;
                     str1(op+1) := NUL;
         when others => 
       end case;
       ip:=ip+1;
     else
      op:=op+1;
      str1(op) := str(ip);
      ip:=ip+1;
     end if;
   end loop;
   if op>0 then
     str1(op+1):=NUL; 
     write( ll , str1 );
     writeline(FSTR, ll);
   end if;
 end printf;


procedure printf( str : STRING; params : T_FMT ) is
variable f_fmt : T_FMT_ARRAY ( 1 to 1);
begin
  f_fmt(1) := params;
  printf(str,f_fmt);
end printf;

procedure printf( str : STRING ) is
variable fm : T_FMT_ARRAY ( 1 to 1);
begin
  fm(1).f_type := NONE;
  printf(str,fm);
end printf;

procedure ifprintf( enable : BOOLEAN;
                    str    : STRING; 
                    Params : T_FMT_ARRAY ) is
begin
 if enable then
   printf(str,params);
 end if;
end ifprintf;

procedure ifprintf( enable : BOOLEAN; str : STRING; params : T_FMT ) is
variable f_fmt : T_FMT_ARRAY ( 1 to 1);
begin
 if enable then
    f_fmt(1) := params;
    printf(str,f_fmt);
 end if;
end ifprintf;

procedure ifprintf( enable : BOOLEAN; str : STRING ) is
variable fm : T_FMT_ARRAY ( 1 to 1);
begin
 if enable then
   fm(1).f_type := NONE;
   printf(str,fm);
 end if;
end ifprintf;



---------------------------------------------------------------------------
-- The Main Print Routine  Replicated to provide printf function
--

procedure fprintf( FSTR   : out text;
                   str    : STRING; 
                   Params : T_FMT_ARRAY ) is
 variable ll : LINE;
 variable str1,pstr : STRING (1 to MAXSTRLEN); 
 variable ip,op,pp,iplen : INTEGER;
 variable numlen : INTEGER;
 variable zeros  : BOOLEAN;
 variable more   : BOOLEAN;
 variable intval : INTEGER;
 variable vectval: QWORD;
 variable len    : INTEGER;
 variable ftype  : T_NUMTYPE;
 begin
   iplen := str'length;
   ip:=1; op:=0; pp:=params'low;
   while ip<= iplen and str(ip)/=NUL loop
     if str(ip) = '%' then
       more:=TRUE;
       numlen:=0; zeros:=FALSE; 
       while more loop
          more:=FALSE;
          ip:=ip+1;
          ftype  := params(pp).f_type;
          intval := params(pp).f_integer;
          vectval:= params(pp).f_vector;
          len    := params(pp).f_length;
          case str(ip) is 
            when '0'     => ZEROS:=TRUE;
                            more:=TRUE;
            when '1' to '9' => 
                            numlen:= 10* numlen + character'pos(str(ip))-48;
                            more := TRUE;
            when '%'     => pstr := strcopy("%");
            when 'd'     => case ftype is
                              when INT  => pstr := inttostr(intval,10,numlen,zeros);
                              when VECT => if is01(vectval,len) then
                                             intval:= conv_integer(vectval(len-1 downto 0));
                                             pstr := inttostr(intval,10,numlen,zeros);
                                           end if;
                              when others => pstr := strcopy("INVALID fprintf d:" & str);
                            end case;
                            pp:=pp+1;  
            when 'h'     => case ftype is
                              when INT  => pstr := inttostr(intval,16,numlen,zeros);
                              when VECT => if is01(vectval,len) then
                                             intval:= conv_integer(vectval(len-1 downto 0));
                                             pstr := inttostr(intval,16,numlen,zeros);
                                           end if;
                              when others => pstr := strcopy("INVALID fprintf h:" & str);
                            end case;
                            pp:=pp+1;  
            when 'b'     => case ftype is
                              when INT    => vectval := ( others => '0');
                                             vectval(31 downto 0) := conv_std_logic_vector(intval,32);
                                             len:=1;
                         for i in 1 to 31 loop
                                               if vectval(i)='1' then
                         len:=i;
                           end if;
                         end loop;
                                             pstr := vecttostr(vectval,len,2,numlen,zeros);
                              when VECT   => pstr := vecttostr(vectval,len,2,numlen,zeros);
                              when others => pstr := strcopy("INVALID fprintf b:" & str);
                            end case;                   
                            pp:=pp+1;  
            when 'x'     => case ftype is
                              when INT  => pstr := inttostr(intval,16,numlen,zeros);
                              when VECT => pstr := vecttostr(vectval,len,16,numlen,zeros);
                              when others => pstr := strcopy("INVALID fprintf x:" & str);
                            end case;
                            pp:=pp+1;  
            when 's'     => case ftype is
                              when STRG   => pstr:=params(pp).f_string;
                              when others => pstr := strcopy("INVALID fprintf s:" & str);
                            end case;
                            pp:=pp+1;
            when others  => pstr := strcopy("ILLEGAL FORMAT");
          end case;
       end loop;
       len := strlen(pstr);
       for i in 1 to len loop
          str1(op+i) := pstr(i);
       end loop;
       ip:=ip+1;
       op:=op+len;
     elsif str(ip)='\' then
       case str(ip+1) is
         when 'n' => str1(op+1):= NUL;
                     write( ll , str1 );
                     writeline( FSTR, ll);
                     op := 0; ip:=ip+1;
                     str1(op+1) := NUL;
         when others => 
       end case;
       ip:=ip+1;
     else
      op:=op+1;
      str1(op) := str(ip);
      ip:=ip+1;
     end if;
   end loop;
   if op>0 then
     str1(op+1):=NUL; 
     write( ll , str1 );
     writeline(FSTR, ll);
   end if;
 end fprintf;


procedure fprintf( FSTR : out text; str : STRING; params : T_FMT ) is
variable f_fmt : T_FMT_ARRAY ( 1 to 1);
begin
  f_fmt(1) := params;
  fprintf(fstr,str,f_fmt);
end fprintf;

procedure fprintf( FSTR : out text; str : STRING ) is
variable fm : T_FMT_ARRAY ( 1 to 1);
begin
  fm(1).f_type := NONE;
  fprintf(fstr,str,fm);
end fprintf;


------------------------------------------------------------------------
-- Check value of signal (expected output) & print message if mis-match
-- (single-bit version)
------------------------------------------------------------------------
procedure checksig (
d:			std_logic;
sig_name:	string;
v:			bit;
ERRCNT:		inout	integer) is
variable	nomatch:		boolean;
variable	vs:				std_logic;
variable	tnow:			integer;
variable	DISP_CORRECT:	boolean;

constant	uline_str2:		string(1 to 77)	:=
"_____________________________________________________________________________";
constant	pound_str2:		string(1 to 77)	:=
"#############################################################################";

begin
	DISP_CORRECT:= false;
				
	tnow		:= NOW / 1 ns;
	nomatch		:= false;
	if (d /= to_stdulogic(v)) then
		nomatch := true;
	end if;
	vs := to_stdulogic(v);

	if (nomatch) then
		printf(" ");
		printf("%s",fmt(pound_str2));
		printf("ERROR!!! Mismatch on signal %s",fmt(sig_name));
		printf("At time: %0d ns",fmt(tnow));
		printf("Expected value was: 0x%0x, observed value is: 0x%0x",
		fmt(vs)&fmt(d));
		printf("%s",fmt(pound_str2));
		printf(" ");
		ERRCNT := ERRCNT + 1;
	elsif (DISP_CORRECT) then
		printf("%s",fmt(uline_str2)); printf(" ");
		printf("CORRECT: match on signal %s",fmt(sig_name));
		printf("At time: %0d ns",fmt(tnow));
		printf("Expected value was: 0x%0x, observed value is: 0x%0x",
		fmt(vs)&fmt(d));
	end if;


end checksig;

------------------------------------------------------------------------
-- Check value of signal (expected output) & print message if mis-match
-- (vector version)
------------------------------------------------------------------------
procedure checksig (
d:			std_logic_vector;
sig_name:	string;
v:			bit_vector;
ERRCNT:		inout	integer) is
variable	nomatch:	boolean;
variable	tnow:		integer;
variable	v_copy:		bit_vector(d'range);
variable	vs:			std_logic_vector(d'range);
variable	DISP_CORRECT:	boolean;

constant	uline_str2:		string(1 to 77)	:=
"_____________________________________________________________________________";
constant	pound_str2:		string(1 to 77)	:=
"#############################################################################";

begin
	DISP_CORRECT:= false;
--	DISP_CORRECT:= true;

	tnow		:= NOW / 1 ns;
	v_copy		:= v;
	nomatch		:= false;
	for i in d'range loop
		vs(i) := to_stdulogic(v_copy(i));
	end loop;
	for i in d'range loop
		if (d(i) /= vs(i)) then
			nomatch := true;
		end if;
	end loop;

	if (nomatch) then
		printf(" ");
		printf("%s",fmt(pound_str2));
		printf("ERROR!!! Mismatch on signal %s",fmt(sig_name));
		printf("At time: %0d ns",fmt(tnow));
		printf("Expected value was: 0x%0x, observed value is: 0x%0x",
		fmt(vs)&fmt(d));
		printf("%s",fmt(pound_str2));
		printf(" ");
		ERRCNT := ERRCNT + 1;
	elsif (DISP_CORRECT) then
		printf("%s",fmt(uline_str2)); printf(" ");
		printf("CORRECT: match on signal %s",fmt(sig_name));
		printf("At time: %0d ns",fmt(tnow));
		printf("Expected value was: 0x%0x, observed value is: 0x%0x",
		fmt(vs)&fmt(d));
	end if;

end checksig;


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

-- small function to convert std_logic values to either 'X','0','1', or 'Z'
function sl2x01z(s: std_logic) return std_logic is
variable sl: std_logic;
begin
	case s is
		when 'U'	=> sl:= 'X';
		when 'X'	=> sl:= 'X';
		when '0'	=> sl:= '0';
		when '1'	=> sl:= '1';
		when 'Z'	=> sl:= 'Z';
		when 'W'	=> sl:= 'X';
		when 'L'	=> sl:= '0';
		when 'H'	=> sl:= '1';
		when '-'	=> sl:= 'X';
		when others	=> sl:= 'X';
	end case;
	return sl;
end sl2x01z;

-- small function to convert vlog values (string) to either 'X','0','1', or 'Z'
--function vlg2x01z(s: character) return std_logic is
function vlg2x01z(s: string(1 to 1)) return std_logic is
variable sl: std_logic;
begin
	case s is
		when "x"	=> sl:= 'X';
		when "0"	=> sl:= '0';
		when "1"	=> sl:= '1';
		when "z"	=> sl:= 'Z';
		when others	=> sl:= 'X';
	end case;
	return sl;
end vlg2x01z;


-- small function to convert std_logic_vector values to 'X','0','1', or 'Z'
function slv2x01z(s: std_logic_vector) return std_logic_vector is
variable sl: std_logic;
variable slv: std_logic_vector(s'range);
begin
	for i in s'range loop
		slv(i):= sl2x01z(s(i));
	end loop;
	return slv;
end slv2x01z;

---------------------------------------------------------------------
-- small function to convert hex character to std_logic values
function hex2sl(s: character) return std_logic is
variable sl: std_logic;
begin
	case s is
		when '0'	=> sl:= '0';
		when '1'	=> sl:= '1';
		when '2'	=> sl:= 'L';
		when '3'	=> sl:= 'H';
		when '4'	=> sl:= 'W';
		when '5'	=> sl:= 'Z';
		when '6'	=> sl:= 'U';
		when '7'	=> sl:= 'X';
		when '8'	=> sl:= '-';
		when others	=> sl:= 'X';
	end case;
	return sl;
end hex2sl;
-- small function to convert hex string to std_logic_vector values
function hexv2slv(s: string) return std_logic_vector is
variable sl: std_logic;
variable c: character;
variable slv: std_logic_vector(s'range);
begin
	for i in s'range loop
		slv(i):= hex2sl(s(i));
	end loop;
	return slv;
end hexv2slv;


-- small function to convert hex character to std_logic values
function ev2sl(e: evbit) return std_logic is
variable sl: std_logic;
begin
	case e is
		when '0'	=> sl:= '0';
		when '1'	=> sl:= '1';
		when '2'	=> sl:= 'L';
		when '3'	=> sl:= 'H';
		when '4'	=> sl:= 'W';
		when '5'	=> sl:= 'Z';
		when '6'	=> sl:= 'U';
		when '7'	=> sl:= 'X';
		when '8'	=> sl:= '-';
		when others	=> sl:= 'X';
	end case;
	return sl;
end ev2sl;
-- small function to convert hex string to std_logic_vector values
function evv2slv(e: evbyte) return std_logic_vector is
variable sl: std_logic;
variable slv: std_logic_vector(7 downto 0);
begin
	for i in 7 downto 0 loop
		slv(i):= ev2sl(e(i));
	end loop;
	return slv;
end evv2slv;
-- small function to convert character to evbit
function to_evbit(c: character) return evbit is
variable e: evbit;
begin
	case c is
		when '0'	=> e:= '0';
		when '1'	=> e:= '1';
		when '2'	=> e:= '2';
		when '3'	=> e:= '3';
		when '4'	=> e:= '4';
		when '5'	=> e:= '5';
		when '6'	=> e:= '6';
		when '7'	=> e:= '7';
		when '8'	=> e:= '8';
		when others	=> e:= '7';
	end case;
	return e;
end to_evbit;

---------------------------------------------------------------------


-- small function to do hex numbers for std_logic_vector
function hx	(b: bit_vector)
return std_logic_vector is
begin
	return to_stdlogicvector(b);
end;

---------------------------------------------------------------------
-- Emulate task of cpu writing data to peripheral (IP macro)
---------------------------------------------------------------------
procedure cpu_wr	(
	constant	addr:	in		bit_vector(7 downto 0);
	constant	d:		in		bit_vector(7 downto 0);
	signal		clk:	in		std_logic;
	signal		a:		out		std_logic_vector (7 downto 0);
	signal		do:		out		std_logic_vector (7 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic
) is
begin
	wait until clk = '0';
	a		<= to_stdlogicvector(addr(7 downto 0));
	sel		<= '1';
	wr		<= '1';
	en		<= '0';
	do		<= to_stdlogicvector(d);
	wait until clk = '1';
	wait until clk = '0';
	en		<= '1';
	wait until clk = '1';
	wait until clk = '0';
	a		<= (others => '0');
	sel		<= '0';
	wr		<= '0';
	en		<= '0';
	do		<= (others => '0');
	wait until clk = '0';
	wait until clk = '1';
	wait until clk = '0';
end cpu_wr;

procedure cpu_wr16	(
	constant	addr:	in		bit_vector(7 downto 0);
	constant	d:		in		bit_vector(15 downto 0);
	signal		clk:	in		std_logic;
	signal		a:		out		std_logic_vector (7 downto 0);
	signal		do:		out		std_logic_vector (15 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic
) is
begin
	wait until clk = '0';
	a		<= to_stdlogicvector(addr(7 downto 0));
	sel		<= '1';
	wr		<= '1';
	en		<= '0';
	do		<= to_stdlogicvector(d);
	wait until clk = '1';
	wait until clk = '0';
	en		<= '1';
	wait until clk = '1';
	wait until clk = '0';
	a		<= (others => '0');
	sel		<= '0';
	wr		<= '0';
	en		<= '0';
	do		<= (others => '0');
	wait until clk = '0';
	wait until clk = '1';
	wait until clk = '0';
end cpu_wr16;

procedure cpu_wr32	(
	constant	addr:	in		bit_vector(7 downto 0);
	constant	d:		in		bit_vector(31 downto 0);
	signal		clk:	in		std_logic;
	signal		a:		out		std_logic_vector (7 downto 0);
	signal		do:		out		std_logic_vector (31 downto 0);
	signal		sel:	out		std_logic;
	signal		wr:		out		std_logic;
	signal		en:		out		std_logic
) is
begin
	wait until clk = '0';
	a		<= to_stdlogicvector(addr(7 downto 0));
	sel		<= '1';
	wr		<= '1';
	en		<= '0';
	do		<= to_stdlogicvector(d);
	wait until clk = '1';
	wait until clk = '0';
	en		<= '1';
	wait until clk = '1';
	wait until clk = '0';
	a		<= (others => '0');
	sel		<= '0';
	wr		<= '0';
	en		<= '0';
	do		<= (others => '0');
	wait until clk = '0';
	wait until clk = '1';
	wait until clk = '0';
end cpu_wr32;

---------------------------------------------------------------------
-- Emulate task of cpu reading data from peripheral (IP macro)
---------------------------------------------------------------------
procedure cpu_rd	(
	-- only 2 LSB bits used out of 8 legacy
--	constant	addr:		in		bit_vector(7 downto 0);
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(7 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		di:			in		std_logic_vector (7 downto 0);
	signal		sel:		out		std_logic;
	signal		wr:	    	out		std_logic;
	signal		en:			out		std_logic;
				simerrors:	inout	integer
) is
	variable	dvar:				std_logic_vector(7 downto 0);
begin
	wait until clk = '0';
	a		<= to_stdlogicvector(addr(7 downto 0));
	sel		<= '1';
	wr		<= '0';
	en		<= '0';
	wait until clk = '1';
	wait until clk = '0';
	en		<= '1';
	wait until clk = '1';
	wait until clk = '0';
	dvar	:= di;
	checksig(dvar,"CPU Data Bus",d,simerrors);
	a		<= (others => '0');
	sel		<= '0';
	wr		<= '0';
	en		<= '0';
	wait until clk = '0';
	wait until clk = '1';
	wait until clk = '0';
end cpu_rd;

procedure cpu_rd16	(
	-- only 2 LSB bits used out of 8 legacy
--	constant	addr:		in		bit_vector(7 downto 0);
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(15 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		di:			in		std_logic_vector (15 downto 0);
	signal		sel:		out		std_logic;
	signal		wr:	    	out		std_logic;
	signal		en:			out		std_logic;
				simerrors:	inout	integer
) is
	variable	dvar:				std_logic_vector(15 downto 0);
begin
	wait until clk = '0';
	a		<= to_stdlogicvector(addr(7 downto 0));
	sel		<= '1';
	wr		<= '0';
	en		<= '0';
	wait until clk = '1';
	wait until clk = '0';
	en		<= '1';
	wait until clk = '1';
	wait until clk = '0';
	dvar	:= di;
	checksig(dvar,"CPU Data Bus",d,simerrors);
	a		<= (others => '0');
	sel		<= '0';
	wr		<= '0';
	en		<= '0';
	wait until clk = '0';
	wait until clk = '1';
	wait until clk = '0';
end cpu_rd16;

procedure cpu_rd32	(
	-- only 2 LSB bits used out of 8 legacy
--	constant	addr:		in		bit_vector(7 downto 0);
	constant	addr:		in		bit_vector(7 downto 0);
	constant	d:			in		bit_vector(31 downto 0);
	signal		clk:		in		std_logic;
	signal		a:			out		std_logic_vector (7 downto 0);
	signal		di:			in		std_logic_vector (31 downto 0);
	signal		sel:		out		std_logic;
	signal		wr:	    	out		std_logic;
	signal		en:			out		std_logic;
				simerrors:	inout	integer
) is
	variable	dvar:				std_logic_vector(31 downto 0);
begin
	wait until clk = '0';
	a		<= to_stdlogicvector(addr(7 downto 0));
	sel		<= '1';
	wr		<= '0';
	en		<= '0';
	wait until clk = '1';
	wait until clk = '0';
	en		<= '1';
	wait until clk = '1';
	wait until clk = '0';
	dvar	:= di;
	checksig(dvar,"CPU Data Bus",d,simerrors);
	a		<= (others => '0');
	sel		<= '0';
	wr		<= '0';
	en		<= '0';
	wait until clk = '0';
	wait until clk = '1';
	wait until clk = '0';
end cpu_rd32;

end corepwm_pkg;
