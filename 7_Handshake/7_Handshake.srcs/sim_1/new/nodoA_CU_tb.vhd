----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 16:24:01
-- Design Name: 
-- Module Name: nodoA_CU_tb - Behavioral
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

entity nodoA_CU_tb is
--  Port ( );
end nodoA_CU_tb;

architecture Behavioral of nodoA_CU_tb is
	component nodoA_CU is
		Port ( start : in STD_LOGIC;
			   ack : in STD_LOGIC;
			   div : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   ready : out STD_LOGIC;
			   inc : out STD_LOGIC;
			   strobe : out STD_LOGIC;
			   rst_dp : out STD_LOGIC);
	end component;
	
	signal start : std_logic;
	signal ack : std_logic;
	signal div : std_logic;
	signal rst : std_logic;
	signal clk : std_logic;
	
	signal ready : std_logic;
	signal inc : std_logic;
	signal strobe : std_logic;
	signal rst_dp : std_logic;
	
	shared variable count : natural := 0;
	
begin
	dut : nodoA_CU port map(
		start => start,
		ack => ack,
		div => div,
		rst => rst,
		clk => clk,
		ready => ready,
		inc => inc,
		strobe => strobe,
		rst_dp => rst_dp );
	
	clk_gen : process
	begin
		clk <= '0';
		wait for 5ns;
		clk <= '1';
		wait for 5ns;
	end process;
	
	process
		
	begin
		count := 0;
		start <= '0';
		ack <= '0';
		rst <= '0';
		div <= '1';
		wait for 15ns;
		
		rst <= '1';
		wait for 15ns;
		assert (inc = '0' and strobe = '0' and ready = '0' and rst_dp = '1') report "Errore IDLE" severity failure;  
		
		rst <= '0';
		start <= '1';
		wait for 15ns;
		assert (inc = '0' and strobe = '1' and ready = '0' and rst_dp = '0') report "Errore READ" severity failure;
		start <= '0';
		
		while count < 7 loop
			ack <= '0';
			wait until ready = '1';
			ack <= '1';
			count := count + 1;
			wait for 15ns;
			assert (inc = '1' and strobe = '0' and ready = '0' and rst_dp = '0') report "Errore INCR" severity failure;
			div <= '0';
		end loop;
		
		
		div <= '1';
		wait for 15ns;
		assert (inc = '0' and strobe = '0' and ready = '0' and rst_dp = '1') report "Errore IDLE" severity failure;

		
	end process;


end Behavioral;
