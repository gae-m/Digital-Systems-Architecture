library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity rom is
	Generic (
		nbit_addr : positive := 3;
		width : positive := 16 );
    Port ( addr : in STD_LOGIC_VECTOR (nbit_addr-1 downto 0);
    		clk : in STD_LOGIC;
    		read : in STD_LOGIC;
    		rst : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (width-1 downto 0));
end rom;

architecture behavioral of rom is
	constant depth : positive := 2**nbit_addr;
	subtype word is std_logic_vector(width-1 downto 0);
	type rom_type is array(0 to depth-1) of word;
	
	signal rom : rom_type := (
	x"1",
	x"2",
	x"3",
	x"4",
	x"5",
	x"6",
	x"7",
	x"8" );

begin
	process(clk)
	begin
		if clk = '1' and clk'event then
			if rst = '1' then
				data_out <= rom(0);
			else
				if read = '1' then
					data_out <= rom(to_integer(unsigned(addr)));
				end if;
			end if;
		end if;
	end process;
	
end behavioral;