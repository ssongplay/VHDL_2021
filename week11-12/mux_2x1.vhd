library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

entity mux_2x1 is
	port(
		SEL : in std_logic;
		A 	 : in std_logic_vector(7 downto 0);
				--> program_memory의 data_bus
		B 	 : in std_logic_vector(7 downto 0);
				--> ALU의 Q값
		Q	 : out std_logic_vector(7 downto 0)
				--> reg_Latch의 in_data가 되는 출력 
	);
end mux_2x1;

architecture BEH of mux_2x1 is
begin
	-- SEL의 값에 따라 Q 값이 다르게 출력
	Q <= A when SEL = '0' else
		  B when SEL = '1' else
		  (others => '0');
end BEH;
