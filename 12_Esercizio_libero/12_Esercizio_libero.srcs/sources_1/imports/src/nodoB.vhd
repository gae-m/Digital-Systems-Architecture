library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.nodoB_util.all;

entity nodoB is
	generic(
		BAUD_RATE_G : positive;		-- f_Tx = f_CLK / BAUD_RATE_G
		K : positive );
    Port ( send : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           TxD : out STD_LOGIC);
end nodoB;

architecture structural of nodoB is

	signal cword : ctrl_word_type;
	signal div : std_logic;
	signal TBE : std_logic;

begin
	ou : entity work.nodoB_ou
	generic map(
		BAUD_RATE_G => BAUD_RATE_G,		-- f_Tx = f_CLK / BAUD_RATE_G
		K => K )
	port map(
		clk => clk,
		ctrl_word => cword,
		TxD => TxD,
		TBE => TBE );
	
	cu : entity work.nodoB_cu
	port map(
		send => send,
		TBE => TBE,
		rst => rst,
		clk => clk,
		ctrl_word => cword );

end structural;
