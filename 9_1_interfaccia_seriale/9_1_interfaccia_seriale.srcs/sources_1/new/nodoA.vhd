----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2024 18:01:37
-- Design Name: 
-- Module Name: nodoA - structural
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

entity nodoA is
	generic(
		BAUD_RATE_G : positive );		-- f_Tx = f_CLK / BAUD_RATE_G	
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           write : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           TxD : out STD_LOGIC);
end nodoA;

architecture structural of nodoA is

begin
	uart_A :  entity work.UARTcomponent
	generic map(
		BAUD_RATE_G => BAUD_RATE_G )	-- f_Tx = f_CLK / BAUD_RATE_G	
	port map(
		DBIN => data_in,
		WR => write,
		RST => rst,
		CLK => clk,
		TXD => TxD,
		RXD => '1',
		RD => '0' ); 

end structural;
