----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2024 17:03:47
-- Design Name: 
-- Module Name: Booth_multiplier - Structural
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
use work.CU_util.all;

entity Booth_multiplier is
	Generic(
		WIDTH : positive := 8); -- WIDTH has to be a power of 2
	Port (
		X : in std_logic_vector(WIDTH-1 downto 0);
		Y : in std_logic_vector(WIDTH-1 downto 0);
		multiply : in std_logic;
		rst : in std_logic;
		clk : in std_logic;
		product : out std_logic_vector(2*WIDTH-1 downto 0);
		busy : out std_logic );
end Booth_multiplier;

architecture Structural of Booth_multiplier is
	signal sum : std_logic_vector(WIDTH-1 downto 0);
	signal parallel_out_A : std_logic_vector(WIDTH-1 downto 0);
	signal rst_A : std_logic;
	signal serial_in_Q : std_logic;
	signal parallel_in_Q : std_logic_vector(WIDTH downto 0);
	signal parallel_out_Q : std_logic_vector(WIDTH downto 0);
	signal reg_output : std_logic_vector(WIDTH-1 downto 0);
	signal div : std_logic;
	signal ctrl_word : ctrl_word_type;
begin
	busy <= ctrl_word(busy_CU);
	rst_A <= rst or ctrl_word(rst_A_CU);
	
	product(2*WIDTH-1 downto WIDTH) <= parallel_out_A;
	A : entity work.right_shifter
	generic map(
		WIDTH => WIDTH )
	port map(
		input_p => sum,
		input_s => parallel_out_A(WIDTH-1),
		en => ctrl_word(enable_A),
		load => ctrl_word(load_A),
		clk => clk,
		rst => rst_A,
		output_s => serial_in_Q,
		output_p => parallel_out_A );
		
	parallel_in_Q <= X & '0';
	Q : entity work.right_shifter
	generic map(
		WIDTH => WIDTH+1 )
	port map(
		input_p => parallel_in_Q,
		input_s => serial_in_Q,
		en => ctrl_word(enable_Q),
		load => ctrl_word(load_Q),
		clk => clk,
		rst => rst,
		output_p => parallel_out_Q );
	product(WIDTH-1 downto 0) <= parallel_out_Q(WIDTH downto 1);
		
	M : entity work.register_pp
	generic map(
		dim => WIDTH )
	port map(
		x => Y,
		clk => clk,
		rst => rst,
		enable => ctrl_word(enable_M),
		y => reg_output );
	
	adder : entity work.adder_subtractor
	generic map(
		NBIT => WIDTH)
	port map(
		a => parallel_out_A,
		b => reg_output,
		sub => ctrl_word(subtract),
		res => sum );

	counter : entity work.counter
	generic map(
		bits => positive(ceil(log2(real(WIDTH)))) )
	port map(
		x => ctrl_word(count_in),
		rst => rst,
		div => div );
		
	CU : entity work.control_unit
	port map(
		mul => multiply,
		Q => parallel_out_Q(1 downto 0),
		div => div,
		rst => rst,
		clk => clk,
		ctrl_word => ctrl_word);
end Structural;
