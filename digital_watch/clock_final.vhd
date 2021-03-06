LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY clock_final IS
PORT(
	clkClock, clkAdjust, clkAlarmAlive : IN BIT;
	adjClock, adjAlarm, offAlarm, soneca, clear, alarmOn : IN BIT;
	upH, downH, upMin, downMin : IN BIT;
	dezH7, uniH7, dezMin7, uniMin7 : OUT BIT_VECTOR(6 DOWNTO 0);
	alarm: OUT BIT
);
END clock_final;

ARCHITECTURE comps OF clock_final IS 

	-- 7 seg decodifier
	COMPONENT dec7seg IS
	PORT(n : IN BIT_VECTOR(3 DOWNTO 0);
     	     s : OUT BIT_VECTOR(6 DOWNTO 0));
	END COMPONENT;
	
	-- Alg extractor
	COMPONENT alg_extractor IS
	GENERIC(W : NATURAL := 6);
	PORT (n : IN BIT_VECTOR(W-1 DOWNTO 0);
     	      dez, uni: OUT BIT_VECTOR(3 DOWNTO 0));
	END COMPONENT;
	
	-- H/m extractor
	COMPONENT min_Hmin IS
	GENERIC(W : NATURAL := 11);
	PORT (mins : IN std_logic_vector((W-1) DOWNTO 0);
	      m : OUT BIT_VECTOR((5) DOWNTO 0);
	      h : OUT BIT_VECTOR((5) DOWNTO 0));
	END COMPONENT;

	-- Multiplex for minutes
	COMPONENT mux_2x1_Wbits IS
	GENERIC(W : NATURAL := 11);
	PORT(a,b: IN std_logic_vector(W-1 DOWNTO 0);
	     sel : IN BIT;
	     s : OUT std_logic_vector(W-1 DOWNTO 0)
	);
	END COMPONENT;	

	-- Multiplex for clocks
	COMPONENT mux_2x1 IS
	PORT(a,b: IN BIT;
	     sel : IN BIT;
	     s : OUT BIT
	);
	END COMPONENT;		

	-- Clock counter
	COMPONENT counter_digital_clock IS
	GENERIC(W : NATURAL := 11);
	PORT(d : IN std_logic_vector(w-1 DOWNTO 0);
     	     clk : IN BIT; -- clock
     	     clrn : IN BIT; -- clear
             ena : IN BIT; -- enable
             upH : IN BIT; -- up hours
             downH : IN BIT; -- down hours
             upMin : IN BIT; -- up minutes
             downMin : IN BIT; -- down minutes
     	     subt : IN BIT;
     	     load : IN BIT; -- load
             ajuste: IN BIT;	
             q : BUFFER std_logic_vector(w-1 DOWNTO 0) -- out
	);
	END COMPONENT;

	-- Alarm register
	COMPONENT counter_alarm IS
	GENERIC(W : NATURAL := 11);
	PORT(d : IN std_logic_vector(w-1 DOWNTO 0);
	     clk : IN BIT; -- clock
	     clrn : IN BIT; -- clear
	     ena : IN BIT; -- enable
	     upH : IN BIT; -- up hours
	     downH : IN BIT; -- down hours
	     upMin : IN BIT; -- up minutes
	     downMin : IN BIT; -- down minutes
	     subt : IN BIT;
	     load : IN BIT; -- load
	     q : BUFFER std_logic_vector(w-1 DOWNTO 0) -- out
	);
	END COMPONENT;	

	-- Comparator
	COMPONENT comp_clockAlarm IS
	GENERIC(W : NATURAL := 11);
	PORT(fromClock : IN std_logic_vector((W-1) DOWNTO 0);
	     fromAlarm : IN std_logic_vector((W-1) DOWNTO 0);
	     enable : IN BIT;
	     turnDown  : IN BIT;
	     soneca : IN BIT;
	     contAlarm : IN std_logic_vector(3 DOWNTO 0);
	     alarm : OUT BIT
	);
	END COMPONENT;

	-- Counter for alarm alive
	COMPONENT counter_mod11 IS
	GENERIC(w: NATURAL := 4 );
	PORT(d : IN std_logic_vector(W-1 DOWNTO 0);
	     clk: IN BIT;
	     clrn: IN BIT;
	     ena : IN BIT;
	     load: IN BIT;
	     q: BUFFER std_logic_vector(W-1 DOWNTO 0));
	END COMPONENT;

	SIGNAL clkClockMult: BIT;
	SIGNAL minNormalClock : std_logic_vector(10 DOWNTO 0);
	SIGNAL minAlarmReg: std_logic_vector(10 DOWNTO 0);
	SIGNAL countAlarmAlive: std_logic_vector(3 DOWNTO 0);
	SIGNAL minToShow: std_logic_vector(10 DOWNTO 0);
	SIGNAL mToShow: BIT_VECTOR(5 DOWNTO 0);
	SIGNAL hToShow: BIT_VECTOR(5 DOWNTO 0);
	SIGNAL dezH,uniH,dezMin,uniMin: BIT_VECTOR(3 DOWNTO 0);
	SIGNAL alarmIntern: BIT;
	
BEGIN

	-- Multiplexing normal clock
	muxClk: mux_2x1 
	PORT MAP(clkClock,clkAdjust,adjClock,clkClockMult);
	-- Configuring normal clock
	counterClock: counter_digital_clock 
	PORT MAP("00000000000",clkClockMult,clear,'1',upH,downH,upMin,downMin,'0','0',adjClock,minNormalClock);
	-- Configuring alarm clock
	counterAlarm: counter_alarm 
	PORT MAP("00000000000",clkAdjust,clear,adjAlarm,upH,downH,upMin,downMin,'0','0',minAlarmReg);
	-- Counter alarme alive
	counterAlarmAlive: counter_mod11 
	PORT MAP("0000",clkAlarmAlive,clear,alarmIntern,'0',countAlarmAlive); -- what put in clear?
	-- Comparator
	comparatorAlarm: comp_clockAlarm 
	PORT MAP(minNormalClock,minAlarmReg,alarmOn,offAlarm,soneca,countAlarmAlive,alarmIntern);
	alarm <= alarmIntern; -- an internal signal for the alarm
	-- Multiplex minutes (what show in displays?)
	muxMinutes: mux_2x1_Wbits 
	PORT MAP(minNormalClock,minAlarmReg,adjAlarm,minToShow);
	-- Convert mins to HH:mm
	hmExt: min_Hmin 
	PORT MAP(minToShow,mToShow,hToShow);
	-- Extract algarisms hours
	algExtHour: alg_extractor 
	PORT MAP(hToShow,dezH,uniH);
	-- Extract algarisms minutes
	algExtMin: alg_extractor 
	PORT MAP(mToShow,dezMin,uniMin);
	-- Decodify dezH
	decDezH: dec7seg 
	PORT MAP(dezH,dezH7);
	-- Decodify uniH
	decUniH: dec7seg 
	PORT MAP(uniH,uniH7);
	-- Decodify dezMin
	decDezMin: dec7seg 
	PORT MAP(dezMin,dezMin7);
	-- Decodify uniMin
	decUniMin: dec7seg 
	PORT MAP(uniMin,uniMin7);
END comps;

