LIBRARY ieee;
use ieee.numeric_std.all;
USE ieee.std_logic_1164.ALL;

ENTITY alg_extractor IS
GENERIC(W : NATURAL := 7);
PORT(n : IN BIT_VECTOR(W-1 DOWNTO 0);
     dez, uni: OUT BIT_VECTOR(3 DOWNTO 0));
BEGIN
END alg_extractor;

ARCHITECTURE struct OF alg_extractor IS

SIGNAL nNat : INTEGER range 0 to 50;
SIGNAL dezNat, uniNat : INTEGER range 0 to 9;

BEGIN
	-- nNat is a natural representation of the number
	nNat <= to_integer(unsigned(To_StdLogicVector(n)));
	-- Take digits as naturals
	dezNat <= nNat / 10;
	uniNat <= nNat mod 10;
	-- Return digits as bit_vector
	dez <= To_BitVector(std_logic_vector(to_unsigned(dezNat,dez'LENGTH)));
	uni <= To_BitVector(std_logic_vector(to_unsigned(uniNat,uni'LENGTH)));
END struct;
