library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system is generic(
            BAUD_DIVIDE_G : positive := 651;    -- baud_rate = 9600 con f_CLK = 100MHz
            K : positive := 3 );
		    
    Port ( rst : in STD_LOGIC;
           clk_A : in STD_LOGIC;
           clk_B : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR(2 downto 0);
           send_A : in STD_LOGIC;
           send_B : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(7 downto 0));
end system;

architecture Structural of system is
	constant BAUD_RATE_G : positive := 16 * BAUD_DIVIDE_G;	-- f_Tx = f_Rx/16
	signal ack : std_logic;
	signal ready : std_logic;
	signal data_sendA : std_logic_vector(7 downto 0);
	signal TxD : std_logic;
begin

    nodoA: entity work.nodoA
    generic map(
    	K => K )
    port map(
    	start => send_A, ack => ack, rst => rst, clk => clk_A, 
        ready => ready, data_out => data_sendA);
        
    nodoB: entity work.nodoB
    generic map(BAUD_RATE_G => BAUD_RATE_G, K => K)
    port map(send => send_B, rst => rst, clk => clk_B, TxD => TxD);
    
    nodoC: entity work.nodoC
    generic map(BAUD_DIVIDE_G => BAUD_DIVIDE_G, K => K)
    port map(clk => clk_B, rst => rst, RxD => TxD, data_in => data_sendA, 
        ready => ready, addr => addr, data_out => data_out, ack => ack);
       	  
end Structural;
