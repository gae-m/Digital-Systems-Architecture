library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_on_board is
	Generic(
		CLK_PERIOD : positive := 10;
		BTN_NOISE_TIME : positive := 125000000;
		CLK_B_FACTOR : positive := 4;
		CLK_B_DELAY : time := 2ns );
	Port(external_rst_btn : in std_logic;
		internal_rst_btn : in std_logic;
		clk : in std_logic;
		addr_sw : in std_logic_vector(2 downto 0);
		send_A_btn : in std_logic;
		send_B_btn : in std_logic;
		led : out std_logic_vector(7 downto 0));
end system_on_board;

architecture structural of system_on_board is
	signal cleared_send_A : std_logic;
	signal cleared_send_B : std_logic;
	signal cleared_rst : std_logic;
	signal clk_HF : std_logic;
	signal clk_LF : std_logic;
	
begin
    sys: entity work.system
    port map(rst => cleared_rst,
    	clk_A => clk_LF,
    	clk_B => clk_HF,
    	addr => addr_sw,
    	send_A => cleared_send_A,
    	send_B => cleared_send_B,
    	data_out => led );
    
    btn_deb_send_A : entity work.button_debouncer
    generic map (
        clk_period => CLK_PERIOD * CLK_B_FACTOR,
        btn_noise_time => BTN_NOISE_TIME)
    port map ( 
		rst => cleared_rst, 
		clk => clk_LF, 
		btn => send_A_btn, 
		cleared_btn => cleared_send_A);
        
    btn_deb_send_B : entity work.button_debouncer
    generic map (
        clk_period => CLK_PERIOD, 
        btn_noise_time => BTN_NOISE_TIME)
    port map ( 
    	rst => cleared_rst,
     	clk => clk_HF, 
     	btn => send_B_btn, 
     	cleared_btn => cleared_send_B);
     
    btn_deb_reset : entity work.button_debouncer
    generic map (
        clk_period => CLK_PERIOD, 
        btn_noise_time => BTN_NOISE_TIME)
    port map ( 
    	rst => external_rst_btn,
     	clk => clk_LF, 
     	btn => internal_rst_btn, 
     	cleared_btn => cleared_rst);
     	
     bdt: entity work.base_dei_tempi
     generic map(
     	clk_B_factor => CLK_B_FACTOR,
     	 clk_B_delay => CLK_B_DELAY)
   	port map(
   		clk => clk, 
   		rst => external_rst_btn, 
   		clk_A => clk_HF, 
   		clk_B => clk_LF );
           
end structural;
