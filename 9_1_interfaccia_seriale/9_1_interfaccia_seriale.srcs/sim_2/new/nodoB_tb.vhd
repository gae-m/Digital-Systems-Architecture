library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodoB_tb is
--  Port ( );
end nodoB_tb;

architecture Behavioral of nodoB_tb is
	
	constant BAUD_DIVIDE_G : positive := 2;
	constant CLK_PERIOD : time := 1ns;
	constant RX_PERIOD : time := BAUD_DIVIDE_G * CLK_PERIOD;
	constant TX_PERIOD : time := 16 * RX_PERIOD;
	
	signal data_out : std_logic_vector(7 downto 0);
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal RxD : std_logic;

begin
	dut : entity work.nodoB
	generic map(
		BAUD_DIVIDE_G => BAUD_DIVIDE_G )	-- f_Rx = f_CLK / BAUD_DIVIDE_G
	port map(
		RxD => RxD,
		rst => rst,
		clk => clk,
		data_out => data_out );
		
	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not(clk);
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
		
		RxD <= '1';
		rst <= '1';
		wait for CLK_PERIOD;
		
		rst <= '0';
		wait for CLK_PERIOD;
		
		data := x"AA";
		parity_bit := '1';		-- corretto
		for i in 0 to 10 loop
			RxD <= data_frame(i);
			wait for TX_PERIOD;
		end loop;
		assert data_out = data report "Error" severity failure;
		
		data := x"40";
		parity_bit := '1';		-- errato
		for i in 0 to 10 loop
			RxD <= data_frame(i);
			wait for TX_PERIOD;
		end loop;
		assert data_out = data report "Error" severity failure;
		
		wait;
	end process; 

end Behavioral;