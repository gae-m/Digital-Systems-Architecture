----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2024 12:53:41
-- Design Name: 
-- Module Name: control_unit_tb - Behavioral
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
use work.CU_util.all;

entity control_unit_tb is
--  Port ( );
end control_unit_tb;

architecture Behavioral of control_unit_tb is
	constant CLK_PERIOD : time := 10ns;
	signal mul : std_logic;
	signal Q : std_logic_vector(1 downto 0);
	signal div : std_logic;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal cword : ctrl_word_type;
	type state_type is (IDLE, INIT, ADD, SUB, SHIFT_Q, SHIFT_A);
	type oracle_type is array(state_type) of ctrl_word_type;
	constant oracle : oracle_type := (
		IDLE => "000000000",
		INIT => "001110011",
		ADD => "110000001",
		SUB => "110001001",
		SHIFT_Q => "001000001",
		SHIFT_A => "100000101" );
begin
	dut : entity work.control_unit
	port map(
		mul => mul,
		Q => Q,
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
		wait until clk'event and clk = '1';
		
		mul <= '0';
		Q <= "00";
		div <= '1';
		rst <= '1';
		wait for CLK_PERIOD;
		assert cword = oracle(IDLE) report "Error IDLE" severity failure;
		
		rst <= '0';
		wait for CLK_PERIOD;
		assert cword = oracle(IDLE) report "Error IDLE" severity failure;
		
		mul <= '1';
		wait for CLK_PERIOD;
		assert cword = oracle(INIT) report "Error INIT" severity failure;
		
		mul <= '0';
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_Q) report "Error SHIFT_Q" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_A) report "Error SHIFT_A" severity failure;
		
		div <= '0';
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_Q) report "Error SHIFT_Q" severity failure;
		
		Q <= "01";
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_A) report "Error SHIFT_A" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(ADD) report "Error ADD" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_Q) report "Error SHIFT_Q" severity failure;
		
		Q <= "10";
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_A) report "Error SHIFT_A" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(SUB) report "Error SUB" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_Q) report "Error SHIFT_Q" severity failure;
		
		Q <= "11";
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_A) report "Error SHIFT_A" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_Q) report "Error SHIFT_Q" severity failure;
		
		wait for CLK_PERIOD;
		assert cword = oracle(SHIFT_A) report "Error SHIFT_A" severity failure;
		
		div <= '1';
		wait for CLK_PERIOD;
		assert cword = oracle(IDLE) report "Error IDLE" severity failure;
		
		wait for 3*CLK_PERIOD;
	end process;
end Behavioral;
