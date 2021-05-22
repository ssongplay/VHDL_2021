library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;

entity digital_watch_vhd is
	port(
		nRst			: in std_logic;
		clk			: in std_logic; --50MHz
		key_sec		: in std_logic;
		key_min		: in std_logic;
		key_hr		: in std_logic;
		sel_sw		: in std_logic;
		fnd_sec_one : out std_logic_vector(6 downto 0);
		fnd_sec_ten : out std_logic_vector(6 downto 0);
		fnd_min_one : out std_logic_vector(6 downto 0);
		fnd_min_ten : out std_logic_vector(6 downto 0);
		fnd_hr_one 	: out std_logic_vector(6 downto 0);
		fnd_hr_ten 	: out std_logic_vector(6 downto 0);
	);
end digital_watch_vhd;

architecture beh of digital_watch_vhd is

	component sec_gen is
	port(
		nRst, clk : in std_logic;
		sec_sig : out std_logic);
	end component;
	
	component mux_2x1_1bit is
	port(
		A   : in std_logic;
		B   : in std_logic;
		SEL : in std_logic;
		Y   : out std_logic
	);
	end component;
	
	component fnd_decoder is
	port( 
		data 		: in std_logic_vector(3 downto 0);
		fnd_data : out std_logic_vector(6 downto 0)
		);
	end component;
	
	component counter60 is
	port(
		nRst  : in std_logic;
		clk	: in std_logic;
		digit_one	: out std_logic_vector (3 downto 0);
		digit_ten	: out std_logic_vector (3 downto 0);
		carry 		: out std_logic 
	);
	end component;
	
	signal sec_sig			: std_logic;
	signal sec_clk			: std_logic;
	signal min_clk			: std_logic;
	signal hr_clk			: std_logic;
	signal sec_carry		: std_logic;
	signal min_carry		: std_logic;
	signal sec_cnt_one	: std_logic_vector(3 downto 0);
	signal sec_cnt_ten	: std_logic_vector(3 downto 0);
	signal min_cnt_one	: std_logic_vector(3 downto 0);
	signal min_cnt_ten	: std_logic_vector(3 downto 0);
	signal hr_cnt_one	: std_logic_vector(3 downto 0);
	signal hr_cnt_ten	: std_logic_vector(3 downto 0);
	
	begin
	
		U_sec_gen : sec_gen
		port map(
			nRst => nRst, 
			clk  => clk,
			sec_sig => sec_sig
		);
		
		U_sec_mux c: mux_2x1_1bit
		port map()
		