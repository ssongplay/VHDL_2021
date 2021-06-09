library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
entity program_memory is
	port(
		nRst 				: in std_logic;
		clk 				: in std_logic;
		address_bus 	: in std_logic_vector(15 downto 0);
							  -- program_counter의 출력으로부터 입력 
		data_bus 		: out std_logic_vector(7 downto 0)
							  -- 명령어 데이터를 출력하는 bus 
	);
end program_memory;

architecture BEH of program_memory is
	-- mem_array의 type 선언
	-- 연산 하나 당 5개의 명령어가 필요하므로 총 20개의 array
	-- array의 각 값은 8bit
	type mem_array is array(0 to 19) of std_logic_vector(7 downto 0);
	
	-- mem을 signal로 선언 
	signal mem : mem_array;

begin
	process(nRst, clk, address_bus)
		-- index를 variable로 선언
		variable index : integer range 0 to 19 := 0;
	begin
		if(nRst = '0') then
			------------------ADD 연산-------------------
			mem(0)  <= "01000000";		-- LD R1		 0x40
			mem(1)  <= "00001010";		-- Data 10   0x0A
			mem(2)  <= "01010000";		-- LD R2		 0x50
			mem(3)  <= "00000101";		-- Data 5	 0x05
			mem(4)  <= "11000000";		-- ADD       0xC0
			------------------SUB 연산-------------------
			mem(5)  <= "01000000";		-- LD R1		 0x40
			mem(6)  <= "00001101";		-- Data 13   0x0D
			mem(7)  <= "01010000";		-- LD R2		 0x50
			mem(8)  <= "00001010";		-- Data 10   0x0A
			mem(9)  <= "11000001";		-- SUB		 0xC1
			------------------AND 연산-------------------
			mem(10) <= "01000000";		-- LD R1		 0x40
			mem(11) <= "00001111";		-- Data 15   0x0F
			mem(12) <= "01010000";		-- LD R2		 0x50
			mem(13) <= "00000011";		-- Data 3    0x03
			mem(14) <= "11000010";		-- AND		 0xC2
			-------------------OR 연산-------------------
			mem(15) <= "01000000";		-- LD R1     0x40
			mem(16) <= "00000011";		-- Data 3    0x03
			mem(17) <= "01010000";		-- LD R2		 0x50
			mem(18) <= "00001100";		-- Data 12	 0x0C
			mem(19) <= "11000011";     -- OR		    0xC3
			
		elsif rising_edge(clk) then
		--clk가 rising_edge일 때, data_bus에 mem(index)출력
		--이때 index의 값은 address_bus의 하위 5개 비트 값을 integer로 바꾼 값
			index := conv_integer(address_bus(4 downto 0));
			data_bus <= mem(index);
		end if;
	end process;
end BEH;