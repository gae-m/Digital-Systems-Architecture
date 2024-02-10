library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
	Generic (
		nbit_addr : positive;
		width : positive );
    Port ( addr : in STD_LOGIC_VECTOR (nbit_addr-1 downto 0);
    		clk : in STD_LOGIC;
    		read : in STD_LOGIC;
    		rst : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (width-1 downto 0));
end rom;

architecture dataflowA of rom is

    constant depth : positive := 2**nbit_addr;
	subtype word is std_logic_vector(width-1 downto 0);
	type rom_type is array(0 to depth-1) of word;
	
	--BEGIN ROM
	constant rom_val : rom_type := (
	x"01",
	x"40",
	x"04",
	x"08",
	x"10",
	x"20",
	x"40",
	x"80" );
	--END ROM

begin
	process(clk)
	begin
		if clk = '1' and clk'event then
			if rst = '1' then
				data_out <= rom_val(0);
			else
				if read = '1' then
					data_out <= rom_val(to_integer(unsigned(addr)));
				end if;
			end if;
		end if;
	end process;
	
end dataflowA;


architecture dataflowB of rom is

    constant depth : positive := 2**nbit_addr;
	subtype word is std_logic_vector(width-1 downto 0);
	type rom_type is array(0 to depth-1) of word;
	
	--BEGIN ROM
	constant rom_val : rom_type := (
	x"03",
	x"01",
	x"04",
	x"08",
	x"01",
	x"02",
	x"40",
	x"80" );
	--END ROM

begin
	process(clk)
	begin
		if clk = '1' and clk'event then
			if rst = '1' then
				data_out <= rom_val(0);
			else
				if read = '1' then
					data_out <= rom_val(to_integer(unsigned(addr)));
				end if;
			end if;
		end if;
	end process;
	
end dataflowB;