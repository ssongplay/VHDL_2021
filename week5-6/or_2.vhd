library ieee;
    use ieee.std_logic_1164.all;
	 use ieee.std_logic_arith.all;
	 use ieee.std_logic_unsigned.all;
	

entity or_2 is
	port(
		A : in std_logic;
		B : in std_logic;
		Y : out std_logic
	);
end or_2;

  
architecture dataflow of or_2 is
begin
	Y <= A or B;
end dataflow; 