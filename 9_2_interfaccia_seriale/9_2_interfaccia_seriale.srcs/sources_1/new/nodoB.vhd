----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 11:58:52
-- Design Name: 
-- Module Name: nodoB - structural
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
use work.nodoB_util.all;

entity nodoB is
	generic(
		BAUD_DIVIDE_G : positive;		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		K : positive );
    Port ( mode : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (K-1 downto 0);
           RxD : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end nodoB;

architecture structural of nodoB is

	signal cword : ctrl_word_type;
	signal RDA : std_logic;
	
begin

	ou : entity work.nodoB_ou
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G,		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		K => K )
	port map(
		RxD => RxD,
		clk => clk,
		addr => addr,
		ctrl_word => cword,
		data_out => data_out,
		RDA => RDA );
	
	cu : entity work.nodoB_cu
	port map(
		mode => mode,
		RDA => RDA,
		rst => rst,
		clk => clk,
		ctrl_word => cword);

end structural;
