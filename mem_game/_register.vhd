LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY P_register IS 
GENERIC (W : NATURAL := 5);
PORT(	d: IN std_logic_VECTOR(W-1 DOWNTO 0);
	clk : IN std_logic;
	clrn : IN std_logic;
	load : IN std_logic;
	q : BUFFER std_logic_VECTOR(W-1 DOWNTO 0));
END P_register;

ARCHITECTURE Arch1 of P_register IS
BEGIN

	PROCESS(clk,clrn)
	BEGIN
		IF (clrn='1') THEN
			q <= (OTHERS => '0');
		ELSIF (clk'EVENT AND clk='1') THEN
			IF (load ='1') THEN
				q<=d;
			END IF;
		END IF;
	END PROCESS;

END Arch1;
