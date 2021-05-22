library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity ADC_controller is
	port(
		nRst : in  std_logic;
		clk  : in  std_logic;
		t    : in  std_logic;	--trigger
		dr   : in std_logic;   --data ready
		sc   : out std_logic;   --start conversion
		oe   : out std_logic    --output enable
	);
end ADC_controller;

architecture BEH of ADC_controller is
	type state_type is (IDLE, START, WAIT_CONV, DATA_READ);
	signal state : state_type;
begin
	process(nRst, clk)
	begin 
		-- nRst = '0'일 때에는 IDLE 
		if(nRst = '0') then
			state <= IDLE;
			sc    <= '0';
			oe    <= '0';
		elsif rising_edge(clk) then
			case state is 
				-- IDLE : trigger 를 기다림 
				when IDLE =>
					if(t = '1') then		-- t='1' 이면
						state <= START;	-- START로 넘어감
						sc    <= '1';		
						oe    <= '0';
					else 						-- t='0'이면 유지
						state <= IDLE;
						sc    <= '0';
						oe    <= '0';
					end if;
					
				-- START
				when START => 		
					state <= WAIT_CONV;	-- WAIT_CONV로 넘어감
					sc    <= '0';
					oe    <= '0';
				
				-- WAIT_CONV : data ready 기다림
				when WAIT_CONV =>
					if(dr = '1') then			-- dr='1'이면
						state <= DATA_READ;	-- DATA_READ로 넘어감 
						sc    <= '0';
						oe    <= '1';
					else							-- dr='0'이면 유지 
						state <= WAIT_CONV;
						sc    <= '0';
						oe    <= '0';
					end if;
				
				-- DATA_READ
				when DATA_READ =>
					state <= IDLE;
					sc    <= '0';
					oe    <= '0';
				
				-- others 일 때에는 IDLE
				when others =>
					state <= IDLE;
					
			end case;
		end if;
	end process;
end BEH;
						