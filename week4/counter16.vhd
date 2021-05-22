library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity counter16 is
	port(
		nRst  : in std_logic;
		clk	: in std_logic;
		q		: out std_logic_vector (3 downto 0)
	);
end counter16;

architecture BEH of counter16 is 
	signal cnt : std_logic_vector(3 downto 0);

begin
	process(nRst, clk)
	begin
		if(nRst = '0') then
			cnt <= (others => '0');
		elsif rising_edge(clk) then
			cnt <= cnt + 1;
		end if;
		
	end process;
	
	q <= cnt;

	end BEH;