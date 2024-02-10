library IEEE;
use IEEE.std_logic_1164.all;

entity nodoA_tb is

end nodoA_tb;

architecture behavioral of nodoA_tb is
	constant CLK_PERIOD : time := 40ns;
	signal send : std_logic;
	signal ack : std_logic;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal ready : std_logic;
	signal data_out : std_logic_vector(7 downto 0) ;
	
	subtype word is std_logic_vector(7 downto 0);
	type rom_type is array(0 to 7) of word;
	constant oracle : rom_type := (
	x"01",
	x"40",
	x"04",
	x"08",
	x"10",
	x"20",
	x"40",
	x"80" );
begin
	dut : entity work.nodoA
	port map(
		start => send,
		ack => ack,
		rst => rst,
		clk => clk,
		ready => ready,
		data_out => data_out);
		
	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
	test : process
	begin
		wait for CLK_PERIOD/4;
		
		send <= '0';
		ack <= '0';
		rst <= '1';
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		
		rst <= '0';
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		
		send <= '1';
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		
		send <= '0';
		wait for CLK_PERIOD;
		assert ready = '1' report "Error" severity failure;
		assert data_out = oracle(0) report "Error" severity failure;
		
		wait for CLK_PERIOD;
		assert ready = '1' report "Error" severity failure;
		assert data_out = oracle(0) report "Error" severity failure;
		
		ack <= '1';
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		
		send <= '1';
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		assert data_out = oracle(1) report "Error" severity failure;
		
		ack <= '0';
		wait for CLK_PERIOD;
		assert ready = '1' report "Error" severity failure;
		assert data_out = oracle(1) report "Error" severity failure;
		
		ack <= '1';
		wait for CLK_PERIOD;
		assert ready = '0' report "Error" severity failure;
		
	end process;

end behavioral;