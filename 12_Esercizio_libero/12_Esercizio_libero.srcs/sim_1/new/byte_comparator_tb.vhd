library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity byte_comparator_tb is
--  Port ( );
end byte_comparator_tb;

architecture Behavioral of byte_comparator_tb is

signal a : STD_LOGIC_VECTOR(7 downto 0);
signal b : STD_LOGIC_VECTOR(7 downto 0);
signal gt : STD_LOGIC;
signal eq : STD_LOGIC;
signal lt : STD_LOGIC;
signal a_gt_b : STD_LOGIC;
signal a_eq_b : STD_LOGIC;
signal a_lt_b : STD_LOGIC;


begin
    
    uut: entity work.byte_comparator generic map(N => 8)
        port map (a => a, b => b, gt => gt, eq => eq, lt => lt, a_gt_b => a_gt_b, a_eq_b => a_eq_b, a_lt_b => a_lt_b
    );
    
     prc_tb: process begin
        a <= "11110000";
        b <= "00011111";
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait for 50ns;
        
        b <= "11110000";
        a <= "00001111";
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait for 50ns;
        
        b <= "10110000";
        a <= "10110000";
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait for 50ns;
        
        a <= "10110000";
        b <= "01110000";
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait for 50ns;
        
        b <= "10110000";
        a <= "00110011";
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait for 50ns;
        
        a <= "10010000";
        b <= "00011111";
        
        lt <= '0';
        eq <= '1';
        gt <= '0';
        wait;
        end process;
    
end Behavioral;
