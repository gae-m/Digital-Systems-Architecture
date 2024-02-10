library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity priority_encoder is
    Port ( x : in STD_LOGIC_VECTOR (9 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0));
end priority_encoder;

architecture structural of priority_encoder is
	component arbiter port(
		x : in std_logic_vector(9 downto 0);
		y : out std_logic_vector(9 downto 0) );
	end component;
	component encoderBCD port(
		x : in std_logic_vector(9 downto 0);
		y : out std_logic_vector(3 downto 0) );
	end component;
	signal w : std_logic_vector(9 downto 0);
begin
	arb : arbiter port map(
		x => x,
		y => w );
	enc : encoderBCD port map(
		x => w,
		y => y);

end structural;
