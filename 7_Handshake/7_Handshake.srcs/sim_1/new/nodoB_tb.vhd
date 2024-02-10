----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2023 17:32:22
-- Design Name: 
-- Module Name: nodoB_tb - Behavioral
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

entity nodoB_tb is
--  Port ( );
end nodoB_tb;

architecture Behavioral of nodoB_tb is
	component nodoB is
		Port ( clk : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   mode : in STD_LOGIC;
			   ready : in STD_LOGIC;
			   data_in : in STD_LOGIC_VECTOR (31 downto 0);
			   addr : in STD_LOGIC_VECTOR (2 downto 0);
			   ack : out STD_LOGIC;
			   cathodes : out STD_LOGIC_VECTOR (7 downto 0);
			   anodes : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	signal clk : std_logic;
	signal rst : std_logic;
	signal mode : std_logic;
	signal ready : std_logic;
	signal data_in : std_logic_vector (31 downto 0);
	signal addr : std_logic_vector (2 downto 0);
	signal ack : std_logic;
	signal cathodes : std_logic_vector (7 downto 0);
	signal anodes : std_logic_vector (7 downto 0);
	
begin
	dut : nodoB
		port map(
			clk => clk,
			rst => rst,
			mode => mode,
			ready => ready,
			data_in => data_in,
			addr => addr,
			ack => ack,
			cathodes => cathodes,
			anodes => anodes );
			
	clk_gen : process
	begin
		clk <= '0';
		wait for 5ns;
		clk <= '1';
		wait for 5ns;
	end process;
	
	process
	begin
		rst <= '0';
		mode <= '0';
		ready <= '0';
		data_in <= (others => '0');
		addr <= (others => '0');
		wait for 10ns;
		rst <= '1';
		wait for 20ns;
		rst <= '0';
		wait for 10ns;
		
		for i in 0 to 7 loop
			ready <= '1';
			wait until ack = '1';
			wait for 10ns;
			ready <= '0';
			wait until ack = '0';
		end loop;
		
		wait for 9ns;
		mode <= '1';
		for i in 0 to 7 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait for 20ns;
		end loop;
		
		mode <= '0';
		data_in <= x"00000001";
		wait for 10ns;
		
		for i in 0 to 7 loop
			ready <= '1';
			wait until ack = '1';
			wait for 10ns;
			ready <= '0';
			wait until ack = '0';
		end loop;
		
		wait for 10ns;
		mode <= '1';
		for i in 0 to 7 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait for 20ns;
		end loop;
	end process;


end Behavioral;
