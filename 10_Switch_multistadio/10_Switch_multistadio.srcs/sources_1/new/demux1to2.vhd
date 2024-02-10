library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1to2 is generic(N : integer := 3);
    Port ( x : in STD_LOGIC_VECTOR(N-1 downto 0);
           s : in STD_LOGIC;
           y0, y1 : out STD_LOGIC_VECTOR (N-1 downto 0));
end demux1to2;

architecture dataflow of demux1to2 is

begin
    y0 <= x when s = '0' else (others => '0');
    y1 <= x when s = '1' else (others => '0');

end dataflow;