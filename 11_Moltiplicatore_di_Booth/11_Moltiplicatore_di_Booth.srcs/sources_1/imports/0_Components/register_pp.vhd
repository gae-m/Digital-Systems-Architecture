----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2023 23:41:43
-- Design Name: 
-- Module Name: register_pp - Behavioral
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

entity register_pp is
	generic (
		dim : positive := 2 );
    Port ( x : in STD_LOGIC_VECTOR (dim-1 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (dim-1 downto 0));
end register_pp;

architecture Behavioral of register_pp is

begin
	process(clk)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				y <= (others => '0');
			elsif enable = '1' then
				y <= x;
			end if;
		end if; 
	end process;

end Behavioral;
