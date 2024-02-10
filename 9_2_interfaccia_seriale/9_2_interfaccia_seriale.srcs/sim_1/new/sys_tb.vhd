----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2024 11:00:36
-- Design Name: 
-- Module Name: sys_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity sys_tb is
--  Port ( );
end sys_tb;

architecture Behavioral of sys_tb is
	constant CLK_PERIOD : time := 0.5ns;
	constant BAUD_DIVIDE_G : positive := 2;
	
	constant K : positive := 3;
	constant depth : positive := 2**K;
	subtype word is std_logic_vector(7 downto 0);
	type rom_type is array(0 to depth-1) of word;
	constant oracle : rom_type := (
	x"01",
	x"02",
	x"04",
	x"08",
	x"10",
	x"20",
	x"40",
	x"80" );
	
	signal send : std_logic;
	signal mode : std_logic;
	signal addr : std_logic_vector(2 downto 0);
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal data_out : std_logic_vector(7 downto 0);
	
begin
	dut : entity work.sys
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G,		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		K => K,								-- f_Tx = f_Rx / 16
		CLK_B_DELAY => 0ns )
	port map(
		send => send,
		mode => mode,
		addr => addr,
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
		
		mode <= '0';
		addr <= (others => '0');
		send <= '0';
		rst <= '1';
		wait for CLK_PERIOD;
		
		rst <= '0';
		wait for CLK_PERIOD;
		
		send <= '1';
		wait for CLK_PERIOD;
		send <= '0';
		
		wait for 2900*CLK_PERIOD;		-- aspetto che finisca la trasmissione
		mode <= '1';
		for i in 0 to depth-1 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait until data_out'active;
			assert data_out = oracle(i) report "Error" severity failure;
			wait for CLK_PERIOD/4;
		end loop;
		
		wait;
	end process;
		
end Behavioral;
