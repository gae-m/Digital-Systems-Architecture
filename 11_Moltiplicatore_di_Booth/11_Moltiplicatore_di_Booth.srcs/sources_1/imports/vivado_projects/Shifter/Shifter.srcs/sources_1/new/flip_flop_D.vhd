----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2024 16:59:24
-- Design Name: 
-- Module Name: flip_flop_D - Behavioral
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

entity ff_D is
    Port ( d : in STD_LOGIC;
           ce : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           q : out STD_LOGIC);
end ff_D;

architecture Behavioral of ff_D is

begin
	process(clk)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				q <= '0';
			elsif ce = '1' then
				q <= d;
			end if;
		end if;
	end process;

end Behavioral;
