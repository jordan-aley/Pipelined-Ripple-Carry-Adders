---------------------------------------------------------------------------------
-------------First Slice---------------------------------------------------------
---------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_First_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_First_BSlice;

ARCHITECTURE BEH_first_BS OF ALEY_First_BSlice IS

CONSTANT My_C: STD_LOGIC:='0';

BEGIN

SUM_Q <= OP_A XOR OP_B XOR My_C;
Carry_Q <= ((OP_A XOR OP_B) AND My_C) OR (OP_A AND OP_B); 

END BEH_first_BS;

---------------------------------------------------------------------------------
-------------Generic Slice-------------------------------------------------------
---------------------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_GEN_BSlice;

ARCHITECTURE BEH_BS OF ALEY_GEN_BSlice IS

BEGIN

SUM_Q <= OP_A XOR OP_B XOR OP_C;
Carry_Q <= ((OP_A XOR OP_B) AND OP_C) OR (OP_A AND OP_B); 

END BEH_BS;


---------------------------------------------------------------------------------
-------------Last Register-------------------------------------------------------
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164. all;
entity ALEY_LastReg is
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

end ALEY_LastReg;

architecture reg16bit_arch of ALEY_LastReg is
signal sSumout: std_logic_vector(sumsize-1 downto 0);
signal scarryout: std_logic;

begin
   process(clk)
          begin
      		if (clk ='1' and clk'event)then
			if(reset='1')then
				sSumout <= (others => '0');
				sCarryout <= '0';
			elsif (en='1')then
				sSumout <= SumIn & PrevSum;
				sCarryout <= CarryIn;
			else
				sSumout <= sSumout;
				sCarryout <= sCarryout;
			end if;
		else
			sSumout <= sSumout;
			sCarryout <= sCarryout;
		end if;
	end process;
Sumout <= sSumout;
Carryout <= sCarryout;
end reg16bit_arch;

---------------------------------------------------------------------------------
-------------First Register-------------------------------------------------------
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164. all;
entity ALEY_FirstReg is
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

end ALEY_FirstReg;

architecture reg16bit_arch of ALEY_FirstReg is
signal sAout: std_logic_vector(w-1 downto 0);
signal sBout: std_logic_vector(w-1 downto 0);
signal sSumout: std_logic_vector(bbits-1 downto 0);
signal scarryout: std_logic;

begin
   process(clk)
          begin
      		if (clk ='1' and clk'event)then
			if(reset='1')then
				sAout <= (others => '0');
				sBout <= (others => '0');
				sSumout <= (others => '0');
				sCarryout <= '0';
			elsif (en='1')then
				sAout <= InA;
				sBout <= InB;
				sSumout <= SumIn;
				sCarryout <= CarryIn;
			else
				sAout <= sAout;
				sBout <= sBout;
				sSumout <= sSumout;
				sCarryout <= sCarryout;
			end if;
		else
			sAout <= sAout;
			sBout <= sBout;
			sSumout <= sSumout;
			sCarryout <= sCarryout;
		end if;
	end process;
Aout <= sAout;
Bout <= sBout;
Sumout <= sSumout;
Carryout <= sCarryout;
end reg16bit_arch;

---------------------------------------------------------------------------------
-------------Generic Register-------------------------------------------------------
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164. all;
entity ALEY_GenReg is
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

end ALEY_GenReg;

architecture reg16bit_arch of ALEY_GenReg is
signal sAout: std_logic_vector(w-1 downto 0);
signal sBout: std_logic_vector(w-1 downto 0);
signal sSumout: std_logic_vector(sumsize-1 downto 0);
signal scarryout: std_logic;

begin
   process(clk)
          begin
      		if (clk ='1' and clk'event)then
			if(reset='1')then
				sAout <= (others => '0');
				sBout <= (others => '0');
				sSumout <= (others => '0');
				sCarryout <= '0';
			elsif (en='1')then
				sAout <= InA;
				sBout <= InB;
				sSumout <= SumIn & PrevSum;
				sCarryout <= CarryIn;
			else
				sAout <= sAout;
				sBout <= sBout;
				sSumout <= sSumout;
				sCarryout <= sCarryout;
			end if;
		else
			sAout <= sAout;
			sBout <= sBout;
			sSumout <= sSumout;
			sCarryout <= sCarryout;
		end if;
	end process;
Aout <= sAout;
Bout <= sBout;
Sumout <= sSumout;
Carryout <= sCarryout;
end reg16bit_arch;

---------------------------------------------------------------------------------
-------------RCA_First_2B-------------------------------------------------------
---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_First_2B IS
generic(BITS2: integer := 2);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS2-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS2-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS2-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_First_2B;

ARCHITECTURE beh_first_2B OF ALEY_RCA_First_2B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;

COMPONENT ALEY_First_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

BEGIN

InstALEY_First_BSlice1: ALEY_First_BSlice port map(OP_A(0), OP_B(0), s1, c1);
InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);

SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
Carry_Q <= c2;

END beh_first_2B;

---------------------------------------------------------------------------------
-------------RCA_GEN_2B-------------------------------------------------------
---------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_GEN_2B IS
generic(BITS2: integer := 2);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS2-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS2-1 downto 0);
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS2-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_GEN_2B;

ARCHITECTURE beh_gen_2B OF ALEY_RCA_GEN_2B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;


COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

BEGIN

InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(0), OP_B(0), OP_C, s1, c1);
InstALEY_GEN_BSlice2: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);

SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
Carry_Q <= c2;

END beh_gen_2B;

---------------------------------------------------------------------------------
-------------RCA_First_4B-------------------------------------------------------
---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_First_4B IS
generic(BITS4: integer := 4);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS4-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS4-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS4-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_First_4B;

ARCHITECTURE beh_first_4B OF ALEY_RCA_First_4B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;
SIGNAL s3: std_logic;
SIGNAL s4: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;

COMPONENT ALEY_First_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

BEGIN

InstALEY_First_BSlice1: ALEY_First_BSlice port map(OP_A(0), OP_B(0), s1, c1);
InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);
InstALEY_GEN_BSlice2: ALEY_GEN_BSlice port map(OP_A(2), OP_B(2), c2, s3, c3);
InstALEY_GEN_BSlice3: ALEY_GEN_BSlice port map(OP_A(3), OP_B(3), c3, s4, c4);

SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
SUM_Q(2) <= s3;
SUM_Q(3) <= s4;
Carry_Q <= c4;

END beh_first_4B;

---------------------------------------------------------------------------------
-------------RCA_GEN_4B-------------------------------------------------------
---------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_GEN_4B IS
generic(BITS4: integer := 4);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS4-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS4-1 downto 0);
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS4-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_GEN_4B;

ARCHITECTURE beh_gen_4B OF ALEY_RCA_GEN_4B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;
SIGNAL s3: std_logic;
SIGNAL s4: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;

COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;


BEGIN

InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(0), OP_B(0), OP_C, s1, c1);
InstALEY_GEN_BSlice2: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);

InstALEY_GEN_BSlice3: ALEY_GEN_BSlice port map(OP_A(2), OP_B(2), c2, s3, c3);
InstALEY_GEN_BSlice4: ALEY_GEN_BSlice port map(OP_A(3), OP_B(3), c3, s4, c4);

SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
SUM_Q(2) <= s3;
SUM_Q(3) <= s4;

Carry_Q <= c4;

END beh_gen_4B;

---------------------------------------------------------------------------------
-------------RCA_First_6B-------------------------------------------------------
---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_First_6B IS
generic(BITS6: integer := 6);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS6-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS6-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS6-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_First_6B;

