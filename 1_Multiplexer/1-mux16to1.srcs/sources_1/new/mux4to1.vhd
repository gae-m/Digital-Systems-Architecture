library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4to1 is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC);
end mux4to1;

architecture dataflow of mux4to1 is

begin
    with s select
        y <= x(0) when "00",
            x(1) when "01",
            x(2) when "10",
            x(3) when others;
end dataflow;
