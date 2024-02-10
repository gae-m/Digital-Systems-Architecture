library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity digits_conv_tb is
--  Port ( );
end digits_conv_tb;

architecture behavioral of digits_conv_tb is
	signal x : std_logic_vector(15 downto 0);
	signal y : std_logic_vector(31 downto 0);
begin
	dut : entity work.digits_converter
	port map(
		x => x,
		y => y );
	
	test : process
	begin
		x <= std_logic_vector(to_signed(32000,16));
		wait for 20ns;
		
		x <= std_logic_vector(to_signed(-32000,16));
		wait for 20ns;
		
		x <= std_logic_vector(to_signed(-30,16));
		wait for 20ns;
		
		x <= std_logic_vector(to_signed(77,16));
		wait for 20ns;
	end process;

end behavioral;