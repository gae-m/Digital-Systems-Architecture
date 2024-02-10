----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2024 16:13:36
-- Design Name: 
-- Module Name: nod - Behavioral
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

package nodoA_util is
	-- nodo A
	subtype ctrl_word_type is std_logic_vector(3 downto 0);
	constant incr : natural := 3;
	constant read : natural := 2;
	constant write : natural := 1;
	constant rst_ou : natural := 0; 
	
end package nodoA_util;
