----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2024 18:01:37
-- Design Name: 
-- Module Name: sys - structural
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

entity sys is
	generic(
		BAUD_DIVIDE_G : positive := 651);		-- baud_rate = 9600 con f_CLK = 100MHz
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           write : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end sys;

architecture structural of sys is

	constant BAUD_RATE_G : positive := 16*BAUD_DIVIDE_G;	-- f_Rx = 16 * f_Tx
	signal data_line : std_logic;

begin
	nodoA : entity work.nodoA
	generic map(
		BAUD_RATE_G => BAUD_RATE_G )		-- f_Tx = f_CLK / BAUD_RATE_G
	port map(
		data_in => data_in,
		write => write,
		rst => rst,
		clk => clk,
		TxD => data_line);
		
	nodoB : entity work.nodoB
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G )	-- f_Rx = f_CLK / BAUD_DIVIDE_G
	port map(
		RxD => data_line,
		rst => rst,
		clk => clk,
		data_out => data_out );
		
end structural;
