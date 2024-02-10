----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2023 17:44:28
-- Design Name: 
-- Module Name: anodes_manager - dataflow
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

entity anodes_manager is
	Port (
		digit_select : in std_logic_vector(2 downto 0);
		digits_enable : in std_logic_vector (7 downto 0);
		anodes : out std_logic_vector(7 downto 0)
	 );
end anodes_manager;

architecture dataflow of anodes_manager is
	signal tmp_anodes : std_logic_vector(7 downto 0);
begin
	with digit_select select
		tmp_anodes <= "11111110" when "000",
			"11111101" when "001",
			"11111011" when "010",
			"11110111" when "011",
			"11101111" when "100",
			"11011111" when "101",
			"10111111" when "110",
			"01111111" when "111",
			(others => '0') when others;
	
	anodes <= tmp_anodes or not digits_enable;

end dataflow;
