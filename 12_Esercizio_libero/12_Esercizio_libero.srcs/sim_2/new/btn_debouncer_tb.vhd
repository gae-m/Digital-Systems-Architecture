library IEEE;
use IEEE.std_logic_1164.all;

entity btn_debouncer_tb is
end btn_debouncer_tb;

architecture behavioral of btn_debouncer_tb is
	constant CLK_PERIOD : time := 10ns;
	constant CLK_PERIOD_INT : integer := 10;
	constant BTN_NOISE_TIME : integer := 20*CLK_PERIOD_INT;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal btn : std_logic;
	signal cleared_btn : std_logic;
begin
	dut : entity work.button_debouncer
    generic map (
        clk_period => CLK_PERIOD_INT,
        btn_noise_time => BTN_NOISE_TIME)
    port map ( 
		rst => rst, 
		clk => clk, 
		btn => btn, 
		cleared_btn => cleared_btn);

	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
	test : process
	begin
		wait for CLK_PERIOD/4;
		rst <= '1';
		btn <= '0';
		wait for CLK_PERIOD;
		
		rst <= '0';
		wait for CLK_PERIOD;
		assert cleared_btn = '0' severity failure;
		
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for 20*CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		
		wait for 20*CLK_PERIOD;
		
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for 20*CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		
		wait for 20*CLK_PERIOD;
		
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for 5*CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		
		wait for 20*CLK_PERIOD;
		
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for 5*CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		
		wait for 20*CLK_PERIOD;
		
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for 20*CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		btn <= '1';
		wait for CLK_PERIOD;
		btn <= '0';
		wait for CLK_PERIOD;
		
		wait;
	end process;
end behavioral;