library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arbiter_tb is
--  Port ( );
end arbiter_tb;

architecture Behavioral of arbiter_tb is
	component arbiter port(
		x : in std_logic_vector(9 downto 0);
		y : out std_logic_vector(9 downto 0) );
	end component;
	signal input :  std_logic_vector(9 downto 0) := "0000000000";
	signal output : std_logic_vector(9 downto 0);
	
	type oracle_type is array(0 to 9) of std_logic_vector(9 downto 0);
	constant oracle : oracle_type := (
	"0000000001",
	"0000000010",
	"0000000100",
	"0000001000",
	"0000010000",
	"0000100000",
	"0001000000",
	"0010000000",
	"0100000000",
	"1000000000");
begin
	--Design Under Test
	dut : arbiter port map(
		x => input,
		y => output );
		
	process
	begin
		input <= "0000000000";
		wait for 50ns;
		assert output = "----------" report "error" severity failure;
		
		for i in 0 to 9 loop
			input(i) <= '1';
			wait for 50ns;
			assert output = oracle(i) report "error" severity failure;
		end loop;
	end process;

end Behavioral;
