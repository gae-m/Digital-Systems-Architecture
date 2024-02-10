library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistema_di_testing is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           read : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(2 downto 0));
end sistema_di_testing;

architecture Structural of sistema_di_testing is

signal readU : STD_LOGIC;
signal en : STD_LOGIC;
signal incr : STD_LOGIC;
signal rst_dp : STD_LOGIC;

begin

    UO : entity work.unita_operativa port map(
        read => readU, en => en, inc => incr, 
        rst_dp => rst_dp, clk => clk, led => led
        );
    
    UC : entity work.unita_controllo port map(
           read_b => read, rst => rst, clk => clk, 
           read => readU, en => en, incr => incr, rst_dp => rst_dp);

end Structural;
