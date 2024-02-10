----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2024 10:55:41
-- Design Name: 
-- Module Name: sys_on_board - structural
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

entity sys_on_board is
	generic(
		WIDTH : positive := 8;
		CLK_PERIOD : integer := 10;				-- T = 10ns
		BTN_NOISE_TIME : integer := 500000000);	-- 0,5s
    Port ( x : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           y : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           mul_btn : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end sys_on_board;

architecture structural of sys_on_board is
	signal product : std_logic_vector(2*WIDTH-1 downto 0);
	signal display_data_in : std_logic_vector(31 downto 0);
	signal busy : std_logic;
	signal cleared_mul : std_logic;
	signal digits_enable : std_logic_vector(7 downto 0);
begin
	btn_deb : entity work.button_debouncer
	generic map(
		clk_period => CLK_PERIOD,
		btn_noise_time => BTN_NOISE_TIME )
	port map(
		rst => rst,
		clk => clk,
		btn => mul_btn,
		cleared_btn => cleared_mul);
	
	multiplier : entity work.Booth_multiplier
	generic map(
		WIDTH => WIDTH)
	port map(
		X => x,
		Y => y,
		multiply => cleared_mul,
		rst => rst,
		clk => clk,
		product => product,
		busy => busy);
		
	converter : entity work.digits_converter
	port map(
		x => product,
		y => display_data_in );
	
	digits_enable <= "00" & not busy & not busy & not busy & not busy & not busy & not busy;
	
	display : entity work.display_7seg_manager
	port map(
		value => display_data_in,
		dots => x"00",
		digits_enable => digits_enable,
		clk => clk,
		rst => rst,
		cathodes => cathodes,
		anodes => anodes);
end structural;
