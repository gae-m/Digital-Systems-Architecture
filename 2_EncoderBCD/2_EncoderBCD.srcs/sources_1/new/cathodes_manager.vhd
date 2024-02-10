library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity cathodes_manager is
    Port ( value : in STD_LOGIC_VECTOR (3 downto 0);
    		dot : in STD_LOGIC;
           cathodes : out STD_LOGIC_VECTOR (7 downto 0));
end cathodes_manager;

architecture dataflow of cathodes_manager is
	--------
	-- cathodes(0) => CA
	-- cathodes(1) => CB
	-- ...
	-- cathodes(7) => DP
	
	-- ATTENZIONE: i catodi sono attivi quando il loro valore di tensione è basso(0)
	---------
	type digit_type is array (0 to 15) of std_logic_vector(6 downto 0);
	constant digit : digit_type := (
	"1000000", -- 0
	"1111001", -- 1
	"0100100", -- 2
	"0110000", -- 3
	"0011001", -- 4
	"0010010", -- 5
	"0000010", -- 6
	"1111000", -- 7
	"0000000", -- 8
	"0010000", -- 9
	"0001000", -- A
	"0000011", -- b
	"1000110", -- C
	"0100001", -- d
	"0000110", -- E
	"0001110");-- F
begin
	cathodes <= (not dot) & digit(conv_integer(value));

end dataflow;
