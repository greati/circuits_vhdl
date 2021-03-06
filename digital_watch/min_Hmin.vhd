LIBRARY ieee;
use ieee.numeric_std.all;
USE ieee.std_logic_1164.ALL;

ENTITY min_Hmin IS
GENERIC(W : NATURAL := 11);
PORT (mins : IN std_logic_vector((W-1) DOWNTO 0);
      m : OUT BIT_VECTOR((5) DOWNTO 0);
      h : OUT BIT_VECTOR((5) DOWNTO 0));
END min_Hmin;

ARCHITECTURE struct OF min_Hmin IS
	SIGNAL minsNat : INTEGER range 0 to 1440;
	SIGNAL mNat: INTEGER range 0 to 59;
	SIGNAL hNat : INTEGER range 0 to 23;
BEGIN
	-- nNat is a natural representation of the number
	minsNat <= to_integer(unsigned(mins));
	-- Take minuts and hours as naturals
	hNat <= minsNat / 60;
	mNat <= minsNat mod 60;
	-- Return as bit_vector
	h <= To_BitVector(std_logic_vector(to_unsigned(hNat,h'LENGTH)));
	m <= To_BitVector(std_logic_vector(to_unsigned(mNat,m'LENGTH)));
END struct;