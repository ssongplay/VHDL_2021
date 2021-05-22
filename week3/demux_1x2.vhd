library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity DEMUX_1x2 is
	port(
	A : in std_logic;
	SEL : in std_logic;
	Y1 : out std_logic;
	Y2 : out std_logic
	);
end DEMUX_1x2;

architecture beh of DEMUX_1x2 is
begin 
	Y1 <= A when SEL = '0' else '0';
	Y2 <= A when SEL = '1' else '0';
end beh;