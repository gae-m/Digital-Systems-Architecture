library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux16to1 is
  Port (
    x : in std_logic_vector(15 downto 0);
    s : in std_logic_vector(3 downto 0);
    y : out std_logic );
end mux16to1;

architecture structural of mux16to1 is
    component mux4to1 port(
        x : in std_logic_vector(3 downto 0);
        s : in std_logic_vector(1 downto 0);
        y : out std_logic );
    end component;
--    for all : mux4to1 use entity work.mux4to1(dataflow);
    
    signal w : std_logic_vector (3 downto 0);
begin
    m0_3 : for i in 0 to 3 generate
        m : mux4to1 port map(
            x => x(i*4+3 downto i*4),
            s => s(1 downto 0),
            y => w(i) );
    end generate;
    m4 : mux4to1 port map(
        x => w,
        s => s(3 downto 2),
        y => y ); 
    
end structural;
