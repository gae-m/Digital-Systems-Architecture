----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2023 12:45:16
-- Design Name: 
-- Module Name: iload_processor_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.common_defs.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity iload_processor_tb is
--  Port ( );
end iload_processor_tb;

architecture Behavioral of iload_processor_tb is
-- Component ports
  signal reset          : std_logic;
  signal mem_data_we    : std_logic;
  signal mem_data_in    : reg_data_type;
  signal mem_data_out   : reg_data_type;
  signal mem_data_addr  : reg_data_type;
  signal mem_instr_in   : mbr_data_type;
  signal mem_instr_addr : reg_data_type;

  -- Clock
  signal clk : std_logic := '1';

  -- Variables
  shared variable end_run : boolean := false;

begin  -- architecture behavioral

  -- Component instantiation
  dut : entity work.processor
    port map (
      clk            => clk,
      reset          => reset,
      mem_data_we    => mem_data_we,
      mem_data_in    => mem_data_in,
      mem_data_out   => mem_data_out,
      mem_data_addr  => mem_data_addr,
      mem_instr_in   => mem_instr_in,
      mem_instr_addr => mem_instr_addr);

  dp_ar_ram : entity work.dp_ar_ram
    port map (
      clk        => clk,
      we_1       => mem_data_we,
      data_in_1  => mem_data_out,
      data_out_1 => mem_data_in,
      address_1  => mem_data_addr,
      we_2       => '0',
      data_in_2  => (others => '0'),
      data_out_2 => mem_instr_in,
      address_2  => mem_instr_addr);

  -- Clock generation
  clk_proc : process
  begin
    while end_run = false loop
      clk <= not clk;
      wait for 5 ns;
    end loop;

    wait;
  end process clk_proc;

  -- Waveform generation
  wavegen_proc: process
  begin
    wait until clk = '1';
    wait for 2 ns;

    reset <= '1';
    wait for 10 ns;
    reset <= '0';

    wait until mem_instr_addr = x"0000000A" and mem_data_we = '1';
    assert mem_data_in = x"00000002" report "Error" severity failure;

    wait until mem_instr_addr = x"0000000B";
    end_run := true;
    wait;
  end process wavegen_proc;

end Behavioral;