ARCHITECTURE beh_first_6B OF ALEY_RCA_First_6B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;
SIGNAL s3: std_logic;
SIGNAL s4: std_logic;
SIGNAL s5: std_logic;
SIGNAL s6: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;
SIGNAL c5: std_logic;
SIGNAL c6: std_logic;

COMPONENT ALEY_First_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

BEGIN

InstALEY_First_BSlice1: ALEY_First_BSlice port map(OP_A(0), OP_B(0), s1, c1);
InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);
InstALEY_GEN_BSlice2: ALEY_GEN_BSlice port map(OP_A(2), OP_B(2), c2, s3, c3);

InstALEY_GEN_BSlice3: ALEY_GEN_BSlice port map(OP_A(3), OP_B(3), c3, s4, c4);
InstALEY_GEN_BSlice4: ALEY_GEN_BSlice port map(OP_A(4), OP_B(4), c4, s5, c5);
InstALEY_GEN_BSlice5: ALEY_GEN_BSlice port map(OP_A(5), OP_B(5), c5, s6, c6);


SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
SUM_Q(2) <= s3;
SUM_Q(3) <= s4;
SUM_Q(4) <= s5;
SUM_Q(5) <= s6;
Carry_Q <= c6;

END beh_first_6B;

---------------------------------------------------------------------------------
-------------RCA_GEN_6B-------------------------------------------------------
---------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_GEN_6B IS
generic(BITS6: integer := 6);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS6-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS6-1 downto 0);
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS6-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_GEN_6B;

ARCHITECTURE beh_gen_6B OF ALEY_RCA_GEN_6B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;
SIGNAL s3: std_logic;
SIGNAL s4: std_logic;
SIGNAL s5: std_logic;
SIGNAL s6: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;
SIGNAL c5: std_logic;
SIGNAL c6: std_logic;

COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;


BEGIN

InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(0), OP_B(0), OP_C, s1, c1);
InstALEY_GEN_BSlice2: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);
InstALEY_GEN_BSlice3: ALEY_GEN_BSlice port map(OP_A(2), OP_B(2), c2, s3, c3);

InstALEY_GEN_BSlice4: ALEY_GEN_BSlice port map(OP_A(3), OP_B(3), c3, s4, c4);
InstALEY_GEN_BSlice5: ALEY_GEN_BSlice port map(OP_A(4), OP_B(4), c4, s5, c5);
InstALEY_GEN_BSlice6: ALEY_GEN_BSlice port map(OP_A(5), OP_B(5), c5, s6, c6);


SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
SUM_Q(2) <= s3;
SUM_Q(3) <= s4;
SUM_Q(4) <= s5;
SUM_Q(5) <= s6;
Carry_Q <= c6;

END beh_gen_6B;

---------------------------------------------------------------------------------
-------------RCA_First_8B-------------------------------------------------------
---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_First_8B IS
generic(BITS8: integer := 8);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS8-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS8-1 downto 0);
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS8-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_First_8B;

ARCHITECTURE beh_first_8B OF ALEY_RCA_First_8B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;
SIGNAL s3: std_logic;
SIGNAL s4: std_logic;
SIGNAL s5: std_logic;
SIGNAL s6: std_logic;
SIGNAL s7: std_logic;
SIGNAL s8: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;
SIGNAL c5: std_logic;
SIGNAL c6: std_logic;
SIGNAL c7: std_logic;
SIGNAL c8: std_logic;

COMPONENT ALEY_First_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;

BEGIN

InstALEY_First_BSlice1: ALEY_First_BSlice port map(OP_A(0), OP_B(0), s1, c1);
InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);
InstALEY_GEN_BSlice2: ALEY_GEN_BSlice port map(OP_A(2), OP_B(2), c2, s3, c3);
InstALEY_GEN_BSlice3: ALEY_GEN_BSlice port map(OP_A(3), OP_B(3), c3, s4, c4);

