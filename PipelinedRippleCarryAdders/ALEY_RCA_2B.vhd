LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_2B IS
generic(W: integer :=24; bbits: integer :=2);
PORT (	
	clk: in std_logic;
	reset: in std_logic;
	en:  in std_logic;
	Op_A	:IN STD_LOGIC_VECTOR(W-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(W-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(W-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_2B;

ARCHITECTURE BEH OF ALEY_RCA_2B IS

SIGNAL s1: std_logic_vector(bbits-1 downto 0);
SIGNAL s2: std_logic_vector(bbits-1 downto 0);
SIGNAL s3: std_logic_vector(bbits-1 downto 0);
SIGNAL s4: std_logic_vector(bbits-1 downto 0);
SIGNAL s5: std_logic_vector(bbits-1 downto 0);
SIGNAL s6: std_logic_vector(bbits-1 downto 0);
SIGNAL s7: std_logic_vector(bbits-1 downto 0);
SIGNAL s8: std_logic_vector(bbits-1 downto 0);
SIGNAL s9: std_logic_vector(bbits-1 downto 0);
SIGNAL s10: std_logic_vector(bbits-1 downto 0);
SIGNAL s11: std_logic_vector(bbits-1 downto 0);
SIGNAL s12: std_logic_vector(bbits-1 downto 0);

SIGNAL Rs1: std_logic_vector(bbits-1 downto 0);
SIGNAL Rs2: std_logic_vector(2*bbits-1 downto 0);
SIGNAL Rs3: std_logic_vector(3*bbits-1 downto 0);
SIGNAL Rs4: std_logic_vector(4*bbits-1 downto 0);
SIGNAL Rs5: std_logic_vector(5*bbits-1 downto 0);
SIGNAL Rs6: std_logic_vector(6*bbits-1 downto 0);
SIGNAL Rs7: std_logic_vector(7*bbits-1 downto 0);
SIGNAL Rs8: std_logic_vector(8*bbits-1 downto 0);
SIGNAL Rs9: std_logic_vector(9*bbits-1 downto 0);
SIGNAL Rs10: std_logic_vector(10*bbits-1 downto 0);
SIGNAL Rs11: std_logic_vector(11*bbits-1 downto 0);
SIGNAL Rs12: std_logic_vector(12*bbits-1 downto 0);

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;
SIGNAL c5: std_logic;
SIGNAL c6: std_logic;
SIGNAL c7: std_logic;
SIGNAL c8: std_logic;
SIGNAL c9: std_logic;
SIGNAL c10: std_logic;
SIGNAL c11: std_logic;
SIGNAL c12: std_logic;

SIGNAL RAout1: std_logic_vector(w-1-bbits downto 0);
SIGNAL RAout2: std_logic_vector(w-1-2*bbits downto 0); 
SIGNAL RAout3: std_logic_vector(w-1-3*bbits downto 0);
SIGNAL RAout4: std_logic_vector(w-1-4*bbits downto 0); 
SIGNAL RAout5: std_logic_vector(w-1-5*bbits downto 0);
SIGNAL RAout6: std_logic_vector(w-1-6*bbits downto 0); 
SIGNAL RAout7: std_logic_vector(w-1-7*bbits downto 0);
SIGNAL RAout8: std_logic_vector(w-1-8*bbits downto 0); 
SIGNAL RAout9: std_logic_vector(w-1-9*bbits downto 0);
SIGNAL RAout10: std_logic_vector(w-1-10*bbits downto 0); 
SIGNAL RAout11: std_logic_vector(w-1-11*bbits downto 0);
SIGNAL RAout12: std_logic_vector(w-1-12*bbits downto 0); 

SIGNAL RBout1: std_logic_vector(w-1-bbits downto 0);
SIGNAL RBout2: std_logic_vector(w-1-2*bbits downto 0);
SIGNAL RBout3: std_logic_vector(w-1-3*bbits downto 0);
SIGNAL RBout4: std_logic_vector(w-1-4*bbits downto 0);
SIGNAL RBout5: std_logic_vector(w-1-5*bbits downto 0);
SIGNAL RBout6: std_logic_vector(w-1-6*bbits downto 0);
SIGNAL RBout7: std_logic_vector(w-1-7*bbits downto 0);
SIGNAL RBout8: std_logic_vector(w-1-8*bbits downto 0);
SIGNAL RBout9: std_logic_vector(w-1-9*bbits downto 0);
SIGNAL RBout10: std_logic_vector(w-1-10*bbits downto 0);
SIGNAL RBout11: std_logic_vector(w-1-11*bbits downto 0);
SIGNAL RBout12: std_logic_vector(w-1-12*bbits downto 0);

SIGNAL Rc1: std_logic;
SIGNAL Rc2: std_logic;
SIGNAL Rc3: std_logic;
SIGNAL Rc4: std_logic;
SIGNAL Rc5: std_logic;
SIGNAL Rc6: std_logic;
SIGNAL Rc7: std_logic;
SIGNAL Rc8: std_logic;
SIGNAL Rc9: std_logic;
SIGNAL Rc10: std_logic;
SIGNAL Rc11: std_logic;
SIGNAL Rc12: std_logic;

COMPONENT ALEY_RCA_First_2B IS
generic(BITS2: integer := 2);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(bbits-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(bbits-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_RCA_GEN_2B IS
generic(BITS2: integer := 2);
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

InstALEY_RCA_First_2B: ALEY_RCA_First_2B generic map(bbits) port map(OP_A(1 downto 0), OP_B(1 downto 0), s1, c1);
InstALEY_RCA_GEN_REG1: ALEY_FirstReg    generic map(w-bbits,bbits) port map(clk, reset, en, OP_A(W-1 downto bbits), OP_B(W-1 downto bbits), s1, c1, RAout1, RBout1, Rs1, Rc1);

InstALEY_RCA_GEN_2B1: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout1(1 downto 0), RBout1(1 downto 0), Rc1, s2, c2);
InstALEY_RCA_GEN_REG2: ALEY_GenReg    generic map(w-2*bbits,bbits,bbits, 2*bbits) port map(clk, reset, en, RAout1(W-1-bbits downto bbits), RBout1(W-1-bbits downto bbits), s2, Rs1, c2, RAout2, RBout2, Rs2, Rc2);

InstALEY_RCA_GEN_2B2: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout2(1 downto 0), RBout2(1 downto 0), Rc2, s3, c3);
InstALEY_RCA_GEN_REG3: ALEY_GenReg    generic map(w-3*bbits,bbits,2*bbits, 3*bbits) port map(clk, reset, en, RAout2(W-1-2*bbits downto bbits), RBout2(W-1-2*bbits downto bbits), s3, Rs2, c3, RAout3, RBout3, Rs3, Rc3);

InstALEY_RCA_GEN_2B3: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout3(1 downto 0), RBout3(1 downto 0), Rc3, s4, c4);
InstALEY_RCA_GEN_REG4: ALEY_GenReg    generic map(w-4*bbits,bbits,3*bbits, 4*bbits) port map(clk, reset, en, RAout3(W-1-3*bbits downto bbits), RBout3(W-1-3*bbits downto bbits), s4, Rs3, c4, RAout4, RBout4, Rs4, Rc4);

InstALEY_RCA_GEN_2B4: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout4(1 downto 0), RBout4(1 downto 0), Rc4, s5, c5);
InstALEY_RCA_GEN_REG5: ALEY_GenReg    generic map(w-5*bbits,bbits,4*bbits, 5*bbits) port map(clk, reset, en, RAout4(W-1-4*bbits downto bbits), RBout4(W-1-4*bbits downto bbits), s5, Rs4, c5, RAout5, RBout5, Rs5, Rc5);

InstALEY_RCA_GEN_2B5: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout5(1 downto 0), RBout5(1 downto 0), Rc5, s6, c6);
InstALEY_RCA_GEN_REG6: ALEY_GenReg    generic map(w-6*bbits,bbits,5*bbits, 6*bbits) port map(clk, reset, en, RAout5(W-1-5*bbits downto bbits), RBout5(W-1-5*bbits downto bbits), s6, Rs5, c6, RAout6, RBout6, Rs6, Rc6);

InstALEY_RCA_GEN_2B6: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout6(1 downto 0), RBout6(1 downto 0), Rc6, s7, c7);
InstALEY_RCA_GEN_REG7: ALEY_GenReg    generic map(w-7*bbits,bbits,6*bbits, 7*bbits) port map(clk, reset, en, RAout6(W-1-6*bbits downto bbits), RBout6(W-1-6*bbits downto bbits), s7, Rs6, c7, RAout7, RBout7, Rs7, Rc7);

