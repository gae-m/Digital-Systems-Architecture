library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodoA is
	Generic(
		M : positive := 8;
		K : positive := 3 );
    Port ( start : in STD_LOGIC;
           ack : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           ready : out STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (M-1 downto 0));
end nodoA;

architecture structural of nodoA is
	component nodoA_CU is
		Port ( start : in STD_LOGIC;
			   ack : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   ready : out STD_LOGIC;
			   inc : out STD_LOGIC;
			   strobe : out STD_LOGIC );
	end component;
	
	component nodoA_datapath is
		Generic(
			M : positive;
			K : positive );
		Port ( inc : in STD_LOGIC;
				strobe : in STD_LOGIC;
				rst_dp : in STD_LOGIC;
			   clk : in STD_LOGIC;
			   data_out : out STD_LOGIC_VECTOR (7 downto 0);
			   div : out STD_LOGIC );
	end component;
	
	-- segnali di controllo
	signal increment : std_logic;
	signal strobe : std_logic;
	
begin
	dp : nodoA_datapath 
	generic map(
		M => M,
		K => K )
	port map(
		inc => increment,
		strobe => strobe,
		rst_dp => rst,
		clk => clk,
		data_out => data_out);
		
	cu : nodoA_CU port map(
		start => start,
		ack => ack,
		ready => ready,
		clk => clk,
		rst => rst,
		inc => increment,
		strobe => strobe );

end structural;
