library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity nodoC_ou is
    generic(BAUD_DIVIDE_G : positive;
            K : positive);		-- f_Rx = f_CLK / BAUD_DIVIDE_G)
    port(
         
         clk : in STD_LOGIC;
         addr : in STD_LOGIC_VECTOR (K-1 downto 0);
         --NODO A
         data_in : in STD_LOGIC_VECTOR(7 downto 0);
         --NODO B
         RxD : in STD_LOGIC;
         --SEGNALI DI CONTROLLO
         read : in STD_LOGIC; 
         incr : in STD_LOGIC;
         en_mem : in STD_LOGIC;
         en_reg : in STD_LOGIC;
         ctrl_mode : in STD_LOGIC;
         rst_ou : in STD_LOGIC;
         --USCITA 
         data_out : out STD_LOGIC_VECTOR (7 downto 0);
         RDA : inout STD_LOGIC);
end nodoC_ou;

architecture Structural of nodoC_ou is

signal dbout : std_logic_vector(7 downto 0);
signal count : std_logic_vector(K-1 downto 0);
signal regB : std_logic_vector(7 downto 0);
signal regA : std_logic_vector(7 downto 0);

signal mux_to_mem : std_logic_vector(K-1 downto 0);
signal cont1_to_mux : std_logic_vector(K-1 downto 0);

signal gt_to_enc : std_logic;
signal eq_to_enc : std_logic;
signal lt_to_enc : std_logic;
signal sel : std_logic_vector(1 downto 0);

signal sum : std_logic_vector(7 downto 0);
signal and_res : std_logic_vector(7 downto 0);
signal data_mem : std_logic_vector(7 downto 0);



begin

and_res <= regA and regB;


registerB : entity work.register_pp generic map ( dim => 8)
            port map(x => dbout, clk => clk, enable => en_reg, rst => rst_ou, y => regB);
            
            
registerA : entity work.register_pp generic map ( dim => 8)
            port map(x => data_in, clk => clk, enable => en_reg, rst => rst_ou, y => regA);
            
            
uart0 : entity work.UARTcomponent generic map( BAUD_DIVIDE_G => BAUD_DIVIDE_G )		-- f_Rx = f_CLK / BAUD_DIVIDE_G
		port map( DBIN => (others => '0'), WR => '0', 
		RST => rst_ou, CLK => clk,
		RXD => RxD, RD => read,
	   DBOUT => dbout,RDA => RDA );            
            
            
comp : entity work.byte_comparator generic map( N => 8)
            port map(a => regA, b => regB, gt =>'0', eq => '1', lt => '0', 
            a_gt_b => gt_to_enc, a_eq_b => eq_to_enc, a_lt_b => lt_to_enc );


enc : entity work.encoder 
            port map(a => gt_to_enc, b => eq_to_enc, c => lt_to_enc, s => sel);


mux4_1 : entity work.mux4to1 generic map( N => 8 )
            port map( x0 => sum, x1 => regA, x2 => and_res, x3 => "00000000", 
            s => sel, y => data_mem);
rca : entity work.ripple_carry_adder generic map (nbit => 8)
        port map(a => regA, b => regB, c_in => '0', s => sum);
        
        
mem : entity work.memory generic map( nbits_addr => K, width => 8 )
        port map( addr => mux_to_mem, 
        en => en_mem, clk => clk, rst => rst_ou,
        data_in => data_mem, r_w => ctrl_mode, data_out => data_out);
        
        
mux2_1 : entity work.mux2to1 generic map( N => K)
        port map( x1 => count, x2 => addr, s => ctrl_mode, y => mux_to_mem);
              
              
counter0 : entity work.counter generic map( bits => K, delay => 0ns )
           port map( x => incr, rst => rst_ou, y => count );
                     
end Structural;
