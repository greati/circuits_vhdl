ENTITY parking_control IS
PORT(cars_inside : IN BIT_VECTOR(6 DOWNTO 0);
     dez_display, uni_display : OUT BIT_VECTOR(6 DOWNTO 0));
BEGIN
END parking_control;

ARCHITECTURE struct OF parking_control IS

	-- Declaring Full Adder/Subtractor C2
	COMPONENT addersubtc2_full IS
	GENERIC (W : NATURAL := 7);
	PORT (a, b : IN BIT_VECTOR(W-1 DOWNTO 0);
      	      subt : IN BIT;
      	      s : OUT BIT_VECTOR(W-1 DOWNTO 0);
              cout : OUT BIT);
	END COMPONENT;

	-- Declaring Algarism Extractor
	COMPONENT alg_extractor IS
	GENERIC(W : NATURAL := 7);
	PORT (n : IN BIT_VECTOR(W-1 DOWNTO 0);
     	      dez, uni: OUT BIT_VECTOR(3 DOWNTO 0));
	END COMPONENT;

	-- Declaring 7 Segments Decodifier
	COMPONENT dec7seg IS
	PORT(n : IN BIT_VECTOR(3 DOWNTO 0);
             s : OUT BIT_VECTOR(6 DOWNTO 0));
	END COMPONENT;

	-- Internals
	SIGNAL max_cars : BIT_VECTOR(6 DOWNTO 0);
	SIGNAL res_subt : BIT_VECTOR(6 DOWNTO 0);
	SIGNAL uni_extracted : BIT_VECTOR(3 DOWNTO 0);
	SIGNAL dez_extracted : BIT_VECTOR(3 DOWNTO 0);
BEGIN
	max_cars <= "0110010";
	subtractor : addersubtc2_full PORT MAP(max_cars, cars_inside, '1', res_subt);
	extractor : alg_extractor PORT MAP(res_subt, dez_extracted, uni_extracted);
	decUni : dec7seg PORT MAP(uni_extracted, uni_display);
	decDez : dec7seg PORT MAP(dez_extracted, dez_display);
END struct;