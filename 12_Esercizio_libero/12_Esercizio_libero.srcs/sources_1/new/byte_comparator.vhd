library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity byte_comparator is
    Generic( N : integer := 8);
    Port ( a : in STD_LOGIC_VECTOR(N-1 downto 0);
           b : in STD_LOGIC_VECTOR(N-1 downto 0);
           gt : in STD_LOGIC;
           eq : in STD_LOGIC;
           lt : in STD_LOGIC;
           a_gt_b : out STD_LOGIC;
           a_eq_b : out STD_LOGIC;
           a_lt_b : out STD_LOGIC);
end byte_comparator;

architecture Structural of byte_comparator is

signal gt_to_gt : std_logic_vector(N downto 0);
signal eq_to_eq : std_logic_vector(N downto 0);
signal lt_to_lt : std_logic_vector(N downto 0);

begin

gt_to_gt(0) <= gt;
eq_to_eq(0) <= eq;
lt_to_lt(0) <= lt;

    n_c: for i in 0 to N-1 generate
        comp: entity work.bit_comparator port map (a => a(i), b => b(i), gt => gt_to_gt(i), eq => eq_to_eq(i), lt => lt_to_lt(i), a_gt_b => gt_to_gt(i+1), a_eq_b => eq_to_eq(i+1), a_lt_b => lt_to_lt(i+1) );
        end generate;
        
a_gt_b <= gt_to_gt(N);
a_eq_b <= eq_to_eq(N);
a_lt_b <= lt_to_lt(N);

end Structural;