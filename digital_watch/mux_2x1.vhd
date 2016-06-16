LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux_2x1 IS
PORT(a,b: IN BIT;
     sel : IN BIT;
     s : OUT BIT
);
END mux_2x1;

ARCHITECTURE behav OF mux_2x1 IS
BEGIN
	PROCESS(a,b,sel)
	BEGIN
		IF (sel = '0') THEN
			s <= a;
		ELSE
			s <=b;
		END IF;
	END PROCESS;
END behav;



