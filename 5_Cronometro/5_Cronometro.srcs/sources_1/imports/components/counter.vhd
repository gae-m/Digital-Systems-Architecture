library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

use IEEE.NUMERIC_STD.ALL;

entity counter is
	generic (
		bits : positive := 3;
		delay : time := 0ns;
		divider : positive
		);
    Port ( x : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : buffer STD_LOGIC_VECTOR (bits-1 downto 0);
           div : out STD_LOGIC);
end counter;

architecture behavioral of counter is

--constant divider : natural := 2**bits - 1;

begin
	process(x, rst)
	begin
	   if rst = '1' then
		  y <= (others => '0');
	   elsif x'event and x = '1' then
	       if y >= std_logic_vector(to_unsigned(divider - 1,y'length)) then
	           y <= (others => '0');
	        else y <= y + "1" after delay;
	       end if;
		end if;
	end process;

	process(y)
	begin
		if y = std_logic_vector(to_unsigned(divider - 1,y'length)) then
			div <= '1';
		else
			div <= '0';
		end if; 
	end process;

end behavioral;
