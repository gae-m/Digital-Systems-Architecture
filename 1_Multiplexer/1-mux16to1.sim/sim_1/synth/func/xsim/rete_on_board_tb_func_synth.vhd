-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Sep 27 18:08:35 2023
-- Host        : LAPTOP-KP9RFQ43 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/Donato/Desktop/vivado_projects/1-mux16to1/1-mux16to1.sim/sim_1/synth/func/xsim/rete_on_board_tb_func_synth.vhd
-- Design      : rete_on_board
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity rete_on_board is
  port (
    addr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    src : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    y : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of rete_on_board : entity is true;
end rete_on_board;

architecture STRUCTURE of rete_on_board is
  signal addr_IBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal dst_IBUF : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal src_IBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal y_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \y_OBUF[3]_inst_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \y_OBUF[0]_inst_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \y_OBUF[1]_inst_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \y_OBUF[2]_inst_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \y_OBUF[3]_inst_i_1\ : label is "soft_lutpair1";
begin
\addr_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => addr(0),
      O => addr_IBUF(0)
    );
\addr_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => addr(1),
      O => addr_IBUF(1)
    );
\addr_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => addr(2),
      O => addr_IBUF(2)
    );
\addr_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => addr(3),
      O => addr_IBUF(3)
    );
\dst_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => dst(0),
      O => dst_IBUF(0)
    );
\dst_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => dst(1),
      O => dst_IBUF(1)
    );
\src_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => src(0),
      O => src_IBUF(0)
    );
\src_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => src(1),
      O => src_IBUF(1)
    );
\src_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => src(2),
      O => src_IBUF(2)
    );
\src_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => src(3),
      O => src_IBUF(3)
    );
\y_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => y_OBUF(0),
      O => y(0)
    );
\y_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00005110"
    )
        port map (
      I0 => dst_IBUF(1),
      I1 => src_IBUF(3),
      I2 => \y_OBUF[3]_inst_i_2_n_0\,
      I3 => addr_IBUF(3),
      I4 => dst_IBUF(0),
      O => y_OBUF(0)
    );
\y_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => y_OBUF(1),
      O => y(1)
    );
\y_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"51100000"
    )
        port map (
      I0 => dst_IBUF(1),
      I1 => src_IBUF(3),
      I2 => \y_OBUF[3]_inst_i_2_n_0\,
      I3 => addr_IBUF(3),
      I4 => dst_IBUF(0),
      O => y_OBUF(1)
    );
\y_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => y_OBUF(2),
      O => y(2)
    );
\y_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000A220"
    )
        port map (
      I0 => dst_IBUF(1),
      I1 => src_IBUF(3),
      I2 => \y_OBUF[3]_inst_i_2_n_0\,
      I3 => addr_IBUF(3),
      I4 => dst_IBUF(0),
      O => y_OBUF(2)
    );
\y_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => y_OBUF(3),
      O => y(3)
    );
\y_OBUF[3]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"A2200000"
    )
        port map (
      I0 => dst_IBUF(1),
      I1 => src_IBUF(3),
      I2 => \y_OBUF[3]_inst_i_2_n_0\,
      I3 => addr_IBUF(3),
      I4 => dst_IBUF(0),
      O => y_OBUF(3)
    );
\y_OBUF[3]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F7FF757751551011"
    )
        port map (
      I0 => src_IBUF(2),
      I1 => src_IBUF(1),
      I2 => addr_IBUF(0),
      I3 => src_IBUF(0),
      I4 => addr_IBUF(1),
      I5 => addr_IBUF(2),
      O => \y_OBUF[3]_inst_i_2_n_0\
    );
end STRUCTURE;
