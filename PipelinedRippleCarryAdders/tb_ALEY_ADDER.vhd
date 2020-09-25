
-- Copyright 2019 by Howard University All rights reserved.
--
-- Manual Testbench for: 
-- Design: Adv. Hierarchical Digital Design Lecture (696)
-- Name:   Hunter Bryant
--	
-- Date:   08/30/2019
--
-- Description: Test Bench for Adv. Hierarchical Digital Design Lecture
-- For Homework #1
--------------------------------------------------------------


LIBRARY IEEE;
USE work.CLOCKS.all;  		 -- Entity that uses CLOCKS
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_textio.all;
USE std.textio.all;
USE work.txt_util.all;

ENTITY tb_ALEY_ADDER IS
END;

ARCHITECTURE TESTBENCH OF tb_ALEY_ADDER IS


---------------------------------------------------------------
-- COMPONENTS -- Entity In/out Ports
---------------------------------------------------------------

COMPONENT ALEY_ADDER 			
	PORT(	inputA: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		inputB: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		cout: OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
		);
END COMPONENT;

COMPONENT CLOCK
	port(	CLK: out std_logic);
END COMPONENT;

---------------------------------------------------------------
-- Read/Write FILES
---------------------------------------------------------------


FILE in_file : TEXT open read_mode is 	"Bryant_24bit_input.txt";   	-- Inputs (binary)
FILE exo_file : TEXT open read_mode is  	"Bryant_24bit_output.txt";   	-- Expected output (binary)
FILE out_file : TEXT open  write_mode is  	"LANGFORD_DIRECTTREEDESCRIPTION_dataout.txt";
FILE xout_file : TEXT open  write_mode is 	"LANGFORD_DIRECTTREEDESCRIPTION_TestOut.txt";
FILE hex_out_file : TEXT open  write_mode is "LANGFORD_DIRECTTREEDESCRIPTION_hex_out.txt";

---------------------------------------------------------------
-- SIGNALS 
---------------------------------------------------------------

  SIGNAL inputA: STD_LOGIC_VECTOR(23 downto 0):= "XXXXXXXXXXXXXXXXXXXXXXXX";
  SIGNAL inputB: STD_LOGIC_VECTOR(23 downto 0):= "XXXXXXXXXXXXXXXXXXXXXXXX";
  SIGNAL CLK: STD_LOGIC;	
  SIGNAL cout : STD_LOGIC_VECTOR(23 downto 0);
  SIGNAL exp_out : STD_LOGIC_VECTOR(23 downto 0);
  SIGNAL Test_Out_Q : STD_LOGIC := 'X';
  SIGNAL LineNumber: integer:=0;

---------------------------------------------------------------
-- BEGIN 
---------------------------------------------------------------

BEGIN

---------------------------------------------------------------
-- Instantiate Components 
---------------------------------------------------------------


U0: CLOCK port map (CLK );
Inst_Bryant_adder: ALEY_ADDER port map (inputA,inputB, cout);

---------------------------------------------------------------
-- PROCESS 
---------------------------------------------------------------
PROCESS

variable in_line, exo_line, out_line, xout_line : LINE;
variable comment, xcomment : string(1 to 128);
variable i : integer range 1 to 128;
variable simcomplete : boolean;

variable v_inputA   : std_logic_vector(23 downto 0):= (OTHERS => 'X');
variable v_inputB   : std_logic_vector(23 downto 0):= (OTHERS => 'X');
variable v_cout : std_logic_vector(23 downto 0):= (OTHERS => 'X');
variable v_exp_out : std_logic_vector(23 downto 0):= (OTHERS => 'X');
variable vTest_Out_Q : std_logic := 'X';
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
	  Test_Out_Q <= 'Z';
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
	  	  Test_Out_Q  <= 'Z';
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


		read(in_line, v_inputA );
		inputA  <= v_inputA;

		read(in_line, v_inputB );
		inputB  <= v_inputB;

		read(exo_line, v_exp_out );
		
		
    vlinenumber :=LineNumber;
    
    write(out_line, vlinenumber);
    write(out_line, STRING'("."));
    write(out_line, STRING'("    "));

	

    CYCLE(1,CLK);
    
    exp_out      <= v_exp_out;
    
      
    if (exp_out = cout) then
      Test_Out_Q <= '0';
    else
      Test_Out_Q <= 'X';
    end if;

		v_cout 	:= cout;
		vTest_Out_Q:= Test_Out_Q;
          		
		write(out_line, v_cout, left, 32);
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		write(out_line,vTest_Out_Q, left, 5);                           --ht is ascii for horizontal tab
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		write(out_line, v_exp_out, left, 32);
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		writeline(out_file, out_line);
		print(xout_file,    str(LineNumber)& "." & "    " &    str(cout) & "          " &   str(exp_out)  & "          " & str(Test_Out_Q) );
	
	END IF;
	LineNumber<= LineNumber+1;

	END LOOP;
	WAIT;
	
	END PROCESS;

END TESTBENCH;

---------------------------------------------------------------
-- Configurations
---------------------------------------------------------------

CONFIGURATION cfg_tb_ALEY_ADDER OF tb_ALEY_ADDER IS
	FOR TESTBENCH
		FOR Inst_Bryant_adder: ALEY_ADDER
			 use entity work.ALEY_ADDER(direct);
		END FOR;
	END FOR;
END;
