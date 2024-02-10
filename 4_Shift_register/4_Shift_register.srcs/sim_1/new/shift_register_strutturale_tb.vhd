library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_strutturale_tb is
end shift_register_strutturale_tb;

architecture Behavioral of shift_register_strutturale_tb is
component shift_register_strutturale is
    generic(
        N : integer := 8
    );
    port(
           in_parallelo : in STD_LOGIC_VECTOR (N-1 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           enable : in STD_LOGIC;
           shifts : in STD_LOGIC_VECTOR (1 downto 0);
           out_parallelo : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end component;

signal in_parallelo : STD_LOGIC_VECTOR (7 downto 0);
signal clk : STD_LOGIC;
signal rst : STD_LOGIC;
signal load : STD_LOGIC;
signal enable : STD_LOGIC;
signal shifts : STD_LOGIC_VECTOR (1 downto 0);
signal out_parallelo : STD_LOGIC_VECTOR (7 downto 0);

begin
    uut : shift_register_strutturale generic map(
        N => 8
     ) port map (
        in_parallelo => in_parallelo, clk => clk, rst => rst, load => load, enable => enable, shifts => shifts, out_parallelo => out_parallelo
     );
     
     clock_tb : process begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
     end process;
     
     inputs_tb : process begin
        rst <= '0';
        enable <= '1';
        load <= '1';
        in_parallelo <= x"05";
        wait for 15 ns;
        load <= '0';
        shifts <= "00";
        wait for 50 ns;
        shifts <= "01";
        wait for 50 ns;
        shifts <= "11";
        wait for 50 ns;
        shifts <= "10";
        wait for 50 ns;
        rst <= '1';
        wait;
     end process;

end Behavioral;
