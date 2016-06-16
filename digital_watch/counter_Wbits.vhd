LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter_Wbits IS
GENERIC(W : NATURAL := 11);
PORT(d : IN std_logic_vector(w-1 DOWNTO 0);
     clk : IN BIT; -- clock
     clrn : IN BIT; -- clear
     ena : IN BIT; -- enable
     subt : IN BIT;
     load : IN BIT; -- load
     q : BUFFER std_logic_vector(w-1 DOWNTO 0) -- out
);
BEGIN
END counter_Wbits;

ARCHITECTURE behav OF counter_Wbits IS
BEGIN
	PROCESS(clk, clrn)
	BEGIN
		IF (clrn = '0') THEN -- clear
			q <= (OTHERS => '0');
		ELSIF (clk'EVENT AND clk='1') THEN -- clock
			IF (ena = '1') THEN -- anable
				IF (load = '1') THEN -- load data in 'd'
					q <= d;
				ELSE
					IF (subt = '0') THEN -- sum
						IF (q = "10110100000") THEN
							q <= "0";
						ELSE
							q <= q + 1;
						END IF;
					ELSE -- subtract
						IF (q = "0") THEN
							q <= "10110100000";
						ELSE
							q <= q - 1;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;	
	END PROCESS;
END behav;
