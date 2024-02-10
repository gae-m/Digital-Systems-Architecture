----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2024 12:04:11
-- Design Name: 
-- Module Name: control_unit - Behavioral
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
use work.CU_util.all;

entity control_unit is
    Port ( mul : in STD_LOGIC;
           Q : in std_logic_vector(1 downto 0);
           div : in std_logic;
           rst : in STD_LOGIC;
           clk : in std_logic;
           ctrl_word : out ctrl_word_type);
end control_unit;

architecture Behavioral of control_unit is
	type state_type is (IDLE, INIT, ADD, SUB, SHIFT_Q, SHIFT_A);
	signal state : state_type := IDLE;
	signal next_state : state_type;
	type cword_map_type is array(state_type) of ctrl_word_type;
	constant cword_map : cword_map_type := (
		IDLE => "000000000",
		INIT => "001110011",
		ADD => "110000001",
		SUB => "110001001",
		SHIFT_Q => "001000001",
		SHIFT_A => "100000101" );
begin
	seq : process(clk)
	begin
		if clk'event and clk = '0' then
			if rst = '1' then
				state <= IDLE;
			else
				state <= next_state;
			end if;
		end if;
	end process;
	
	comb : process(state, mul, Q, div)
	begin
		case state is
			when IDLE =>
				ctrl_word <= cword_map(IDLE);
				if mul = '1' then
					next_state <= INIT;
				else
					next_state <= IDLE;
				end if;
				
			when INIT =>
				ctrl_word <= cword_map(INIT);
				if Q = "01" then
					next_state <= ADD;
				elsif Q = "10" then
					next_state <= SUB;
				else
					next_state <= SHIFT_Q;
				end if;
			
			when ADD =>
				ctrl_word <= cword_map(ADD);
				next_state <= SHIFT_Q;
				
			when SUB =>
				ctrl_word <= cword_map(SUB);
				next_state <= SHIFT_Q;
				
			when SHIFT_Q =>
				ctrl_word <= cword_map(SHIFT_Q);
				next_state <= SHIFT_A;
				
			when SHIFT_A =>
				ctrl_word <= cword_map(SHIFT_A);
				if div = '1' then
					next_state <= IDLE;
				elsif Q = "01" then
					next_state <= ADD;
				elsif Q = "10" then
					next_state <= SUB;
				else
					next_state <= SHIFT_Q;
				end if;
		end case;
	end process;

end Behavioral;
