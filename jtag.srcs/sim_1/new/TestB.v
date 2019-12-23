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
    reg TMS = 1, TCK=0,TRST,TDI;
    reg CLK=0;
    wire TDO;//data output
    
    wire TMS_O, TCK_O,TDI_O,TDO_O;
    reg [15:0] SW=0;
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


event SET_TDI_1_triger;
event SET_TDI_1_done_triger;

initial begin 
    forever begin
     @(SET_TDI_1_triger);
     @(negedge TCK);
     TDI = 1;
     @(posedge TCK);
     -> SET_TDI_1_done_triger;
     end
end

event SET_TDI_0_triger;
event SET_TDI_0_done_triger;

initial begin 
    forever begin
     @(SET_TDI_0_triger);
     @(negedge TCK);
     TDI = 0;
     @(posedge TCK);
     -> SET_TDI_0_done_triger;
     end
end

event SET_TMS_1_triger;
event SET_TMS_1_done_triger;

initial begin 
    forever begin
     @(SET_TMS_1_triger);
     @(negedge TCK);
     TMS = 1;
     @(posedge TCK);
     -> SET_TMS_1_done_triger;
     end
end

event SET_TMS_0_triger;
event SET_TMS_0_done_triger;

initial begin 
    forever begin
     @(SET_TMS_0_triger);
     @(negedge TCK);
     TMS = 0;
     @(posedge TCK);
     -> SET_TMS_0_done_triger;
     end
end

integer cur_state = 0;

localparam STATE_RESET    = 0;
localparam STATE_TEST_RUN = 1;
localparam STATE_UPDATE   = 2;
    /*localparam STATE_SELECT_IR_SCAN   =     4'd4;
    localparam STATE_DR_CAPTURE       =     4'd5;
    localparam STATE_DR_SHIFT         =     4'd6;
    localparam STATE_DR_EXIT1         =     4'd7;
    localparam STATE_DR_PAUSE         =     4'd8;
    localparam STATE_DR_EXIT2         =     4'd9;
    localparam STATE_DR_UPDATE        =     4'd10;
*/

event SET_SELECT_SCAN_triger;
event SET_SELECT_SCAN_done_triger;
reg SET_SELECT_SCAN_ev = 0;

initial begin 
    forever begin
     @(SET_SELECT_SCAN_triger);
     SET_SELECT_SCAN_ev = 1;
     if(cur_state == STATE_RESET) begin
        -> SET_TMS_0_triger;
        @(SET_TMS_0_done_triger);
        cur_state = STATE_TEST_RUN;
     end
     SET_SELECT_SCAN_ev = 0;
     -> SET_SELECT_SCAN_done_triger;
    end
end

integer TDI_SHIFT_SIZE = 0;
integer TDI_SHIFT_REG_I = 0;
reg [31:0] TDI_SHIFT_REG;

event SHIFT_TDI_triger;
event SHIFT_TDI_done_triger;
reg SHIFT_TDI_ev = 0;

initial begin 
    forever begin
     @(SHIFT_TDI_triger);
     SHIFT_TDI_ev = 1;
     for (TDI_SHIFT_REG_I = 0; TDI_SHIFT_REG_I < TDI_SHIFT_SIZE - 1; TDI_SHIFT_REG_I = TDI_SHIFT_REG_I+1) 
        begin
            if(TDI_SHIFT_REG[TDI_SHIFT_REG_I]) begin
                -> SET_TDI_1_triger;
                @(SET_TDI_1_done_triger);
            end
            else begin
                -> SET_TDI_0_triger;
                @(SET_TDI_0_done_triger);
            end            
        end
        
        if(TDI_SHIFT_REG[TDI_SHIFT_REG_I]) begin
            -> SET_TDI_1_triger;
        end
        else begin
            -> SET_TDI_0_triger;
        end
        
        @(negedge TCK);
        -> SHIFT_TDI_done_triger;
        SHIFT_TDI_ev = 0;        
    end
end

event LS_DR_triger; //SDR
event LS_DR_done_triger;
reg LS_DR_ev = 0;

initial begin 
    forever begin
     @(LS_DR_triger);
     LS_DR_ev = 1;
     -> SET_SELECT_SCAN_triger;
     @(SET_SELECT_SCAN_done_triger);
     
     -> SET_TMS_1_triger;
     @(SET_TMS_1_done_triger);
     
     -> SET_TMS_0_triger;
     @(SET_TMS_0_done_triger);
     
     -> SET_TMS_0_triger;
     //@(SET_TMS_0_done_triger);
     
     -> SHIFT_TDI_triger;
     @(SHIFT_TDI_done_triger)
     
     -> SET_TMS_1_triger;
     //exit -> update
     @(SET_TMS_1_done_triger);     
     cur_state = STATE_UPDATE;
     -> LS_DR_done_triger;
     LS_DR_ev = 0;
     end
end

event LS_IR_triger;//SIR
event LS_IR_done_triger;
reg LS_IR_ev = 0;

initial begin 
    forever begin
    @(LS_IR_triger);
    LS_IR_ev = 1;
    -> SET_SELECT_SCAN_triger;
    @(SET_SELECT_SCAN_done_triger);
    
    -> SET_TMS_1_triger;
    @(SET_TMS_1_done_triger);
    
    -> SET_TMS_1_triger;
    @(SET_TMS_1_done_triger);
    
    -> SET_TMS_0_triger;
    @(SET_TMS_0_done_triger);
    
    -> SET_TMS_0_triger;
    //@(SET_TMS_0_done_triger);
    
    -> SHIFT_TDI_triger;
    @(SHIFT_TDI_done_triger)
    
    -> SET_TMS_1_triger;
    //exit -> update
    @(SET_TMS_1_done_triger);     
    cur_state = STATE_UPDATE;
    -> LS_IR_done_triger;
    LS_IR_ev = 0;
    end
end

initial
begin
    
    #3
    
    SW[8]=1;
    SW[7:0]=12;
    #8
    SW[8]=0;
end
   
initial
    
    begin
        # 3
        TDI_SHIFT_SIZE = 4;
        TDI_SHIFT_REG  = 4'b0001;
        
        -> LS_IR_triger;
        @(LS_IR_done_triger);
        
        TDI_SHIFT_SIZE = 4;
        TDI_SHIFT_REG  = 4'b1111;
        
        -> LS_IR_triger;
        @(LS_IR_done_triger);

        /*TDI = 1;
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
        */
    end

initial begin
    TCK = 0;
    #10
    TCK = 0; 
    forever begin
         #10 TCK = !TCK;
    end
end

    
always 
    #20 CLK = !CLK;

//always 
  //  #5 SW[10] = !SW[10];
      
//always 
    //#10 TDI = !TDI;
    
endmodule
