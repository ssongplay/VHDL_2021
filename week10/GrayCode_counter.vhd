library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity GrayCode_counter is 
	port(
		nRst  : in std_logic;
		clk   : in std_logic;
		q : out std_logic_vector(2 downto 0)
	);
end GrayCode_counter;

architecture state_machine of GrayCode_counter is
	type state_type is (zero, one, two, three, four, five, six, seven);
	signal state : state_type;
begin
	state_move : process(nRst, clk)
	begin
		if(nRst = '0') then
			state <= zero;
		elsif rising_edge(clk) then
			case state is 
				when zero => 
					state <= one;
				when one => 
					state <= two;
				when two =>
					state <= three;
				when three => 
					state <= four;
				when four => 
					state <= five;
				when five =>
					state <= six;
				when six =>
					state <= seven;
				when seven => 
					state <= zero;
				when others =>
					state <= zero;
			end case;
		end if;
	end process;
	
	q <= "000" when state = zero  else
		  "001" when state = one   else
		  "011" when state = two   else
		  "010" when state = three else
		  "110" when state = four  else
		  "111" when state = five  else
		  "101" when state = six   else
		  "100" when state = seven else
		  "000";
				
end state_machine;