InstALEY_GEN_BSlice4: ALEY_GEN_BSlice port map(OP_A(4), OP_B(4), c4, s5, c5);
InstALEY_GEN_BSlice5: ALEY_GEN_BSlice port map(OP_A(5), OP_B(5), c5, s6, c6);
InstALEY_GEN_BSlice6: ALEY_GEN_BSlice port map(OP_A(6), OP_B(6), c6, s7, c7);
InstALEY_GEN_BSlice7: ALEY_GEN_BSlice port map(OP_A(7), OP_B(7), c7, s8, c8);

SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
SUM_Q(2) <= s3;
SUM_Q(3) <= s4;
SUM_Q(4) <= s5;
SUM_Q(5) <= s6;
SUM_Q(6) <= s7;
SUM_Q(7) <= s8;
Carry_Q <= c8;

END beh_first_8B;

---------------------------------------------------------------------------------
-------------RCA_GEN_8B-------------------------------------------------------
---------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY ALEY_RCA_GEN_8B IS
generic(BITS8: integer := 8);
PORT (	
	Op_A	:IN STD_LOGIC_VECTOR(BITS8-1 downto 0);
	Op_B	:IN STD_LOGIC_VECTOR(BITS8-1 downto 0);
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC_VECTOR(BITS8-1 downto 0);
	Carry_Q	:OUT STD_LOGIC
     );

END ALEY_RCA_GEN_8B;

ARCHITECTURE beh_gen_8B OF ALEY_RCA_GEN_8B IS

SIGNAL s1: std_logic;
SIGNAL s2: std_logic;
SIGNAL s3: std_logic;
SIGNAL s4: std_logic;
SIGNAL s5: std_logic;
SIGNAL s6: std_logic;
SIGNAL s7: std_logic;
SIGNAL s8: std_logic;

SIGNAL c1: std_logic;
SIGNAL c2: std_logic;
SIGNAL c3: std_logic;
SIGNAL c4: std_logic;
SIGNAL c5: std_logic;
SIGNAL c6: std_logic;
SIGNAL c7: std_logic;
SIGNAL c8: std_logic;

COMPONENT ALEY_GEN_BSlice IS
PORT (	
	Op_A	:IN STD_LOGIC;
	Op_B	:IN STD_LOGIC;
	Op_C	:IN STD_LOGIC;
	SUM_Q	:OUT STD_LOGIC;
	Carry_Q	:OUT STD_LOGIC
     );

END COMPONENT;


BEGIN

InstALEY_GEN_BSlice1: ALEY_GEN_BSlice port map(OP_A(0), OP_B(0), OP_C, s1, c1);
InstALEY_GEN_BSlice2: ALEY_GEN_BSlice port map(OP_A(1), OP_B(1), c1, s2, c2);
InstALEY_GEN_BSlice3: ALEY_GEN_BSlice port map(OP_A(2), OP_B(2), c2, s3, c3);
InstALEY_GEN_BSlice4: ALEY_GEN_BSlice port map(OP_A(3), OP_B(3), c3, s4, c4);

InstALEY_GEN_BSlice5: ALEY_GEN_BSlice port map(OP_A(4), OP_B(4), c4, s5, c5);
InstALEY_GEN_BSlice6: ALEY_GEN_BSlice port map(OP_A(5), OP_B(5), c5, s6, c6);
InstALEY_GEN_BSlice7: ALEY_GEN_BSlice port map(OP_A(6), OP_B(6), c6, s7, c7);
InstALEY_GEN_BSlice8: ALEY_GEN_BSlice port map(OP_A(7), OP_B(7), c7, s8, c8);

SUM_Q(0) <= s1;
SUM_Q(1) <= s2;
SUM_Q(2) <= s3;
SUM_Q(3) <= s4;
SUM_Q(4) <= s5;
SUM_Q(5) <= s6;
SUM_Q(6) <= s7;
SUM_Q(7) <= s8;
Carry_Q <= c8;

END beh_gen_8B;


