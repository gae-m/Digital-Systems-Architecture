library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity riconoscitore_tb is
end riconoscitore_tb;

architecture Behavioral of riconoscitore_tb is
    component riconoscitore is port(
       ingresso : in STD_LOGIC;
       clk : in STD_LOGIC;
       m : in STD_LOGIC;
       i_read : in STD_LOGIC;
       m_read : in STD_LOGIC;
       rst : in STD_LOGIC;
       uscita : out STD_LOGIC;
       stato_out : out STD_LOGIC_VECTOR(3 downto 0)
       );
     end component;
     
    signal ingresso : std_logic := '0';
    signal clk : std_logic := '0';
    signal m : std_logic := '0';
    signal i_read : std_logic := '0';
    signal m_read : std_logic := '0';
    signal rst : std_logic := '0';
    signal uscita : std_logic := '0';
    signal stato_out : std_logic_vector(3 downto 0);
    
begin

    r: riconoscitore port map (
        ingresso => ingresso,
        clk => clk,
        m => m,
        i_read => i_read,
        m_read => m_read,
        rst => rst,
        uscita => uscita,
        stato_out => stato_out
        );
        
     clock_tb: process begin
        wait for 40 ns;
        clk <= '1';
        wait for 40 ns;
        clk <='0';
    end process;
    
    inputs_tb: process begin
    --m = 0
--        wait for 40 ns;
--        i_read <= '0';
--        m_read <= '1';
--        m <= '0';
--        wait for 20 ns;
--        m_read <= '0';
--        ingresso <= '1';
--        wait for 20 ns;
--        i_read <='1';
--        wait for 80 ns;
--        i_read <= '0';
--        wait for 20 ns;
--        ingresso <= '0';
--        wait for 20 ns;
--        i_read <= '1';
--        wait for 80 ns;
--        i_read <= '0';
--        wait for 20 ns;
--        ingresso <= '0';
--        wait for 20 ns;
--        i_read <= '1';
--        wait for 80 ns;
--        i_read <= '0';
--        wait for 20 ns;
--        ingresso <= '1';
--        wait for 20 ns;
--        i_read <= '1';
--        wait for 80 ns;
--        i_read <= '0';
--        wait for 20 ns;
--        i_read <= '1';
--        ingresso <= '0';
--        wait for 80 ns;
--        i_read <= '0';
--        wait for 20 ns;
--        rst <= '1';
--        wait for 80 ns;
--        rst <= '0';
--        wait for 20 ns;
--        i_read <= '1';
--        ingresso <= '1';
--        wait for 80 ns;
--        i_read <= '0';
        
    
    --m = 1
    wait for 40 ns;
        i_read <= '0';
        m_read <= '1';
        m <= '1';
        wait for 80 ns;
        m_read <= '0';
        ingresso <= '1';
        wait for 20 ns;
        i_read <='1';
        wait for 80 ns;
        i_read <= '0';
--        wait for 20 ns;
--        m <= '0';
--        m_read <= '1';
--        wait for 80 ns;
--        m_read <= '0';
        wait for 20 ns;
        ingresso <= '0';
        wait for 20 ns;
        i_read <= '1';
        wait for 80 ns;
        i_read <= '0';
        wait for 20 ns;
        ingresso <= '1';
        i_read <= '1';
        wait for 80 ns;
        i_read <= '0';
        ingresso <= '0';
        wait for 20 ns;
        i_read <= '1';
        wait for 80 ns;
        i_read <= '0';
        wait for 20 ns;
        i_read <= '1';
        wait for 80 ns;
        i_read <= '0';
        wait for 20 ns;
        ingresso <= '1';
        i_read <= '1';
        wait for 80 ns;
        i_read <= '0';
        wait for 20 ns;
        ingresso <= '1';
        i_read <= '1';
        wait for 80 ns;
        i_read <= '0'; 
        wait for 20 ns;
        rst <= '1';
        wait for 80 ns;
        rst <= '0';
        wait for 20 ns;
        ingresso <= '1';
        i_read <= '1';
        wait for 80 ns;
        i_read <= '0'; 
        
        wait;
    end process;
        
end Behavioral;
