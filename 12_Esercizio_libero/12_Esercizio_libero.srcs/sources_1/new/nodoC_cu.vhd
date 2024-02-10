library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodoC_cu is
    Port ( rda : in STD_LOGIC;
           ready : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           en_reg : out STD_LOGIC;
           en_mem : out STD_LOGIC;
           read : out STD_LOGIC;
           incr : out STD_LOGIC;
           ctrl_mode : out STD_LOGIC;
           ack : out STD_LOGIC);
end nodoC_cu;

architecture Behavioral of nodoC_cu is

type stato is (idle, receive, mem, inc);
signal sc : stato := idle; --stato corrente
signal next_state : stato;

begin
        process(clk) 
        begin
            if(falling_edge(clk)) then
                if(rst = '1') then
                    sc <= idle;
                else sc <= next_state; 
                end if;
             end if;
        end process;
        
        process(sc, rda, ready, rst)
            begin
                case sc is
                                    
                        when idle =>
                            en_reg <= '0';
                            en_mem <= '1';
                            read <= '0';
                            ack <= '0';
                            incr <= '0';
                            ctrl_mode <= '1';
                            
                            if(rda = '1' and ready = '1') then next_state <= receive;
                            else next_state <= sc;
                            end if; 
                                                  
                        when receive =>
                            en_reg <= '1';
                            en_mem <= '0';
                            read <= '1';
                            ack <= '1';
                            incr <= '0';
                            ctrl_mode <= '0';   
                                      
                            next_state <= mem;
                                                  
                        when mem =>
                            en_reg <= '0';
                            en_mem <= '1';
                            read <= '0';
                            ack <= '1';
                            incr <= '0';
                            ctrl_mode <= '0';
                            
                            if(ready = '1') then next_state <= sc;
                            else next_state <= inc;
                            end if;
                            
                        when inc =>
                            en_reg <= '0';
                            en_mem <= '0';
                            read <= '0';
                            ack <= '0';
                            incr <= '1';
                            ctrl_mode <= '1';
                            
                            if(rda = '1' and ready = '1') then next_state <= receive;
                            else next_state <= idle;
                            end if;
                    end case;
        end process;

end Behavioral;
