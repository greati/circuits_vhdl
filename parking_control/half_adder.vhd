ENTITY half_adder IS
PORT (a,b : IN BIT;
	s : OUT BIT;
	cout : OUT BIT);
END half_adder;

ARCHITECTURE structural OF half_adder IS
BEGIN
	s <= a XOR b;
	cout <= a AND b;
END structural;