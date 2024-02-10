library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit_comparator_tb is
--  Port ( );
end bit_comparator_tb;

architecture Behavioral of bit_comparator_tb is


signal a : STD_LOGIC;
signal b : STD_LOGIC;
signal gt : STD_LOGIC;
signal eq : STD_LOGIC;
signal lt : STD_LOGIC;
signal a_gt_b : STD_LOGIC;
signal a_eq_b : STD_LOGIC;
signal a_lt_b : STD_LOGIC;

begin

    uut: entity work.bit_comparator port map(
        a => a, b => b, gt => gt, eq => eq, lt => lt, a_gt_b => a_gt_b, a_eq_b => a_eq_b, a_lt_b => a_lt_b
    );
    
    
    prc_tb: process begin
        a <= '1';
        b <= '1';
        
        lt <= '0';
        eq <= '0';
        gt <= '0';
        wait for 20 ns;
        
        a <= '0';
        b <= '0';
        
        lt <= '0';
        eq <= '0';
        gt <= '1';
        wait for 20 ns;
        
        a <= '1';
        b <= '0';
        
        lt <= '0';
        eq <= '0';
        gt <= '0';
        wait for 20 ns;
        
        a <= '1';
        b <= '0';
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait for 20 ns;
        
        a <= '0';
        b <= '0';
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait for 20 ns;
        
        a <= '1';
        b <= '0';
        
        lt <= '1';
        eq <= '0';
        gt <= '0';
        wait for 20 ns;
        
        a <= '1';
        b <= '0';
        
        lt <= '0';
        eq <= '0';
        gt <= '1';
        wait for 20 ns;
        
        a <= '0';
        b <= '1';
        
        lt <= '0';
        eq <= '0';
        gt <= '1';
        wait for 20 ns;
        wait;
    end process;

end Behavioral;
