ENTITY adder_Wbits IS
GENERIC (W : NATURAL := 7);
PORT(a, b : IN BIT_VECTOR(W-1 DOWNTO 0);
	cin : IN BIT;
	s : OUT BIT_VECTOR(W-1 DOWNTO 0);
	cout : OUT BIT);
END adder_Wbits;

ARCHITECTURE arch1 OF adder_Wbits IS
SIGNAL carry : BIT_VECTOR(W DOWNTO 0);
BEGIN
	carry(0) <= cin;
	f0 : FOR i IN (W-1) DOWNTO 0 GENERATE
		s(i) <= a(i) XOR b(i) XOR carry(i);
		carry(i+1) <= (a(i) AND b(i)) 
			       OR (a(i) AND carry(i)) 
			       OR (b(i) AND carry(i));
	END GENERATE f0;
	cout <= carry(W);
END arch1;

