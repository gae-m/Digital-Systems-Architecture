----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2023 14:39:11
-- Design Name: 
-- Module Name: handshake_system_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity handshake_system_tb is
--  Port ( );
end handshake_system_tb;

architecture Behavioral of handshake_system_tb is
	component handshake_system is
		Port ( start : in STD_LOGIC;
			   clk_A : in STD_LOGIC;
			   clk_B : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   addr : in STD_LOGIC_VECTOR (2 downto 0);
			   mode : in STD_LOGIC;
			   cathodes : out STD_LOGIC_VECTOR (7 downto 0);
			   anodes : out STD_LOGIC_VECTOR (7 downto 0));
	end component;

	signal start : std_logic;
	signal clock_A : std_logic;
	signal clock_B : std_logic;
	signal reset : std_logic;
	signal address : std_logic_vector (2 downto 0);
	signal mode : std_logic;
	signal cathodes : std_logic_vector (7 downto 0);
	signal anodes : std_logic_vector (7 downto 0);	
		
begin
	dut : handshake_system port map(
		start => start,
		clk_A => clock_A,
		clk_B => clock_B,
		rst => reset,
		addr => address,
		mode => mode,
		cathodes => cathodes,
		anodes => anodes );

	clk_A_gen : process
	begin
		clock_A <= '0';
		wait for 5ns;
		clock_A <= '1';
		wait for 5ns;
	end process;
	
	clk_B_gen : process
	begin
		clock_B <= '0' after 4ns;
		wait for 10ns;
		clock_B <= '1' after 4 ns;
		wait for 10ns;
	end process;
	
	test : process
	begin
		start <= '0';
		reset <= '0';
		address <= "000";
		mode <= '0';
		wait for 10ns;
		
		reset <= '1';
		wait for 20ns;
		
		reset <= '0';
		start <= '1';
		wait for 10ns;
		start <= '0';
		
		wait for 1us;
		mode <= '1';
		wait for 25ns;
		for i in 0 to 7 loop
			address <= std_logic_vector(to_unsigned(i,address'length));
			wait for 25ns;
		end loop;
		wait;
		
	end process;
	
end Behavioral;
