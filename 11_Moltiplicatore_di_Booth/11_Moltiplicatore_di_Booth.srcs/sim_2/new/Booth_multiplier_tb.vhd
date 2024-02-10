library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity booth_mult_tb is
--  Port ( );
end booth_mult_tb;

architecture behavioral of booth_mult_tb is
	constant CLK_PERIOD : time := 10ns;
	constant WIDTH : positive := 8;
	constant OPERAND_1 : integer := -5;
	constant OPERAND_2 : integer := 47;
	constant RESULT : integer := -235;
	
	signal X : std_logic_vector(wIDTH-1 downto 0);
	signal Y : std_logic_vector(wIDTH-1 downto 0);
	signal multiply : std_logic;
	signal rst : std_logic;
	signal clk : std_logic := '0';
	signal P : std_logic_vector(2*wIDTH-1 downto 0);
	signal busy : std_logic;
begin
	dut : entity work.Booth_multiplier
	generic map(
		WIDTH => WIDTH)
	port map(
		X => X,
		Y => Y,
		multiply => multiply,
		rst => rst,
		clk => clk,
		product => P,
		busy => busy);
		
	clk_gen : process
	begin
		wait for CLK_PERIOD/2;
		clk <= not clk;
	end process;
	
	test : process
	begin
		wait for CLK_PERIOD/4;
		rst <= '1';
		wait for CLK_PERIOD;
		
		rst <= '0';
		wait for CLK_PERIOD;
		
		assert busy = '0' report "Error: busy" severity failure;
		-- X e Y devono restare stabili per almeno 2 colpi di clock;
		X <= std_logic_vector(to_signed(OPERAND_1,X'length));
		Y <= std_logic_vector(to_signed(OPERAND_2,Y'length));
		multiply <= '1';
		wait for CLK_PERIOD;
		
		assert busy = '1' report "Error: busy" severity failure;
		multiply <= '0';
		
		wait until falling_edge(busy);
		assert P = std_logic_vector(to_signed(RESULT,P'length))
			report "Error result" severity failure;
		
		wait for CLK_PERIOD/4;
		-- X e Y devono restare stabili per almeno 2 colpi di clock;
		X <= std_logic_vector(to_signed(OPERAND_1,X'length));
		Y <= std_logic_vector(to_signed(OPERAND_2,Y'length));
		multiply <= '1';
		wait for CLK_PERIOD;
		
		assert busy = '1' report "Error: busy" severity failure;
		multiply <= '0';
		
		wait until falling_edge(busy);
		assert P = std_logic_vector(to_signed(RESULT,P'length))
			report "Error result" severity failure;
			
		wait;
		
	end process;
		
end behavioral;