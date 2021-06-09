library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

entity ALU is
	port(
		op : in  std_logic_vector(1 downto 0);
				--> 총 4개의 연산 결정
		A  : in  std_logic_vector(7 downto 0);
		B  : in  std_logic_vector(7 downto 0);
			   --> A, B : 연산 값 
		Q  : out std_logic_vector(7 downto 0)
				--> 연산 결과
	);
end ALU;

architecture BEH of ALU is
begin  
	-- op의 값에 따라 연산이 결정됨
	Q <=  A  +  B when (op = 0) else
		   A  -  B when (op = 1) else
			A and B when (op = 2) else
			A or  B when (op = 3) else
			(others => '0');
end BEH;
		  