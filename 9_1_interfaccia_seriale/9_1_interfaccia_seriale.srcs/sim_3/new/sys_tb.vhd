library IEEE;
use IEEE.std_logic_1164.all;

entity sys_tb is
	-- Port();
end sys_tb;

architecture behavioral of sys_tb is

	constant BAUD_DIVIDE_G : positive := 2;
	constant CLK_PERIOD : time := 1ns;
	
	signal data_in : std_logic_vector(7 downto 0);
	signal data_out : std_logic_vector(7 downto 0);
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal write : std_logic;

begin
	dut : entity work.sys
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G)
	port map(
		data_in => data_in,
		write => write,
		rst => rst,
		clk => clk,
		data_out => data_out );
		
	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
	test : process
	begin
		wait for CLK_PERIOD/4;
		rst <= '1';
		data_in <= x"77";
		write <= '0';
		wait for CLK_PERIOD;
		
		rst <= '0';
		wait for CLK_PERIOD;
		write <= '1';
		wait for CLK_PERIOD;
		write <= '0';
		
		wait on data_out;
		assert data_out = x"77" report "Error" severity failure;
		
		wait;
		
	end process;

end behavioral;