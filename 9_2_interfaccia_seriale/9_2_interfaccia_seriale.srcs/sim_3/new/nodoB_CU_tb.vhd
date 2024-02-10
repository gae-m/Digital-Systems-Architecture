library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.nodoB_util.all;
	
entity nodoB_CU_tb is
	--Port()
end nodoB_CU_tb;

architecture behavioral of nodoB_CU_tb is
	constant CLK_PERIOD : time := 10ns;
	
	type state_type is (RESET,IDLE,RECEIVE,INCR,READ_MEM);
	type oracle_type is array(state_type) of ctrl_word_type;
	constant oracle : oracle_type := (
		RESET => "00001",
		IDLE => "00000",
		RECEIVE => "10100",
		INCR => "01000",
		READ_MEM => "00110" );
	
	signal mode : std_logic;
	signal RDA : std_logic;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal cword : ctrl_word_type;
	
begin
	dut : entity work.nodoB_cu
	port map(
		mode => mode,
		RDA => RDA,
		rst => rst,
		clk => clk,
		ctrl_word => cword);
		
	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
	test : process
	begin
		wait for CLK_PERIOD/4;
		
		mode <= '0';
		RDA <= '0';
		rst <= '1';
		wait for CLK_PERIOD;
		assert cword = oracle(RESET) report "Error RESET" severity failure;
		
		rst <= '0';
		wait for CLK_PERIOD;
		assert cword = oracle(IDLE) report "Error IDLE" severity failure;
		
		RDA <= '1';
		wait for CLK_PERIOD;
		assert cword = oracle(RECEIVE) report "Error RECEIVE" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(INCR) report "Error INCR" severity failure;
		
		RDA <= '0';
		wait for CLK_PERIOD;
		assert cword = oracle(IDLE) report "Error IDLE" severity failure;
		
		mode <= '1';
		wait for CLK_PERIOD;
		assert cword = oracle(READ_MEM) report "Error READ_MEM" severity failure;
		
		RDA <= '1';
		wait for CLK_PERIOD;
		assert cword = oracle(READ_MEM) report "Error READ_MEM" severity failure;
		
		mode <= '0';
		wait for CLK_PERIOD;
		assert cword = oracle(IDLE) report "Error IDLE" severity failure;
		
		wait;
	end process;

end behavioral;