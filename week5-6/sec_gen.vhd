library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

entity sec_gen is
	port(
		nRst, clk : in std_logic;
		sec_sig : out std_logic);
end sec_gen;

architecture BEH of sec_gen is
	signal cnt : std_logic_vector(31 downto 0);
	signal sig : std_logic;
	
begin
	sec_sig <= sig;
	process(nRst, clk)
	begin
		if (nRst = '0') then
			sig <= '0';
			cnt <=(others => '0');
		elsif rising_edge(clk) then
			if(cnt = 1) then
				cnt <=(others => '0');
				sig <= not sig;
			else
				cnt <= cnt + 1;
			end if;
		end if;
	end process;
end BEH;