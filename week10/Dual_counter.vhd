library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity Dual_counter is 
	port(
		nRst  : in std_logic;
		clk   : in std_logic;
		sw_a  : in std_logic;
		sw_b  : in std_logic;
		count : out std_logic_vector(3 downto 0)
	);
end Dual_counter;

architecture state_machine of Dual_counter is
	type state_type is (IDLE, STATE_A, STATE_B);
	signal state : state_type;
	signal cnt   : std_logic_vector(3 downto 0);
begin
	process(nRst, clk)
	begin
		if(nRst = '0') then
			state <= IDLE;
			cnt   <= (others => '0');
		elsif rising_edge(clk) then
			case state is 
				when IDLE => 
					if(sw_a = '1') then
						state <= STATE_A;
					elsif(sw_b = '1') then
						state <= STATE_B;
					else	
						state <= IDLE;
					end if;
					cnt <= (others => '0');
				when STATE_A =>
					if(cnt = 9) then
						cnt   <= (others => '0');
						state <= IDLE;
					else 
						cnt   <= cnt + 1;
						state <= STATE_A;
					end if;
				when STATE_B => 
					if(cnt = 15) then
						cnt   <= (others => '0');
						state <= IDLE;
					else 
						cnt   <= cnt + 1;
						state <= STATE_B;
					end if;
				when others =>
					state <= IDLE;
			end case;
		end if;
	end process;
	count <= cnt;			
end state_machine;