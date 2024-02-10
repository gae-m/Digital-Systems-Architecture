----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2023 12:25:59
-- Design Name: 
-- Module Name: base_dei_tempi_tb - Behavioral
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

entity base_dei_tempi_tb is
--  Port ( );
end base_dei_tempi_tb;

architecture Behavioral of base_dei_tempi_tb is
    signal clock : std_logic;
    signal reset : std_logic;
    signal clock_A : std_logic;
    signal clock_B : std_logic;

begin
    dut : entity work.base_dei_tempi(structural)
        port map(
            clk => clock,
            rst => reset,
            clk_A => clock_A,
            clk_B => clock_B );
    
	clk_gen : process
	begin
		clock <= '0';
		wait for 5ns;
		clock <= '1';
		wait for 5ns;
	end process;
	
	process
	begin
		reset <= '1';
		wait for 25ns;
		reset <= '0';
		wait for 200ns;
	end process;
	
end Behavioral;
