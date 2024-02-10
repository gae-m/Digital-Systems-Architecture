library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_comparator is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           gt : in STD_LOGIC;
           eq : in STD_LOGIC;
           lt : in STD_LOGIC;
           a_gt_b : out STD_LOGIC;
           a_eq_b : out STD_LOGIC;
           a_lt_b : out STD_LOGIC);
end bit_comparator;

architecture dataflow of bit_comparator is

begin

a_gt_b <= (a and gt) or (not(b) and gt) or (a and not(b));
a_eq_b <= (a and b and eq) or (not(a) and not(b) and eq);
a_lt_b <= (not(a) and lt) or (b and lt) or (not(a) and b);

end dataflow;
