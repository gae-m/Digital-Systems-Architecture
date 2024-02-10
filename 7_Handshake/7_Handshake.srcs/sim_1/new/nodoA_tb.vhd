----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 17:01:51
-- Design Name: 
-- Module Name: nodoA_tb - Behavioral
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

entity nodoA_tb is
--  Port ( );
end nodoA_tb;

architecture Behavioral of nodoA_tb is
	constant width : positive := 32;
	constant nbit_addr : positive := 3;
	constant depth : positive := 2**nbit_addr;
	 
	component nodoA is
		Generic(
			M : positive := width;
			K : positive := nbit_addr );
		Port ( start : in STD_LOGIC;
			   ack : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   ready : out STD_LOGIC;
			   data_out : out STD_LOGIC_VECTOR (width-1 downto 0));
	end component;
	
	signal start : std_logic;
	signal ack : std_logic := '0';
	signal rst : std_logic;
	signal clk : std_logic;
	
	signal ready : std_logic;
	signal data_out : std_logic_vector (width-1 downto 0);
	
	shared variable count : integer := 0;
	
	subtype word is std_logic_vector (width-1 downto 0);
	type rom_type is array(0 to depth-1) of word;
	constant oracle : rom_type := (
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
	dut : nodoA port map(
		start => start,
		ack => ack,
		rst => rst,
		clk => clk,
		ready => ready,
		data_out => data_out );
		
	clk_gen : process
	begin
		clk <= '0';
		wait for 5ns;
		clk <= '1';
		wait for 5ns;
	end process;
	
	process
	begin
		rst <= '1';
		start <= '0';
		wait for 15ns;
		
		rst <= '0';
		wait for 15ns;
		
		start <= '1';
		wait for 15ns;
		start <= '0';
		
		
		wait for 255ns;
		start <= '1';
		wait for 15ns;
		start <= '0';
		
		wait for 285ns;
	end process; 
	
	process
	begin
		wait until ready'event and ready = '1';
		assert data_out <= oracle(count) report "error" severity failure;
		count := (count + 1)mod 8;
		wait for 5ns;
		ack <= '1';
		
		wait until ready'event and ready = '0';
		wait for 5ns;
		ack <= '0';
		
	end process;

end Behavioral;
