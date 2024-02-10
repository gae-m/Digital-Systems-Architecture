----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2023 13:40:16
-- Design Name: 
-- Module Name: nodoA_CU - Behavioral
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

-----
-- il componente deve avere un reset ASINCRONO sul fronte di salita
-----

entity nodoA_CU is
    Port ( start : in STD_LOGIC;
           ack : in STD_LOGIC;
           div : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           ready : out STD_LOGIC;
           inc : out STD_LOGIC;
           strobe : out STD_LOGIC;
           rst_dp : out STD_LOGIC);
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

	process(clk)
	begin
		if clk'event and clk = '0' then
			if rst = '1' then
				state <= IDLE;
			else
				state <= next_state;
			end if;
		end if;
	end process;
	
	process(state,start,ack,div)
	begin
		case state is
			when IDLE =>
				inc <= '0';
				strobe <= '0';
				ready <= '0';
				rst_dp <= '1';
				if start = '1' then
					next_state <= READ;
				else
					next_state <= state;
				end if;
			when READ =>
				inc <= '0';
				strobe <= '1';
				ready <= '0';
				rst_dp <= '0';
				if ack = '0' then
					next_state <= SEND;
				else
					next_state <= state;
				end if;
			when SEND =>
				inc <= '0';
				strobe <= '0';
				ready <= '1';
				rst_dp <= '0';
				if ack = '1' then
					next_state <= INCR;
				else
					next_state <= state;
				end if;
			when INCR =>
				inc <= '1';
				strobe <= '0';
				ready <= '0';
				rst_dp <= '0';
				if div = '1' then
					next_state <= IDLE;
				else
					next_state <= READ;
				end if;
			end case;
	end process;

end Behavioral;
