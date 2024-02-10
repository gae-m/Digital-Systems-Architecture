library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux1to4 is
    Port ( x : in STD_LOGIC;
           s : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0));
end demux1to4;

architecture dataflow of demux1to4 is

begin
    y(0) <= x when s = "00" else '0';
    y(1) <= x when s = "01" else '0';
    y(2) <= x when s = "10" else '0';
    y(3) <= x when s = "11" else '0';

end dataflow;
