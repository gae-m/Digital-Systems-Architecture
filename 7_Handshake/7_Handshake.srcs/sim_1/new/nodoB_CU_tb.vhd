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
	signal ready : std_logic;
	signal mode : std_logic;
	signal clk : std_logic;
	signal rst : std_logic;
	signal ack : std_logic;
	signal en_mem : std_logic;
	signal en_reg1 : std_logic;
	signal en_reg2 : std_logic;
	signal ctrl_mode : std_logic;
	signal inc : std_logic;
	signal r_w : std_logic;

begin
	dut : entity work.nodoB_CU(Behavioral)
		port map(
			ready => ready,
			mode => mode,
			clk => clk,
			rst => rst,
			ctrl_mode => ctrl_mode,
			en_reg1 => en_reg1,
			en_reg2 => en_reg2,
			en_mem => en_mem,
			r_w => r_w,
			ack => ack,
			inc => inc );
			
	clk_gen : process
	begin
		clk <= '0';
		wait for 5ns;
		clk <= '1';
		wait for 5ns;
	end process;
	
	test : process
	begin
		ready <= '0';
		mode <= '0';
		rst <= '0';
		wait for 20ns;
		rst <= '1';
		wait for 25ns;
		rst <= '0';
		ready <= '1';
		wait until ack = '1';
		wait for 50ns;
		ready <= '0';
		wait for 15ns;
		mode <= '1';
		wait for 30ns;
		ready <= '1';
		wait for 20ns;
		mode <= '0';
		wait for 30ns;
		rst <= '1';
		wait for 15ns;
		rst <= '0';
		wait for 300ns;
	end process;


end Behavioral;
