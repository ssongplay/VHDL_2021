library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity mux_2x1_2bit is
	port(
		A   : in std_logic_vector(1 downto 0);
		B   : in std_logic_vector(1 downto 0);
		SEL : in std_logic;
		Y   : out std_logic_vector(1 downto 0)
	);
end mux_2x1_2bit;

architecture beh of mux_2x1_2bit is
begin
	Y <= A when SEL = '0' else
		  B when SEL = '1' else
			(others => 'Z');
end beh;