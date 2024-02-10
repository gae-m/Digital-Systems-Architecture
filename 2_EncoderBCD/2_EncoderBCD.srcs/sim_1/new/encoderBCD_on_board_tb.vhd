library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoderBCD_on_board_tb is
--  Port ( );
end encoderBCD_on_board_tb;

architecture Behavioral of encoderBCD_on_board_tb is
	component encoderBCD_on_board port(
		switch : in STD_LOGIC_VECTOR (9 downto 0);
		led : out STD_LOGIC_VECTOR (3 downto 0);
		anodes : out STD_LOGIC_VECTOR (7 downto 0);
		cathodes : out STD_LOGIC_VECTOR (7 downto 0) );
	end component;
	
	signal input : STD_LOGIC_VECTOR (9 downto 0);
	signal output_led : STD_LOGIC_VECTOR (3 downto 0);
	signal output_anodes :  STD_LOGIC_VECTOR (7 downto 0);
	signal output_cathodes : STD_LOGIC_VECTOR (7 downto 0);
	
	type oracle_led_type is array(0 to 9) of std_logic_vector(3 downto 0);
	constant oracle_led : oracle_led_type := (
		x"0", x"1", x"2", x"3", x"4", x"5", x"6", x"7", x"8", x"9" );
		
	type digit_type is array (0 to 15) of std_logic_vector(6 downto 0);
	constant oracle_cathodes : digit_type := (
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
	dut : encoderBCD_on_board port map(
		switch => input,
		led => output_led,
		anodes => output_anodes,
		cathodes => output_cathodes );
		
	process
	begin
		input <= "0000000000";
		wait for 50ns;
		assert output_led = "----" report "error led" severity failure;
		assert output_anodes = x"fe" report "error anode" severity failure;
		--assert output_cathodes = "----" report "error_led" severity failure;
		
		for i in 0 to 9 loop
			input(i) <= '1';
			wait for 50ns;
			assert output_led = oracle_led(i) report "error led" severity failure;
			assert output_anodes = x"fe" report "error anode" severity failure;
			assert output_cathodes = '1' & oracle_cathodes(i) report "error cathodes" severity failure;
		end loop;
	end process;

end Behavioral;
