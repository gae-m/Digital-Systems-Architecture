library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.nodoB_util.all;

entity nodoB_ou is
	generic(
		BAUD_RATE_G : positive;		-- f_Tx = f_CLK / BAUD_RATE_G
		K : positive );
    Port ( clk : in STD_LOGIC;
           ctrl_word : in ctrl_word_type;
           TxD : out STD_LOGIC;
           div : out STD_LOGIC;
           TBE : out std_logic);
end nodoB_ou;

architecture structural of nodoB_ou is

	signal count : std_logic_vector(K-1 downto 0);
	signal dbin : std_logic_vector(7 downto 0);
	
begin
	counter0 : entity work.counter
		generic map(
			bits => K,
			delay => 0ns )
		port map(
			x => ctrl_word(incr),
			rst => ctrl_word(rst_ou),
			y => count,
			div => div );
	
	rom0 : entity work.rom (dataflowB)
		generic map(
			nbit_addr => K,
			width => 8 )
		port map(
			addr => count,
			clk => clk,
			read => ctrl_word(read),
			rst => ctrl_word(rst_ou),
			data_out => dbin );

	uart0 : entity work.UARTComponent
		generic map(
			BAUD_RATE_G => BAUD_RATE_G)		-- f_Tx = f_CLK / BAUD_RATE_G
		port map(
			DBIN => dbin,
			WR => ctrl_word(write),
			RST => ctrl_word(rst_ou),
			CLK => clk,
			RXD => '1',
			RD => '0',
			TBE => TBE,
			TXD => TxD );
			
end structural;
