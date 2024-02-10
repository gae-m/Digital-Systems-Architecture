----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 11:58:52
-- Design Name: 
-- Module Name: nodoB_ou - Behavioral
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

entity nodoB_ou is
	generic(
		BAUD_DIVIDE_G : positive;		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		K : positive );
    Port ( RxD : in STD_LOGIC;
           clk : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (K-1 downto 0);
           ctrl_word : in ctrl_word_type;
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           RDA : inout STD_LOGIC);
end nodoB_ou;

architecture structural of nodoB_ou is

	signal dbout : std_logic_vector(7 downto 0);
	signal count : std_logic_vector(K-1 downto 0);
	signal mem_addr : std_logic_vector(K-1 downto 0);
	
begin
	uart0 : entity work.UARTcomponent
		generic map(
			BAUD_DIVIDE_G => BAUD_DIVIDE_G )		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		port map(
			DBIN => (others => '0'),
			WR => '0',
			RST => ctrl_word(rst_ou),
			CLK => clk,
			RXD => RxD,
			RD => ctrl_word(read),
			DBOUT => dbout,
			RDA => RDA );
			
	counter0 : entity work.counter
		generic map(
			bits => K,
			delay => 0ns )
		port map(
			x => ctrl_word(incr),
			rst => ctrl_word(rst_ou),
			y => count );
			
	mux0 : entity work.mux_2_1
		generic map(
			width => K )
		port map(
			x0 => count,
			x1 => addr,
			sel => ctrl_word(ctrl_mode),
			y => mem_addr );
			
	mem0 : entity work.memory
		generic map(
			nbits_addr => K,
			width => 8 )
		port map(
			addr => mem_addr,
			en => ctrl_word(en_mem),
			clk => clk,
			rst => ctrl_word(rst_ou),
			data_in => dbout,
			r_w => ctrl_word(ctrl_mode),
			data_out => data_out);
	
end structural;
