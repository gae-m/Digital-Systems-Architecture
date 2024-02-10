----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2024 18:32:11
-- Design Name: 
-- Module Name: adder_subtractor - structural
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

entity adder_subtractor is
	generic(
		NBIT : positive := 4);
    Port ( a : in STD_LOGIC_VECTOR (NBIT-1 downto 0);
           b : in STD_LOGIC_VECTOR (NBIT-1 downto 0);
           sub : in STD_LOGIC;
           res : out STD_LOGIC_VECTOR (NBIT-1 downto 0);
           c_out : out STD_LOGIC );
end adder_subtractor;

architecture structural of adder_subtractor is
	signal op2 : std_logic_vector(NBIT-1 downto 0);
begin
	rca : entity work.ripple_carry_adder
	generic map(
		nbit => NBIT )
	port map(
		a => a,
		b => op2,
		c_in => sub,
		s => res,
		c_out => c_out );

	b_xor_cin : for i in 0 to NBIT-1 generate
		op2(i) <= b(i) xor sub;
	end generate;
end structural;
