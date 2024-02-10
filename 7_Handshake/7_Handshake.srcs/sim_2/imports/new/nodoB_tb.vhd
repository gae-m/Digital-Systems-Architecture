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
use IEEE.std_logic_unsigned.all;

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
	constant clk_period : time := 10ns;
	constant M : positive := 32;
	constant K : positive := 3;
	
	signal clk : std_logic;
	signal rst : std_logic;
	signal mode : std_logic;
	signal ready : std_logic;
	signal data_in : std_logic_vector (M-1 downto 0);
	signal addr : std_logic_vector (K-1 downto 0);
	signal ack : std_logic;
	signal data_out : std_logic_vector(M-1 downto 0);
	
	constant depth : positive := 2**K;
	subtype word is std_logic_vector (M-1 downto 0);
	type rom_type is array(0 to depth-1) of word;
	constant rom : rom_type := (
		x"00010002",
		x"00030004",
		x"00050006",
		x"00070008",
		x"0009000A",
		x"000B000C",
		x"000D000E",
		x"000F0010"
	);
	
begin
	dut : entity work.nodoB
		port map(
			clk => clk,
			rst => rst,
			mode => mode,
			ready => ready,
			data_in => data_in,
			addr => addr,
			ack => ack,
			data_out => data_out);
			
	clk_gen : process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	process
	begin
		rst <= '1';
		mode <= '0';
		ready <= '0';
		data_in <= (others => '0');
		addr <= (others => '0');
		wait for 2*clk_period;
		
		rst <= '0';
		wait for clk_period;
		
		for i in 0 to 7 loop
			ready <= '1';
			wait until ack = '1';
			wait for 2*clk_period;
			ready <= '0';
			wait until ack = '0';
		end loop;
		
		mode <= '1';
		wait for 2*clk_period;
		for i in 0 to 7 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait on data_out;
			assert data_out = rom(i) report "Errore" severity failure;
		end loop;
			
		mode <= '0';
		data_in <= x"00000001";
		wait for clk_period;
		
		for i in 0 to 7 loop
			ready <= '1';
			wait until ack = '1';
			wait for 2*clk_period;
			ready <= '0';
			wait until ack = '0';
		end loop;
		
		mode <= '1';
		wait for 2*clk_period;
		for i in 0 to 7 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait on data_out;
			assert data_out = rom(i) + "1"  report "Errore" severity failure;
		end loop;

		rst <= '1';
		wait for 2*clk_period;
		rst <= '0';
		wait for clk_period;
		for i in 0 to 7 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait for clk_period;
			assert data_out = x"00000000" report "Errore" severity failure;
		end loop;
	end process;
	
end Behavioral;
