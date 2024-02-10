library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rete_on_board_tb is
--  Port ( );
end rete_on_board_tb;

architecture Behavioral of rete_on_board_tb is
	component rete_on_board port(
		addr : in std_logic_vector(3 downto 0);
		src : in std_logic_vector(3 downto 0);
		dst : in std_logic_vector(1 downto 0);
		clk : in std_logic;
		y : out std_logic_vector(3 downto 0) );
	end component;
	
	signal address : std_logic_vector(3 downto 0) := "0000";
	signal source : std_logic_vector(3 downto 0) := "0000";
	signal destination : std_logic_vector(1 downto 0) := "00";
	signal clock : std_logic := '0';
	signal output : std_logic_vector(3 downto 0);
begin
	--Design Under Test
	dut : rete_on_board port map(
		addr => address,
		src => source,
		dst => destination,
		clk => clock,
		y => output );
		
	gen_clk : process
	begin
		wait for 5ns;
		clock <= '1';
		wait for 5ns;
		clock <= '0';
	end process;
	
	process
	begin
		wait for 50ns;
		
		address <= "0000";
		source <= "0000";
		destination <= "11";
		wait for 50ns;
		assert output = "1000" report "error_1" severity failure;
		
		destination <= "01";
		wait for 50ns;
		assert output = "0010" report "error_2" severity failure;
		
		source <= "1111";
		wait for 50ns;
		assert output = "0000" report "error_3" severity failure;
		
		address <= "1111";
		wait for 50ns;
		assert output = "0010" report "error_4" severity failure;
		
		source <= "0010";
		destination <= "11";
		wait for 50ns;
		assert output = "1000" report "error_5" severity failure;
	end process;

end Behavioral;
