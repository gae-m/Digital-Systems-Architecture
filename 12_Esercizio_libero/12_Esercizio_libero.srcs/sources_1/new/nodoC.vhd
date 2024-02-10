library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodoC is generic(
		BAUD_DIVIDE_G : positive;		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		K : positive );
		port (clk : in std_logic;
		rst : in std_logic;
		RxD : in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		ready : in std_logic;
		addr : in std_logic_vector(K-1 downto 0);
		data_out : out std_logic_vector(7 downto 0);
		ack : out std_logic);

end nodoC;

architecture Structural of nodoC is

signal rda : std_logic;

signal en_reg : STD_LOGIC;
signal en_mem : STD_LOGIC;
signal read : STD_LOGIC;
signal incr : STD_LOGIC;
signal ctrl_mode :  STD_LOGIC;

begin
    
    cu: entity work.nodoC_cu port map(
        rda =>rda, ready => ready, rst => rst, clk => clk, 
        en_reg => en_reg, en_mem => en_mem, read => read, incr => incr, 
        ctrl_mode => ctrl_mode, ack => ack);
    
    ou: entity work.nodoC_ou generic map ( BAUD_DIVIDE_G => BAUD_DIVIDE_G, K => K)
        port map(clk => clk, addr => addr, data_in => data_in, RxD => RxD, 
        read => read, incr => incr, en_mem => en_mem, en_reg => en_reg, 
        ctrl_mode => ctrl_mode, rst_ou => rst, 
        data_out => data_out, RDA => rda);
       

end Structural;
