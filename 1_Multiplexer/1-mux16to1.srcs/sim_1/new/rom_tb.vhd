----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.09.2023 12:24:19
-- Design Name: 
-- Module Name: rom_tb - Behavioral
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

entity rom_tb is
--  Port ( );
end rom_tb;

architecture Behavioral of rom_tb is
	component rom port(
		addr : in std_logic_vector(3 downto 0);
		clk : in std_logic;
		y : out std_logic_vector(15 downto 0) );
	end component;
	signal input : std_logic_vector(3 downto 0);
	signal output : std_logic_vector(15 downto 0);
	signal clock : std_logic := '0';
	type rom_type is array(0 to 15) of std_logic_vector(15 downto 0);
	signal rom_check : rom_type := (
	x"0001",
	x"0003",
	x"0007",
	x"000f",
	x"001f",
	x"003f",
	x"007f",
	x"00ff",
	x"01ff",
	x"03ff",
	x"07ff",
	x"0fff",
	x"1fff",
	x"3fff",
	x"7fff",
	x"ffff" );
begin
	dut : rom port map(
		addr => input,
		clk => clock,
		y => output );
		
	gen_clk : process
	begin
		wait for 5ns;
		clock <= '1';
		wait for 5ns;
		clock <= '0';
	end process;
	
	process
	begin
		for i in 0 to 15 loop
			input <= std_logic_vector(to_unsigned(i,input'length));
			wait for 50ns;
			assert output = rom_check(i) report "error" severity failure;
		end loop;
	end process;

end Behavioral;