InstALEY_RCA_GEN_2B7: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout7(1 downto 0), RBout7(1 downto 0), Rc7, s8, c8);
InstALEY_RCA_GEN_REG8: ALEY_GenReg    generic map(w-8*bbits,bbits,7*bbits, 8*bbits) port map(clk, reset, en, RAout7(W-1-7*bbits downto bbits), RBout7(W-1-7*bbits downto bbits), s8, Rs7, c8, RAout8, RBout8, Rs8, Rc8);

InstALEY_RCA_GEN_2B8: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout8(1 downto 0), RBout8(1 downto 0), Rc8, s9, c9);
InstALEY_RCA_GEN_REG9: ALEY_GenReg    generic map(w-9*bbits,bbits,8*bbits, 9*bbits) port map(clk, reset, en, RAout8(W-1-8*bbits downto bbits), RBout8(W-1-8*bbits downto bbits), s9, Rs8, c9, RAout9, RBout9, Rs9, Rc9);

InstALEY_RCA_GEN_2B9: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout9(1 downto 0), RBout9(1 downto 0), Rc9, s10, c10);
InstALEY_RCA_GEN_REG10: ALEY_GenReg    generic map(w-10*bbits,bbits,9*bbits, 10*bbits) port map(clk, reset, en, RAout9(W-1-9*bbits downto bbits), RBout9(W-1-9*bbits downto bbits), s10, Rs9, c10, RAout10, RBout10, Rs10, Rc10);

InstALEY_RCA_GEN_2B10: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout10(1 downto 0), RBout10(1 downto 0), Rc10, s11, c11);
InstALEY_RCA_GEN_REG11: ALEY_GenReg    generic map(w-11*bbits,bbits,10*bbits, 11*bbits) port map(clk, reset, en, RAout10(W-1-10*bbits downto bbits), RBout10(W-1-10*bbits downto bbits), s11, Rs10, c11, RAout11, RBout11, Rs11, Rc11);

InstALEY_RCA_GEN_2B11: ALEY_RCA_GEN_2B generic map(bbits) port map(RAout11(1 downto 0), RBout11(1 downto 0), Rc11, s12, c12);
InstALEY_RCA_Last_REG1: ALEY_LastReg  generic map(bbits,11*bbits,12*bbits) port map(clk, reset, en, s12, Rs11, c12, Rs12, Rc12);


SUM_Q <= Rs12;
Carry_Q <= Rc12;

END BEH;
