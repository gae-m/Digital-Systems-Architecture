library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometro_on_board is
    Port ( clk : in STD_LOGIC;
           rst_b : in STD_LOGIC;
           salva_b : in STD_LOGIC;
           visualizza_b : in STD_LOGIC;
           mode_sw : in STD_LOGIC;
           set_b : in STD_LOGIC;
           min_in : in STD_LOGIC_VECTOR(5 downto 0);
           ore_in : in STD_LOGIC_VECTOR(4 downto 0);
           anodes : out STD_LOGIC_VECTOR(7 downto 0);
           cathodes : out STD_LOGIC_VECTOR(7 downto 0));
end cronometro_on_board;

architecture Structural of cronometro_on_board is

component cronometro_sys is
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
end component;

component display_7seg_manager is
    Port ( value : in STD_LOGIC_VECTOR (31 downto 0);
           dots : in STD_LOGIC_VECTOR (7 downto 0);
           digits_enable : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component button_debouncer is
    generic (                       
        clk_period : integer := 10;  -- periodo del clock
        btn_noise_time : integer := 650000000 -- stima della durata del transitorio del button
    );
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           cleared_btn : out STD_LOGIC);
end component;

signal set_cronometro : STD_LOGIC;
signal en : STD_LOGIC;
signal r_w : STD_LOGIC;
signal incr_s : STD_LOGIC;
signal incr_v : STD_LOGIC;
signal rst_dp : STD_LOGIC;

signal ingresso_visore : STD_LOGIC_VECTOR(31 downto 0);

signal cleared_salva : STD_LOGIC;
signal cleared_visualizza : STD_LOGIC;
signal cleared_set : STD_LOGIC;


begin
    
    sys: cronometro_sys generic map( clk_B_factor => 100000000)
        port map(
        clk => clk, rst => rst_b, salva_b => cleared_salva, visualizza_b => cleared_visualizza,
        mode => mode_sw, set_b => cleared_set, 
        sec_in => "000000", min_in => min_in, ore_in => ore_in, ingresso_visore => ingresso_visore
        );
     
        
    display: display_7seg_manager port map ( 
            value => ingresso_visore, dots => "00010100", digits_enable => "00111111",
            clk => clk, rst => rst_b, cathodes => cathodes, anodes => anodes);
    
    button_salva : button_debouncer generic map(
        CLK_period=>10, btn_noise_time=>325000000)
        port map(
        rst=> rst_b, clk=>clk, btn=>salva_b, cleared_btn=>cleared_salva);
        
    button_visualizza : button_debouncer generic map(
    CLK_period=>10, btn_noise_time=>325000000)
    port map(
    rst=> rst_b, clk=>clk, btn=>visualizza_b, cleared_btn=>cleared_visualizza);
    
    
    button_set : button_debouncer generic map(
        CLK_period=>10, btn_noise_time=>325000000)
        port map(
        rst=> rst_b, clk=>clk, btn=>set_b, cleared_btn=>cleared_set);
        
   

end Structural;
