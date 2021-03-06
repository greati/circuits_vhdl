LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mem_game IS
PORT(
	--Registradores (pe�as)
	rg1,rg2,rg3,rg4,rg5,rg6,rg7,rg8,
	rg9,rg10,rg11,rg12,rg13,rg14,rg15,rg16 : OUT std_logic_vector (4 DOWNTO 0);
	
	-- Pe�as
	choice1, choice2 : IN std_logic_vector(4 DOWNTO 0);

	-- Escolhas
	confirm_choice1, confirm_choice2 : IN std_logic;

	-- Reset
	reset, clock : IN std_logic;
	
	-- Points
	p : BUFFER std_ulogic_vector (3 DOWNTO 0); 
	
	-- Attempts
	attempts : BUFFER std_logic_vector (31 DOWNTO 0)
);
END mem_game;

ARCHITECTURE comps OF mem_game IS

	-- 7 seg decodifier
	COMPONENT dec7seg IS
	PORT(n : IN BIT_VECTOR(4 DOWNTO 0);
     	     s : OUT BIT_VECTOR(6 DOWNTO 0));
	END COMPONENT;

	-- Multiplex for registers
	COMPONENT mux_2x1_Wbits IS
	GENERIC(W : NATURAL := 5);
	PORT(a,b: IN std_logic_vector(W-1 DOWNTO 0);
	     sel : IN std_logic;
	     s : OUT std_logic_vector(W-1 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT mux_2x1 IS
	PORT(a,b: IN std_logic;
	     sel : IN std_logic;
	     s : OUT std_logic
	);
	END COMPONENT;
	
	--Comparator
	COMPONENT comp_5bits IS
	PORT(a,b: IN std_logic_vector(4 DOWNTO 0);
	     output : OUT std_logic
	);
	END COMPONENT;

	COMPONENT simple_subtractor IS
	GENERIC(W : NATURAL := 4);
	PORT (a, b : IN std_logic_vector((W-1) DOWNTO 0);
      	sub: IN std_logic;
	s : OUT std_logic_vector((W-1) DOWNTO 0));
	END COMPONENT;

	
	-- Multiplex for registers
	COMPONENT mux_16x1_Wbits IS
	GENERIC(W : NATURAL := 4);
	PORT(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p: IN std_logic_vector(W-1 DOWNTO 0);
             sel : IN std_logic_vector(4 DOWNTO 0);
     	     s : OUT std_logic_vector(W-1 DOWNTO 0)
	);
	END COMPONENT;

	-- Decoder 4x16 
	COMPONENT decodificador4x16 IS
	PORT(input : IN std_logic_vector(4 DOWNTO 0);
     	     output : OUT std_logic_vector(15 DOWNTO 0));
	END COMPONENT;

	-- Registers
	COMPONENT parallel_register IS
	PORT(vis: IN std_logic;
	    d: IN std_logic_VECTOR(4 DOWNTO 0);
	    clk : IN std_logic;
	    clrn : IN std_logic;
	    load : IN std_logic;
	    q : OUT std_logic_VECTOR(4 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT P_register IS
	PORT(d: IN std_logic_VECTOR(4 DOWNTO 0);
	    clk : IN std_logic;
	    clrn : IN std_logic;
	    load : IN std_logic;
	    q : OUT std_logic_VECTOR(4 DOWNTO 0));
	END COMPONENT;

	-- State Machines
	COMPONENT state_machine IS
   	PORT(clk      : IN   STD_LOGIC;
      	     reset    : IN   STD_LOGIC; --Reset the game
             c1_confirm : IN STD_LOGIC; --First choice confirmation
      	     c2_confirm : IN STD_LOGIC; --Second choice confirmation
      	     msb  : IN   STD_LOGIC; --LSB from comparator, if P == 8
      	     output   : OUT  STD_LOGIC_VECTOR(9 downto 0));
	END COMPONENT;

	COMPONENT set_visi IS
	PORT(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p: BUFFER std_logic_vector(4 DOWNTO 0);
     	     sel : IN std_logic_vector(3 DOWNTO 0);
     	     confirm : IN std_logic
	);
	END COMPONENT;

	-- Signals

	SIGNAL r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16: std_logic_vector(4 DOWNTO 0); -- Registers output
	SIGNAL output_state_machine : std_logic_vector (9 DOWNTO 0); -- Output from state Machine
	SIGNAL comp_p : std_logic; -- Most significant bit from P
	SIGNAL comp_out: std_logic; -- output from comparator
	SIGNAL load : std_logic_vector(15 DOWNTO 0):= "0000000000000000"; -- load output from decoder
	SIGNAL mux_t1_out: std_logic_vector(4 DOWNTO 0); -- Mux T1 from diagram
	SIGNAL mux_t2_out: std_logic_vector(4 DOWNTO 0); -- Mux T2 from diagram
	SIGNAL vis : std_logic; -- Visible
	SIGNAL mux_c_out : std_logic_vector (4 DOWNTO 0);-- Mux C from diagram
	SIGNAL Out_Sym1: std_logic_vector(4 DOWNTO 0); -- Out from Sym1 register
	SIGNAL Out_Sym2: std_logic_vector(4 DOWNTO 0); -- Out from Sym1 register
	SIGNAL addOut: std_logic_vector (4 DOWNTO 0); -- Output from subtractor//adder
	SIGNAL andPort: std_logic; 
	SIGNAL P_out: std_logic_vector(4 DOWNTO 0);
	SIGNAL att_out: std_logic_vector(4 DOWNTO 0);
	SIGNAL ms1_out: std_logic_vector(4 DOWNTO 0);
	SIGNAL ms2_out: std_logic_vector(4 DOWNTO 0);

BEGIN
	--State Machine
	controller : state_machine PORT MAP(clock, reset, confirm_choice1, confirm_choice2, comp_p, output_state_machine);
	
	--Mux V and C
	MUX_V: mux_2x1 PORT MAP(comp_out,  output_state_machine(7), output_state_machine(8),vis);
	muxc: mux_2x1_Wbits PORT MAP(choice1, choice2,output_state_machine(9), mux_c_out);
	
	--Decoder
	d1:decodificador4x16 PORT MAP(mux_c_out, load );
	
	--Special Registers
	register1:parallel_register PORT MAP(vis ,r1 ,clock,reset, load(15), r1);
	register2:parallel_register PORT MAP(vis ,r2 ,clock,reset, load(14), r2);
	register3:parallel_register PORT MAP(vis ,r3 ,clock,reset, load(13), r3);
	register4:parallel_register PORT MAP(vis ,r4 ,clock,reset, load(12), r4);	
	register5:parallel_register PORT MAP(vis ,r5 ,clock,reset, load(11), r5);
	register6:parallel_register PORT MAP(vis ,r6 ,clock,reset, load(10), r6);
	register7:parallel_register PORT MAP(vis ,r7 ,clock,reset, load(9), r7);
	register8:parallel_register PORT MAP(vis ,r8 ,clock,reset, load(8), r8);
	register9:parallel_register PORT MAP(vis ,r9 ,clock,reset, load(7), r9);
	register10:parallel_register PORT MAP(vis ,r10 ,clock,reset, load(6), r10);
	register11:parallel_register PORT MAP(vis ,r11 ,clock,reset, load(5), r11);
	register12:parallel_register PORT MAP(vis ,r12 ,clock,reset, load(4), r12);
	register13:parallel_register PORT MAP(vis ,r13 ,clock,reset, load(3), r13);
	register14:parallel_register PORT MAP(vis ,r14 ,clock,reset, load(2), r14);
	register15:parallel_register PORT MAP(vis ,r15 ,clock,reset, load(1), r15);
	register16:parallel_register PORT MAP(vis ,r16 ,clock,reset, load(0), r16);

	
	--Mux T1 and T2	
	mux_t1: mux_16x1_Wbits PORT MAP(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16, choice1,mux_t1_out );
	mux_t2: mux_16x1_Wbits PORT MAP(r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16, choice2,mux_t2_out );

	--Normal Register holding the choices
	registerChoice_sym1: P_register PORT MAP(mux_t1_out, clock, reset, output_state_machine(6), Out_Sym1 );
	registerChoice_sym2: P_register PORT MAP(mux_t2_out, clock, reset, output_state_machine(5), Out_Sym2 );
	
	--Comparator
	
	comp: comp_5bits PORT MAP(Out_Sym1, Out_Sym2, comp_out);

	--And Port
	andPort <= comp_out AND output_state_machine(4);
	
	--P and Attempts normal registers
	P1_register: P_register PORT MAP(addOut,clock,reset,andPort, P_out );
	Attempts_register: P_register PORT MAP(addOut, clock, reset, output_state_machine(3), att_out);
	
	--Mux
	MS1:mux_2x1_Wbits PORT MAP(att_out, P_out, output_state_machine(2), ms1_out  );
	MS2:mux_2x1_Wbits PORT MAP("01000", "00001", output_state_machine(1), ms2_out  );

	--Adder Subtractor

	add_sub: simple_subtractor PORT MAP(ms1_out, ms2_out, output_state_machine(0), addOut);
	
	--Check if P is negative
	comp_p <= addOut(4);	


END comps;
