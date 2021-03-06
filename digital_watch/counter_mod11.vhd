LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;


ENTITY counter_mod11 IS
GENERIC(w: NATURAL := 4 );
PORT(d : IN std_logic_vector(W-1 DOWNTO 0);
	clk: IN BIT;
	clrn: IN BIT;
	ena : IN BIT;
	load: IN BIT;
	q: BUFFER std_logic_vector(W-1 DOWNTO 0));
END counter_mod11;

ARCHITECTURE behav of counter_mod11 IS
BEGIN 
	PROCESS(clk, clrn)
	BEGIN
		IF (clrn = '0') THEN
			q <= (OTHERS =>'0');
		ELSIF(clk'EVENT AND clk = '1' ) THEN
			IF (ena='1') THEN
				IF ( q = 12) THEN 
					q <= (OTHERS =>'0');
				ELSE
					q<=q+1;
				END IF;
			ELSE
				q <= (OTHERS =>'0');
			END IF;
		END IF;
	END PROCESS;
END behav; 
