LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY set_visi IS
PORT(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p: BUFFER std_logic_vector(4 DOWNTO 0);
     sel : IN std_logic_vector(3 DOWNTO 0);
     confirm : IN std_logic
);
END set_visi;

ARCHITECTURE behav OF set_visi IS

SIGNAL aux : std_logic_vector(4 DOWNTO 0);

BEGIN
	aux <= (OTHERS => '0');
	
	PROCESS(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,sel,confirm)
	BEGIN	
		IF(confirm = '1') THEN
			aux(0) <= '1';
		ELSE 
			aux(1) <= '0';
		END IF;

		IF (sel = "0000") THEN
			a<= a XOR aux;
		ELSIF (sel = "0001") THEN
			b<= b XOR aux;
		ELSIF (sel = "0010") THEN
			c<= c XOR aux;
		ELSIF (sel = "0011") THEN
			d<= d XOR aux;
		ELSIF (sel = "0100") THEN
			e<= e XOR aux;
		ELSIF (sel = "0101") THEN
			f<= f XOR aux;
		ELSIF (sel = "0110") THEN
			g<= g XOR aux;
		ELSIF (sel = "0111") THEN
			h<= h XOR aux;
		ELSIF (sel = "1000") THEN
			i<= i XOR aux;
		ELSIF (sel = "1001") THEN
			j<= j XOR aux;
		ELSIF (sel = "1010") THEN
			k<= k XOR aux;
		ELSIF (sel = "1011") THEN
			l<= l XOR aux;
		ELSIF (sel = "1100") THEN
			m<= m XOR aux;
		ELSIF (sel = "1101") THEN
			n<= n XOR aux;
		ELSIF (sel = "1110") THEN
			o<= o XOR aux;			
		ELSE
			p<= p XOR aux;
		END IF;
	END PROCESS;
END behav;

