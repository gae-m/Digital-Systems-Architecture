library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flopD is
    Port ( d : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable : in STD_LOGIC;
           q : out STD_LOGIC);
end flip_flopD;

architecture Behavioral of flip_flopD is
begin
    process(clk)
    begin
        if( clk'event and clk = '1') then
            if( rst = '1' ) then
                q <= '0';
            elsif(enable = '1') then
                    q <= d; 
            end if;
        end if;
    end process;

end Behavioral;
