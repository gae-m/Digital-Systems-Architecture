library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity unita_operativa is
    Port ( m0 : in STD_LOGIC_VECTOR(1 downto 0);
           m1 : in STD_LOGIC_VECTOR(1 downto 0);
           m2 : in STD_LOGIC_VECTOR(1 downto 0);
           m3 : in STD_LOGIC_VECTOR(1 downto 0);
           s : in STD_LOGIC_VECTOR(1 downto 0);
           d : in STD_LOGIC_VECTOR(1 downto 0);
           out0 : out STD_LOGIC_VECTOR(1 downto 0);
           out1 : out STD_LOGIC_VECTOR(1 downto 0);
           out2 : out STD_LOGIC_VECTOR(1 downto 0);
           out3 : out STD_LOGIC_VECTOR(1 downto 0));
end unita_operativa;

architecture Structural of unita_operativa is

signal sw_to_sw0 : std_logic_vector(1 downto 0);
signal sw_to_sw1 : std_logic_vector(1 downto 0);
signal sw_to_sw2 : std_logic_vector(1 downto 0);
signal sw_to_sw3 : std_logic_vector(1 downto 0);



begin
    switch02: entity work.switch port map(
            in0 => m0, in1 => m2, s => s(1), d => d(1), out0 => sw_to_sw0, out1 => sw_to_sw2 
            );
            
     switch01: entity work.switch port map(
            in0 => sw_to_sw0, in1 => sw_to_sw1, s => s(0), d => d(0), out0 => out0, out1 => out1
            );
            
    switch13: entity work.switch port map(
            in0 => m1, in1 => m3, s => s(1), d => d(1), out0 => sw_to_sw1, out1 => sw_to_sw3
            );

    switch23: entity work.switch port map(
            in0 => sw_to_sw2, in1 => sw_to_sw3, s => s(0), d => d(0), out0 => out2, out1 => out3
            );
            
end Structural;
