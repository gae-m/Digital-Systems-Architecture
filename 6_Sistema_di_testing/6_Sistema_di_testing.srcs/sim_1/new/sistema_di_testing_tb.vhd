library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistema_di_testing_tb is
end sistema_di_testing_tb;

architecture Behavioral of sistema_di_testing_tb is

signal clk : STD_LOGIC;
signal rst : STD_LOGIC;
signal read : STD_LOGIC;
signal led : STD_LOGIC_VECTOR(2 downto 0);

begin

    uut : entity work.sistema_di_testing port map(
            clk => clk, rst => rst, read => read, led => led
            );
            
    clock_tb: process begin
        clk <= '1';
        wait for 10 ns;
        clk <='0';
        wait for 10 ns;
        end process;

    prc: process
     begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 20 ns;
        read<='1';
        wait for 500 ns;
        read<='0';
        wait;
     end process; 


end Behavioral;
