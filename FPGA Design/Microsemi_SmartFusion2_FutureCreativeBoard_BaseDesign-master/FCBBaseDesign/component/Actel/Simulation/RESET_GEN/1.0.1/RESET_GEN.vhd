library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity RESET_GEN is
generic(DELAY : integer := 1000 ; LOGIC_LEVEL : integer := 0);

port( RESET : out std_logic
	);
end RESET_GEN;

architecture behavior of RESET_GEN is
	signal T1_time : time := 1 ns ;
begin
	process
	begin		
		if LOGIC_LEVEL = 0 then
			RESET <= '0';
			wait for (T1_time*DELAY) ;
			RESET <= '1';

		else
			RESET <= '1';
			wait for (T1_time*DELAY) ;
			RESET <= '0';
		end if;
		wait;
	end process;
end behavior;