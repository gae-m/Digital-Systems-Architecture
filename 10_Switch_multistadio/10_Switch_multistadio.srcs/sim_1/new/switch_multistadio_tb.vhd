library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_multistadio_tb is
end switch_multistadio_tb;

architecture Behavioral of switch_multistadio_tb is

signal x0 : STD_LOGIC_VECTOR(5 downto 0);
signal x1 : STD_LOGIC_VECTOR(5 downto 0);
signal x2 : STD_LOGIC_VECTOR(5 downto 0);
signal x3 : STD_LOGIC_VECTOR(5 downto 0);
signal s0 : STD_LOGIC;
signal s1 : STD_LOGIC;
signal s2 : STD_LOGIC;
signal s3 : STD_LOGIC;
signal out0 : STD_LOGIC_VECTOR(1 downto 0);
signal out1 : STD_LOGIC_VECTOR(1 downto 0);
signal out2 : STD_LOGIC_VECTOR(1 downto 0);
signal out3 : STD_LOGIC_VECTOR(1 downto 0);
           
begin
    
    uut: entity work.switch_multistadio port map(
        x0 => x0, x1 => x1, x2 => x2, x3 => x3, 
        s0 => s0, s1 => s1, s2 => s2, s3 => s3,
        out0 => out0, out1 => out1, out2 => out2, out3 => out3);
        
        
    prc_tb: process begin
        x0 <= "11" & "10" & "00"; -- || 2 bit messaggio | 2 bit destinazione | 2 bit sorgente ||
        x1 <= "10" & "00" & "01";
        x2 <= "01" & "11" & "10";
        x3 <= "10" & "01" & "11";
        
        
        s0 <= '1';
        s1 <= '1';
        s2 <= '1';
        s3 <= '1';
        wait for 20 ns;
        
        s3 <= '0';
        wait for 20 ns;
        s2 <= '0';
        wait for 20 ns;
        s1 <= '0';
        wait;
    end process;

end Behavioral;
