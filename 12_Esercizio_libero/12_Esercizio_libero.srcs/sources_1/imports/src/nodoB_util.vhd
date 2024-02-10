library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package nodoB_util is
	-- nodo A
	subtype ctrl_word_type is std_logic_vector(3 downto 0);
	constant incr : natural := 3;
	constant read : natural := 2;
	constant write : natural := 1;
	constant rst_ou : natural := 0; 
	
end package nodoB_util;
