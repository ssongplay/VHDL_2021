library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity mux_2x1_1bit is
	port(
		A   : in std_logic;
		B   : in std_logic;
		SEL : in std_logic;
		Y   : out std_logic
	);
end mux_2x1_1bit;

architecture beh of mux_2x1_1bit is
begin
	Y <= A when SEL = '0' else
		  B when SEL = '1' else
			'Z';
end beh;