----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2024 13:08:21
-- Design Name: 
-- Module Name: handshake_sys_bdt - structural
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

entity handshake_sys_bdt is
	Generic(
		M : positive := 32;
		K : positive := 3; 
		clk_B_factor : positive := 4;
		clk_B_delay : time := 4ns);
    Port ( start : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (K-1 downto 0);
           mode : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst_sys : in STD_LOGIC;
           rst_bdt : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(M-1 downto 0) );
end handshake_sys_bdt;

architecture structural of handshake_sys_bdt is
	signal clock_A : std_logic;
	signal clock_B : std_logic;
	
begin

	hs_sys : entity work.handshake_system
	generic map(
		M => M,
		K => K )
	port map(
		start => start,
		clk_A => clock_A,
		clk_B => clock_B,
		rst => rst_sys,
		addr => addr,
		mode => mode,
		data_out => data_out );
		
	bdt : entity work.base_dei_tempi
	generic map(
		clk_B_factor => clk_B_factor,
		clk_B_delay => clk_B_delay)
    port map( 
    	clk => clk,
        rst => rst_bdt,
       	clk_A => clock_A,
       	clk_B => clock_B);

	


end structural;
