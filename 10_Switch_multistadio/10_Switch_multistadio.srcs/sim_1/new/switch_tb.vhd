library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_tb is

end switch_tb;

architecture Behavioral of switch_tb is
signal in0 : STD_LOGIC_VECTOR(1 downto 0);
signal in1 : STD_LOGIC_VECTOR(1 downto 0);
signal s : STD_LOGIC;
signal d : STD_LOGIC;
signal out0 : STD_LOGIC_VECTOR(1 downto 0);
signal out1 : STD_LOGIC_VECTOR(1 downto 0);

begin
    uut: entity work.switch port map(
        in0 => in0, in1 => in1, 
        s => s, d => d,
         out0 => out0, out1 => out1);
         
    prc_tb: process begin
        in0 <= "11";
        in1 <= "10";
        
        s <= '1';
        d <= '0';
        wait for 20 ns;
        s <= '0';
        wait for 20 ns;
        d <= '1';
        wait;
    end process;


end Behavioral;
