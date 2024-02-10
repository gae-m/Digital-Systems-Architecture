library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.nodoA_util.all;
	
entity nodoA_tb is
	--Port()
end nodoA_tb;

architecture behavioral of nodoA_tb is
	constant CLK_PERIOD : time := 1ns;
	constant BAUD_RATE_G : positive := 2;
	constant TX_PERIOD : time := BAUD_RATE_G * CLK_PERIOD;
	
	constant K : positive := 3;
	constant depth : positive := 2**K;
	subtype word is std_logic_vector(7 downto 0);
	type rom_type is array(0 to depth-1) of word;
	constant oracle : rom_type := (
	x"01",
	x"02",
	x"04",
	x"08",
	x"10",
	x"20",
	x"40",
	x"80" );
	
	signal send : std_logic;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal TxD : std_logic;
begin
	dut : entity work.nodoA
	generic map(
		BAUD_RATE_G => BAUD_RATE_G,
		K => K )
	port map(
		send => send,
		rst => rst,
		clk => clk,
		TxD => TxD );
		
	gen_clk : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
	--------------
	-- il data frame della UART è composto da 11 bit:
	-- 1 bit di start -> '0'
	-- 8 bit di dato da LSb a MSb
	-- 1 bit di parità DISPARI
	-- 1 bit di stop -> '1'
	---------------
	test : process
		variable data_frame : std_logic_vector (10 downto 0) := "10000000000";
		alias data : std_logic_vector is data_frame(8 downto 1);
		alias parity_bit : std_logic is data_frame(9);
	begin
		wait for CLK_PERIOD/4;
		
		send <= '0';
		rst <= '1';
		wait for CLK_PERIOD;
		assert TxD = '1' report "Error reset UART" severity failure;
		
		rst <= '0';
		wait for CLK_PERIOD;
		assert TxD = '1' report "Error reset UART" severity failure;
		
		send <= '1';
		wait for CLK_PERIOD;
		send <= '0';
		
		for i in 0 to depth-1 loop
			wait until TxD'event and TxD = '0';
			data := oracle(i);
			parity_bit := '0';
			wait for CLK_PERIOD + CLK_PERIOD/4;
			for j in 0 to 10 loop
				assert TxD = data_frame(j) report "Errore di trasmissione" severity failure;
				wait for TX_PERIOD;
			end loop;
		end loop;
		
		wait for 2*CLK_PERIOD;
		assert TxD = '1' report "Error UART" severity failure;
		
		send <= '1';
		wait for CLK_PERIOD;
		send <= '0';
		
		for i in 0 to depth-1 loop
			wait until TxD'event and TxD = '0';
			data := oracle(i);
			parity_bit := '0';
			wait for CLK_PERIOD + CLK_PERIOD/4;
			for j in 0 to 10 loop
				assert TxD = data_frame(j) report "Errore di trasmissione" severity failure;
				wait for TX_PERIOD;
			end loop;
		end loop;
		
		wait;
	end process;
	
end behavioral;