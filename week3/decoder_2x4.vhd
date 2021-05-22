library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity decoder_2x4 is
	port(
		A0 : in std_logic;
		A1 : in std_logic;
		Y1 : out std_logic;
		Y2 : out std_logic;
		Y3 : out std_logic;
		Y4 : out std_logic
	);
end decoder_2x4;

architecture beh of decoder_2x4 is
begin
	Y1 <= '1' when A0 = '0' and A1 = '0' else '0';
	Y2 <= '1' when A0 = '1' and A1 = '0' else '0';
	Y3 <= '1' when A0 = '0' and A1 = '1' else '0';
	Y4 <= '1' when A0 = '1' and A1 = '1' else '0';
end beh;