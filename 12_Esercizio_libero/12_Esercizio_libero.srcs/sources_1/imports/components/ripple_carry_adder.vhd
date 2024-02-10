library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_carry_adder is
	generic(
		nbit : positive );
    Port ( a : in STD_LOGIC_VECTOR (nbit-1 downto 0);
           b : in STD_LOGIC_VECTOR (nbit-1 downto 0);
           c_in : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (nbit-1 downto 0);
           c_out : out STD_LOGIC);
end ripple_carry_adder;

architecture structural of ripple_carry_adder is
	signal carry : std_logic_vector(nbit downto 0);
begin
	carry(0) <= c_in;
	c_out <= carry(nbit);
	
	FA_1toN : for i in 0 to nbit-1 generate
		FA : entity work.full_adder
		port map(
			a => a(i),
			b => b(i),
			c_in => carry(i),
			s => s(i),
			c_out => carry(i+1) );
	end generate;

end structural;
