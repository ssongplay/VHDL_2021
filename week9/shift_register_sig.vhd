library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_arith.all;
   use ieee.std_logic_unsigned.all;
   
entity shift_register_sig is
   port(
      clk   : in std_logic;
      din   : in std_logic;
      dout  : out std_logic
   );
end shift_register_sig;

architecture BEH of shift_register_sig is
   signal a,b,c : std_logic;
begin
   process(clk)
   begin
      if rising_edge(clk) then 
         a <= din;
         b <= a;
         c <= b;
         dout <= c;
      end if;
   end process;
end BEH;
