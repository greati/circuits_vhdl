LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter_digital_clock IS
GENERIC(W : NATURAL := 11);
PORT(d : IN std_logic_vector(w-1 DOWNTO 0);
     clk : IN BIT; -- clock
     clrn : IN BIT; -- clear
     ena : IN BIT; -- enable
     upH : IN BIT; -- up hours
     downH : IN BIT; -- down hours
     upMin : IN BIT; -- up minutes
     downMin : IN BIT; -- down minutes
     subt : IN BIT;
     load : IN BIT; -- load
     ajuste: IN BIT;	
     q : BUFFER std_logic_vector(w-1 DOWNTO 0) -- out
);
BEGIN
END counter_digital_clock;

ARCHITECTURE behav OF counter_digital_clock IS
BEGIN
	PROCESS(clk, clrn)
	BEGIN
		IF (clrn = '0') THEN -- clear
			q <= (OTHERS => '0');
		ELSIF (clk'EVENT AND clk='1') THEN -- clock
			IF (ena = '1') THEN -- anable
				IF (load = '1') THEN -- load data in 'd'
					q <= d;
				ELSIF (ajuste = '1') THEN
					-- perform actions according to the buttons pressed
					IF (upH = '1') THEN
						IF (q >= 1380) THEN
							q <= q -"10101100100" ;
						ELSE 
							q <= q + 60;
						END IF;
					ELSIF (downH = '1') THEN
						IF (q < 60) THEN
							q <="10101100100" + q ;
						ELSE 
							q <= q - 60;
						END IF;
					ELSIF (upMin = '1') THEN
						q <= q + 1;
						IF ((to_integer(unsigned(q)) mod 60) = 59) THEN
							q <=q - 59;
						END IF;
					ELSIF (downMin = '1') THEN
						q <= q - 1;
						IF ((to_integer(unsigned(q)) mod 60) = 0) THEN
							q <= q + 59;
						END IF;
					END IF;
				ELSIF (q = "10110011111") THEN
					q <= (OTHERS => '0');
				ELSE
					q<= q+1;
				END IF;
			END IF;
		END IF;	
	END PROCESS;
END behav;
