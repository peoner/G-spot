`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2019 03:58:03 PM
// Design Name: 
// Module Name: Board
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Test_box(
    input wire [7:0]a,
    input wire [7:0]b,
    output wire [7:0]c,
    input clk
);
reg [7:0]res;

assign c = res;

always @ (posedge clk)
    res = a + b;
    
endmodule

module Board(
    input  TMS,//state control port 
    input  TCK,//clock
    input  TDI,//data input
    output  TDO,//data output
    
    output TMS_O,//state control port 
    output TCK_O,//clock
    output TDI_O,//data input
    output TDO_O,//data output
    
    input wire [15:0]SW,
    output wire [15:0]LD,
    input wire CLK
    );
    
    assign TMS_O = TMS;
    assign TCK_O = TCK;
    assign TDI_O = TDI;
    assign TDO_O = TDO;
    
    wire [7:0]TB_a_in;
    wire [7:0]TB_b_in;
    wire [7:0]TB_c_out;
    wire TB_clk;
    
    Test_box t_box(TB_a_in,TB_b_in,TB_c_out,TB_clk);
    
    
    tap_controller tap_c(TMS, TCK, TDI, TDO, SW, LD, CLK ,{TB_a_in,TB_b_in,TB_clk},TB_c_out);
    
endmodule
