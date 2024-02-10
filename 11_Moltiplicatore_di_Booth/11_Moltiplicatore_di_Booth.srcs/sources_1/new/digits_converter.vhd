----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2024 20:50:40
-- Design Name: 
-- Module Name: digits_converter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity digits_converter is
    Port ( x : in STD_LOGIC_VECTOR (15 downto 0);
           y : out STD_LOGIC_VECTOR (31 downto 0));
end digits_converter;

architecture Behavioral of digits_converter is
begin
	process(x)
		variable value : integer;
		variable digit : integer;
	begin
		value := to_integer(signed(x));
		y(31 downto 24) <= (others => '0');
		if value < 0 then
			y(23 downto 20) <= "1010";
			value := abs(value);
		else
			y(23 downto 20) <= "0000";
		end if;
		
		digit := value/10000;
		y(19 downto 16) <= std_logic_vector(to_unsigned(digit,4));
		value := value mod 10000;
		
		digit := value/1000;
		y(15 downto 12) <= std_logic_vector(to_unsigned(digit,4));
		value := value mod 1000;
		
		digit := value/100;
		y(11 downto 8) <= std_logic_vector(to_unsigned(digit,4));
		value := value mod 100;
		
		digit := value/10;
		y(7 downto 4) <= std_logic_vector(to_unsigned(digit,4));
		value := value mod 10;
	
		y(3 downto 0) <= std_logic_vector(to_unsigned(value,4));
	end process;

end Behavioral;
