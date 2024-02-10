library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rete_inter is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           s : in STD_LOGIC_VECTOR (3 downto 0);
           d : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0) );
end rete_inter;

architecture structural of rete_inter_16to4 is
	component mux16to1 port(
		x : in std_logic_vector(15 downto 0);
		s : in std_logic_vector(3 downto 0);
		y : out std_logic );
	end component;
	component demux1to4 port(
		x : in std_logic;
		s : in std_logic_vector(1 downto 0);
		y : out std_logic_vector(3 downto 0) );
	end component;
	signal w : std_logic;
begin
	mux : mux16to1 port map(
		x => x,
		s => s,
		y => w );
	demux: demux1to4 port map(
		x => w,
		s => d,
		y => y );

end structural;
