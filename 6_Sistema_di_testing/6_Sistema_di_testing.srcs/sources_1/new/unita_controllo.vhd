library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_controllo is
    Port ( read_b : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in std_logic;
           read : out STD_LOGIC;
           en : out STD_LOGIC;
           incr : out STD_LOGIC;
           rst_dp : out STD_LOGIC);
end unita_controllo;

architecture Behavioral of unita_controllo is

type stato is (reset, read_rom, idle, mem, inc);
signal sc : stato := reset; --stato corrente
signal next_state : stato;

begin
        process(clk) 
        begin
            if(falling_edge(clk)) then
                if(rst = '1') then
                    sc <= reset;
                else sc <= next_state; 
                end if;
             end if;
        end process;
        
        process(sc, read_b, rst)
            begin
                case sc is
                        when reset =>
                            read <= '0';
                            en <= '0';
                            incr <= '0';
                            rst_dp <= '1';
                             
                            if(read_b = '1') then
                                next_state <= read_rom;
                            else next_state <= sc;
                            end if;       
                                    
                        when idle =>
                            read <= '0';
                            en <= '0';
                            incr <= '0';
                            rst_dp <= '0';
                            
                            if(read_b = '1') then
                                next_state <= read_rom;
                            else next_state <= sc;
                            end if;
                                      
                                      
                        when read_rom =>
                            read <= '1';
                            en <= '0';
                            incr <= '0';
                            rst_dp <= '0';
                            
                            next_state <= mem;   
                                      
                                                  
                        when mem =>
                            read <= '0';
                            en <= '1';
                            incr <= '0';
                            rst_dp <= '0';
                            
                            next_state <= inc;
                        
                        when inc =>
                            read <= '0';
                            en <= '0';
                            incr <= '1';
                            rst_dp <= '0';
                            
                            if(read_b = '1') then
                                next_state <= read_rom;
                            else next_state <= idle;
                            end if; 
                                                    
                    end case;
        end process;


end Behavioral;
