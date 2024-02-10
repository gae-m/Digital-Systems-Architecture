library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoderBCD_tb is
--  Port ( );
end encoderBCD_tb;

architecture Behavioral of encoderBCD_tb is
	component encoderBCD port(
		x : in std_logic_vector (9 downto 0);
		y : out std_logic_vector (3 downto 0) );
	end component;
	
	signal input : std_logic_vector (9 downto 0) := "0000000000";
	signal output : std_logic_vector (3 downto 0);
	
	type oracle_type is array (0 to 9) of std_logic_vector(3 downto 0);
	constant oracle : oracle_type := (
	"0000", "0001", "0010", "0011", "0100", "0101" , "0110", "0111", "1000", "1001");
	
begin
	dut : encoderBCD port map(
		x => input,
		y => output );
	
	process
	begin
		input <= "0000000001";
		wait for 50ns;
		assert output = oracle(0) report "error" severity failure;
		
		for i in 1 to 9 loop
			input <= input(8 downto 0) & '0';
			wait for 50ns;
			assert output = oracle(i) report "error" severity failure;
		end loop;
		
		input <= "0000000000";
		wait for 50ns;
		assert output = "----" report "error" severity failure;
		
		input <= "1111111111";
		wait for 50ns;
		assert output = "----" report "error" severity failure;
	end process;
	

end Behavioral;
