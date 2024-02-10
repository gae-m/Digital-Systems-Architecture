----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2023 11:47:49
-- Design Name: 
-- Module Name: clock_filter - Behavioral
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

entity clock_filter is
	generic(
		clk_in_freq : integer := 100000000; -- frequenza di clock 100MHz
		clk_out_freq : integer := 500 ); --frequenza desiderata in uscita 500Hz (freq. di refresh)
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clock_filter;

architecture Behavioral of clock_filter is
	constant max_count : integer := clk_in_freq / clk_out_freq - 1;
begin
	process(clk_in)
		variable count : integer := 0;
	begin
		if clk_in'event and clk_in = '1' then
			if rst = '1' then
				count := 0;
				clk_out <= '0';
			elsif count = max_count then
					count := 0;
					clk_out <= '1';
				else
					clk_out <= '0';
					count := count + 1;
			end if;
		end if;
	end process;

end Behavioral;
