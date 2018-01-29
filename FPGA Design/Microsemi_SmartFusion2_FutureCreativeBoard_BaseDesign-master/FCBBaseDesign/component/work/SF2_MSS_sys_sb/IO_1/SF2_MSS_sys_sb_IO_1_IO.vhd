-- Version: v11.8 SP2 11.8.2.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity SF2_MSS_sys_sb_IO_1_IO is

    port( PAD_BI : inout std_logic_vector(0 to 0) := (others => 'Z');
          D      : in    std_logic_vector(0 to 0);
          E      : in    std_logic_vector(0 to 0);
          Y      : out   std_logic_vector(0 to 0)
        );

end SF2_MSS_sys_sb_IO_1_IO;

architecture DEF_ARCH of SF2_MSS_sys_sb_IO_1_IO is 

  component BIBUF
    generic (IOSTD:string := "");

    port( PAD : inout   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;


begin 


    U0_0 : BIBUF
      generic map(IOSTD => "LVCMOS33")

      port map(PAD => PAD_BI(0), D => D(0), E => E(0), Y => Y(0));
    

end DEF_ARCH; 
