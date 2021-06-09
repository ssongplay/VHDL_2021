library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity reg_Latch is
	port(
		clk 		: in std_logic;
		load 		: in std_logic;
		in_data  : in std_logic_vector(7 downto 0);
		q 			: out std_logic_vector(7 downto 0)
						-- MUX의 입력신호가 되는 출력
	);
end reg_Latch;

architecture BEH of reg_Latch is
	signal sig_q : std_logic_vector(7 downto 0);
	
begin
	process(load, clk)
	begin 
		-- load = '1' 구간에서 클럭의 하강에지일 때
		if falling_edge(clk) then
			if(load = '1') then
				sig_q <= in_data;   --in_data를 출력 q로 전달
			end if;
		end if;
	end process;
	q <= sig_q;
end BEH;
