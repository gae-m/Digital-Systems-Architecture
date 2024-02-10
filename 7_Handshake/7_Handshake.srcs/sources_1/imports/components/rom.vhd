library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity rom is
	generic(
		nbit_addr : positive := 3;		-- numero di bit di indirizzamento
		width : positive := 32 );	-- dimensione di una word di memoria
    Port ( addr : in STD_LOGIC_VECTOR (nbit_addr - 1 downto 0);
    		read : in STD_LOGIC;
    		rst : in STD_LOGIC;
    		clk : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (width - 1 downto 0) );
end rom;

architecture behavioral of rom is
	constant depth : positive := 2**nbit_addr;
	subtype word is std_logic_vector (width - 1 downto 0);
	type rom_type is array(0 to depth - 1) of word;
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
	process(clk)
	begin
		if clk = '1' and clk'event then
			if rst = '1' then
				data_out <= rom(0);
			else
				if read = '1' then
					data_out <= rom(conv_integer(addr));
				end if;
			end if;
		end if;
	end process;
	
end behavioral;
