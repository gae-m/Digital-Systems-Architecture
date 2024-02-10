----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2024 18:29:01
-- Design Name: 
-- Module Name: nodoA_tb - Behavioral
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

entity nodoA_tb is
--  Port ( );
end nodoA_tb;

architecture Behavioral of nodoA_tb is
	
	constant BAUD_RATE_G : positive := 2;
	constant CLK_PERIOD : time := 10ns;
	constant TX_PERIOD : time := BAUD_RATE_G * CLK_PERIOD;
	
	signal data_in : std_logic_vector(7 downto 0);
	signal write : std_logic;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal TxD : std_logic;

begin
	dut : entity work.nodoA
	generic map(
		BAUD_RATE_G => BAUD_RATE_G )		-- f_Tx = f_CLK / BAUD_RATE_G
	port map(
		data_in => data_in,
		write => write,
		rst => rst,
		clk => clk,
		TxD => TxD);
		
	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not(clk);
	end process;
	
	--------------
	-- il data frame della UART è composto da 11 bit:
	-- 1 bit di start -> '0'
	-- 8 bit di dato da LSb a MSb
	-- 1 bit di parità DISPARI
	-- 1 bit di stop -> '1'
	---------------
	test : process
		variable data_frame : std_logic_vector (10 downto 0);
	begin
		wait for CLK_PERIOD/4;
		
		rst <= '1';
		data_in <= x"AA";
		write <= '0';
		wait for CLK_PERIOD;
		assert TxD = '1' report "Error" severity failure;
		
		rst <= '0';
		wait for CLK_PERIOD;
		assert TxD = '1' report "Error" severity failure;
		
		write <= '1';
		wait for CLK_PERIOD;
		write <= '0';
		wait for CLK_PERIOD;
		data_frame := '1' & '1' & data_in & '0'; 	-- STOP + PARITY + DATA + START
		for i in 0 to 10 loop
			wait for TX_PERIOD;
			assert TxD = data_frame(i) report "Error" severity failure;
		end loop;
		wait for 2*CLK_PERIOD;	-- per far alzare TBE
		
		data_in <= x"01";
		write <= '1';
		wait for CLK_PERIOD;
		write <= '0';
		wait for CLK_PERIOD;
		data_frame := '1' & '0' & data_in & '0'; 	-- STOP + PARITY + DATA + START
		for i in 0 to 10 loop
			wait for TX_PERIOD;
			assert TxD = data_frame(i) report "Error" severity failure;
		end loop;
		
	end process; 

end Behavioral;
