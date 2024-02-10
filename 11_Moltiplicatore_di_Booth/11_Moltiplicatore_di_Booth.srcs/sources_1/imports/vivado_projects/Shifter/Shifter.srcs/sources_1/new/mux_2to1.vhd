----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2024 17:37:50
-- Design Name: 
-- Module Name: mux_2to1 - dataflow
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

entity mux2to1 is
	generic(
		WIDTH : positive := 1 );
    Port ( x0 : in std_logic_vector (WIDTH-1 downto 0);
    		x1 : in std_logic_vector (WIDTH-1 downto 0);
           sel : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end mux2to1;

architecture dataflow of mux2to1 is
	
begin
	with sel select
		y <= x0 when '0',
			x1 when '1',
			(others => '-') when others;
end dataflow;
