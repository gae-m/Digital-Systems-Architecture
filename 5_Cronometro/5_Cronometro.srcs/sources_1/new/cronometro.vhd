library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity cronometro is
    generic ( clk_B_factor : positive);
    port(
        clk, rst, set : in std_logic;
        sec_in : in std_logic_vector(5 downto 0);
        min_in : in std_logic_vector(5 downto 0);
        ore_in : in std_logic_vector(4 downto 0);
        
        sec_out : out std_logic_vector(5 downto 0);
        min_out : out std_logic_vector(5 downto 0);
        ore_out : out std_logic_vector(4 downto 0)
    );
end cronometro;

architecture Structural of cronometro is

    component base_dei_tempi is 
        generic ( clk_B_factor : positive);
        Port ( clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            clk_B : out STD_LOGIC);
    end component;
    
    component contatore_mod60 is
        port(clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           count : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR(5 downto 0);
           div : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR(5 downto 0));
    end component;
    
    component contatore_mod24 is
        port(clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           count : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR(4 downto 0);
           div : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR(4 downto 0));
    end component;
    
signal u : std_logic_vector(2 downto 0);
signal z : std_logic_vector(1 downto 0);
    
begin

    z(0) <= u(0) and u(1);
    z(1) <= u(0) and u(1) and u(2);
    
    bdt: base_dei_tempi generic map(clk_B_factor => clk_B_factor)
        port map(
        clk => clk, rst => rst, clk_b => u(0)
    );
 
    sec: contatore_mod60 port map(
        clk => clk, rst => rst, load => set, count => u(0), data => sec_in, div => u(1), y => sec_out
    );
    
    min: contatore_mod60 port map(
        clk => clk, rst => rst, load => set, count => z(0), data => min_in, div => u(2), y => min_out
    );
    
    ore: contatore_mod24 port map(
        clk => clk, rst => rst, load => set, count => z(1), data => ore_in, y => ore_out
    );

end Structural;
