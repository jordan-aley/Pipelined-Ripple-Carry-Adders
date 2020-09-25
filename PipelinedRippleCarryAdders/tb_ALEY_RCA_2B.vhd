
--------------------------------------------------------------
--------------------------------------------------------------
-- Copyright JORDAN ALEY, Howard University 
-- Adv. Dig. Design. II (496)
-- Dr. Michaela E. Amoo
--RCA
--------------------------------------------------------------
--------------------------------------------------------------


LIBRARY IEEE;
USE work.CLOCKS.all;  		 -- Entity that uses CLOCKS
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_textio.all;
USE std.textio.all;
USE work.txt_util.all;
 
ENTITY tb_ALEY_RCA_2B IS
END;

ARCHITECTURE TESTBENCH OF tb_ALEY_RCA_2B IS

CONSTANT W : integer := 24;
CONSTANT BITS2 : integer := 2;

---------------------------------------------------------------
-- COMPONENTS -- Entity In/out Ports
---------------------------------------------------------------

COMPONENT ALEY_RCA_2B
  generic(W: integer :=24; bbits: integer :=2);
	PORT(		
		clk: in std_logic;
		reset: in std_logic;
		en:  in std_logic;
		Op_A		: IN std_logic_vector(W-1 DOWNTO 0);
		Op_B		: IN std_logic_vector(W-1 DOWNTO 0);
		Sum_Q		: OUT std_logic_vector(W-1 DOWNTO 0);
		Carry_Q		: OUT std_logic);
END COMPONENT;

COMPONENT CLOCK
	port(	CLK: out std_logic);
END COMPONENT;

---------------------------------------------------------------
-- Read/Write FILES
---------------------------------------------------------------


FILE in_file : TEXT open read_mode is 	"ALEY_RCA_input.txt";   	-- Inputs (binary)
FILE exo_file : TEXT open read_mode is  	"ALEY_RCA_2B_output.txt";   	-- Expected output (binary)
FILE out_file : TEXT open  write_mode is  	"ALEY_RCA_dataout.txt";
FILE xout_file : TEXT open  write_mode is 	"ALEY_RCA_TestOut.txt";
FILE hex_out_file : TEXT open  write_mode is "ALEY_RCA_hex_out.txt";

---------------------------------------------------------------
-- SIGNALS 
---------------------------------------------------------------
  SIGNAL OP_A: STD_LOGIC_VECTOR(W-1 downto 0):= (OTHERS=>'X');
  SIGNAL OP_B: STD_LOGIC_VECTOR(W-1 downto 0):= (OTHERS=>'X');

  SIGNAL CLK: STD_LOGIC;
  SIGNAL reset: STD_LOGIC;
  SIGNAL en: STD_LOGIC;

  SIGNAL Sum_Q: STD_LOGIC_VECTOR(W-1 downto 0):= (OTHERS=>'X');
  SIGNAL Exp_Sum_Q : STD_LOGIC_VECTOR(W-1 downto 0):= (OTHERS=>'X');
  SIGNAL Carry_Q: std_logic:= 'X';
  SIGNAL Exp_Carry_Q: std_logic:= 'X';

  SIGNAL Test_OutS : STD_LOGIC:= 'X';
  SIGNAL LineNumber: integer:=0;

---------------------------------------------------------------
-- BEGIN 
---------------------------------------------------------------

BEGIN

---------------------------------------------------------------
-- Instantiate Components 
---------------------------------------------------------------


U0: CLOCK port map (CLK );
InstALEY_RCA_2B: ALEY_RCA_2B generic map (W,BITS2) port map (clk, reset, en, Op_A, Op_B, Sum_Q, Carry_Q);

---------------------------------------------------------------
-- PROCESS 
---------------------------------------------------------------
PROCESS

variable in_line, exo_line, out_line, xout_line : LINE;
variable comment, xcomment : string(1 to 128);
variable i : integer range 1 to 128;
variable simcomplete : boolean;

