library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nodoA_datapath is
	Generic(
		M : positive := 8;
		K : positive := 3 );
    Port ( inc : in STD_LOGIC;
    		strobe : in STD_LOGIC;
    		rst_dp : in STD_LOGIC;
    		clk : in std_logic;
           data_out : out STD_LOGIC_VECTOR (M-1 downto 0);
           div : out STD_LOGIC );		-- segnale di stato del contatore
end nodoA_datapath;

architecture structural of nodoA_datapath is
	component counter is
		generic (
			bits : positive := K);
		Port ( x : in STD_LOGIC;
			   rst : in STD_LOGIC;
			   y : buffer STD_LOGIC_VECTOR (bits-1 downto 0);
			   div : out STD_LOGIC);
	end component;
	
	component rom is
		generic(
			nbit_addr : positive := K;		-- numero di bit di indirizzamento
			width : positive := M );	-- dimensione di una word di memoria
		Port ( addr : in STD_LOGIC_VECTOR (nbit_addr - 1 downto 0);
				clk : in STD_LOGIC;
				read : in STD_LOGIC;
				rst : in STD_LOGIC;
			   data_out : out STD_LOGIC_VECTOR (width - 1 downto 0));
	end component;
	FOR ALL : rom USE ENTITY work.rom (dataflowA);
	
	signal address : std_logic_vector (K-1 downto 0);
	
begin
	counter0 : counter port map(
		x => inc,
		rst => rst_dp,
		y => address,
		div => div );
	
	rom0 : rom port map(
		addr => address,
		clk => clk,
		rst => rst_dp,
		read => strobe,
		data_out => data_out );
		
end structural;
