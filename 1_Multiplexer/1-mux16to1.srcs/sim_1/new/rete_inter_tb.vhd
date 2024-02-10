library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity rete_inter_tb is
--  Port ( );
end rete_inter_tb;

architecture Behavioral of rete_inter_tb is
	component rete_inter port(
		x : in std_logic_vector(15 downto 0);
		s : in std_logic_vector(3 downto 0);
		d : in std_logic_vector(1 downto 0);
		y : out std_logic_vector(3 downto 0) );
	end component;
	signal input : std_logic_vector(15 downto 0) := x"a5a5";
	signal src : std_logic_vector(3 downto 0);
	signal dest : std_logic_vector(1 downto 0);
	signal output : std_logic_vector(3 downto 0);
begin
	dut : rete_inter port map(
		x => input,
		s => src,
		d => dest,
		y => output );
	process
		constant n_src : positive := 2**src'length;
		constant n_dest : positive := 2**dest'length;
	begin
		wait for 5ns;
		for i in 0 to n_src-1 loop
			src <= std_logic_vector(to_unsigned(i,src'length));
			
			for j in 0 to n_dest-1 loop
				dest <= std_logic_vector(to_unsigned(j,dest'length));
				wait for 5ns;
				assert output(j) = input(i) report "errore" severity failure;
			end loop;
			
		end loop;
	end process;

end Behavioral;
