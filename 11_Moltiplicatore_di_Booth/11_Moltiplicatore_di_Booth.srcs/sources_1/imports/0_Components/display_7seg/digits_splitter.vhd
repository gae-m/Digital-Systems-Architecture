----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2023 12:45:05
-- Design Name: 
-- Module Name: digits_splitter - dataflow
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Componente che serve a dividere la stringa di 32bit in stringhe da 4
-- per rappresentare le 8 cifre esadecimali sul display, e ad inoltrare tali
-- valori verso i catodi in maniera sincronizzata alla variazione degli anodi 

entity digits_splitter is
    Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
           dots : in STD_LOGIC_VECTOR (7 downto 0);
           digit_select : in STD_LOGIC_VECTOR (2 downto 0);
           digit : out STD_LOGIC_VECTOR (3 downto 0);
           dot : out STD_LOGIC);
end digits_splitter;

architecture dataflow of digits_splitter is
	subtype nibble is std_logic_vector(3 downto 0);
	
	alias digit_0 : nibble is x(3 downto 0);
	alias digit_1 : nibble is x(7 downto 4);
	alias digit_2 : nibble is x(11 downto 8);
	alias digit_3 : nibble is x(15 downto 12);
	alias digit_4 : nibble is x(19 downto 16);
	alias digit_5 : nibble is x(23 downto 20);
	alias digit_6 : nibble is x(27 downto 24);
	alias digit_7 : nibble is x(31 downto 28);
	
--	type digits_type is array(7 downto 0) of nibble;
--	signal digits : digits_type := (
--		x(31 downto 28),
--		x(27 downto 24),
--		x(23 downto 20),
--		x(19 downto 16),
--		x(15 downto 12),
--		x(11 downto 8),
--		x(7 downto 4),
--		x(3 downto 0) );
--signal digits : digits_type := (
--		digit_7,
--		digit_6,
--		digit_5,
--		digit_4,
--		digit_3,
--		digit_2,
--		digit_1,
--		digit_0 );
begin
	with digit_select select
		digit <= digit_0 when "000",
			digit_1 when "001",
			digit_2 when "010",
			digit_3 when "011",
			digit_4 when "100",
			digit_5 when "101",
			digit_6 when "110",
			digit_7 when "111",
			digit_0 when others;
	
	with digit_select select
		dot <= dots(0) when "000",
			dots(1) when "001",
			dots(2) when "010",
			dots(3) when "011",
			dots(4) when "100",
			dots(5) when "101",
			dots(6) when "110",
			dots(7) when "111",
			dots(0) when others;
	--digit <= digits(conv_integer(digit_select));
	-- dot <= dots(conv_integer(digit_select));

end dataflow;
