library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity IR_Decoder is
port(
	nRst		 : in std_logic;
	clk 		 : in std_logic;
	data_bus  : in std_logic_vector(7 downto 0);
	SELA 		 : out std_logic_vector(1 downto 0);
					--> 4x1 ALU_A_MUX의 SEL신호로 입력되는 출력
	SELB 		 : out std_logic_vector(1 downto 0);
					--> 4x1 ALU_B_MUX의 SEL신호로 입력되는 출력
	SELD 		 : out std_logic_vector(1 downto 0);
					--> 2x4 Decoder의 SEL신호로 입력되는 출력
	ALU_OP 	 : out std_logic_vector(1 downto 0);
					--> ALU 연산 결정 신호
	BUS_Sel	 : out std_logic
					--> 2x1 MUX의 sel이 되는 출력 
);
end IR_Decoder;

architecture BEH of IR_Decoder is
begin 
	process(nRst,clk)
	begin
		if(nRst = '0') then
		-- nRst = '0' 인 경우 모든 출력 Z 
			SELA 	   <= "ZZ";
			SELB  	<= "ZZ";
			SELD 	   <= "ZZ";
			ALU_OP   <= "ZZ";
			BUS_Sel  <= 'Z';
		elsif rising_edge(clk) then
			if (data_bus(7 downto 6)="01") then		--LD
				SELA 	   <= "ZZ";
				SELB  	<= "ZZ";
				ALU_OP   <= "ZZ";
				SELD 	   <= data_bus(5 downto 4); --레지스터 번호
				BUS_Sel  <= '0';  -- 2x1 MUX에 명령어 출력
			elsif (data_bus(7 downto 6) = "11") then	--ALU OP
				SELA 	   <= "00"; -- 4x1 ALU_A_MUX의 sel신호로 reg1 출력
				SELB  	<= "01"; -- 4x1 ALU_B_MUX의 sel신호로 reg2 출력
				SELD 	   <= data_bus(5 downto 4); -- 2x4 Decoder의 sel
				ALU_OP   <= data_bus(1 downto 0); 
				BUS_Sel  <= '1';
			else
				SELA 	   <= "ZZ";
				SELB  	<= "ZZ";
				SELD 	   <= "ZZ";
				ALU_OP   <= "ZZ";
				BUS_Sel  <= '0';   -- 충돌 방지
			end if;
		end if;
	end process;
end BEH;
