`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 03:00:13 PM
// Design Name: 
// Module Name: TestB
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


module TestB(
    );
    reg TMS, TCK=0,TRST,TDI;
    reg CLK;
    wire TDO;//data output
    
    wire TMS_O, TCK_O,TDI_O,TDO_O;
    reg [15:0] SW;
    wire [15:0] LD;
    
    Board b(
    TMS,//state control port 
    TCK,//clock
    TDI,//data input
    TDO,//data output
    
    TMS_O,//state control port 
    TCK_O,//clock
    TDI_O,//data input
    TDO_O,//data 
    SW,
    LD,
    CLK);
    
initial
    
    begin
        TDI = 1;
        TCK = 0; 
        TMS = 1;
        #10 
        TMS = 0; //->reset
        #10
        TMS = 1; //->select DR
        #10
        TMS = 1; //->select IR
        #10
        TMS = 0; //capture IR
        #10
        TMS = 0; //shift IR 1
        #10
        TDI = 0; //shift 1
        TMS = 0; //shift IR 2
        #10
        TDI = 1;    //2
        TMS = 0; //shift IR 3
        #10
        TDI = 0;    //3
        #10
        TDI = 0;    //4
        TMS = 1; //exit IR
        #10
        TMS = 1; //Updaete IR
        #10
        TMS = 1; //Select DR
        #10
        TMS = 0; //Capture DR
        #10
        TMS = 0; //shift DR 32
        #310
        #10
        TMS = 1; //Exit DR
        #10
        TMS = 1; //Update DR
        #10
        TMS = 0;
        
    end

always 
    #5 TCK = !TCK;
      
//always 
    //#10 TDI = !TDI;
    
endmodule
