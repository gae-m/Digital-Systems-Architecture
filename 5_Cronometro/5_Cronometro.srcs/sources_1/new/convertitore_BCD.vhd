library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity convertitore_BCD is
    Port ( x : in STD_LOGIC_VECTOR(5 downto 0);
           y : out STD_LOGIC_VECTOR(7 downto 0));
end convertitore_BCD;

architecture Behavioral of convertitore_BCD is

begin
    process(x)
       variable unita : integer;
       variable decine : integer;
       begin 
            unita := conv_integer(x) mod 10;
            decine := (conv_integer(x)/10) mod 10;
            
            y(3 downto 0) <= std_logic_vector(to_unsigned(unita,4));
            y(7 downto 4) <= std_logic_vector(to_unsigned(decine,4));
    end process;

end Behavioral;
