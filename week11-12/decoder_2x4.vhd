library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity decoder_2x4 is
	port( 
		SEL : in std_logic_vector(1 downto 0);
		A 	 : out std_logic;
		B 	 : out std_logic;
		C 	 : out std_logic;
		D 	 : out std_logic
	);
end decoder_2x4;

architecture BEH of decoder_2x4 is
begin
	-- SEL 신호의 값에 따라 A,B,C,D중 하나가 '1'
	A <= '1' when SEL = 0 else '0';
	B <= '1' when SEL = 1 else '0';
	C <= '1' when SEL = 2 else '0';
	D <= '1' when SEL = 3 else '0';
end BEH;