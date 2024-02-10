----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 12:13:30
-- Design Name: 
-- Module Name: memory - Behavioral
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

entity memory is
	generic(
		nbits_addr : positive := 3;	-- numero di bit di indirizzamento
		width : positive := 32 );	-- dimensione di una word di memoria
    Port ( addr : in STD_LOGIC_VECTOR (nbits_addr - 1 downto 0);
           en : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (width - 1 downto 0);
           r_w : in STD_LOGIC;		-- r_w = 1 => read ; r_w = 0 => write
           data_out : out STD_LOGIC_VECTOR (width - 1 downto 0));
end memory;

architecture Behavioral of memory is
	constant depth : positive := 2**nbits_addr;
	subtype word is std_logic_vector (width - 1 downto 0);
	
	type mem_type is array(0 to depth - 1) of word;
--	constant default_mem : mem_type := (
--		x"00000001",
--		x"00000002",
--		x"00000003",
--		x"00000004",
--		x"00000005",
--		x"00000006",
--		x"00000007",
--		x"00000008"
--	);
	signal mem : mem_type;

begin
	process(clk)
	begin
		if clk = '1' and clk'event then
			if rst = '1' then
				for i in 0 to depth-1 loop
					mem(i) <= (others => '0');
				end loop;
			else
				if en = '1' then
					if r_w = '1' then
						data_out <= mem(to_integer(unsigned(addr)));
					else
						mem(to_integer(unsigned(addr))) <= data_in;
					end if;
				end if;
			end if;
		end if;
	end process;

end Behavioral;
