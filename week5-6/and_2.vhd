library ieee;
    use ieee.std_logic_1164.all;
	 use ieee.std_logic_arith.all;
	 use ieee.std_logic_unsigned.all;
	 
entity and_2 is
	port(
		A : in std_logic;
		B : in std_logic;
		Y : out std_logic
	);
	
end and_2;

architecture dataflow of and_2 is
begin
	Y <= A and B;
	-- Y <= '1' when A = '1' and B = '1' else '0';
end dataflow;
