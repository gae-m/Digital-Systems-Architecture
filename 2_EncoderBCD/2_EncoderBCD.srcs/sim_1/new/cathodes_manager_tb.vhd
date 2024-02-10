library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cathodes_manager_tb is
--  Port ( );
end cathodes_manager_tb;

architecture Behavioral of cathodes_manager_tb is
	component cathodes_manager port(
		value : in std_logic_vector(3 downto 0);
		dot : in std_logic;
		cathodes : out std_logic_vector(7 downto 0) );
	end component;
	signal input_value : std_logic_vector(3 downto 0) := "0000";
	signal input_dot : std_logic := '0';
	signal output : std_logic_vector(7 downto 0);
	
	type digit_type is array (0 to 15) of std_logic_vector(6 downto 0);
	constant oracle : digit_type := (
	"1000000", -- 0
	"1111001", -- 1
	"0100100", -- 2
	"0110000", -- 3
	"0011001", -- 4
	"0010010", -- 5
	"0000010", -- 6
	"1111000", -- 7
	"0000000", -- 8
	"0010000", -- 9
	"0001000", -- A
	"0000011", -- b
	"1000110", -- C
	"0100001", -- d
	"0000110", -- E
	"0001110");-- F
begin
	-- Design Under Test
	dut : cathodes_manager port map(
		value => input_value,
		dot => input_dot,
		cathodes => output );
	
	process
	begin
		input_dot <= '0';
		for i in 0 to 15 loop
			input_value <= std_logic_vector(to_unsigned(i,input_value'length));
			wait for 30ns;
			assert output = '1' & oracle(i) report "error" severity failure;
		end loop;
		
		input_dot <= '1';
		for i in 0 to 15 loop
			input_value <= std_logic_vector(to_unsigned(i,input_value'length));
			wait for 30ns;
			assert output = '0' & oracle(i) report "error" severity failure;
		end loop;
	end process;

end Behavioral;
