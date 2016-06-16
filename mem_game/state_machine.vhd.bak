LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY state_machine IS
   PORT(
      clk      : IN   STD_LOGIC;
      reset    : IN   STD_LOGIC; --Reset the game
      c1_confirm : IN STD_LOGIC; --First choice confirmation
      c2_confirm : IN STD_LOGIC; --Second choice confirmation
      msb  : IN   STD_LOGIC; --LSB from comparator, if P == 8
      output   : OUT  STD_LOGIC_VECTOR(9 downto 0));
END state_machine;
ARCHITECTURE a OF state_machine IS
   TYPE STATE_TYPE IS  (s1, s2, s3, s4, s5, s6);
   SIGNAL state   : STATE_TYPE;
BEGIN
   PROCESS (clk, reset)
   BEGIN
      IF reset = '1' THEN
         state <= s1;
      ELSIF (clk'EVENT AND clk = '1') THEN
         CASE state IS
            WHEN s1 =>
		--If p < 8 need change	
               IF msb = '1' THEN
			--Next State
                  state <= s2;
               ELSE
			--Final wining State
                  state <= s6;
               END IF;
            WHEN s2 =>
		--If first piece choice is confirmed
               IF c1_confirm = '1' THEN
                  state <= s3;
               ELSE
                  state <= s2;
               END IF;
	    WHEN s3 =>
		--If second piece choice is confirmed
		IF c2_confirm = '1' THEN
		  state <=s4;
		ELSE
		  state <=s3;
		END IF;
	    WHEN s4 =>
		--p++ if sel1 == sel 2 and set visible  
		state <= s5;
	    WHEN s5 =>
		--attempts++ if sel1 == sel 2 and set visible
		state <= s1;
	    WHEN s6 => 
		--Final wining State
         END CASE;
      END IF;
   END PROCESS;
   
   PROCESS (state)
   BEGIN
      CASE state IS
         WHEN s1 =>
            output <= "0000000101";
         WHEN s2 =>
            output <= "0011000000";
	 WHEN s3 =>
	    output <= "1010100000";
         WHEN s4 =>
            output <= "0100010110";
	 WHEN s5 =>
            output <= "1100011010"; 
         WHEN s6 =>
            output <= "0000000000";
      END CASE;
   END PROCESS;
   
END a;