----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 19:01:43
-- Design Name: 
-- Module Name: adder - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
	generic(
		dim : positive := 32);
    Port ( a : in STD_LOGIC_VECTOR (dim-1 downto 0);
           b : in STD_LOGIC_VECTOR (dim-1 downto 0);
           sum : out STD_LOGIC_VECTOR (dim-1 downto 0));
end adder;

architecture Behavioral of adder is

begin
	sum <= a + b;
end Behavioral;
