----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2023 15:48:14
-- Design Name: 
-- Module Name: display_7seg_manager - structural
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

entity display_7seg_manager is
    Port ( value : in STD_LOGIC_VECTOR (31 downto 0);
           dots : in STD_LOGIC_VECTOR (7 downto 0);
           digits_enable : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end display_7seg_manager;

architecture structural of display_7seg_manager is
	component digits_splitter is
		Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
			   dots : in STD_LOGIC_VECTOR (7 downto 0);
			   digit_select : in STD_LOGIC_VECTOR (2 downto 0);
			   digit : out STD_LOGIC_VECTOR (3 downto 0);
			   dot : out STD_LOGIC);
	end component;
	
	component counter is
		generic (
			bits : positive;
			divider : positive );
		Port ( x : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   y : buffer STD_LOGIC_VECTOR (bits-1 downto 0);
			   div : out STD_LOGIC);
	end component;
	
	component clock_filter is
		Port ( clk_in : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   clk_out : out STD_LOGIC);
	end component;
	
	component cathodes_manager is
		Port ( value : in STD_LOGIC_VECTOR (3 downto 0);
				dot : in STD_LOGIC;
			   cathodes : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component anodes_manager is
		Port (
			digit_select : in std_logic_vector(2 downto 0);
			digits_enable : in std_logic_vector (7 downto 0);
			anodes : out std_logic_vector(7 downto 0)
		 );
	end component;
	
	signal clock_filtered : std_logic;
	signal count : std_logic_vector (2 downto 0);
	signal digit : std_logic_vector (3 downto 0);
	signal dot : std_logic;

begin
	clk_filter : clock_filter port map (
		clk_in => clk,
		rst => rst,
		clk_out => clock_filtered );
	
	counter_mod8 : counter generic map (
		bits => 3, divider => 8)
	port map(
		x => clock_filtered,
		rst => rst,
		y => count );
		
	splitter : digits_splitter port map (
	 	x => value,
	 	dots => dots,
	 	digit_select => count,
	 	digit => digit,
	 	dot => dot );
	 	
	 cat_man : cathodes_manager port map (
	 	value => digit,
	 	dot => dot,
	 	cathodes => cathodes );
	 	
	 an_man : anodes_manager port map (
	 	digit_select => count,
	 	digits_enable => digits_enable,
	 	anodes => anodes );
	 
end structural;
