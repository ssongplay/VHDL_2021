library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity counter12 is
	port(
		nRst  : in std_logic;
		clk	: in std_logic;
		digit_one	: out std_logic_vector (3 downto 0);
		digit_ten	: out std_logic_vector (3 downto 0)
	);
end counter12;

architecture BEH of counter12 is 
	signal cnt_one : std_logic_vector(3 downto 0);
	signal cnt_ten : std_logic_vector(3 downto 0);

begin
	process(nRst, clk)
	begin
		if(nRst = '0') then
			cnt_one <= "0010";
			cnt_ten <= "0001";
			
		elsif clk'event and clk = '1' then
			if(cnt_one = 9) then
				cnt_one <= "0000";
            cnt_ten <= cnt_ten + 1;
         else
            cnt_one <= cnt_one + 1;
         end if;
			
         if(cnt_one = 2 and cnt_ten = 1) then
            cnt_one <= "0001";
            cnt_ten <= "0000";
         end if;
		end if;
	end process;
	digit_one <= cnt_one;
	digit_ten <= cnt_ten;
end BEH; 