library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_comportamentale_tb is
end shift_register_comportamentale_tb;

architecture Behavioral of shift_register_comportamentale_tb is
    component shift_register_comportamentale is
    generic(
        N : integer := 16
    );
    port(
           in_parallelo : in STD_LOGIC_VECTOR (N-1 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           enable : in STD_LOGIC;
           shifts : in STD_LOGIC_VECTOR (3 downto 0);
           is_right : in STD_LOGIC;
           out_parallelo : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end component;

signal in_parallelo : STD_LOGIC_VECTOR (15 downto 0);
signal clk : STD_LOGIC;
signal rst : STD_LOGIC;
signal load : STD_LOGIC;
signal enable : STD_LOGIC;
signal shifts : STD_LOGIC_VECTOR (3 downto 0);
signal is_right : STD_LOGIC;
signal out_parallelo : STD_LOGIC_VECTOR (15 downto 0);

begin

    uut : shift_register_comportamentale generic map(
        N => 16
    ) port map(
        in_parallelo => in_parallelo, clk => clk, rst => rst, load => load, enable => enable, shifts => shifts, is_right => is_right, out_parallelo => out_parallelo
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
        shifts <= x"1";
        is_right <= '0';
        load <= '1';
        in_parallelo <= x"0001";
        wait for 15 ns;
        load <= '0';
        wait for 20 ns;
        shifts <= x"1";
        wait for 20 ns;
        shifts <= x"2";
        wait for 20 ns;
        is_right <= '1';
        wait for 20 ns;
        shifts <= x"2";
        wait for 20 ns;
        shifts <= x"3";
        wait for 20 ns;
        shifts <= x"3";
        wait for 50 ns;
        rst <= '1';
        wait;
    end process;

end Behavioral;
