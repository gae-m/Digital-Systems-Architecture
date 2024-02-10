----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 11:58:52
-- Design Name: 
-- Module Name: sys - structural
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

entity sys is
	generic(
		BAUD_DIVIDE_G : positive := 651;		-- baud_rate = 9600 con f_CLK = 100MHz
		K : positive := 3;
		CLK_B_DELAY : time := 0ns );
    Port ( send : in STD_LOGIC;
           mode : in STD_LOGIC;
           addr : in std_logic_vector (K-1 downto 0);
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end sys;

architecture structural of sys is
	
	constant BAUD_RATE_G : positive := 16 * BAUD_DIVIDE_G;	-- f_Tx = f_Rx/16
	signal data_line : std_logic;
	signal clk_B : std_logic;
	
begin

	clk_B <= clk after CLK_B_DELAY;
	
	nodoA : entity work.nodoA
	generic map(
		BAUD_RATE_G => BAUD_RATE_G,			-- f_Tx = f_CLK / BAUD_RATE_G
		K => K )
	port map(
		send => send,
		rst => rst,
		clk => clk,
		TxD => data_line );
			
	nodoB : entity work.nodoB
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G,		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		K => K )
	port map(
		mode => mode,
		addr => addr,
		RxD => data_line,
		clk => clk_B,
		rst => rst,
		data_out => data_out);

end structural;
