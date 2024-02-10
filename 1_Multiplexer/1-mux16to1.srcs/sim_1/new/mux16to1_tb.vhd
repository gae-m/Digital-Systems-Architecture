library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity mux16to1_tb is
--  Port ( );
end mux16to1_tb;

architecture Behavioral of mux16to1_tb is
    component mux16to1 port(
        x : in std_logic_vector(15 downto 0);
        s : in std_logic_vector(3 downto 0);
        y : out std_logic );
    end component;
    
    signal input : std_logic_vector(15 downto 0) := x"d555";
    signal sel : std_logic_vector(3 downto 0);
    signal output : std_logic;
begin
    dut : mux16to1 port map(
        x => input,
        s => sel,
        y => output );
        
    process
    begin
        wait for 5ns;
        for i in 0 to 15 loop
            sel <= std_logic_vector(to_unsigned(i,sel'length));
            wait for 5ns;
            assert output = input(i) report "errore" severity failure;
        end loop;
    end process;

end Behavioral;
