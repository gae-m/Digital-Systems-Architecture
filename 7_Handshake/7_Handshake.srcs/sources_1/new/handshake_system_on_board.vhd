----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2023 18:48:06
-- Design Name: 
-- Module Name: handshake_system_on_board - structural
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

entity handshake_system_on_board is
    Port ( start : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (2 downto 0);
           mode : in STD_LOGIC;
           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end handshake_system_on_board;

architecture structural of handshake_system_on_board is
	component handshake_system is
		generic(
			clk_B_freq : integer := 100000000/4 );
		Port ( start : in STD_LOGIC;
			   clk_A : in STD_LOGIC;
			   clk_B : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   addr : in STD_LOGIC_VECTOR (2 downto 0);
			   mode : in STD_LOGIC;
			   cathodes : out STD_LOGIC_VECTOR (7 downto 0);
			   anodes : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component button_debouncer is
		generic (                       
			clk_period : integer := 10;
			btn_noise_time : integer := 65000000
		);
		Port ( rst : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   btn : in STD_LOGIC;
			   cleared_btn : out STD_LOGIC);
	end component;
	
	component base_dei_tempi is
		generic(
			clk_B_factor : positive := 4;
			clk_B_delay : time := 4ns );
		Port ( clk : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   clk_A : out STD_LOGIC;
			   clk_B : out STD_LOGIC);
	end component;
	
	signal cleared_start : std_logic;
	signal cleared_rst : std_logic;
	signal clock_A : std_logic;
	signal clock_B : std_logic;
begin
	bd_start : button_debouncer
		port map(
			clk => clock_A,
			rst => '0',
			btn => start,
			cleared_btn => cleared_start );
			
	bd_rst : button_debouncer
		port map(
			clk => clock_B,
			rst => '0',
			btn => rst,
			cleared_btn => cleared_rst );
			
	bdt : base_dei_tempi
		port map(
			clk => clk,
			rst => cleared_rst,
			clk_A => clock_A,
			clk_B => clock_B );
			
	hs : handshake_system
		port map(
			start => cleared_start,
			clk_A => clock_A,
			clk_B => clock_B,
			rst => cleared_rst,
			addr => addr,
			mode => mode,
			cathodes => cathodes,
			anodes => anodes );
			
end structural;
