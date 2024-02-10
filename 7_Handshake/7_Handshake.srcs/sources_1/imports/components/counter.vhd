----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2023 11:21:15
-- Design Name: 
-- Module Name: counter - structural_reg
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
	generic (
		bits : positive := 1;
		delay : time := 0ns );
    Port ( x : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : buffer STD_LOGIC_VECTOR (bits-1 downto 0);
           div : out STD_LOGIC);
end counter;

architecture behavioral of counter is

constant divider : natural := 0; --l'uscita div si alza quando il conteggio vale zero

begin
	process(x,rst)
	begin
		if rst = '1' then
			y <= (others => '0');
		elsif x'event and x = '1' then
			y <= y + "1" after delay;
		end if;
	end process;
	
	process(y)
	begin
		if y = std_logic_vector(to_unsigned(divider,y'length)) then
			div <= '1';
		else
			div <= '0';
		end if; 
	end process;

end behavioral;
