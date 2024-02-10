----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 16:14:52
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nodoA is
	Generic(
		M : positive := 32;
		K : positive := 3 );
    Port ( start : in STD_LOGIC;
           ack : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           ready : out STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end nodoA;

architecture structural of nodoA is
	component nodoA_CU is
		Port ( start : in STD_LOGIC;
			   ack : in STD_LOGIC;
			   div : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   ready : out STD_LOGIC;
			   inc : out STD_LOGIC;
			   strobe : out STD_LOGIC;
			   rst_dp : out STD_LOGIC);
	end component;
	
	component nodoA_datapath is
		Generic(
			M : positive;
			K : positive );
		Port ( inc : in STD_LOGIC;
				strobe : in STD_LOGIC;
				rst_dp : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   data_out : out STD_LOGIC_VECTOR (31 downto 0);
			   div : out STD_LOGIC );
	end component;
	
	-- segnali di stato
	signal div : std_logic;
	
	-- segnali di controllo
	signal increment : std_logic;
	signal strobe : std_logic;
	signal reset_dp : std_logic;
	
begin
	dp : nodoA_datapath 
	generic map(
		M => M,
		K => K )
	port map(
		inc => increment,
		strobe => strobe,
		rst_dp => reset_dp,
		clk => clk,
		data_out => data_out,
		div => div );
		
	cu : nodoA_CU port map(
		start => start,
		ack => ack,
		ready => ready,
		clk => clk,
		rst => rst,
		div => div,
		inc => increment,
		strobe => strobe,
		rst_dp => reset_dp );

end structural;
