library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometro_sys is 
           Generic ( clk_B_factor : positive);
           Port(
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           salva_b : in STD_LOGIC;
           visualizza_b : in STD_LOGIC;
           mode : in STD_LOGIC;
           set_b : in STD_LOGIC;
           sec_in : in STD_LOGIC_VECTOR(5 downto 0);
           min_in : in STD_LOGIC_VECTOR(5 downto 0);
           ore_in : in STD_LOGIC_VECTOR(4 downto 0);
           ingresso_visore : out STD_LOGIC_VECTOR(31 downto 0));
end cronometro_sys;

architecture Structural of cronometro_sys is

component unita_controllo is
    Port ( mode : in STD_LOGIC; --switch
           salva_b : in STD_LOGIC; --salva -> 0 , visualizza -> 1, button
           visualizza_b : in STD_LOGIC; --button per la visualizzazione
           set_b : in STD_LOGIC;
           rst : in STD_LOGIC; --button reset
           clk : in STD_LOGIC;
           set_cronometro : out STD_LOGIC;
           en : out STD_LOGIC;
           r_w : out STD_LOGIC;
           incr_s : out STD_LOGIC;
           incr_v : out STD_LOGIC;
           rst_dp : out STD_LOGIC);
end component;

component unita_operativa is
    generic ( clk_B_factor : positive);
    Port ( 
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           set : in STD_LOGIC;
           sec_in : in STD_LOGIC_VECTOR(5 downto 0);
           min_in : in STD_LOGIC_VECTOR(5 downto 0);
           ore_in : in STD_LOGIC_VECTOR(4 downto 0);
           en : in STD_LOGIC;
           r_w : in STD_LOGIC;
           incr_v : in STD_LOGIC;
           incr_s : in STD_LOGIC;
           uscita_visore : out STD_LOGIC_VECTOR(23 downto 0));--da dare in ingresso al display
end component;

signal set_cronometro : STD_LOGIC;
signal en : STD_LOGIC;
signal r_w : STD_LOGIC;
signal incr_s : STD_LOGIC;
signal incr_v : STD_LOGIC;
signal rst_dp : STD_LOGIC;

begin

ingresso_visore(31 downto 24) <= "00000000";

    UC: unita_controllo port map(
        mode => mode, salva_b => salva_b, visualizza_b => visualizza_b, set_b => set_b,
        rst => rst, clk => clk, 
        set_cronometro => set_cronometro, en => en, r_w => r_w, incr_s => incr_s, incr_v => incr_v, rst_dp => rst_dp
        );
        
    UO: unita_operativa generic map ( clk_B_factor => clk_B_factor)
        port map(
        rst => rst_dp, clk => clk, 
        set => set_cronometro, sec_in => sec_in, min_in => min_in, ore_in => ore_in,
        en => en, r_w => mode, incr_v => incr_v, incr_s => incr_s, uscita_visore => ingresso_visore(23 downto 0)
        );

end Structural;
