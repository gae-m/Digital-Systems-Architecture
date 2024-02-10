-- Questo componente prende in input il segnale proveniente da un push button e genera un 
-- segnale "ripulito" che presenta un impulso della durata di un colpo di clock per 
-- segnalare l'avvenuta pressione.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity button_debouncer is
    generic (                       
        clk_period : integer := 10;  -- periodo del clock
        btn_noise_time : integer := 6500000 -- stima della durata del transitorio del button
    );
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           cleared_btn : out STD_LOGIC);
end button_debouncer;

architecture Behavioral of button_debouncer is
	type state_type is (NOT_PRESSED, PRESSED);
	signal btn_state : state_type := NOT_PRESSED;
	constant max_count : integer := btn_noise_time/clk_period; -- 6500000/10 = 650000 [colpi di clock] 
begin
	deb: process (clk,rst)
		variable count : integer := 1;
	begin
		if rst = '1' then
		   btn_state <= NOT_PRESSED;
		   cleared_btn <= '0';
		   count := 0;
		elsif rising_edge(clk) then 
			case btn_state is
				when NOT_PRESSED =>
					cleared_btn <= '0';
					if( btn = '1' ) then
						btn_state <= PRESSED;
					else 
						btn_state <= NOT_PRESSED;
					end if;
					
				when PRESSED =>
					if(count = max_count) then
						count := 1;
						cleared_btn <= '1';
						btn_state <= NOT_PRESSED;
					else 
						count := count + 1;
						btn_state <= PRESSED;
					end if;
					
				when others => 
					btn_state <= NOT_PRESSED;
			end case;
		end if;  
	end process;

end Behavioral;