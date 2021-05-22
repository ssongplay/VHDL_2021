library ieee;
    use ieee.std_logic_1164.all;
	 use ieee.std_logic_arith.all;
	 use ieee.std_logic_unsigned.all;
	

entity nor_gate_vhd is
	port(
		A : in std_logic;
		B : in std_logic;
		Y : out std_logic
	);
end nor_gate_vhd;

  
architecture dataflow of nor_gate_vhd is
begin
	Y <= A nor B;
end dataflow; 