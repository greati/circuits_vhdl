LIBRARY ieee;
use ieee.numeric_std.all;
USE ieee.std_logic_1164.ALL;

ENTITY simple_subtractor IS
GENERIC(W : NATURAL := 5);
PORT (a, b : IN std_logic_vector((4) DOWNTO 0);
      	sub: IN std_logic;
	s : OUT std_logic_vector((4) DOWNTO 0));
END simple_subtractor;

ARCHITECTURE struct OF simple_subtractor IS
BEGIN
	PROCESS(a,b, sub)
	BEGIN
		IF (sub = '1') THEN
			s <= std_logic_vector(unsigned(a) + unsigned(b));
		ELSE
			s <= std_logic_vector(unsigned(a) - unsigned(b));
		END IF;
	END PROCESS;
END struct;