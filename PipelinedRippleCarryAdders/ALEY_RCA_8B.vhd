LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_8B IS
generic(W: integer :=24; bbits: integer :=8);
PORT (	
	clk: in std_logic;
	reset: in std_logic;
	en:  in std_logic;
	Op_A	:IN STD_LOGIC_VECTOR(W-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(W-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(W-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_8B;

ARCHITECTURE BEH OF ALEY_RCA_8B IS

SIGNAL s1: std_logic_vector(bbits-1 downto 0);
SIGNAL s2: std_logic_vector(bbits-1 downto 0);
SIGNAL s3: std_logic_vector(bbits-1 downto 0);

SIGNAL Rs1: std_logic_vector(bbits-1 downto 0);
SIGNAL Rs2: std_logic_vector(2*bbits-1 downto 0);
SIGNAL Rs3: std_logic_vector(3*bbits-1 downto 0);

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;

SIGNAL RAout1: std_logic_vector(w-1-bbits downto 0);
SIGNAL RAout2: std_logic_vector(w-1-2*bbits downto 0); 
SIGNAL RAout3: std_logic_vector(w-1-3*bbits downto 0);

SIGNAL RBout1: std_logic_vector(w-1-bbits downto 0);
SIGNAL RBout2: std_logic_vector(w-1-2*bbits downto 0);
SIGNAL RBout3: std_logic_vector(w-1-3*bbits downto 0);

SIGNAL Rc1: std_logic;
SIGNAL Rc2: std_logic;
SIGNAL Rc3: std_logic;


COMPONENT ALEY_RCA_First_8B IS
generic(BITS8: integer := 8);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(bbits-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_RCA_GEN_8B IS
generic(BITS8: integer := 8);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC_VECTOR(bbits-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_FirstReg is
	generic(w: integer:= 24; bbits: integer:=2);
        port (
		clk: in std_logic;
		reset: in std_logic;
		en:  in std_logic;
		InA: in std_logic_vector(w-1 downto 0);
		InB: in std_logic_vector(w-1 downto 0); 
		SumIn: in std_logic_vector(bbits-1 downto 0);
		CarryIn: in std_logic;
                Aout: out std_logic_vector(w-1 downto 0);
		Bout: out std_logic_vector(w-1 downto 0);
		SumOut: out std_logic_vector(bbits-1 downto 0);
		Carryout: out std_logic
);

end COMPONENT;

COMPONENT ALEY_GenReg is
	generic(w: integer:= 24; bbits: integer:=2; prevbbits: integer:= 2; sumsize: integer:=24);
        port (
		clk: in std_logic;
		reset: in std_logic;
		en:  in std_logic;
		InA: in std_logic_vector(w-1 downto 0);
		InB: in std_logic_vector(w-1 downto 0); 
		SumIn: in std_logic_vector(bbits-1 downto 0);
		PrevSum: in std_logic_vector(prevbbits-1 downto 0);
		CarryIn: in std_logic;
                Aout: out std_logic_vector(w-1 downto 0);
		Bout: out std_logic_vector(w-1 downto 0);
		SumOut: out std_logic_vector(sumsize-1 downto 0);
		Carryout: out std_logic
);

end COMPONENT;

COMPONENT ALEY_LastReg is
	generic(bbits: integer:=2; prevbbits: integer:= 2; sumsize: integer:=24);
        port (
		clk: in std_logic;
		reset: in std_logic;
		en:  in std_logic;
		SumIn: in std_logic_vector(bbits-1 downto 0);
		PrevSum: in std_logic_vector(prevbbits-1 downto 0);
		CarryIn: in std_logic;
		SumOut: out std_logic_vector(sumsize-1 downto 0);
		Carryout: out std_logic
);

end COMPONENT;


BEGIN

InstALEY_RCA_First_8B: ALEY_RCA_First_8B generic map(bbits) port map(OP_A(bbits-1 downto 0), OP_B(bbits-1 downto 0), s1, c1);
InstALEY_RCA_GEN_REG1: ALEY_FirstReg       generic map(w-bbits,bbits) port map(clk, reset, en, OP_A(W-1 downto bbits), OP_B(W-1 downto bbits), s1, c1, RAout1, RBout1, Rs1, Rc1);

InstALEY_RCA_GEN_8B1: ALEY_RCA_GEN_8B generic map(bbits) port map(RAout1(7 downto 0), RBout1(7 downto 0), Rc1, s2, c2);
InstALEY_RCA_GEN_REG2: ALEY_GenReg    generic map(w-2*bbits,bbits,bbits, 2*bbits) port map(clk, reset, en, RAout1(W-1-bbits downto bbits), RBout1(W-1-bbits downto bbits), s2, Rs1, c2, RAout2, RBout2, Rs2, Rc2);
  
InstALEY_RCA_GEN_2B2: ALEY_RCA_GEN_8B generic map(bbits) port map(RAout2(7 downto 0), RBout2(7 downto 0), Rc2, s3, c3);
InstALEY_RCA_Last_REG1: ALEY_LastReg  generic map(bbits,2*bbits,3*bbits) port map(clk, reset, en, s3, Rs2, c3, Rs3, Rc3);

SUM_Q <= Rs3;
Carry_Q <= Rc3;

END BEH;