variable vreset: std_logic:='X';
variable ven: std_logic:='X';

variable vOp_A   : std_logic_vector(W-1 downto 0):= (OTHERS => 'X');
variable vOp_B   : std_logic_vector(W-1 downto 0):= (OTHERS => 'X');

variable vSum_Q : std_logic_vector(W-1 downto 0):= (OTHERS => 'X');
variable vCarry_Q : std_logic:= 'X';

variable vExp_Sum_Q : std_logic_vector(W-1 downto 0):= (OTHERS => 'X');
variable vExp_Carry_Q : std_logic:= 'X';

variable vTest_OutS : std_logic:= 'X';

variable vlinenumber: integer;

BEGIN

simcomplete := false;

while (not simcomplete) LOOP
  
	if (not endfile(in_file) ) then
		readline(in_file, in_line);
	else
		simcomplete := true;
	end if;

	if (not endfile(exo_file) ) then
		readline(exo_file, exo_line);
	else
		simcomplete := true;
	end if;
	
	if (in_line(1) = '-') then  --Skip comments
		next;
	elsif (in_line(1) = '.')  then  --exit Loop
	  Test_OutS <= 'Z';
		simcomplete := true;
	elsif (in_line(1) = '#') then        --Echo comments to out.txt
	  i := 1;
	  while in_line(i) /= '.' LOOP
		comment(i) := in_line(i);
		i := i + 1;
	  end LOOP;

	elsif (exo_line(1) = '-') then  --Skip comments
		next;
	elsif (exo_line(1) = '.')  then  --exit Loop
	  	  Test_OutS  <= 'Z';
		   simcomplete := true;
	elsif (exo_line(1) = '#') then        --Echo comments to out.txt
	     i := 1;
	   while exo_line(i) /= '.' LOOP
		 xcomment(i) := exo_line(i);
		 i := i + 1;
	   end LOOP;

	
	  write(out_line, comment);
	  writeline(out_file, out_line);
	  
	  write(xout_line, xcomment);
	  writeline(xout_file, xout_line);

	  
	ELSE      --Begin processing

		read(in_line, vreset );
		reset  <= vreset;
		read(in_line, ven );
		en  <= ven;

		read(in_line, vOp_A );
		Op_A  <= vOp_A;

		read(in_line, vOp_B );
		Op_B  <= vOp_B;
	
		read(exo_line, vexp_Sum_Q );
		exp_Sum_Q  <= vexp_Sum_Q;

		read(exo_line, vexp_Carry_Q );
		exp_Carry_Q  <= vexp_Carry_Q;

    vlinenumber :=LineNumber;
    
    write(out_line, vlinenumber);
    write(out_line, STRING'("."));
    write(out_line, STRING'("    "));

	

    CYCLE(1,CLK);
   
      
    if (Exp_Sum_Q = Sum_Q) then
      Test_OutS <= '0';
    else
      Test_OutS <= 'X';
    end if;

          		
		write(out_line, vSum_Q, left, 32);
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab

		write(out_line,vTest_OutS, left, 5);                           --ht is ascii for horizontal tab
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		write(out_line, vexp_Sum_Q, left, 32);
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		writeline(out_file, out_line);
		print(xout_file,    str(LineNumber)& "." & "    " &    str(Sum_Q) & "       " &   str(Exp_Sum_Q)  & "     " & str(Test_OutS));
	
	END IF;
	LineNumber<= LineNumber+1;

	END LOOP;
	WAIT;
	
	END PROCESS;

END TESTBENCH;

---------------------------------------------------------------
-- Configurations
---------------------------------------------------------------

CONFIGURATION cfg_tb_ALEY_RCA_2B OF tb_ALEY_RCA_2B IS
	FOR TESTBENCH
		FOR InstALEY_RCA_2B: ALEY_RCA_2B
			 use entity work.ALEY_RCA_2B;		
		END FOR;
	END FOR;
END;
