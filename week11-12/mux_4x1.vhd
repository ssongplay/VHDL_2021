library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

entity mux_4x1 is
	port(
		SEL 	 : in std_logic_vector(1 downto 0);
		reg1 	 : in std_logic_vector(7 downto 0);
		reg2 	 : in std_logic_vector(7 downto 0);
		reg3 	 : in std_logic_vector(7 downto 0);
		reg4 	 : in std_logic_vector(7 downto 0);
		Q		 : out std_logic_vector(7 downto 0)
					--> ALU의 입력이 되는 출력 
	);
end mux_4x1;

architecture BEH of mux_4x1 is
begin
	-- SEL의 값에 따라 Q 값이 다르게 출력
	Q <= reg1 when SEL = 0 else
		  reg2 when SEL = 1 else
		  reg3 when SEL = 2 else
		  reg4 when SEL = 3 else
		  (others => '0');
end BEH;
