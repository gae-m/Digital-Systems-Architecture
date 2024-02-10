library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity priority_encoder_tb is
--  Port ( );
end priority_encoder_tb;

architecture Behavioral of priority_encoder_tb is
	component priority_encoder port(
		x : in std_logic_vector(9 downto 0);
		y : out std_logic_vector(3 downto 0) );
	end component;
	signal input : std_logic_vector(9 downto 0) := "0000000000";
	signal output : std_logic_vector(3 downto 0);
	
	type oracle_type is array(0 to 9) of std_logic_vector(3 downto 0);
	constant oracle : oracle_type := (
		x"0", x"1", x"2", x"3", x"4", x"5", x"6", x"7", x"8", x"9" );
begin
	--Design Under Test
	dut : priority_encoder port map(
		x => input,
		y => output );
		
	process
	begin
		input <= "0000000000";
		wait for 50ns;
		assert output = "----" report "error" severity failure;
		
		for i in 0 to 9 loop
			input(i) <= '1';
			wait for 50ns;
			assert output = oracle(i) report "error" severity failure;
		end loop;
	end process;

end Behavioral;
