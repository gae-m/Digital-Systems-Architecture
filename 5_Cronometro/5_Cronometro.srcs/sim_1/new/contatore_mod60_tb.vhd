library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contatore_mod60_tb is
end contatore_mod60_tb;

architecture Behavioral of contatore_mod60_tb is
    component contatore_mod60 is
        port(clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR(5 downto 0);
           div : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR(5 downto 0));
    end component;
    
signal clk : STD_LOGIC;
signal rst : STD_LOGIC;
signal load : STD_LOGIC;
signal data : STD_LOGIC_VECTOR(5 downto 0);
signal div : STD_LOGIC;
signal y : STD_LOGIC_VECTOR(5 downto 0);
    
begin
    uut: contatore_mod60 port map ( 
         clk => clk,
        rst => rst,
        load => load,
        data => data,
        div => div,
        y => y);
    
    clock_tb: process begin
        wait for 2 ns;
        clk <= '1';
        wait for 2 ns;
        clk <='0';
        end process;
        
     prc: process
     begin
     wait for 1 ns;
     -- resetto il cronometro a 00:00:00
     rst <= '1';
     data <= "000111";
     load <= '0';
     wait for 1 ns;
     rst <= '0';
     wait for 10 ns;
     load <= '1';
     wait for 5 ns;
     load <= '0';
     -- setto l'ora iniziale a 10:59:40
     wait;
     end process;

end Behavioral;
