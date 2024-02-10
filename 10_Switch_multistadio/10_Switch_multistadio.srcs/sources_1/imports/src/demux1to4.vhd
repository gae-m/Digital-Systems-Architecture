library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1to4 is generic(N: integer := 6);
    Port ( x : in STD_LOGIC_VECTOR(N-1 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           y0, y1, y2, y3 : out STD_LOGIC_VECTOR (N-1 downto 0));
end demux1to4;

architecture dataflow of demux1to4 is

begin
    y0 <= x when s = "00" else (others => '0');
    y1 <= x when s = "01" else (others => '0');
    y2 <= x when s = "10" else (others => '0');
    y3 <= x when s = "11" else (others => '0');

end dataflow;
