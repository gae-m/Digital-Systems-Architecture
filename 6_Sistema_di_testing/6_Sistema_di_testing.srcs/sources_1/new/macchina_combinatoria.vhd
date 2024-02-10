library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity macchina_combinatoria is
    Port ( x : in STD_LOGIC_VECTOR(3 downto 0);
           y : out STD_LOGIC_VECTOR(2 downto 0));
end macchina_combinatoria;

architecture Dataflow of macchina_combinatoria is
   
begin
    y(0) <= not x(0);
    y(1) <= not x(1);
    y(2) <= not x(2);

end Dataflow;
