library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity CrossWalk_controller is 
	port(
		nRst  : in std_logic;
		clk   : in std_logic;
		
		M_G : out std_logic;		-- MAN_GREEN  (사람 초록불)
		M_R : out std_logic;		-- MAN_RED    (사람 빨간불)
		
		C_G : out std_logic;		-- CAR_GREEN  (차 초록불)
		C_Y : out std_logic;		-- CAR_YELLOW (차 노란불)
		C_R : out std_logic;		-- CAR_RED    (차 빨간불)
		
		count : out std_logic_vector(5 downto 0)
	);
end CrossWalk_controller;

architecture state_machine of CrossWalk_controller is
	type state_type is (MAN_GO, MAN_STOP, CAR_GO, CAR_STOP);
	signal state : state_type;
	signal cnt   : std_logic_vector(5 downto 0);
	
begin
	process(nRst, clk)
	begin
		-- 초기상태 : MAN_GO , cnt=0
		if(nRst = '0') then
			state <= MAN_GO;
			cnt   <= (others => '0');
		elsif rising_edge(clk) then
			case state is 
			
				-- 사람 통행 30초 
				when MAN_GO => 
					if(cnt = 29) then					-- cnt=29 (30초)가 되면 
						state <= MAN_STOP;			-- MAN_STOP 으로 넘어가고 
						cnt <= (others => '0');		-- cnt 초기화 
					else									-- 30초가 지나지 않았을 때 
						state <= MAN_GO;				-- MAN_GO state 유지하고 
						cnt   <= cnt + 1;				-- cnt 1 증가
					end if;
					
					
				-- 사람 통행 30초 후 점멸 10초 
				when MAN_STOP =>						
					if(cnt = 9) then					-- cnt=9 (10초)가 되면
						state <= CAR_GO;				-- CAR_GO 로 넘어가고  
						cnt <= (others => '0');		-- cnt 초기화 
					else									-- 10초가 지나지 않았을 때 
						state <= MAN_STOP;			-- MAN_STOP state 유지하고 
						cnt   <= cnt + 1;				-- cnt 1 증가 
					end if;
					
				
				-- 차량 통행 60초 
				when CAR_GO => 
					if(cnt = 59) then					-- cnt=59 (60초)가 되면 
						state <= CAR_STOP;			-- CAR_STOP 으로 넘어가고 
						cnt <= (others => '0');		-- cnt 초기화 
					else 									-- 60초가 지나지 않았을 때 
						state <= CAR_GO;				-- CAR_GO state 유지하고 
						cnt   <= cnt + 1;				-- cnt 1 증가 
					end if;
					
				
				-- 차량 통행 60초 후 황색등 5초 
				when CAR_STOP =>
					if(cnt = 4) then					-- cnt=4 (5초)가 되면 
						state <= MAN_GO;				-- MAN_GO로 넘어가고 
						cnt <= (others => '0');		-- cnt 초기화 
					else									-- 5초가 지나지 않았을 때 
						state <= CAR_STOP;			-- CAR_STOP state 유지하고 
						cnt   <= cnt + 1;				-- cnt 1 증가 
					end if;
				
				-- others 
				when others =>
					state <= MAN_GO; 					-- others일 땐 MAN_GO 
					
			end case;
		end if;
	end process;
	
	count <= cnt;
	
	M_G <= '1' when state = MAN_GO   else		--MAN_GO 일 때 MAN_GREEN ON
			 clk when state = MAN_STOP else		--MAN_STOP일 때 MAN_GREEN 10초 BLINK
			 '0';											--나머지 경우 MAN_GREEN OFF		 
	M_R <= '1' when state = CAR_GO or state = CAR_STOP 	else '0';
	C_G <= '1' when state = CAR_GO 								else '0';
	C_Y <= '1' when state = CAR_STOP 							else '0';
	C_R <= '1' when state = MAN_GO or state = MAN_STOP 	else '0';

end state_machine;