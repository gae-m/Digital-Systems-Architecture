library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity rom is
    Port ( addr : in STD_LOGIC_VECTOR (3 downto 0);
    		clk : in STD_LOGIC;
    		--read : in STD_LOGIC;
    		--rst : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR (15 downto 0));
end rom;

architecture dataflow of rom is
	type rom_type is array(0 to 15) of std_logic_vector(15 downto 0);
	signal rom : rom_type := (
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
	process(clk)
	begin
		if clk = '1' and clk'event then
			y <= rom(conv_integer(addr));
		end if;
	end process;
	
end dataflow;
