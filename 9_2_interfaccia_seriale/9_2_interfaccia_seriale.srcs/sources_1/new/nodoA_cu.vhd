----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 11:58:52
-- Design Name: 
-- Module Name: nodoA_cu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.nodoA_util.all;

entity nodoA_cu is
    Port ( send : in STD_LOGIC;
           TBE : in STD_LOGIC;
           div : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in std_logic;
           ctrl_word : out ctrl_word_type );
end nodoA_cu;

architecture Behavioral of nodoA_cu is

    type state_type is (RESET,IDLE,READ_ROM,SEND_INCR);
    signal state : state_type := RESET;
    signal next_state : state_type;
    
begin

    process(clk)
    begin
        if clk'event and clk = '0' then
            if rst = '1' then
                state <= RESET;
            else
                state <= next_state;
            end if;
        end if;
    end process;
    
    process(state,send,TBE,div)
    begin
        case state is
        	when RESET =>
        		ctrl_word <= "0001";
				if send = '1' then
					next_state <= READ_ROM;
				else
					next_state <= IDLE;
				end if;
        		
            when IDLE =>
                ctrl_word <= "0000";
                if send = '1' then
                	next_state <= READ_ROM;
                else
                	next_state <= IDLE;
               	end if;
                
            when READ_ROM =>
                ctrl_word <= "0100";
                if TBE = '1' then
                    next_state <= SEND_INCR;
                else
                	next_state <= READ_ROM;
               	end if;
                
            when SEND_INCR =>
            	ctrl_word <= "1010";
            	if div = '0' then
            		next_state <= READ_ROM;
            	elsif send = '1' then
            		next_state <= READ_ROM;
            	else
            		next_state <= IDLE;
            	end if;
        end case;
    end process;

end Behavioral;
