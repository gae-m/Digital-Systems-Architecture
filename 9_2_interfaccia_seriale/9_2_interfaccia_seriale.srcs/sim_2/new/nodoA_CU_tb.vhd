library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.nodoA_util.all;
	
entity nodoA_CU_tb is
	--Port()
end nodoA_CU_tb;

architecture behavioral of nodoA_CU_tb is

	constant CLK_PERIOD : time := 20ns;
	
	type state_type is (RESET,IDLE,READ_ROM,SEND_INCR);
	type oracle_type is array(state_type) of ctrl_word_type;
	constant oracle : oracle_type := (
		RESET => "0001",
		IDLE => "0000",
		READ_ROM => "0100",
		SEND_INCR => "1010" );
		
	signal send : std_logic;
	signal TBE : std_logic;
	signal div : std_logic;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal cword : ctrl_word_type;
	
begin
	dut : entity work.nodoA_cu
	port map(
		send => send,
		TBE => TBE,
		div => div,
		rst => rst,
		clk => clk,
		ctrl_word => cword );
		
	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
	test : process
	begin
	wait for CLK_PERIOD/4;
	
	send <= '0';
	TBE <= '1';
	div <= '1';
	rst <= '1';
	wait for CLK_PERIOD;
	assert cword = oracle(RESET) report "Error RESET" severity failure;
	
	rst <= '0';
	wait for CLK_PERIOD;
	assert cword = oracle(IDLE) report "Error IDLE" severity failure;
	
	send <= '1';
	wait for CLK_PERIOD;
	assert cword = oracle(READ_ROM) report "Error READ_ROM" severity failure;
	
	send <= '0';
	wait for CLK_PERIOD;
	assert cword = oracle(SEND_INCR) report "Error SEND_INCR" severity failure;
	
	TBE <= '0';
	div <= '0';
	wait for CLK_PERIOD;
	assert cword = oracle(READ_ROM) report "Error READ_ROM" severity failure;
	
	wait for CLK_PERIOD;
	assert cword = oracle(READ_ROM) report "Error READ_ROM" severity failure;
	
	TBE <= '1';
	wait for CLK_PERIOD;
	assert cword = oracle(SEND_INCR) report "Error SEND_INCR" severity failure;
	
	div <= '1';
	send <= '1';
	wait for CLK_PERIOD;
	assert cword = oracle(READ_ROM) report "Error READ_ROM" severity failure;
	
	send <= '0';
	wait for CLK_PERIOD;
	assert cword = oracle(SEND_INCR) report "Error SEND_INCR" severity failure;
	
	wait for CLK_PERIOD;
	assert cword = oracle(IDLE) report "Error IDLE" severity failure;
	
	wait;
	end process;
	 
end behavioral;