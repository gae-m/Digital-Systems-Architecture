----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 19:20:38
-- Design Name: 
-- Module Name: base_dei_tempi - Behavioral
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
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity base_dei_tempi is
	generic(
		clk_B_factor : positive := 4;
		clk_B_delay : time := 4ns );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_A : out STD_LOGIC;
           clk_B : out STD_LOGIC);
end base_dei_tempi;

architecture structural of base_dei_tempi is
	component counter is
		generic (
			bits : positive := positive(ceil(log2(real(clk_B_factor))));
			delay : time := 4ns );	-- delay per sfasare clk_A e clk_B
		Port ( x : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   y : buffer STD_LOGIC_VECTOR (bits-1 downto 0);
			   div : out STD_LOGIC);
	end component;
	
begin
	clk_A <= clk;

	counter0 : counter
		port map(
			x => clk,
			rst => rst,
			div => clk_B );		
			
end structural;
