library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arbitro is
    Port ( en00 : in STD_LOGIC;
           en01 : in STD_LOGIC;
           en10 : in STD_LOGIC;
           en11 : in STD_LOGIC;
           selected : out STD_LOGIC_VECTOR(1 downto 0));
end arbitro;

architecture dataflow of arbitro is

begin
    selected <= "11" when en11 = '1' else
    "10" when en10 = '1' else
    "01" when en01 = '1' else
    "00" when en00 = '1' else
    "--";

end dataflow;
