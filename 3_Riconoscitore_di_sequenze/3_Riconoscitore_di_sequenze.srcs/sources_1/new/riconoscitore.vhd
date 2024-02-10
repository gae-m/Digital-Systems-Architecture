library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity riconoscitore is
    Port ( ingresso : in STD_LOGIC;
           clk : in STD_LOGIC;
           m : in STD_LOGIC;
           i_read : in STD_LOGIC;
           m_read : in STD_LOGIC;
           rst : in STD_LOGIC;
           uscita : out STD_LOGIC;
           stato_out : out STD_LOGIC_VECTOR(3 downto 0));
end riconoscitore;

architecture Behavioral of riconoscitore is
type stato is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);
signal sc : stato := s0; --stato corrente

begin
    automa: process(clk)
    begin
        if(clk'event and clk = '1') then
          if(rst = '1') then 
                sc <= s0;
                uscita <= '0';
          elsif(rst = '0') then    
                if(m_read = '1') then
                    if(m = '1' and (sc = s0 or sc = s1 or sc = s2 or sc = s3 or sc = s4 or sc = s5 or sc = s6)) then 
                        sc <= s7;
                        uscita <= '0';
                    elsif (m = '0' and (sc = s7 or sc = s8 or sc = s9 or sc = s10)) then
                        sc <= s0;
                        uscita <= '0';
                    end if;
                elsif(i_read ='1') then
                    case sc is
                        when s0 =>
                                if(ingresso = '0')then 
                                    sc <= s4;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s1;
                                    uscita <= '0';
                                 end if; 
                        when s1 =>
                                if(ingresso = '0')then 
                                    sc <= s2;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s5;
                                    uscita <= '0';
                                 end if;
                        when s2 =>
                                if(ingresso = '0')then 
                                    sc <= s3;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s6;
                                    uscita <= '0';
                                 end if;
                        when s3 =>
                                if(ingresso = '0')then 
                                    sc <= s0;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s0;
                                    uscita <= '1';
                                 end if;
                        when s4 => 
                                  sc <= s5;
                                  uscita <= '0';
                        when s5 =>
                                  sc <= s6;
                                  uscita <= '0';
                        when s6 =>
                                  sc <= s0;
                                  uscita <= '0';
                        when s7 =>
                                if(ingresso = '0')then 
                                    sc <= s7;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s8;
                                    uscita <= '0';
                                 end if;
                        when s8 =>
                                if(ingresso = '0')then 
                                    sc <= s9;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s8;
                                    uscita <= '0';
                                 end if;
                        when s9 =>
                                if(ingresso = '0')then 
                                    sc <= s10;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s8;
                                    uscita <= '0';
                                 end if;
                        when s10 =>
                                if(ingresso = '0')then 
                                    sc <= s7;
                                    uscita <= '0';
                                 elsif(ingresso = '1') then
                                    sc <= s7;
                                    uscita <= '1';
                                 end if;
                        end case;
                    end if;
                end if;
              end if;  
            end process;
        
        with sc select
            stato_out <= x"0" when s0,
                         x"1" when s1,
                         x"2" when s2,
                         x"3" when s3,
                         x"4" when s4,
                         x"5" when s5,
                         x"6" when s6,
                         x"7" when s7,
                         x"8" when s8,
                         x"9" when s9,
                         x"a" when s10,
                         x"f" when others;
end Behavioral;
