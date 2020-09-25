library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALEY_ADDER is
	port
	(
		inputA : in std_logic_vector(23 downto 0);
		inputB : in std_logic_vector(23 downto 0);
		cout : out std_logic_vector(23 downto 0)
	);
end ALEY_ADDER;

architecture direct of ALEY_ADDER is

begin
	cout <= inputA + inputB;

end direct;
