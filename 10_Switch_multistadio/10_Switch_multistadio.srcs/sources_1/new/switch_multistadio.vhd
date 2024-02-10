library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_multistadio is
    Port ( x0 : in STD_LOGIC_VECTOR(5 downto 0);
           x1 : in STD_LOGIC_VECTOR(5 downto 0);
           x2 : in STD_LOGIC_VECTOR(5 downto 0);
           x3 : in STD_LOGIC_VECTOR(5 downto 0);
           s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           s2 : in STD_LOGIC;
           s3 : in STD_LOGIC;
           out0 : out STD_LOGIC_VECTOR(1 downto 0);
           out1 : out STD_LOGIC_VECTOR(1 downto 0);
           out2 : out STD_LOGIC_VECTOR(1 downto 0);
           out3 : out STD_LOGIC_VECTOR(1 downto 0));
end switch_multistadio;

architecture structural of switch_multistadio is

signal sc_0 : STD_LOGIC_VECTOR(1 downto 0);
signal sc_1 : STD_LOGIC_VECTOR(1 downto 0);
signal sc_2 : STD_LOGIC_VECTOR(1 downto 0);
signal sc_3 : STD_LOGIC_VECTOR(1 downto 0);

signal sorg : STD_LOGIC_VECTOR(1 downto 0);
signal dest : STD_LOGIC_VECTOR(1 downto 0);

begin

    uc: entity work.unita_controllo port map(
        x0=> x0, x1 => x1, x2 => x2, x3 => x3, en00 => s0, en01 => s1, en10 => s2, en11 => s3,
         y0 => sc_0, y1 => sc_1, y2 => sc_2, y3 => sc_3, s => sorg, d => dest);
         
    uo: entity work.unita_operativa port map(
        m0 => sc_0, m1 => sc_1, m2 => sc_2, m3 => sc_3, s => sorg, d => dest, 
        out0 => out0, out1 => out1, out2 => out2, out3 => out3);

end structural;
