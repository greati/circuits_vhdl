ENTITY addersubtc2_full IS
GENERIC (W : NATURAL := 7);
PORT (a, b : IN BIT_VECTOR(W-1 DOWNTO 0);
      subt : IN BIT;
      s : OUT BIT_VECTOR(W-1 DOWNTO 0);
      cout : OUT BIT);
END addersubtc2_full;

ARCHITECTURE structural OF addersubtc2_full IS
	-- Declaring full adder W bits
	COMPONENT adder_Wbits IS
	GENERIC (W : NATURAL := 7);
	PORT(a, b : IN BIT_VECTOR(W-1 DOWNTO 0);
		cin : IN BIT;
		s : OUT BIT_VECTOR(W-1 DOWNTO 0);
		cout : OUT BIT);
	END COMPONENT;
	-- Declaring the second operator
	SIGNAL bop : BIT_VECTOR(W-1 DOWNTO 0);
BEGIN

	-- If it's a subtraction, inverts b
	PROCESS(a,b,subt)
		BEGIN
		IF (subt = '1') THEN
			bop <= NOT b;
		ELSE
			-- Initializes the second operator for a sum
			bop <= b;
		END IF;
	END PROCESS;
	full_adder : adder_Wbits PORT MAP(a, bop, subt, s, cout);
END structural;

