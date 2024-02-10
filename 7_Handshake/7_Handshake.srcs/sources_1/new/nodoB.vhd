----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 18:31:34
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nodoB is
	generic(
--		clk_freq : integer := 100000000 
		M : positive := 32;
		K : positive := 3 );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           mode : in STD_LOGIC;
           ready : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (M-1 downto 0);
           addr : in STD_LOGIC_VECTOR (K-1 downto 0);
           ack : out STD_LOGIC;
--           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
--           anodes : out STD_LOGIC_VECTOR (7 downto 0)
			data_out : out std_logic_vector(M-1 downto 0) );
end nodoB;

architecture structural of nodoB is
	signal increment : std_logic;
	signal strobe : std_logic;
	signal enable_reg : std_logic;
	signal enable_mem : std_logic;
	signal reset_dp : std_logic;
	signal control_mode : std_logic;

begin
	dp : entity work.nodoB_datapath(structural)
		generic map (
--			clk_freq => clk_freq 
			M => M,
			K => K )
		port map(
			addr => addr,
           data_in => data_in,
           rst_dp => reset_dp,
           clk => clk,
           inc => increment,
           en_reg => enable_reg,
           strobe => strobe,
           ctrl_mode => control_mode,
           en_mem => enable_mem,
--           cathodes => cathodes,
--           anodes => anodes, 
           data_out => data_out );

	cu : entity work.nodoB_CU(Behavioral)
		port map(
			ready => ready,
           mode => mode,
           clk => clk,
           rst => rst,
           ack => ack,
           en_mem => enable_mem,
           en_reg => enable_reg,
           strobe => strobe,
           inc => increment,
           rst_dp => reset_dp, 
           ctrl_mode => control_mode );

end structural;
