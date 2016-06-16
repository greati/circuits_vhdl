LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY comp_5bits IS
PORT(a,b: IN std_logic_vector(4 DOWNTO 0);
     output : OUT std_logic
);
END comp_5bits;

ARCHITECTURE behav OF comp_5bits IS

BEGIN

	PROCESS(a,b)
	BEGIN
		IF(a = b) THEN
			output <= '1';
		ELSE 
			output <= '0';
		END IF;
	END PROCESS;

END behav;

