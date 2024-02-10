----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2023 19:18:50
-- Design Name: 
-- Module Name: handshake_system - structural
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

entity handshake_system is
	generic(
--		clk_B_freq : integer := 100000000 
		M : positive := 32;
		K : positive := 3 );
    Port ( start : in STD_LOGIC;
           clk_A : in STD_LOGIC;
           clk_B : in STD_LOGIC;
           rst : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (K-1 downto 0);
           mode : in STD_LOGIC;
--           cathodes : out STD_LOGIC_VECTOR (7 downto 0);
--           anodes : out STD_LOGIC_VECTOR (7 downto 0);
           data_out : out std_logic_vector(M-1 downto 0) );
end handshake_system;

architecture structural of handshake_system is
	component nodoA is
		Generic (
			M : positive;
			K : positive );
		Port ( start : in STD_LOGIC;
			   ack : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   ready : out STD_LOGIC;
			   data_out : out STD_LOGIC_VECTOR (M-1 downto 0));
	end component;
	
	component nodoB is
		generic(
--			clk_freq : integer := clk_B_freq; 
			M : positive;
			K : positive );
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
	end component;
	
	signal ready : std_logic;
	signal data : std_logic_vector (31 downto 0);
	signal ack : std_logic;
	
begin

	A : nodoA
	generic map(
		M => M,
		K => K ) 
	port map(
		start => start,
	   ack => ack,
	   rst => rst,
	   clk => clk_A,
	   ready => ready,
	   data_out => data );
	
	B : nodoB 
	generic map(
		M => M,
		K => K ) 
	port map(
		clk => clk_B,
	   rst => rst,
	   mode => mode,
	   ready => ready,
	   data_in => data,
	   addr => addr,
	   ack => ack,
	   data_out => data_out);

end structural;
