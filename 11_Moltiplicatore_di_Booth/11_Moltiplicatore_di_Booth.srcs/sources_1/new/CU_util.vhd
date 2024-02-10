----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2024 12:04:47
-- Design Name: 
-- Module Name: CU_util - Behavioral
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

package CU_util is
	subtype ctrl_word_type is std_logic_vector(0 to 8);
	constant enable_A : integer := 0;
	constant load_A : integer := 1;
	constant enable_Q : integer := 2;
	constant load_Q : integer := 3;
	constant enable_M : integer := 4;
	constant subtract : integer := 5;
	constant count_in : integer := 6;
	constant rst_A_CU : integer := 7;
	constant busy_CU : integer := 8;
end CU_util;
