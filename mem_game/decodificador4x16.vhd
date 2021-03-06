LIBRARY WORK;
LIBRARY IEEE;
USE WORK.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decodificador4x16 IS
PORT(input : IN std_logic_vector(4 DOWNTO 0);
     output : OUT std_logic_vector(15 DOWNTO 0));
END decodificador4x16;

ARCHITECTURE behavior OF decodificador4x16 IS
BEGIN
	PROCESS(input)
	BEGIN
		IF(input = "00000") THEN
			output <= "0000000000000000";
		ELSIF(input = "00001") THEN
			output <= "1000000000000000";
		ELSIF(input = "00010") THEN
			output <= "0100000000000000";
		ELSIF(input = "00011") THEN
			output <= "0010000000000000";
		ELSIF(input = "00100") THEN
			output <= "0001000000000000";
		ELSIF(input = "00101") THEN
			output <= "0000100000000000";
		ELSIF(input = "00110") THEN
			output <= "0000010000000000";
		ELSIF(input = "00111") THEN
			output <= "0000001000000000";
		ELSIF(input = "01000") THEN
			output <= "0000000100000000";
		ELSIF(input = "01001") THEN
			output <= "0000000010000000";
		ELSIF(input = "01010") THEN
			output <= "0000000001000000";
		ELSIF(input = "01011") THEN
			output <= "0000000000100000";
		ELSIF(input = "01100") THEN
			output <= "0000000000010000";
		ELSIF(input = "01101") THEN
			output <= "0000000000001000";
		ELSIF(input = "01110") THEN
			output <= "0000000000000100";
		ELSIF(input = "01111") THEN
			output <= "0000000000000010";
		ELSE
			output <= "0000000000000001";
		END IF;
	END PROCESS;
END behavior;
