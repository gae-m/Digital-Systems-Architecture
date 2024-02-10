library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_strutturale is
    generic (
        N : integer := 8);
    Port ( in_parallelo : in STD_LOGIC_VECTOR (N-1 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           enable : in STD_LOGIC;
           shifts : in STD_LOGIC_VECTOR (1 downto 0);
           out_parallelo : out STD_LOGIC_VECTOR (N-1 downto 0));
end shift_register_strutturale;

architecture Structural of shift_register_strutturale is
    signal mux_to_ff : std_logic_vector(N-1 downto 0);
    signal ff_to_mux : std_logic_vector(N-1 downto 0);
    signal mux_to_mux : std_logic_vector(N-1 downto 0);
    
    
begin

    out_parallelo <= ff_to_mux;
    
    SR: for i in 0 to N-1 generate
            FF : entity work.flip_flopD port map(
            d=> mux_to_ff(i), clk => clk, rst => rst, enable => enable,
            q =>ff_to_mux(i)
            );
            
            MUX2_1 : entity work.mux2to1 port map(
            x(0) => mux_to_mux(i), x(1) => in_parallelo(i), s => load,
            y =>mux_to_ff(i));
            
            MUX4_1 : entity work.mux4to1 port map(
            x(0) => ff_to_mux((i-1) mod N), x(1) => ff_to_mux((i-2) mod N), x(2) => ff_to_mux((i+1) mod N), x(3) => ff_to_mux((i+2) mod N),
            s => shifts, y => mux_to_mux(i)
            );
            
        end generate;
end Structural;
