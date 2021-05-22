library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;
   
entity ROM_4x8 is
   port(
      clk 		: in std_logic;
      en 		: in std_logic;
      address 	: in std_logic_vector(1 downto 0);
      data 		: out std_logic_vector(7 downto 0)
   );
end ROM_4x8;

architecture BEH of ROM_4x8 is
   type 		mem_array is array(0 to 3) of std_logic_vector(7 downto 0);
   signal 	mem : mem_array;
begin
   read : process(clk, address)
      variable index : integer range 0 to 3 := 0;
   begin
      mem(0) <= x"08";
      mem(1) <= x"04";
      mem(2) <= x"02";
      mem(3) <= x"01";
      index := conv_integer(address ( 1 downto 0));
      if(en = '1') then
         data <= (others => '0');
      elsif rising_edge(clk) then
         data <= mem(index);
      end if;
   end process;
end BEH;