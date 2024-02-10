library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.nodoB_util.all;
	
entity nodoB_tb is
	--Port()
end nodoB_tb;

architecture behavioral of nodoB_tb is
	constant CLK_PERIOD : time := 1ns;
	constant BAUD_DIVIDE_G : positive := 2;
	constant RX_PERIOD : time := BAUD_DIVIDE_G * CLK_PERIOD;
	constant TX_PERIOD : time := 16 * RX_PERIOD;
	
	constant K : positive := 2;
	constant depth : positive := 2**K;
	subtype word is std_logic_vector(7 downto 0);
	type rom_type is array(0 to depth-1) of word;
	constant oracle : rom_type := (
	x"01",
	x"03",
	x"10",
	x"30" );
	
	signal mode : std_logic;
	signal addr : std_logic_vector(K-1 downto 0);
	signal RxD : std_logic;
	signal clk : std_logic := '0';
	signal rst : std_logic;
	signal data_out : std_logic_vector(7 downto 0);
	
begin
	dut : entity work.nodoB
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G,		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		K => K )
	port map(
		mode => mode,
		addr => addr,
		RxD => RxD,
		clk => clk,
		rst => rst,
		data_out => data_out);
		
	clk_gen : process
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
		
		mode <= '0';
		addr <= (others => '0');
		RxD <= '1';
		rst <= '1';
		wait for CLK_PERIOD;
		
		rst <= '0';
		wait for CLK_PERIOD;
		
		for i in 0 to depth-1 loop
			data := oracle(i);
			parity_bit := '1'; 		-- per il calcolo della parità DISPARI
			for j in 1 to 8 loop
				parity_bit := parity_bit xor data(j);		-- calcolo del bit di parità
			end loop;
			
			for j in 0 to 10 loop
				RxD <= data_frame(j);
				wait for TX_PERIOD;
			end loop;
		end loop;
		
		mode <= '1';
		wait for CLK_PERIOD;
		for i in 0 to depth-1 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait for CLK_PERIOD;
			assert data_out = oracle(i) report "Error" severity failure;
		end loop;
		
		wait;
	end process;
	
end behavioral;