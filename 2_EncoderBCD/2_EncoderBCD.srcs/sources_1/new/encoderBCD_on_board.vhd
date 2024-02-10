library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoderBCD_on_board is
    Port ( switch : in STD_LOGIC_VECTOR (9 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out STD_LOGIC_VECTOR (7 downto 0));
end encoderBCD_on_board;

architecture structural of encoderBCD_on_board is
	component priority_encoder port(
		x : in std_logic_vector(9 downto 0);
		y : out std_logic_vector(3 downto 0) );
	end component;
	
	component cathodes_manager port(
		value : in std_logic_vector(3 downto 0);
		dot : in std_logic;
		cathodes : out std_logic_vector(7 downto 0) );
	end component;
	 
	signal w : std_logic_vector(3 downto 0);
begin
	encoder : priority_encoder port map(
		x => switch,
		y => w );
	
	cm : cathodes_manager port map(
		value => w,
		dot => '0',
		cathodes => cathodes);
		
	anodes <= x"fe";
	led <= w;

end structural;
