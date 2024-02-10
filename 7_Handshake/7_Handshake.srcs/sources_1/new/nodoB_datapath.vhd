----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 18:31:34
-- Design Name: 
-- Module Name: nodoB_datapath - structural
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

entity nodoB_datapath is
	generic(
--		clk_freq : integer := 100000000;
		M : positive := 32;
		K : positive := 3 );
    Port ( addr : in STD_LOGIC_VECTOR (K-1 downto 0);
           data_in : in STD_LOGIC_VECTOR (M-1 downto 0);
           rst_dp : in STD_LOGIC;
           clk : in STD_LOGIC;
           inc : in STD_LOGIC;
           en_reg : in STD_LOGIC;
           ctrl_mode : in STD_LOGIC;
           en_mem : in STD_LOGIC;
           strobe : in STD_LOGIC;
           data_out : out std_logic_vector(M-1 downto 0) );
--           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
--           anodes : out STD_LOGIC_VECTOR (7 downto 0));
end nodoB_datapath;

architecture structural of nodoB_datapath is

	signal op1 : std_logic_vector (M-1 downto 0);
	signal op2 : std_logic_vector (M-1 downto 0);
	signal count : std_logic_vector (K-1 downto 0);
	signal mem_addr : std_logic_vector (K-1 downto 0);
	signal sum : std_logic_vector (M-1 downto 0);

begin
	reg0 : entity work.register_pp(behavioral)
		generic map(
			dim => M )
		port map( 
			x => data_in,
			clk => clk,
			rst => rst_dp,
			enable => en_reg,
			y => op2 );
	
--	reg2 : entity work.register_pp(behavioral)
--		generic map(
--			dim => 32 )
--		port map( 
--			x => sum,
--			clk => clk,
--			rst => rst,
--			enable => en_reg2,
--			y => out_reg2 );
			
	counter0 : entity work.counter(behavioral)
		generic map(
			bits => K)
		Port map( 
			x => inc,
			rst => rst_dp,
			y => count );
	
	mux0 : entity work.mux_2_1(dataflow)
		port map(
			x0 => count,
			x1 => addr,
			sel => ctrl_mode,
			y => mem_addr );
	
	mem0 : entity work.memory(behavioral)
		generic map(
			nbits_addr => K,	-- numero di bit di indirizzamento
			width => M )	-- dimensione di una word di memoria
		Port map( 
			addr => mem_addr,
			en => en_mem,
			clk => clk,
			rst => rst_dp,
			data_in => sum,
			r_w => ctrl_mode,		-- r_w= 1 => read ; r_w = 0 => write
		  	data_out => data_out );
		  	
	adder0 : entity work.adder(behavioral)
		port map(
			a => op1,
			b => op2,
			sum => sum );
			
	rom0 : entity work.rom(behavioral)
		port map( 
			addr => count,
    		read => strobe,
    		rst => rst_dp,
    		clk => clk,
           data_out => op1 );
	
--	dec0 : entity work.decoder(dataflow)
--		port map(
--			x => ctrl_mode,
--			y => en_digits );
		
--	display : entity work.display_7seg_manager(structural)
--		generic map(
--			clk_freq => clk_freq )
--		Port map(
--			value => b,
--		    dots => (others => '0'),
--			digits_enable => en_digits,
--			clk => clk,
--			rst => rst,
--			cathodes => cathodes,
--			anodes => anodes );
		
end structural;
