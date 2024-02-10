----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2023 13:06:15
-- Design Name: 
-- Module Name: nodoB_CU_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nodoB_CU_tb is
--  Port ( );
end nodoB_CU_tb;

architecture Behavioral of nodoB_CU_tb is
	constant clk_period : time := 10ns;

	signal ready : std_logic;
	signal mode : std_logic;
	signal clk : std_logic;
	signal rst : std_logic;
	
	signal ack : std_logic;
	signal en_mem : std_logic;
	signal en_reg : std_logic;
	signal strobe : std_logic;
	signal rst_dp : std_logic;
	signal inc : std_logic;
	signal ctrl_mode : std_logic;
	
	signal ctrl_word : std_logic_vector(6 downto 0);

begin
	dut : entity work.nodoB_CU(Behavioral)
		port map(
			ready => ready,
			mode => mode,
			clk => clk,
			rst => rst,
			ack => ack,
			en_mem => en_mem,
			en_reg => en_reg,
			strobe => strobe,
			rst_dp => rst_dp,
			inc => inc,
			ctrl_mode => ctrl_mode );
			
	ctrl_word <= inc & strobe & en_reg & en_mem & ack & ctrl_mode & rst_dp;
			
	clk_gen : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	test : process
	begin
		ready <= '0';
		mode <= '0';
		rst <= '1';
		wait for 22ns;
		assert ctrl_word = "0000001" report "Errore RESET" severity failure;
		
		rst <= '0';
		wait for 12ns;
		assert ctrl_word = "0000000" report "Errore IDLE" severity failure;
		
		ready <= '1';
		wait for clk_period;
		assert ctrl_word = "0110000" report "Errore RECEIVE" severity failure;
		
		wait until ctrl_word(2) = '1'; -- ack = '1'
		assert ctrl_word = "0001100" report "Errore SUM" severity failure;
		wait for 22ns;
		
		ready <= '0';
		wait for clk_period;
		assert ctrl_word = "1000000" report "Errore INCR" severity failure;
		
		mode <= '1';
		wait for 2*clk_period;
		assert ctrl_word = "0001010" report "Errore READ_MEM" severity failure;
		wait for 22ns;
		
		rst <= '1';
		wait for clk_period;
		assert ctrl_word = "0000001" report "Errore RESET" severity failure;
		
		wait for 30ns;
	end process;


end Behavioral;
