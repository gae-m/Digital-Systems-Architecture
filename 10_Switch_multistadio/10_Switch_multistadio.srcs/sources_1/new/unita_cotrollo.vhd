library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_controllo is
    Port ( x0 : in STD_LOGIC_VECTOR(5 downto 0); --  x => || 2 bit sorgente| 2 bit destinazione | 2 bit messaggio ||
           x1 : in STD_LOGIC_VECTOR(5 downto 0);
           x2 : in STD_LOGIC_VECTOR(5 downto 0);
           x3 : in STD_LOGIC_VECTOR(5 downto 0);
           en00 : in STD_LOGIC;
           en01 : in STD_LOGIC;
           en10 : in STD_LOGIC;
           en11 : in STD_LOGIC;
           y0 : out STD_LOGIC_VECTOR(1 downto 0);
           y1 : out STD_LOGIC_VECTOR(1 downto 0);
           y2 : out STD_LOGIC_VECTOR(1 downto 0);
           y3 : out STD_LOGIC_VECTOR(1 downto 0);
           s : out STD_LOGIC_VECTOR(1 downto 0);
           d : out STD_LOGIC_VECTOR(1 downto 0));
           
end unita_controllo;

architecture Structural of unita_controllo is

signal selected : std_logic_vector(1 downto 0);
signal mux_to_demux : std_logic_vector(5 downto 0);
signal u0 : std_logic_vector(5 downto 0);
signal u1 : std_logic_vector(5 downto 0);
signal u2 : std_logic_vector(5 downto 0);
signal u3 : std_logic_vector(5 downto 0);

begin

    mux: entity work.mux4to1 port map(
        x0 => x0, x1 => x1, x2 => x2, x3 => x3, s => selected, y => mux_to_demux
    );
    
    demux: entity work.demux1to4 port map(
        x => mux_to_demux, s => selected, y0 => u0, y1 => u1, y2 => u2, y3 => u3 
    );
    
    arbitro: entity work.arbitro port map(
        en00 => en00, en01 => en01, en10 => en10, en11 => en11, selected => selected
    );
    
    y0 <= u0(5 downto 4);
    y1 <= u1(5 downto 4);
    y2 <= u2(5 downto 4);
    y3 <= u3(5 downto 4);
    
    d <= u0 (3 downto 2) when selected ="00" else
        u1 (3 downto 2) when selected ="01" else
        u2 (3 downto 2) when selected ="10" else
        u3 (3 downto 2) when selected ="11" else
        "--";
        
    s <= selected;

end Structural;
