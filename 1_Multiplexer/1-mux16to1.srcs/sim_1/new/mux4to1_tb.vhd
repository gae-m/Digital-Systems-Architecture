library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4to1_tb is
--  Port ( );
end mux4to1_tb;

architecture Behavioral of mux4to1_tb is
    component mux4to1 port(
        x : in std_logic_vector(3 downto 0);
        s : in std_logic_vector(1 downto 0);
        y : out std_logic);
    end component;
    signal input : std_logic_vector(3 downto 0) := "0101";
    signal sel : std_logic_vector(1 downto 0);
    signal output : std_logic;
begin
    dut : mux4to1 port map(
        x => input,
        s => sel,
        y => output );
    process
    begin
        wait for 5ns;
        sel <= "00";
        wait for 5ns;
        assert output = input(0) report "errore" severity failure;
        sel <= "01";
        wait for 5ns;
        assert output = input(1) report "errore" severity failure;
        sel <= "10";
        wait for 5ns;
        assert output = input(2) report "errore" severity failure;
        sel <= "11";
        wait for 5ns;
        assert output = input(3) report "errore" severity failure;
        
    end process;

end Behavioral;
