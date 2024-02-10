library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity contatore_mod24 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           count : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR(4 downto 0);
           div : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR(4 downto 0));
end contatore_mod24;

architecture Behavioral of contatore_mod24 is
signal TY: std_logic_vector(4 downto 0);

begin

    Y <= TY;
    
    process(clk,rst) begin  
        if(clk'event and clk='1') then
            if(rst = '1') then
                TY <= (others => '0');
            elsif(load = '1') then
                TY <= data;
                elsif(count = '1') then
                    if(TY = "10111") then
                        TY <= (others => '0');
                    else
                        TY <= TY + "00001";
                end if; 
            end if;
        end if;    
    end process;
    
    process(TY) begin
        if(TY = "10111") then
            div <= '1';
        else
            div <= '0';
        end if;
    end process;    

end Behavioral;

