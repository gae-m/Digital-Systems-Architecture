----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2024 18:01:37
-- Design Name: 
-- Module Name: nodoB - structural
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

entity nodoB is
	generic(
		BAUD_DIVIDE_G : positive );		-- f_Rx = f_CLK / BAUD_DIVIDE_G
    Port ( RxD : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end nodoB;

architecture structural of nodoB is

	signal rda : std_logic;
	signal rd : std_logic;

begin
	rd <= rda after 1ns;

	uart_B : entity work.UARTcomponent
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G)		-- f_Rx = f_CLK / BAUD_DIVIDE_G
	port map(
		RXD => RxD,
		RST => rst,
		CLK => clk,
		RDA => rda,
		RD => rd,
		DBOUT => data_out,
		DBIN => (others => '0'),
		WR => '0' );

end structural;
