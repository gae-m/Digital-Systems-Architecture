----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.01.2024 16:59:24
-- Design Name: 
-- Module Name: right_shifter - structural
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

entity right_shifter is
	Generic(
		WIDTH : positive );
    Port ( input_p : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           input_s : in STD_LOGIC;
           en : in STD_LOGIC;
           load : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           output_p : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           output_s : out STD_LOGIC);
end right_shifter;

architecture structural of right_shifter is
	signal out_ff : std_logic_vector(WIDTH downto 0);
	signal in_ff : std_logic_vector(WIDTH-1 downto 0);
begin
	out_ff(WIDTH) <= input_s;
	output_s <= out_ff(0);
	output_p <= out_ff(WIDTH-1 downto 0);
	
	comp : for i in WIDTH-1 downto 0 generate
		ff_D : entity work.ff_D
		port map(
			d => in_ff(i),
			ce => en,
			rst => rst,
			clk => clk,
			q => out_ff(i)
		 );
		 
		 mux : entity work.mux2to1
		 generic map(
		 	WIDTH => 1)
		 port map(
		 	x0 => out_ff(i+1 downto i+1),
		 	x1 => input_p(i downto i),
		 	sel => load,
		 	y => in_ff(i downto i) );
	end generate;

end structural;
