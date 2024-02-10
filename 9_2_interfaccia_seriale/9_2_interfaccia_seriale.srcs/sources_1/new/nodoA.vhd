----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 11:58:52
-- Design Name: 
-- Module Name: nodoA - structural
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
use work.nodoA_util.all;

entity nodoA is
	generic(
		BAUD_RATE_G : positive;		-- f_Tx = f_CLK / BAUD_RATE_G
		K : positive );
    Port ( send : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           TxD : out STD_LOGIC);
end nodoA;

architecture structural of nodoA is

	signal cword : ctrl_word_type;
	signal div : std_logic;
	signal TBE : std_logic;

begin
	ou : entity work.nodoA_ou
	generic map(
		BAUD_RATE_G => BAUD_RATE_G,		-- f_Tx = f_CLK / BAUD_RATE_G
		K => K )
	port map(
		clk => clk,
		ctrl_word => cword,
		TxD => TxD,
		div => div,
		TBE => TBE );
	
	cu : entity work.nodoA_cu
	port map(
		send => send,
		TBE => TBE,
		div => div,
		rst => rst,
		clk => clk,
		ctrl_word => cword );

end structural;
