library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity DPRAM_8x8 is
	port(
		clk_l		: in std_logic;
		wrn		: in std_logic;
		waddr		: in std_logic_vector(2 downto 0);
		data_in  : in std_logic_vector(7 downto 0);
		clk_r		: in std_logic;
		rdn 		: in std_logic;
		raddr		: in std_logic_vector(2 downto 0);
		data_out : out std_logic_vector(7 downto 0)
	);
end DPRAM_8x8;

architecture BEH of DPRAM_8x8 is

	type    mem_tbl is array(0 to 7) of std_logic_vector(7 downto 0);
	signal  mem : mem_tbl;
	
begin
	
	write : process(clk_l)
		variable I_A : natural;
	begin
		I_A := conv_integer(waddr);
		if rising_edge(clk_l) then
			if(wrn = '0') then
				mem(I_A) <= data_in;
			end if;
		end if;
	end process;
	
	read : process(clk_r)
		variable I_A : natural;
	begin
		I_A := conv_integer(raddr);
		if falling_edge(clk_r) then
			if(rdn = '0') then
				data_out <= mem(I_A);
			else
				data_out <= (others => '0');
			end if;
		end if;
	end process;
	
end BEH;