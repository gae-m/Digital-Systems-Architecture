library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
    Port ( in0 : in STD_LOGIC_VECTOR(1 downto 0);
           in1 : in STD_LOGIC_VECTOR(1 downto 0);
           s : in STD_LOGIC;
           d : in STD_LOGIC;
           out0 : out STD_LOGIC_VECTOR(1 downto 0);
           out1 : out STD_LOGIC_VECTOR(1 downto 0));
end switch;

architecture Structural of switch is

signal mux_to_demux : STD_LOGIC_VECTOR(1 downto 0);

begin
    mux: entity work.mux2to1 generic map( N=>2)
    port map(x1 => in0, x2 =>in1, s => s, y => mux_to_demux);
    
    demux: entity work.demux1to2 generic map(N=>2)
    port map(x => mux_to_demux, s => d, y0 => out0, y1 => out1);
   
end Structural;
