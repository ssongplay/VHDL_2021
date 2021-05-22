library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity 1bit2x1mux_vhd is
	port(
		A   : in std_logic;
		B   : in std_logic;
		SEL : in std_logic;
		Y   : out std_logic
	);
end 1bit2x1mux_vhd;

architecture beh of 1bit2x1mux_vhd is
begin
	Y <= A when SEL = '0' else
		  B when SEL = '1' else
			'Z';
end beh;