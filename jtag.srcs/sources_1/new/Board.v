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
    input wire [7:0]in_p,
    output wire [7:0]out,
    input in_p_ac,
    input clk
);
reg [7:0]res;

assign out = res;

always @ (*)
begin
    if(in_p_ac)
        res[7:0] = in_p[7:0];
    else if (clk)
        res[7:0] = {res[0], res[7:1]};
end

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
    
    reg [10:0]CLK_d = 0;
    
    always @(posedge CLK)
        CLK_d = CLK_d + 1;
        
    
    wire [7:0]TB_a_in;
    wire [7:0]TB_c_out;
    wire TB_clk;
    wire TB_p_in_ac;
    
    Test_box t_box(TB_a_in,TB_c_out,TB_p_in_ac,TB_clk);
    
    
    tap_controller tap_c(TMS, TCK, TDI, TDO, {SW[10], SW[8:0]}, LD[7:0], {TB_clk,TB_p_in_ac,TB_a_in},TB_c_out);
    
endmodule
