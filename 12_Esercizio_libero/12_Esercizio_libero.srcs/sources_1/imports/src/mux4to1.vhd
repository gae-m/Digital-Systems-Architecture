library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4to1 is
    generic(
    N : integer := 6);
    Port ( x0, x1, x2, x3 : in STD_LOGIC_VECTOR (N-1 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC_VECTOR(N-1 downto 0)
           );
end mux4to1;

architecture dataflow of mux4to1 is

begin
    with s select
        y <= x0 when "00",
            x1 when "01",
            x2 when "10",
            x3 when "11",
           (others=>'-') when others;
end dataflow;
