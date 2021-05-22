library ieee;
 
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    
entity counter567 is
 
    port(
        nRst : in std_logic;
        clk  : in std_logic;
        q 	 : out std_logic_vector(2 downto 0)
 
    );
end counter567;
    
architecture BEH of counter567 is
    
    signal cnt : std_logic_vector(2 downto 0);
 
begin
    process(nRst, clk)
    begin
        if(nRst = '0') then
            cnt <= "101";
        elsif rising_edge(clk) then
            if(cnt = 7) then
                cnt <= "101";
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    
    q <= cnt;
    
end BEH;