----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 18:34:08
-- Design Name: 
-- Module Name: mux_2_1 - dataflow
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

entity mux_2_1 is
	generic(
		width : positive := 1 );
    Port ( x0 : in std_logic_vector (width-1 downto 0);
    		x1 : in std_logic_vector (width-1 downto 0);
           sel : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (width-1 downto 0));
end mux_2_1;

architecture dataflow of mux_2_1 is
	
begin
	with sel select
		y <= x0 when '0',
			x1 when '1',
			(others => '-') when others;
end dataflow;
