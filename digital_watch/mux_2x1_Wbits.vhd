LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux_2x1_Wbits IS
GENERIC(W : NATURAL := 11);
PORT(a,b: IN std_logic_vector(W-1 DOWNTO 0);
     sel : IN BIT;
     s : OUT std_logic_vector(W-1 DOWNTO 0)
);
END mux_2x1_Wbits;

ARCHITECTURE behav OF mux_2x1_Wbits IS
BEGIN
	PROCESS(a,b,sel)
	BEGIN
		IF (sel = '0') THEN
			s<= a;
		ELSE
			s<=b;
		END IF;
	END PROCESS;
END behav;




