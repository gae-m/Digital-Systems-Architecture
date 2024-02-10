library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa is
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
end unita_operativa;

architecture Structural of unita_operativa is

signal secU : std_logic_vector(5 downto 0);
signal minU : std_logic_vector(5 downto 0);
signal oreU : std_logic_vector(5 downto 0);

signal secondi : std_logic_vector(7 downto 0); -- secondi, primi 4 bit unita secondi 4 bit decine 
signal minuti : std_logic_vector(7 downto 0); -- minuti, primi 4 bit unita secondi 4 bit decine 
signal ore : std_logic_vector(7 downto 0); -- ore, primi 4 bit unita secondi 4 bit decine 

signal mux_to_mem : std_logic_vector(2 downto 0); --possono essere memorizzati massimo 8 intertempi
signal orario : std_logic_vector(23 downto 0);

signal contS_to_mux : std_logic_vector(2 downto 0); --con tre bit possono essere memorizzati massimo 8 intertempi
signal contV_to_mux : std_logic_vector(2 downto 0);

signal valore_memoria : std_logic_vector(23 downto 0);--4 bit unita secondi, 4 bit decine secondi, 4 bit unita minuti ...

begin
    oreU(5)<= '0';
    orario <= ore & minuti & secondi;
    
    cronometro: entity work.cronometro generic map(clk_B_factor => clk_B_factor)
                port map(
                clk => clk, rst => rst, 
                set => set, sec_in => sec_in, min_in => min_in, ore_in => ore_in,
                 sec_out => secU, min_out => minU, ore_out => oreU(4 downto 0)); 
    convertitore_s: entity work.convertitore_BCD port map(
                 x => secU, y => secondi);
                 
    convertitore_m: entity work.convertitore_BCD port map(
                 x => minU, y => minuti);
                 
    convertitore_o: entity work.convertitore_BCD port map(
                 x => oreU, y => ore);
                 
                 
    memoria: entity work.memory generic map(nbits_addr => 3, width => 24)
            port map(
            addr => mux_to_mem, en => en, clk => clk, rst => rst, data_in => orario, r_w => r_w, data_out => valore_memoria 
            );
    contatore_salva: entity work.counter generic map(bits => 3, divider => 8)
                    port map(x => incr_s, rst => rst, y => contS_to_mux);
                    
    contatore_visualizza: entity work.counter generic map(bits => 3, divider => 8)
                    port map(x => incr_v, rst => rst, y => contV_to_mux);
   
   mux_adress: entity work.mux2to1 generic map(N => 3)
               port map(
                x1 => contS_to_mux, x2 => contV_to_mux, s => r_w, y => mux_to_mem);

    mux_display: entity work.mux2to1 generic map(N => 24)
               port map(
                x1 => orario, x2 => valore_memoria, s => r_w, y => uscita_visore);                                          
end Structural;
