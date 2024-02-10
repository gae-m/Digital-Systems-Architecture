----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 13:05:40
-- Design Name: 
-- Module Name: nodoB_util - Behavioral
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

package nodoB_util is
	-- nodo B
	subtype ctrl_word_type is std_logic_vector(4 downto 0);
	constant read : natural := 4;
	constant incr : natural := 3;
	constant en_mem : natural := 2;
	constant ctrl_mode : natural := 1;
	constant rst_ou : natural := 0; 
	
end package nodoB_util;
