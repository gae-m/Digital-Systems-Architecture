----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 18:31:34
-- Design Name: 
-- Module Name: nodoB_CU - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nodoB_CU is
    Port ( ready : in STD_LOGIC;
           mode : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ack : out STD_LOGIC;
           en_mem : out STD_LOGIC;
           en_reg : out STD_LOGIC;
           strobe : out STD_LOGIC;
           rst_dp : out STD_LOGIC;
           inc : out STD_LOGIC;
           ctrl_mode : out std_logic);
end nodoB_CU;

architecture Behavioral of nodoB_CU is
	type state_type is (
		RESET,
		IDLE,
		READ_MEM,
		RECEIVE,
		SUM,
		INCR );
	signal state : state_type := RESET;
	signal next_state : state_type;
	
	subtype ctrl_word_type is std_logic_vector(6 downto 0);
	signal ctrl_word : ctrl_word_type;
	
begin

	inc <= ctrl_word(6);
	strobe <= ctrl_word(5);
	en_reg <= ctrl_word(4);
	en_mem <= ctrl_word(3);
	ack <= ctrl_word(2);
	ctrl_mode <= ctrl_word(1);
	rst_dp <= ctrl_word(0);

	process(state,ready,mode)
	begin
		case state is
			when RESET =>
				ctrl_word <= "0000001";
				if mode = '0' then
					next_state <= IDLE;
				else
					next_state <= READ_MEM;
				end if;
				
			when IDLE =>
				ctrl_word <= "0000000";
				if mode = '1' then
					next_state <= READ_MEM;
				elsif ready = '1' then
					next_state <= RECEIVE;
				else
					next_state <= IDLE;
				end if;
				
			when RECEIVE =>
				ctrl_word <= "0110000";
				next_state <= SUM;
				
			when SUM =>
				ctrl_word <= "0001100";
				if ready = '0' then
					next_state <= INCR;
				else
					next_state <= SUM;
				end if;
				
			when INCR =>
				ctrl_word <= "1000000";
				next_state <= IDLE;
				
			when READ_MEM =>
				ctrl_word <= "0001010";
				if mode = '0' then
					next_state <= IDLE;
				else
					next_state <= READ_MEM;
				end if;
		end case;
	end process;
	
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


end Behavioral;
