library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistema_di_testing_on_board is
    Port ( clk : in STD_LOGIC;
           rst_b : in STD_LOGIC;
           read_b : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(2 downto 0));
end sistema_di_testing_on_board;

architecture Structural of sistema_di_testing_on_board is

signal cleared_read : STD_LOGIC;

begin

    sistema_testing : entity work.sistema_di_testing port map(
            clk => clk, rst => rst_b, read => cleared_read, led => led
            );
            
    button_read : entity work.button_debouncer generic map (
        clk_period => 10, btn_noise_time => 650000000)
        port map ( rst => rst_b, clk => clk, btn => read_b, cleared_btn => cleared_read);

end Structural;
