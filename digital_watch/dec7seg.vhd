ENTITY dec7seg IS
PORT(n : IN BIT_VECTOR(3 DOWNTO 0);
     s : OUT BIT_VECTOR(6 DOWNTO 0));
BEGIN
END dec7seg;

ARCHITECTURE struct OF dec7seg IS
BEGIN
	-- Segment 2
	s(6) <= n(3) OR 
		( NOT(n(2)) AND NOT(n(0)) ) OR 
		( NOT(n(2)) AND n(1) ) OR 
		( n(2) AND n(0) );
	-- Segment 1
	s(5) <= ( NOT(n(2)) ) OR
		( NOT(n(1)) AND NOT(n(0)) ) OR
		( n(1) AND n(0) );
	-- Segment 0
	s(4) <= NOT(n(1)) OR n(0) OR n(2);
	-- Segment 4
	s(3) <= n(3) OR 
		( NOT(n(2)) AND NOT(n(0)) ) OR
		( NOT(n(2)) AND n(1) ) OR
		( n(1) AND NOT(n(0)) ) OR
		( n(2) AND NOT(n(1)) AND n(0));
	-- Segment 5
	s(2) <= ( NOT(n(2)) AND NOT(n(0)) ) OR
		( n(1) AND NOT(n(0)) );
	-- Segment 6
	s(1) <= ( n(3) ) OR
		( NOT(n(1)) AND NOT(n(0)) ) OR
		( n(2) AND NOT(n(1)) ) OR
		( n(2) AND NOT(n(0)) );
	-- Segment 7
	s(0) <= ( n(3) ) OR
		( NOT(n(2)) AND n(1) ) OR
		( n(1) AND NOT(n(0)) ) OR
		( n(2) AND NOT(n(1)) ); 
END struct;