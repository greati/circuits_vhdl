LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY comp_clockAlarm IS
GENERIC(W : NATURAL := 11);
PORT(fromClock : IN std_logic_vector((W-1) DOWNTO 0);
     fromAlarm : IN std_logic_vector((W-1) DOWNTO 0);
     enable : IN BIT;
     turnDown : IN BIT;
     soneca : IN BIT;
     contAlarm : IN std_logic_vector(3 DOWNTO 0);
     alarm : OUT BIT
);
END comp_clockAlarm;

ARCHITECTURE behav OF comp_clockAlarm IS

SIGNAL hold : BIT := '0';

BEGIN
	PROCESS(fromClock, fromAlarm, contAlarm)
	BEGIN
		IF (enable = '1')THEN
			IF (contAlarm < 11 AND hold = '0' AND turnDown = '0') THEN
				IF ((soneca = '1' AND fromClock = fromAlarm + 10) OR
				    (soneca = '0' AND fromClock = fromAlarm)) THEN
					alarm <= '1';
				ELSE
					alarm <= '0';			
				END IF;
			ELSIF (fromClock = fromAlarm) OR (soneca = '1' AND fromClock = fromAlarm + 10)  THEN
				hold <= '1';
				alarm <='0';
			ELSE 
				hold<='0';
				alarm <= '0';
			END IF;
	
			IF (fromClock = fromAlarm AND soneca = '1') THEN
				alarm<= '0';
			END IF;
		END IF;
	END PROCESS;
END behav;




