// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Fri Nov 29 18:09:22 2019
// Host        : DESKTOP-2OJTJAP running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file D:/jtag2/jtag.sim/sim_1/impl/func/xsim/TestB_func_impl.v
// Design      : Board
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* ECO_CHECKSUM = "bcb686c4" *) 
(* NotValidForBitStream *)
module Board
   (TMS,
    TCK,
    TDI,
    TDO,
    TMS_O,
    TCK_O,
    TDI_O,
    TDO_O,
    SW,
    LD,
    CLK);
  input TMS;
  input TCK;
  input TDI;
  output TDO;
  output TMS_O;
  output TCK_O;
  output TDI_O;
  output TDO_O;
  input [15:0]SW;
  output [15:0]LD;
  input CLK;

  wire [15:0]LD;
  wire [9:4]LD_OBUF;
  wire \LD_TRI[5] ;
  wire TCK;
  wire TCK_O;
  wire TCK_O_OBUF;
  wire TCK_O_OBUF_BUFG;
  wire TDI;
  wire TDI_O;
  wire TDO;
  wire TDO_O;
  wire TMS;
  wire TMS_O;
  wire TMS_O_OBUF;
  wire lopt;
  wire lopt_1;
  wire NLW_tap_c_lopt_2_UNCONNECTED;

  OBUFT \LD_OBUFT[5]_inst 
       (.I(lopt),
        .O(LD[5]),
        .T(\LD_TRI[5] ));
  OBUFT \LD_OBUF[0]_inst 
       (.I(1'b0),
        .O(LD[0]),
        .T(1'b1));
  OBUFT \LD_OBUF[10]_inst 
       (.I(1'b0),
        .O(LD[10]),
        .T(1'b1));
  OBUFT \LD_OBUF[11]_inst 
       (.I(1'b0),
        .O(LD[11]),
        .T(1'b1));
  OBUFT \LD_OBUF[12]_inst 
       (.I(1'b0),
        .O(LD[12]),
        .T(1'b1));
  OBUFT \LD_OBUF[13]_inst 
       (.I(1'b0),
        .O(LD[13]),
        .T(1'b1));
  OBUFT \LD_OBUF[14]_inst 
       (.I(1'b0),
        .O(LD[14]),
        .T(1'b1));
  OBUFT \LD_OBUF[15]_inst 
       (.I(1'b0),
        .O(LD[15]),
        .T(1'b1));
  OBUFT \LD_OBUF[1]_inst 
       (.I(1'b0),
        .O(LD[1]),
        .T(1'b1));
  OBUFT \LD_OBUF[2]_inst 
       (.I(1'b0),
        .O(LD[2]),
        .T(1'b1));
  OBUFT \LD_OBUF[3]_inst 
       (.I(1'b0),
        .O(LD[3]),
        .T(1'b1));
  OBUF \LD_OBUF[4]_inst 
       (.I(LD_OBUF[4]),
        .O(LD[4]));
  OBUF \LD_OBUF[6]_inst 
       (.I(LD_OBUF[6]),
        .O(LD[6]));
  OBUF \LD_OBUF[7]_inst 
       (.I(LD_OBUF[7]),
        .O(LD[7]));
  OBUF \LD_OBUF[8]_inst 
       (.I(LD_OBUF[8]),
        .O(LD[8]));
  OBUF \LD_OBUF[9]_inst 
       (.I(LD_OBUF[9]),
        .O(LD[9]));
  IBUF TCK_IBUF_inst
       (.I(TCK),
        .O(TCK_O_OBUF));
  BUFG TCK_O_OBUF_BUFG_inst
       (.I(TCK_O_OBUF),
        .O(TCK_O_OBUF_BUFG));
  OBUF TCK_O_OBUF_inst
       (.I(TCK_O_OBUF_BUFG),
        .O(TCK_O));
  IBUF TDI_IBUF_inst
       (.I(TDI),
        .O(LD_OBUF[4]));
  OBUF TDI_O_OBUF_inst
       (.I(LD_OBUF[4]),
        .O(TDI_O));
  OBUFT TDO_OBUFT_inst
       (.I(lopt_1),
        .O(TDO),
        .T(\LD_TRI[5] ));
  OBUFT TDO_O_OBUFT_inst
       (.I(LD_OBUF[5]),
        .O(TDO_O),
        .T(\LD_TRI[5] ));
  IBUF TMS_IBUF_inst
       (.I(TMS),
        .O(TMS_O_OBUF));
  OBUF TMS_O_OBUF_inst
       (.I(TMS_O_OBUF),
        .O(TMS_O));
  tap_controller tap_c
       (.CLK(TCK_O_OBUF_BUFG),
        .LD_OBUF(LD_OBUF[9:5]),
        .\LD_TRI[5] (\LD_TRI[5] ),
        .TDI(LD_OBUF[4]),
        .TMS_O_OBUF(TMS_O_OBUF),
        .lopt(lopt),
        .lopt_1(lopt_1),
        .lopt_2(NLW_tap_c_lopt_2_UNCONNECTED));
endmodule

module tap_controller
   (LD_OBUF,
    \LD_TRI[5] ,
    CLK,
    TMS_O_OBUF,
    TDI,
    lopt,
    lopt_1,
    lopt_2);
  output [4:0]LD_OBUF;
  output \LD_TRI[5] ;
  input CLK;
  input TMS_O_OBUF;
  input [0:0]TDI;
  output lopt;
  output lopt_1;
  output lopt_2;

  wire CLK;
  wire [4:0]LD_OBUF;
  wire \LD_TRI[5] ;
  wire [0:0]TDI;
  wire TMS_O_OBUF;
  wire dr_shift;
  wire dr_shift_neg;
  wire ir_shift;
  wire ir_shift_ready;
  wire ir_update;
  wire [3:0]jtag_ir;
  wire \jtag_ir[0]_i_1_n_0 ;
  wire \jtag_ir[1]_i_1_n_0 ;
  wire \jtag_ir[2]_i_1_n_0 ;
  wire \jtag_ir[3]_i_2_n_0 ;
  wire \jtag_ir[3]_i_3_n_0 ;
  wire latched_jtag_ir;
  wire [3:0]p_0_out;
  wire [3:0]present_state;
  wire tdo_mux_out;
  wire tdo_mux_out_reg_i_1_n_0;
  wire tdo_mux_out_reg_i_2_n_0;
  wire tdo_out_reg_lopt_replica_1;
  wire tdo_out_reg_lopt_replica_2_1;
  wire test_logic_reset;

  assign lopt = tdo_out_reg_lopt_replica_1;
  assign lopt_1 = tdo_out_reg_lopt_replica_2_1;
  LUT2 #(
    .INIT(4'h1)) 
    TDO_OBUFT_inst_i_2
       (.I0(ir_shift_ready),
        .I1(dr_shift_neg),
        .O(\LD_TRI[5] ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    dr_shift_neg_i_1
       (.I0(present_state[3]),
        .I1(present_state[0]),
        .I2(present_state[1]),
        .I3(present_state[2]),
        .O(dr_shift));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    dr_shift_neg_reg
       (.C(CLK),
        .CE(1'b1),
        .D(dr_shift),
        .Q(dr_shift_neg),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h1000)) 
    ir_shift_ready_i_1
       (.I0(present_state[0]),
        .I1(present_state[1]),
        .I2(present_state[3]),
        .I3(present_state[2]),
        .O(ir_shift));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    ir_shift_ready_reg
       (.C(CLK),
        .CE(1'b1),
        .D(ir_shift),
        .Q(ir_shift_ready),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \jtag_ir[0]_i_1 
       (.I0(LD_OBUF[1]),
        .I1(present_state[3]),
        .I2(present_state[2]),
        .I3(present_state[0]),
        .I4(present_state[1]),
        .I5(jtag_ir[1]),
        .O(\jtag_ir[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \jtag_ir[1]_i_1 
       (.I0(LD_OBUF[2]),
        .I1(present_state[3]),
        .I2(present_state[2]),
        .I3(present_state[0]),
        .I4(present_state[1]),
        .I5(jtag_ir[2]),
        .O(\jtag_ir[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \jtag_ir[2]_i_1 
       (.I0(LD_OBUF[3]),
        .I1(present_state[3]),
        .I2(present_state[2]),
        .I3(present_state[0]),
        .I4(present_state[1]),
        .I5(jtag_ir[3]),
        .O(\jtag_ir[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0010)) 
    \jtag_ir[3]_i_1 
       (.I0(present_state[3]),
        .I1(present_state[2]),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .O(test_logic_reset));
  LUT5 #(
    .INIT(32'hFFFF0800)) 
    \jtag_ir[3]_i_2 
       (.I0(present_state[1]),
        .I1(present_state[0]),
        .I2(present_state[2]),
        .I3(present_state[3]),
        .I4(ir_shift_ready),
        .O(\jtag_ir[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF08000000)) 
    \jtag_ir[3]_i_3 
       (.I0(LD_OBUF[4]),
        .I1(present_state[3]),
        .I2(present_state[2]),
        .I3(present_state[0]),
        .I4(present_state[1]),
        .I5(TDI),
        .O(\jtag_ir[3]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \jtag_ir_reg[0] 
       (.C(CLK),
        .CE(\jtag_ir[3]_i_2_n_0 ),
        .D(\jtag_ir[0]_i_1_n_0 ),
        .Q(jtag_ir[0]),
        .R(test_logic_reset));
  FDRE #(
    .INIT(1'b0)) 
    \jtag_ir_reg[1] 
       (.C(CLK),
        .CE(\jtag_ir[3]_i_2_n_0 ),
        .D(\jtag_ir[1]_i_1_n_0 ),
        .Q(jtag_ir[1]),
        .R(test_logic_reset));
  FDRE #(
    .INIT(1'b0)) 
    \jtag_ir_reg[2] 
       (.C(CLK),
        .CE(\jtag_ir[3]_i_2_n_0 ),
        .D(\jtag_ir[2]_i_1_n_0 ),
        .Q(jtag_ir[2]),
        .R(test_logic_reset));
  FDRE #(
    .INIT(1'b0)) 
    \jtag_ir_reg[3] 
       (.C(CLK),
        .CE(\jtag_ir[3]_i_2_n_0 ),
        .D(\jtag_ir[3]_i_3_n_0 ),
        .Q(jtag_ir[3]),
        .R(test_logic_reset));
  LUT4 #(
    .INIT(16'h0004)) 
    \latched_jtag_ir[3]_i_1 
       (.I0(present_state[1]),
        .I1(present_state[0]),
        .I2(present_state[2]),
        .I3(present_state[3]),
        .O(latched_jtag_ir));
  LUT4 #(
    .INIT(16'h0001)) 
    \latched_jtag_ir[3]_i_2 
       (.I0(present_state[3]),
        .I1(present_state[2]),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .O(ir_update));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \latched_jtag_ir_reg[0] 
       (.C(CLK),
        .CE(ir_update),
        .D(jtag_ir[0]),
        .Q(LD_OBUF[1]),
        .R(latched_jtag_ir));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \latched_jtag_ir_reg[1] 
       (.C(CLK),
        .CE(ir_update),
        .D(jtag_ir[1]),
        .Q(LD_OBUF[2]),
        .S(latched_jtag_ir));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \latched_jtag_ir_reg[2] 
       (.C(CLK),
        .CE(ir_update),
        .D(jtag_ir[2]),
        .Q(LD_OBUF[3]),
        .R(latched_jtag_ir));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \latched_jtag_ir_reg[3] 
       (.C(CLK),
        .CE(ir_update),
        .D(jtag_ir[3]),
        .Q(LD_OBUF[4]),
        .S(latched_jtag_ir));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h75005F24)) 
    \present_state[0]_i_1 
       (.I0(present_state[0]),
        .I1(present_state[2]),
        .I2(present_state[1]),
        .I3(TMS_O_OBUF),
        .I4(present_state[3]),
        .O(p_0_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h55D52A9F)) 
    \present_state[1]_i_1 
       (.I0(present_state[0]),
        .I1(present_state[2]),
        .I2(TMS_O_OBUF),
        .I3(present_state[3]),
        .I4(present_state[1]),
        .O(p_0_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7C3C74C0)) 
    \present_state[2]_i_1 
       (.I0(TMS_O_OBUF),
        .I1(present_state[0]),
        .I2(present_state[2]),
        .I3(present_state[3]),
        .I4(present_state[1]),
        .O(p_0_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6E4888CE)) 
    \present_state[3]_i_1 
       (.I0(present_state[2]),
        .I1(present_state[3]),
        .I2(TMS_O_OBUF),
        .I3(present_state[1]),
        .I4(present_state[0]),
        .O(p_0_out[3]));
  FDRE #(
    .INIT(1'b1)) 
    \present_state_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_out[0]),
        .Q(present_state[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \present_state_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_out[1]),
        .Q(present_state[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \present_state_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_out[2]),
        .Q(present_state[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \present_state_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_out[3]),
        .Q(present_state[3]),
        .R(1'b0));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  LDCE #(
    .INIT(1'b0)) 
    tdo_mux_out_reg
       (.CLR(1'b0),
        .D(tdo_mux_out_reg_i_1_n_0),
        .G(tdo_mux_out_reg_i_2_n_0),
        .GE(1'b1),
        .Q(tdo_mux_out));
  LUT6 #(
    .INIT(64'h88888888888888B8)) 
    tdo_mux_out_reg_i_1
       (.I0(jtag_ir[0]),
        .I1(ir_shift),
        .I2(LD_OBUF[2]),
        .I3(LD_OBUF[1]),
        .I4(LD_OBUF[4]),
        .I5(LD_OBUF[3]),
        .O(tdo_mux_out_reg_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0208)) 
    tdo_mux_out_reg_i_2
       (.I0(present_state[2]),
        .I1(present_state[1]),
        .I2(present_state[0]),
        .I3(present_state[3]),
        .O(tdo_mux_out_reg_i_2_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    tdo_out_reg
       (.C(CLK),
        .CE(1'b1),
        .D(tdo_mux_out),
        .Q(LD_OBUF[0]),
        .R(1'b0));
  (* OPT_INSERTED_REPDRIVER *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    tdo_out_reg_lopt_replica
       (.C(CLK),
        .CE(1'b1),
        .D(tdo_mux_out),
        .Q(tdo_out_reg_lopt_replica_1),
        .R(1'b0));
  (* OPT_INSERTED_REPDRIVER *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    tdo_out_reg_lopt_replica_2
       (.C(CLK),
        .CE(1'b1),
        .D(tdo_mux_out),
        .Q(tdo_out_reg_lopt_replica_2_1),
        .R(1'b0));
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
