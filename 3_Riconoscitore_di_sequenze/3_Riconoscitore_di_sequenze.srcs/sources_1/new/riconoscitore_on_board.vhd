library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity riconoscitore_on_board is
    Port ( switch_i : in STD_LOGIC;
           clk : in STD_LOGIC;
           switch_m : in STD_LOGIC;
           butt_i : in STD_LOGIC;
           butt_m : in STD_LOGIC;
           butt_rst : in STD_LOGIC;
           led_uscita : out STD_LOGIC;
           led_stato : out STD_LOGIC_VECTOR(3 downto 0));
end riconoscitore_on_board;

architecture Behavioral of riconoscitore_on_board is

signal cleared_i : std_logic;
signal cleared_m : std_logic;

begin
    butt1_i: entity work.button_debouncer generic map (
        clk_period => 10 , btn_noise_time => 650000000
        ) port map ( rst => butt_rst, clk => clk, btn => butt_i, cleared_btn => cleared_i);
        
    butt2_m: entity work.button_debouncer generic map (
        clk_period => 10 , btn_noise_time => 650000000
        ) port map ( rst => butt_rst, clk => clk, btn => butt_m, cleared_btn => cleared_m);
        
    automa1: entity work.riconoscitore port map(
        ingresso => switch_i, clk => clk, m => switch_m, 
        i_read => cleared_i, m_read => cleared_m, rst => butt_rst, 
        uscita => led_uscita, stato_out => led_stato);

end Behavioral;
