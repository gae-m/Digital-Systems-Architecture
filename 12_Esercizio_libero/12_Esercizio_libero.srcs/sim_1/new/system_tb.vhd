library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity system_tb is
end system_tb;

architecture Behavioral of system_tb is

constant BAUD_DIVIDE_G : positive := 2;
constant CLK_PERIOD_B : time := 5ps;
constant CLK_PERIOD_A : time := 4*CLK_PERIOD_B;

signal rst : STD_LOGIC;
signal addr : STD_LOGIC_VECTOR(2 downto 0);
signal send_A : STD_LOGIC;
signal send_B : STD_LOGIC;
signal data_out : STD_LOGIC_VECTOR(7 downto 0);
signal clk_A : std_logic := '0';
signal clk_B : std_logic := '0';

type rom_type is array(0 to 7) of std_logic_vector(7 downto 0);
constant oracle : rom_type := (
x"01",
x"41",
x"04",
x"08",
x"11",
x"22",
x"40",
x"80" );

begin

    uut: entity work.system generic map(BAUD_DIVIDE_G => BAUD_DIVIDE_G)    -- baud_rate = 9600 con f_CLK = 100MHz
        port map(rst => rst, clk_A => clk_A, clk_B => clk_B, addr => addr, send_A => send_A, send_B => send_B, data_out=> data_out);
    
    clk_A_gen : process begin
        wait for CLK_PERIOD_A/2;
        clk_A <= not clk_A;
        end process;
        
    clk_B_gen : process begin
        wait for CLK_PERIOD_B/2;
        clk_B <= not clk_B;
        end process;    
        
     prc_tb: process begin
     	wait for CLK_PERIOD_B/4;
            rst <= '1';
            
            send_A <= '0';
            send_B <= '0';
            addr <= "000";
            wait for CLK_PERIOD_A;
            rst <= '0';
 
--            for i in 0 to 7 loop
--            	wait for CLK_PERIOD_A;
--            	addr <= std_logic_vector(to_unsigned(i,addr'length));
--            	send_B <= '1';
--				wait for CLK_PERIOD_B;
--				send_B <= '0';
				
--            	send_A <= '1';
--				wait for CLK_PERIOD_A;
--				send_A <= '0';
				
--				wait on data_out;
----				assert data_out = oracle(i) report "Error" severity failure;
--            end loop;
            
--            wait for 2*CLK_PERIOD_A;
            
--            for i in 0 to 7 loop
--            	addr <= std_logic_vector(to_unsigned(i,addr'length));
----            	wait until data_out'active;
----            	assert data_out = oracle(i) report "Error" severity failure;
--            end loop;
            
            
            
            for i in 0 to 7 loop  
                wait for  CLK_PERIOD_B;
                send_B <= '1';
                wait for  CLK_PERIOD_B;
                send_B <= '0';
                wait for  CLK_PERIOD_B;
                send_A <= '1';
                wait for  CLK_PERIOD_B;
                send_A <= '0';
                wait for 2 ns;
            end loop;
            
            addr <= "000";
            wait for 5ns;
            addr <= "001";
            wait for 5ns;
            addr <= "010";
            wait for 5ns;
            addr <= "011";
            wait for 5ns;
            addr <= "100";
            wait for 5ns;
            addr <= "101";
            wait for 5ns;
            addr <= "110";
            wait for 5ns;
            addr <= "111";
            wait;
            
            
     end process;
end Behavioral;
