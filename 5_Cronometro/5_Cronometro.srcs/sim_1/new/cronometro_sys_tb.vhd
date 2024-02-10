library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity cronometro_sys_tb is
end cronometro_sys_tb;

architecture Behavioral of cronometro_sys_tb is
signal clk : std_logic;
signal rst : std_logic;
signal salva_b : STD_LOGIC;
signal visualizza_b : STD_LOGIC;
signal mode : STD_LOGIC;
signal set_b : STD_LOGIC;
signal sec_in : STD_LOGIC_VECTOR(5 downto 0);
signal min_in : STD_LOGIC_VECTOR(5 downto 0);
signal ore_in : STD_LOGIC_VECTOR(4 downto 0);
signal ingresso_visore : STD_LOGIC_VECTOR(31 downto 0);

begin
    uut: entity work.cronometro_sys generic map( clk_B_factor => 2)
        port map(
        clk => clk, rst => rst, salva_b => salva_b, visualizza_b => visualizza_b,
        mode => mode, set_b => set_b, 
        sec_in => sec_in, min_in => min_in, ore_in => ore_in, ingresso_visore => ingresso_visore
        );

    clock_tb: process begin
        clk <= '1';
        wait for 10 ps;
        clk <='0';
        wait for 10 ps;
        end process;

    prc_tb: process begin
        rst <= '1';
        
        mode <= '0';
        set_b <= '0';
        visualizza_b <= '0';
        salva_b <= '0';
        
        sec_in <= "100110";
        min_in <= "001000";
        ore_in <= "00001";
        wait for 10ps;
        rst <= '0';
        wait for 20ps;
        set_b <= '1';
        wait for 20ps;
        set_b <= '0';
        wait for 40ps;
        salva_b <= '1';
        wait for 20ps;
        salva_b <= '0';
        wait for 40ps;


        
        mode <= '1';
        wait for 40 ps;
        visualizza_b <= '1';
        wait for 20ps;
        visualizza_b <= '0';
        
        wait;
        
        end process;

end Behavioral;
