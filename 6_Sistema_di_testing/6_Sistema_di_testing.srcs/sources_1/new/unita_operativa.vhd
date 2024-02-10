library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa is
    Port ( read : in STD_LOGIC;
           en : in STD_LOGIC;
           inc : in STD_LOGIC;
           rst_dp : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(2 downto 0));
end unita_operativa;

architecture Structural of unita_operativa is


signal cont_to_rom : std_logic_vector(2 downto 0);
signal rom_to_mc  : std_logic_vector(3 downto 0);
signal mc_to_mem : std_logic_vector(2 downto 0);


begin

    cont : entity work.counter generic map(
 bits => 3)
        port map(
        x => inc, rst=> rst_dp, y => cont_to_rom
        );
        
    rom : entity work.rom generic map(nbit_addr => 3,
		width => 4 )
        port map(
        addr => cont_to_rom, clk => clk, read => read, rst => rst_dp, data_out => rom_to_mc
        );
        
    m : entity work.macchina_combinatoria port map(
        x => rom_to_mc, y => mc_to_mem
        );

    memoria : entity work.memory generic map( nbits_addr => 3, width => 3 )
        port map ( 
        addr => cont_to_rom, en => read, clk => clk, rst => rst_dp, 
        data_in =>mc_to_mem, r_w =>'0'
        );           

    mux : entity work.mux2to1 generic map(N => 3)
        port map ( x1 => mc_to_mem, x2 => "000", s => rst_dp, y => led
        );


end Structural;
