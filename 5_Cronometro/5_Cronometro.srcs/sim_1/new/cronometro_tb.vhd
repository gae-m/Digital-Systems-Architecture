library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometro_tb is
end cronometro_tb;

architecture Behavioral of cronometro_tb is
    component cronometro is
    port(clk, rst, set : in std_logic;
        sec_in : in std_logic_vector(5 downto 0);
        min_in : in std_logic_vector(5 downto 0);
        ore_in : in std_logic_vector(4 downto 0);
        
        sec_out : out std_logic_vector(5 downto 0);
        min_out : out std_logic_vector(5 downto 0);
        ore_out : out std_logic_vector(4 downto 0)
    );
    end component;
    
signal clk, rst, set : std_logic;
signal sec_in : std_logic_vector(5 downto 0);
signal min_in : std_logic_vector(5 downto 0);
signal ore_in : std_logic_vector(4 downto 0);
signal sec_out : std_logic_vector(5 downto 0);
signal min_out : std_logic_vector(5 downto 0);
signal ore_out : std_logic_vector(4 downto 0);

begin
    uut: cronometro port map ( 
        clk => clk,
        rst => rst,
        set => set,
        sec_in => sec_in,
        min_in => min_in,
        ore_in => ore_in,
        sec_out => sec_out,
        min_out => min_out,
        ore_out => ore_out
        );
    
    clock_tb: process begin
        clk <= '1';
        wait for 10 ps;
        clk <='0';
        wait for 10 ps;
        end process;
        
     prc: process
     begin
     rst <= '1';
     set <= '0';
     wait for 10 ps;
     rst <= '0';
     wait for 100 ns;
     sec_in <= "111000";
     min_in <= "111011";
     ore_in <= "01110";
     wait for 15 ps;
     set <= '1';
     wait for 20 ps;
     set <= '0';
     wait for 200 ns;
     rst <= '1';
     wait for 20 ps;
     rst <= '0'; 
     wait;
     end process;

end Behavioral;
