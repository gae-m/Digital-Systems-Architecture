library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity demux1to4_tb is
--  Port ( );
end demux1to4_tb;

architecture Behavioral of demux1to4_tb is
    component demux1to4 port(
        x : in std_logic;
        s : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(3 downto 0) );
    end component;
    signal input : std_logic := '1';
    signal sel : std_logic_vector(1 downto 0);
    signal output : std_logic_vector(3 downto 0);
begin
    dut : demux1to4 port map(
        x => input,
        s => sel,
        y => output );
        
    process
    begin
        wait for 5ns;
        for i in 0 to 3 loop
            sel <= std_logic_vector(to_unsigned(i,sel'length));
            wait for 5ns;
            assert output(i) = input report "errore" severity failure;
        end loop;
    end process;

end Behavioral;
