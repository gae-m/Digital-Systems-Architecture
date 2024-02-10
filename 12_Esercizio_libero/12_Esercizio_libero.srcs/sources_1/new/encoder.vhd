library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR(1 downto 0));
end encoder;

architecture Behavioral of encoder is

signal x : STD_LOGIC_VECTOR(2 downto 0);

begin
x <= a & b & c;

    with x select
		s <= "00" when "100",
			"01" when "010",
			"10" when "001",
			"11" when others;


end Behavioral;
