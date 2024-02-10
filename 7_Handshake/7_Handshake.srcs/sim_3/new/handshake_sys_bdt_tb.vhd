library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity handshake_sys_bdt_tb is

end handshake_sys_bdt_tb;

architecture behavioral of handshake_sys_bdt_tb is
	constant M : positive := 32;
	constant K : positive := 3; 
	constant clk_B_factor : positive := 2;
	constant clk_B_delay : time := 4ns;
	constant clkA_period : time := 10ns;
	constant clkB_period : time := clk_B_factor * clkA_period;
	
	signal start : std_logic;
	signal addr : std_logic_vector(K-1 downto 0);
	signal mode : STD_LOGIC;
    signal clk : STD_LOGIC := '1';
	signal rst_sys : STD_LOGIC;
	signal rst_bdt : STD_LOGIC;
	signal data_out : STD_LOGIC_VECTOR(M-1 downto 0);
	
	constant depth : positive := 2**K;
	subtype word is std_logic_vector (M - 1 downto 0);
	type rom_type is array(0 to depth - 1) of word;
	constant rom : rom_type := (
		x"00010002",
		x"00030004",
		x"00050006",
		x"00070008",
		x"0009000A",
		x"000B000C",
		x"000D000E",
		x"000F0010"
	); 
	
begin

	dut: entity work.handshake_sys_bdt
	Generic map (
		M => M,
		K => K, 
		clk_B_factor => clk_B_factor,
		clk_B_delay => clk_B_delay)
    Port map ( 
    	start => start,
        addr => addr,
        mode => mode,
        clk => clk,
        rst_sys => rst_sys,
        rst_bdt => rst_bdt,
        data_out => data_out );
        
    clk_gen : process
    begin
    	wait for clkA_period/2;
    	clk <= not(clk);
    end process;
    
    test: process
    begin
    	start <= '0';
    	mode <= '0';
    	addr <= (others => '0');
    	rst_sys <= '1';
    	rst_bdt <= '1';
    	wait for clkA_period;
    	
    	rst_bdt <= '0';
    	wait for clkB_period;
    	
    	rst_sys <= '0';
    	wait for clkB_period;
    	
    	start <= '1';
    	wait for clkA_period;
    	start <= '0';
    	
    	wait for 630ns;
    	mode <= '1';
    	for i in 0 to 7 loop
			addr <= std_logic_vector(to_unsigned(i,addr'length));
			wait until data_out'active;
			assert data_out = rom(i) + rom(i) report "Errore" severity failure;
    	end loop;
    	
    	mode <= '0';
    	wait for clkB_period;
    end process;

end behavioral;