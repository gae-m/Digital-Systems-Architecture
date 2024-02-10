library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
entity mux2to1 is
    generic(
    N : integer := 3);
    Port ( x1 : in STD_LOGIC_VECTOR(N-1 downto 0);
           x2 : in STD_LOGIC_VECTOR(N-1 downto 0);
           s : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR(N-1 downto 0));
end mux2to1;

architecture dataflow of mux2to1 is

begin
    with s select
        y <= x1 when '0',
            x2 when '1',
            (others=>'-') when others;

end dataflow;
