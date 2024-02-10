library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rete_on_board is
    Port ( addr : in STD_LOGIC_VECTOR (3 downto 0);
           src : in STD_LOGIC_VECTOR (3 downto 0);
           dst : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (3 downto 0));
end rete_on_board;

architecture Behavioral of rete_on_board is
	component rete_inter port(
		x : in std_logic_vector(15 downto 0);
		s : in std_logic_vector(3 downto 0);
		d : in std_logic_vector(1 downto 0);
		y : out std_logic_vector(3 downto 0) );
	end component;
	
	component rom port(
		addr : in std_logic_vector(3 downto 0);
		clk : in std_logic;
		y : out std_logic_vector(15 downto 0) );
	end component;
	
	signal w : std_logic_vector(15 downto 0);
begin
	net : rete_inter port map(
		x => w,
		s => src,
		d => dst,
		y => y );
	mem : rom port map(
		addr => addr,
		clk => clk,
		y => w );
end Behavioral;
