library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_controllo is
    Port ( mode : in STD_LOGIC; --switch
           salva_b : in STD_LOGIC; --salva -> 0 , visualizza -> 1, button
           visualizza_b : in STD_LOGIC; --button per la visualizzazione
           set_b : in STD_LOGIC;
           rst : in STD_LOGIC; --button
           clk : in STD_LOGIC;
           set_cronometro : out STD_LOGIC;
           en : out STD_LOGIC;
           r_w : out STD_LOGIC;
           incr_s : out STD_LOGIC;
           incr_v : out STD_LOGIC;
           rst_dp : out STD_LOGIC);
end unita_controllo;

architecture Behavioral of unita_controllo is
type stato is (reset,cronometro,set,salva,visualizza,inc_s, inc_v);
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
        
        process(sc, mode, set_b, salva_b, visualizza_b, rst)
            begin
                case sc is
                        when reset =>
                                    set_cronometro <= '0';
                                    en <= '0';
                                    r_w <= '0';
                                    incr_s <= '0';
                                    incr_v <= '0';
                                    rst_dp <= '1';
                                     
                                    if(mode = '1') then
                                        next_state <= visualizza;
                                    else next_state <= cronometro;
                                    end if;
                                    
                        when cronometro =>
                                      set_cronometro <= '0';
                                      en <= '0';
                                      r_w <= '0';
                                      incr_s <= '0';
                                      incr_v <= '0';
                                      rst_dp <= '0';
                                      
                                      if(mode = '1') then next_state <= visualizza;
                                      elsif(set_b = '1') then next_state <= set;
                                          elsif (salva_b = '1') then next_state <= salva;
                                            else next_state <= sc;
                                      end if;
                                      
                        when set =>   
                                      set_cronometro <= '1';
                                      en <= '0';
                                      r_w <= '0';
                                      incr_s <= '0';
                                      incr_v <= '0';
                                      rst_dp <= '0';
                                      
                                      if(mode = '1') then next_state <= visualizza;
                                      elsif(set_b = '1') then next_state <= sc;
                                        elsif(salva_b = '1') then next_state <= salva;
                                        else next_state <= cronometro;
                                      end if;
                                                  
                        when salva =>
                                      set_cronometro <= '0';
                                      en <= '1';
                                      r_w <= '0';
                                      incr_s <= '0';
                                      incr_v <= '0';
                                      rst_dp <= '0';
                                      
                                      next_state <= inc_s;
                        
                        when inc_s => 
                                     set_cronometro <= '0';
                                     en <= '0';
                                     r_w <= '0';
                                     incr_s <= '1';
                                     incr_v <= '0';
                                     rst_dp <= '0';
                                     
                                     if(mode = '1') then next_state <= visualizza;
                                     elsif(set_b = '1') then next_state <= set;
                                         elsif(salva_b = '1') then next_state <= salva;
                                            else next_state <= cronometro;
                                     end if;
                                        
                         when visualizza =>
                                      set_cronometro <= '0';
                                      en <= '1';
                                      r_w <= '1';
                                      incr_s <= '0';
                                      incr_v <= '0';
                                      rst_dp <= '0';
                                      
                                      if(mode = '0') then next_state <= cronometro;
                                        elsif(visualizza_b = '1') then next_state <= inc_v;
                                            else next_state <= sc;
                                      end if; 
                         
                         when inc_v =>
                                      set_cronometro <= '0';
                                      en <= '0';
                                      r_w <= '0';
                                      incr_s <= '0';
                                      incr_v <= '1';
                                      rst_dp <= '0';
                                      
                                      if(mode = '0') then next_state <= cronometro;
                                      elsif(visualizza_b = '1') then next_state <= sc;
                                        else next_state <= visualizza;
                                      end if;                    
                    end case;
        end process;
        
end Behavioral;
