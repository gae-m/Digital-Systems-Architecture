library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa_tb is
end unita_operativa_tb;

architecture Behavioral of unita_operativa_tb is

signal m0 : STD_LOGIC_VECTOR(1 downto 0);
signal m1 : STD_LOGIC_VECTOR(1 downto 0);
signal m2 : STD_LOGIC_VECTOR(1 downto 0);
signal m3 : STD_LOGIC_VECTOR(1 downto 0);
signal s : STD_LOGIC_VECTOR(1 downto 0);
signal d : STD_LOGIC_VECTOR(1 downto 0);
signal out0 : STD_LOGIC_VECTOR(1 downto 0);
signal out1 : STD_LOGIC_VECTOR(1 downto 0);
signal out2 : STD_LOGIC_VECTOR(1 downto 0);
signal out3 : STD_LOGIC_VECTOR(1 downto 0);

begin

    uut: entity work.unita_operativa port map(
        m0 => m0, m1 => m1, m2 => m2, m3 => m3,
        s => s, d => d, out0 => out0, out1 => out1, out2 => out2, out3 => out3
    );
    
    prc_tb: process begin
    m0 <= "11";
    m1 <= "10";
    m2 <= "01";
    m3 <= "10";
    
    s <= "00";
    d <= "10";
    wait for 20 ns;
    s <= "01";
    d <= "00";
    
    wait for 20 ns;
    s <= "10";
    d <= "11";
    
    wait for 20 ns;
    s <= "11";
    d <= "01";
    wait;
    
    
    end process;

end Behavioral;
