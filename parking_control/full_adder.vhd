ENTITY full_adder IS
PORT(a, b : IN BIT;
	cin : IN BIT;
	s : OUT BIT;
	cout : OUT BIT);
END full_adder;

ARCHITECTURE structural OF full_adder IS
BEGIN 
	cout <= (a AND cin) OR (b AND cin) OR (a AND b);
	s <= (a XOR b) XOR cin; 
END structural;
