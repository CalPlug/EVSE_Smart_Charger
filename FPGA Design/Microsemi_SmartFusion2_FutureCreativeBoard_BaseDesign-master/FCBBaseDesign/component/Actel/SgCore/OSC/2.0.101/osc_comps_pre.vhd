library ieee;
use ieee.std_logic_1164.all;

entity RCOSC_1MHZ is
  port(
         CLKOUT : out   STD_ULOGIC
  );
end RCOSC_1MHZ;

architecture DEF_ARCH of RCOSC_1MHZ is 
    attribute black_box : boolean;
    attribute black_box of DEF_ARCH : architecture is true;
begin
end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;

entity RCOSC_25_50MHZ is

  generic(
    FREQUENCY:real := 20.0
  );

  port(
    CLKOUT : out   STD_ULOGIC
  );
end RCOSC_25_50MHZ;

architecture DEF_ARCH of RCOSC_25_50MHZ is 
    attribute black_box : boolean;
    attribute black_box of DEF_ARCH : architecture is true;
begin
end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;

entity XTLOSC is

  generic(
    MODE:std_logic_vector := x"3";
    FREQUENCY:real := 20.0
  );

  port(
    CLKOUT : out   STD_ULOGIC;
    XTL : in    STD_ULOGIC
  );
end XTLOSC;

architecture DEF_ARCH of XTLOSC is 
    attribute black_box : boolean;
    attribute black_box of DEF_ARCH : architecture is true;
    attribute black_box_pad : string; 
    attribute black_box_pad of DEF_ARCH: architecture is "XTL"; 
begin
end DEF_ARCH;

library ieee;
use ieee.std_logic_1164.all;

entity RCOSC_1MHZ_FAB is
  port(
         CLKOUT : out   STD_ULOGIC;
            A   : in    STD_ULOGIC
  );
end RCOSC_1MHZ_FAB;

architecture DEF_ARCH of RCOSC_1MHZ_FAB is 
    attribute black_box : boolean;
    attribute black_box of DEF_ARCH : architecture is true;
begin
end DEF_ARCH;

library ieee;
use ieee.std_logic_1164.all;

entity RCOSC_25_50MHZ_FAB is
  port(
         CLKOUT : out   STD_ULOGIC;
            A   : in    STD_ULOGIC
  );
end RCOSC_25_50MHZ_FAB;

architecture DEF_ARCH of RCOSC_25_50MHZ_FAB is 
    attribute black_box : boolean;
    attribute black_box of DEF_ARCH : architecture is true;
begin
end DEF_ARCH;

library ieee;
use ieee.std_logic_1164.all;

entity XTLOSC_FAB is
  port(
         CLKOUT : out   STD_ULOGIC;
            A   : in    STD_ULOGIC
  );
end XTLOSC_FAB;

architecture DEF_ARCH of XTLOSC_FAB is 
    attribute black_box : boolean;
    attribute black_box of DEF_ARCH : architecture is true;
begin
end DEF_ARCH;
