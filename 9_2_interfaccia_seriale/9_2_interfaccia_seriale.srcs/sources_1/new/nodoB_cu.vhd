----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 11:58:52
-- Design Name: 
-- Module Name: nodoB_cu - Behavioral
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
use work.nodoB_util.all;

entity nodoB_cu is
    Port ( mode : in STD_LOGIC;
           RDA : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in std_logic;
           ctrl_word : out ctrl_word_type);
end nodoB_cu;

architecture Behavioral of nodoB_cu is

	type state_type is (RESET,IDLE,RECEIVE,INCR,READ_MEM);
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
	
	process(state,mode,RDA)
	begin
		case state is
			when RESET =>
				ctrl_word <= "00001";
				next_state <= IDLE;
				
			when IDLE =>
				ctrl_word <= "00000";
				if mode = '1' then
					next_state <= READ_MEM;
				elsif RDA = '1' then
					next_state <= RECEIVE;
				else
					next_state <= IDLE;
				end if;
				
			when RECEIVE =>
				ctrl_word <= "10100";
				next_state <= INCR;
				
			when INCR =>
				ctrl_word <= "01000";
				next_state <= IDLE;
				
			when READ_MEM =>
				ctrl_word <= "00110";
				if mode = '0' then
					next_state <= IDLE;
				else
					next_state <= READ_MEM;
				end if;
				
		end case;
	end process;

end Behavioral;
