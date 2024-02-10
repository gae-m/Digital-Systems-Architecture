library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodoA_CU is
    Port ( start : in STD_LOGIC;
           ack : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           ready : out STD_LOGIC;
           inc : out STD_LOGIC;
           strobe : out STD_LOGIC);
end nodoA_CU;

architecture Behavioral of nodoA_CU is
	type state_type is (
		IDLE,
		READ,
		SEND,
		INCR );
	signal state : state_type := IDLE;
	signal next_state : state_type;
	
begin

	process(clk, rst)
	begin
	   if rst = '1' then
	       state <= IDLE;
	   elsif clk'event and clk = '0' then
			state <= next_state;
		end if;
	end process;
	
	process(state,start,ack)
	begin
		case state is
			when IDLE =>
				inc <= '0';
				strobe <= '0';
				ready <= '0';
				if start = '1' then
					next_state <= READ;
				else
					next_state <= state;
				end if;
			when READ =>
				inc <= '0';
				strobe <= '1';
				ready <= '0';
				if ack = '0' then
					next_state <= SEND;
				else
					next_state <= state;
				end if;
			when SEND =>
				inc <= '0';
				strobe <= '0';
				ready <= '1';
				if ack = '1' then
					next_state <= INCR;
				else
					next_state <= state;
				end if;
			when INCR =>
				inc <= '1';
				strobe <= '0';
				ready <= '0';
				
			    if start = '0' then
					next_state <= IDLE;
				else
					next_state <= READ;
				end if;

			end case;
	end process;

end Behavioral;
