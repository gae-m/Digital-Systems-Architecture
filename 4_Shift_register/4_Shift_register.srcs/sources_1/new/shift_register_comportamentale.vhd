library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shift_register_comportamentale is
    generic( N : integer := 8);
    Port ( in_parallelo : in STD_LOGIC_VECTOR (N-1 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           enable : in STD_LOGIC;
           shifts : in STD_LOGIC_VECTOR (3 downto 0);
           is_right : in STD_LOGIC;
           out_parallelo : out STD_LOGIC_VECTOR (N-1 downto 0));
end shift_register_comportamentale;

architecture Behavioral of shift_register_comportamentale is
signal x : std_logic_vector (N-1 downto 0);
begin
    process(clk)
    begin
        if(clk'event and clk = '1') then
            if(rst = '1') then
                x <= (others => '0');
            elsif(enable = '1') then
                if(load = '1') then
                    x <= in_parallelo;
                elsif(is_right = '0') then
                    x(N - 1 downto conv_integer(shifts)) <= x(N - 1 - conv_integer(shifts) downto 0);
                    x(conv_integer(shifts) - 1 downto 0) <= x(N-1 downto N - conv_integer(shifts));
                elsif (is_right = '1') then
                    x(N - 1 - conv_integer(shifts) downto 0) <= x(N - 1 downto conv_integer(shifts));
                    x(N - 1 downto N - conv_integer(shifts)) <= x(conv_integer(shifts) - 1 downto 0);
                end if;    
            end if;
        end if;
     end process;
     
     out_parallelo <= x;     

end Behavioral;
