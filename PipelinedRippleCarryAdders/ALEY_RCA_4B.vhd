LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_4B IS
generic(W: integer :=24; bbits: integer :=4);
PORT (	
	clk: in std_logic;
	reset: in std_logic;
	en:  in std_logic;
	Op_A	:IN STD_LOGIC_VECTOR(W-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(W-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(W-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_4B;

ARCHITECTURE BEH OF ALEY_RCA_4B IS
SIGNAL s1: std_logic_vector(bbits-1 downto 0);
SIGNAL s2: std_logic_vector(bbits-1 downto 0);
SIGNAL s3: std_logic_vector(bbits-1 downto 0);
SIGNAL s4: std_logic_vector(bbits-1 downto 0);
SIGNAL s5: std_logic_vector(bbits-1 downto 0);
SIGNAL s6: std_logic_vector(bbits-1 downto 0);

SIGNAL Rs1: std_logic_vector(bbits-1 downto 0);
SIGNAL Rs2: std_logic_vector(2*bbits-1 downto 0);
SIGNAL Rs3: std_logic_vector(3*bbits-1 downto 0);
SIGNAL Rs4: std_logic_vector(4*bbits-1 downto 0);
SIGNAL Rs5: std_logic_vector(5*bbits-1 downto 0);
SIGNAL Rs6: std_logic_vector(6*bbits-1 downto 0);

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;
SIGNAL c5: std_logic;
SIGNAL c6: std_logic;

SIGNAL RAout1: std_logic_vector(w-1-bbits downto 0);
SIGNAL RAout2: std_logic_vector(w-1-2*bbits downto 0); 
SIGNAL RAout3: std_logic_vector(w-1-3*bbits downto 0);
SIGNAL RAout4: std_logic_vector(w-1-4*bbits downto 0);
SIGNAL RAout5: std_logic_vector(w-1-5*bbits downto 0); 
SIGNAL RAout6: std_logic_vector(w-1-6*bbits downto 0);

SIGNAL RBout1: std_logic_vector(w-1-bbits downto 0);
SIGNAL RBout2: std_logic_vector(w-1-2*bbits downto 0);
SIGNAL RBout3: std_logic_vector(w-1-3*bbits downto 0);
SIGNAL RBout4: std_logic_vector(w-1-4*bbits downto 0);
SIGNAL RBout5: std_logic_vector(w-1-5*bbits downto 0);
SIGNAL RBout6: std_logic_vector(w-1-6*bbits downto 0);


SIGNAL Rc1: std_logic;
SIGNAL Rc2: std_logic;
SIGNAL Rc3: std_logic;
SIGNAL Rc4: std_logic;
SIGNAL Rc5: std_logic;
SIGNAL Rc6: std_logic;


COMPONENT ALEY_RCA_First_4B IS
generic(BITS4: integer := 4);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(bbits-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_RCA_GEN_4B IS
generic(BITS4: integer := 4);
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

InstALEY_RCA_First_4B: ALEY_RCA_First_4B generic map(bbits) port map(OP_A(3 downto 0), OP_B(3 downto 0), s1, c1);
InstALEY_RCA_GEN_REG1: ALEY_FirstReg    generic map(w-bbits,bbits) port map(clk, reset, en, OP_A(W-1 downto bbits), OP_B(W-1 downto bbits), s1, c1, RAout1, RBout1, Rs1, Rc1);

InstALEY_RCA_GEN_4B1: ALEY_RCA_GEN_4B generic map(bbits) port map(RAout1(3 downto 0), RBout1(3 downto 0), Rc1, s2, c2);
InstALEY_RCA_GEN_REG2: ALEY_GenReg    generic map(w-2*bbits,bbits,bbits, 2*bbits) port map(clk, reset, en, RAout1(W-1-bbits downto bbits), RBout1(W-1-bbits downto bbits), s2, Rs1, c2, RAout2, RBout2, Rs2, Rc2);

InstALEY_RCA_GEN_4B2: ALEY_RCA_GEN_4B generic map(bbits) port map(RAout2(3 downto 0), RBout2(3 downto 0), Rc2, s3, c3);
InstALEY_RCA_GEN_REG3: ALEY_GenReg    generic map(w-3*bbits,bbits,2*bbits, 3*bbits) port map(clk, reset, en, RAout2(W-1-2*bbits downto bbits), RBout2(W-1-2*bbits downto bbits), s3, Rs2, c3, RAout3, RBout3, Rs3, Rc3);

InstALEY_RCA_GEN_4B3: ALEY_RCA_GEN_4B generic map(bbits) port map(RAout3(3 downto 0), RBout3(3 downto 0), Rc3, s4, c4);
InstALEY_RCA_GEN_REG4: ALEY_GenReg    generic map(w-4*bbits,bbits,3*bbits, 4*bbits) port map(clk, reset, en, RAout3(W-1-3*bbits downto bbits), RBout3(W-1-3*bbits downto bbits), s4, Rs3, c4, RAout4, RBout4, Rs4, Rc4);

InstALEY_RCA_GEN_4B4: ALEY_RCA_GEN_4B generic map(bbits) port map(RAout4(3 downto 0), RBout4(3 downto 0), Rc4, s5, c5);
InstALEY_RCA_GEN_REG5: ALEY_GenReg    generic map(w-5*bbits,bbits,4*bbits, 5*bbits) port map(clk, reset, en, RAout4(W-1-4*bbits downto bbits), RBout4(W-1-4*bbits downto bbits), s5, Rs4, c5, RAout5, RBout5, Rs5, Rc5);

InstALEY_RCA_GEN_4B5: ALEY_RCA_GEN_4B generic map(bbits) port map(RAout5(3 downto 0), RBout5(3 downto 0), Rc5, s6, c6);
InstALEY_RCA_Last_REG1: ALEY_LastReg  generic map(bbits,5*bbits,6*bbits) port map(clk, reset, en, s6, Rs5, c6, Rs6, Rc6);

SUM_Q <= Rs6;
Carry_Q <= Rc6;

END BEH;
