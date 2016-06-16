LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux_16x1_Wbits IS
GENERIC(W : NATURAL := 5);
PORT(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p: IN std_logic_vector(4 DOWNTO 0);
     sel : IN std_logic_vector(4 DOWNTO 0);
     s : OUT std_logic_vector(4 DOWNTO 0)
);
END mux_16x1_Wbits;

ARCHITECTURE behav OF mux_16x1_Wbits IS
BEGIN
	PROCESS(a,b,sel)
	BEGIN
		IF (sel = "0000") THEN
			s<= a;
		ELSIF (sel = "0001") THEN
			s<= b;
		ELSIF (sel = "0010") THEN
			s<= c;
		ELSIF (sel = "0011") THEN
			s<= d;
		ELSIF (sel = "0100") THEN
			s<= e;
		ELSIF (sel = "0101") THEN
			s<= f;
		ELSIF (sel = "0110") THEN
			s<= g;
		ELSIF (sel = "0111") THEN
			s<= h;
		ELSIF (sel = "1000") THEN
			s<= i;
		ELSIF (sel = "1001") THEN
			s<= j;
		ELSIF (sel = "1010") THEN
			s<= k;
		ELSIF (sel = "1011") THEN
			s<= l;
		ELSIF (sel = "1100") THEN
			s<= m;
		ELSIF (sel = "1101") THEN
			s<= n;
		ELSIF (sel = "1110") THEN
			s<= o;			
		ELSE
			s<= p;
		END IF;
	END PROCESS;
END behav;


