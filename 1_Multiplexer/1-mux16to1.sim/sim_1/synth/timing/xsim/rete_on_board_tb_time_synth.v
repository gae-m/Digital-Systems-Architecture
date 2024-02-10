// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Sep 27 18:09:28 2023
// Host        : LAPTOP-KP9RFQ43 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/Donato/Desktop/vivado_projects/1-mux16to1/1-mux16to1.sim/sim_1/synth/timing/xsim/rete_on_board_tb_time_synth.v
// Design      : rete_on_board
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* NotValidForBitStream *)
module rete_on_board
   (addr,
    src,
    dst,
    y);
  input [3:0]addr;
  input [3:0]src;
  input [1:0]dst;
  output [3:0]y;

  wire [3:0]addr;
  wire [3:0]addr_IBUF;
  wire [1:0]dst;
  wire [1:0]dst_IBUF;
  wire [3:0]src;
  wire [3:0]src_IBUF;
  wire [3:0]y;
  wire [3:0]y_OBUF;
  wire \y_OBUF[3]_inst_i_2_n_0 ;

initial begin
 $sdf_annotate("rete_on_board_tb_time_synth.sdf",,,,"tool_control");
end
  IBUF \addr_IBUF[0]_inst 
       (.I(addr[0]),
        .O(addr_IBUF[0]));
  IBUF \addr_IBUF[1]_inst 
       (.I(addr[1]),
        .O(addr_IBUF[1]));
  IBUF \addr_IBUF[2]_inst 
       (.I(addr[2]),
        .O(addr_IBUF[2]));
  IBUF \addr_IBUF[3]_inst 
       (.I(addr[3]),
        .O(addr_IBUF[3]));
  IBUF \dst_IBUF[0]_inst 
       (.I(dst[0]),
        .O(dst_IBUF[0]));
  IBUF \dst_IBUF[1]_inst 
       (.I(dst[1]),
        .O(dst_IBUF[1]));
  IBUF \src_IBUF[0]_inst 
       (.I(src[0]),
        .O(src_IBUF[0]));
  IBUF \src_IBUF[1]_inst 
       (.I(src[1]),
        .O(src_IBUF[1]));
  IBUF \src_IBUF[2]_inst 
       (.I(src[2]),
        .O(src_IBUF[2]));
  IBUF \src_IBUF[3]_inst 
       (.I(src[3]),
        .O(src_IBUF[3]));
  OBUF \y_OBUF[0]_inst 
       (.I(y_OBUF[0]),
        .O(y[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00005110)) 
    \y_OBUF[0]_inst_i_1 
       (.I0(dst_IBUF[1]),
        .I1(src_IBUF[3]),
        .I2(\y_OBUF[3]_inst_i_2_n_0 ),
        .I3(addr_IBUF[3]),
        .I4(dst_IBUF[0]),
        .O(y_OBUF[0]));
  OBUF \y_OBUF[1]_inst 
       (.I(y_OBUF[1]),
        .O(y[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h51100000)) 
    \y_OBUF[1]_inst_i_1 
       (.I0(dst_IBUF[1]),
        .I1(src_IBUF[3]),
        .I2(\y_OBUF[3]_inst_i_2_n_0 ),
        .I3(addr_IBUF[3]),
        .I4(dst_IBUF[0]),
        .O(y_OBUF[1]));
  OBUF \y_OBUF[2]_inst 
       (.I(y_OBUF[2]),
        .O(y[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h0000A220)) 
    \y_OBUF[2]_inst_i_1 
       (.I0(dst_IBUF[1]),
        .I1(src_IBUF[3]),
        .I2(\y_OBUF[3]_inst_i_2_n_0 ),
        .I3(addr_IBUF[3]),
        .I4(dst_IBUF[0]),
        .O(y_OBUF[2]));
  OBUF \y_OBUF[3]_inst 
       (.I(y_OBUF[3]),
        .O(y[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hA2200000)) 
    \y_OBUF[3]_inst_i_1 
       (.I0(dst_IBUF[1]),
        .I1(src_IBUF[3]),
        .I2(\y_OBUF[3]_inst_i_2_n_0 ),
        .I3(addr_IBUF[3]),
        .I4(dst_IBUF[0]),
        .O(y_OBUF[3]));
  LUT6 #(
    .INIT(64'hF7FF757751551011)) 
    \y_OBUF[3]_inst_i_2 
       (.I0(src_IBUF[2]),
        .I1(src_IBUF[1]),
        .I2(addr_IBUF[0]),
        .I3(src_IBUF[0]),
        .I4(addr_IBUF[1]),
        .I5(addr_IBUF[2]),
        .O(\y_OBUF[3]_inst_i_2_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
