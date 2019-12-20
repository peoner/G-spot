`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 02:15:08 PM
// Design Name: 
// Module Name: tap_controller
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


module tap_controller(
    input wire TMS,//state control port 
    input wire TCK,//clock
    //input wire TRST,//reset
    input wire TDI,//data input
    output wire TDO,//data output
    
    //input wire External_clk,
    input wire [9:0]External_input,    //SW
    output wire [7:0]External_output,  //LED
    
    output wire [9:0]Internal_input,   //clk, in_p, in_p_ac
    input wire [7:0]Internal_output     //out_res
    );
    
    `define IR_LENGTH                       4
    `define BSR_LENGHT                      18
    
    `define In_input_LENGHT                 10
    `define In_output_LENGHT                8
    
    `define Ex_input_LENGHT                 10
    `define Ex_output_LENGHT                8
        
    
    localparam STATE_TEST_LOGIC_RESET = 	4'd1;
    localparam STATE_TEST_RUN         =     4'd2;
    localparam STATE_SELECT_DR_SCAN   =     4'd3;
    localparam STATE_SELECT_IR_SCAN   =     4'd4;
    localparam STATE_DR_CAPTURE       =     4'd5;
    localparam STATE_DR_SHIFT         =     4'd6;
    localparam STATE_DR_EXIT1         =     4'd7;
    localparam STATE_DR_PAUSE         =     4'd8;
    localparam STATE_DR_EXIT2         =     4'd9;
    localparam STATE_DR_UPDATE        =     4'd10;
    localparam STATE_IR_CAPTURE       =     4'd11;
    localparam STATE_IR_SHIFT         =     4'd12;
    localparam STATE_IR_EXIT1         =     4'd13;
    localparam STATE_IR_PAUSE         =     4'd14;
    localparam STATE_IR_EXIT2         =     4'd15;
    localparam STATE_IR_UPDATE        =     4'd0;
    
    localparam EXTEST         = 4'b0000;
    localparam SAMPLE_PRELOAD = 4'b0010;
    localparam IDCODE         = 4'b0001;
    localparam INTEST         = 4'b0100;
    localparam BYPASS         = 4'b1111;

    reg [3:0] present_state = STATE_TEST_LOGIC_RESET;
    reg [3:0] next_state = STATE_TEST_LOGIC_RESET;
    
always @ (*)
begin 
    if(TMS)
        case (present_state)	
        STATE_TEST_LOGIC_RESET: next_state = STATE_TEST_LOGIC_RESET;
        STATE_TEST_RUN:         next_state = STATE_SELECT_DR_SCAN;
        STATE_SELECT_DR_SCAN:   next_state = STATE_SELECT_IR_SCAN;
        STATE_SELECT_IR_SCAN:   next_state = STATE_TEST_LOGIC_RESET;
        STATE_DR_CAPTURE:       next_state = STATE_DR_EXIT1;
        STATE_DR_SHIFT:         next_state = STATE_DR_EXIT1;
        STATE_DR_EXIT1:         next_state = STATE_DR_UPDATE;
        STATE_DR_PAUSE:         next_state = STATE_DR_EXIT2;
        STATE_DR_EXIT2:         next_state = STATE_DR_UPDATE;
        STATE_DR_UPDATE:        next_state = STATE_SELECT_DR_SCAN;
        STATE_IR_CAPTURE:       next_state = STATE_IR_EXIT1;
        STATE_IR_SHIFT:         next_state = STATE_IR_EXIT1;
        STATE_IR_EXIT1:         next_state = STATE_IR_UPDATE;
        STATE_IR_PAUSE:         next_state = STATE_IR_EXIT2;
        STATE_IR_EXIT2:         next_state = STATE_IR_UPDATE;
        STATE_IR_UPDATE:        next_state = STATE_SELECT_DR_SCAN;
        endcase
    else
        case (present_state)	
            STATE_TEST_LOGIC_RESET: next_state = STATE_TEST_RUN;
            STATE_TEST_RUN:         next_state = STATE_TEST_RUN;
            STATE_SELECT_DR_SCAN:   next_state = STATE_DR_CAPTURE;
            STATE_SELECT_IR_SCAN:   next_state = STATE_IR_CAPTURE;
            STATE_DR_CAPTURE:       next_state = STATE_DR_SHIFT;
            STATE_DR_SHIFT:         next_state = STATE_DR_SHIFT;
            STATE_DR_EXIT1:         next_state = STATE_DR_PAUSE;
            STATE_DR_PAUSE:         next_state = STATE_DR_PAUSE;
            STATE_DR_EXIT2:         next_state = STATE_DR_SHIFT;
            STATE_DR_UPDATE:        next_state = STATE_TEST_RUN;
            STATE_IR_CAPTURE:       next_state = STATE_IR_SHIFT;
            STATE_IR_SHIFT:         next_state = STATE_IR_SHIFT;
            STATE_IR_EXIT1:         next_state = STATE_IR_PAUSE;
            STATE_IR_PAUSE:         next_state = STATE_IR_PAUSE;
            STATE_IR_EXIT2:         next_state = STATE_IR_SHIFT;
            STATE_IR_UPDATE:        next_state = STATE_TEST_RUN;
            endcase	 
end

//state register
always @ (posedge TCK)
   present_state <= next_state;
 
 

/************************
*   curent active sate wire
*************************/
    reg test_logic_reset;
    reg test_run;
    reg select_dr_scan;
    reg select_ir_scan;
    reg dr_capture;
    reg dr_shift;
    reg dr_shift_neg;
    reg dr_exit1;
    reg dr_pause;
    reg dr_exit2;
    reg dr_update;
    reg ir_capture;
    reg ir_shift;
    reg ir_shift_neg;
    reg ir_exit1;
    reg ir_pause;
    reg ir_exit2;
    reg ir_update;
    
    reg dr_shift_ready = 0;
//sate reg/wire

always @ (*)
begin
    test_logic_reset = 1'b0;
    test_run = 1'b0;
    select_dr_scan = 1'b0;
    select_ir_scan = 1'b0;
    dr_capture = 1'b0;
    dr_shift = 1'b0;
    dr_exit1 = 1'b0;
    dr_pause = 1'b0;
    dr_exit2 = 1'b0;
    dr_update = 1'b0;
    ir_capture = 1'b0;
    ir_shift = 1'b0;
    ir_exit1 = 1'b0;
    ir_pause = 1'b0;
    ir_exit2 = 1'b0;
    ir_update = 1'b0;
   case (present_state)	
        STATE_TEST_LOGIC_RESET: test_logic_reset = 1'b1;
        STATE_TEST_RUN:         test_run = 1'b1;
        STATE_SELECT_DR_SCAN:   select_dr_scan = 1'b1;
        STATE_SELECT_IR_SCAN:   select_ir_scan = 1'b1;
        STATE_DR_CAPTURE:       dr_capture = 1'b1;
        STATE_DR_SHIFT:         dr_shift = 1'b1;
        STATE_DR_EXIT1:         dr_exit1 = 1'b1;
        STATE_DR_PAUSE:         dr_pause = 1'b1;
        STATE_DR_EXIT2:         dr_exit2 = 1'b1;
        STATE_DR_UPDATE:        dr_update = 1'b1;
        STATE_IR_CAPTURE:       ir_capture = 1'b1;
        STATE_IR_SHIFT:         ir_shift = 1'b1;
        STATE_IR_EXIT1:         ir_exit1 = 1'b1;
        STATE_IR_PAUSE:         ir_pause = 1'b1;
        STATE_IR_EXIT2:         ir_exit2 = 1'b1;
        STATE_IR_UPDATE:        ir_update = 1'b1;
    endcase
end

always @(negedge TCK)
    if(dr_shift)
        dr_shift_ready = 1;
    else
        dr_shift_ready = 0;

/************************
*   curent active instruction
*************************/
    reg     bypass_select = 0;
    reg     sample_preload_select = 0;
    reg     extest_select = 0;
    reg     intest_select = 0;
    reg     idcode_select = 0;

//curent instruction 
    
always @ (*)
begin
    bypass_select = 1'b0;
    sample_preload_select = 1'b0;
    extest_select = 1'b0;
    intest_select = 1'b0;
    idcode_select = 1'b0;
      case(latched_jtag_ir)    // synthesis parallel_case
        IDCODE:            idcode_select = 1'b1;       // Reading ID code
        SAMPLE_PRELOAD:    sample_preload_select = 1'b1;   // Sampling/Preloading
        EXTEST:            extest_select = 1'b1;   // External test
        INTEST :           intest_select = 1'b1;      // INTEST test
        BYPASS:            bypass_select = 1'b1;     // BYPASS instruction
        default:           bypass_select = 1'b1;     // BYPASS instruction
      endcase
end   
   
    /**********************************************************************************
   *                                                                                 *
   *   idcode                                                                        *
   *                                                                                 *
   **********************************************************************************/
   reg [31:0] idcode_reg;
   wire        idcode_tdo;
   localparam IDCODE_VALUE         = 32'hCFFE75;
    
   always @ (posedge TCK)
   begin
     if (test_logic_reset)
       idcode_reg[31:0] <= IDCODE_VALUE;   // IDCODE selected after reset
     else if(idcode_select & dr_capture)
       idcode_reg[31:0] <=  IDCODE_VALUE;
     else if(idcode_select & dr_shift_ready)
       idcode_reg[31:0] <=  {TDI, idcode_reg[31:1]};
   end
   
   assign idcode_tdo = idcode_reg[0];
   
  /**********************************************************************************
  *                                                                                 *
  *   bypass                                                                        *
  *                                                                                 *
  **********************************************************************************/
  reg  bypass_reg;
  wire bypassed_tdo;
   
  always @ (posedge TCK)
  begin
        if(bypass_select & dr_shift_ready)
            bypass_reg <=  TDI;
  end

assign bypassed_tdo = bypass_reg;


  /**********************************************************************************
  *                                                                                 *
  *   SAMPLE                                                                        *
  *                                                                                 *
  **********************************************************************************/
  
  
/**********************************************************************************
*                                                                                 *
*   BSR reg                                                                       *
*                                                                                 *
**********************************************************************************/
  
 reg [`BSR_LENGHT-1:0] BSR;
 reg [`BSR_LENGHT-1:0] BSR_sample;
 reg [`BSR_LENGHT-1:0] BSR_latched;
 
 wire bs_chain_tdo_i = BSR[0];
 wire bsr_select = intest_select | extest_select | sample_preload_select;
 
always @ (*)
 begin
    if(dr_capture)
        begin
            case(latched_jtag_ir)    // synthesis parallel_case
                SAMPLE_PRELOAD:     BSR[`BSR_LENGHT-1:0] = {External_input, Internal_output};   // Sampling/Preloading
                EXTEST:             BSR[`BSR_LENGHT-1:0] = {External_input, External_output};   // External test
                INTEST:             BSR[`BSR_LENGHT-1:0] = {Internal_input, Internal_output};      // INTEST test
            endcase
        end
    /*else if(dr_update)
        begin
            case(latched_jtag_ir)    // synthesis parallel_case
                SAMPLE_PRELOAD:    tdo_mux_out = bs_chain_tdo_i;   // Sampling/Preloading
                EXTEST:             BSR[`BSR_LENGHT-1:0] = ;   // External test
                INTEST:             BSR[`BSR_LENGHT-1:0] = ;      // INTEST test
            endcase            
        end*/
    else if(bsr_select & dr_shift_ready)
          BSR[`BSR_LENGHT-1:0] <=  {TDI, idcode_reg[31:1]};     
 end
 
 wire BSR_active = (extest_select | intest_select) ;
 
 
assign Internal_input = (!BSR_active) ? 
    (External_input[`Ex_input_LENGHT-1:0]) 
        : 
        (BSR[`BSR_LENGHT-1:`BSR_LENGHT-`In_input_LENGHT]);

assign External_output = (!BSR_active) ? 
            (Internal_output[`In_output_LENGHT-1:0]) 
                : 
                (BSR[`BSR_LENGHT-`In_input_LENGHT-1:0]);
     
   
   /**********************************************************************************
   *                                                                                 *
   *   jtag_ir Instruction Register                                           *
   *                                                                                 *
   **********************************************************************************/
   reg [`IR_LENGTH-1:0]  jtag_ir;          // Instruction register
   reg [`IR_LENGTH-1:0]  latched_jtag_ir;  //saved register
   wire                  instruction_tdo;
   reg ir_shift_ready = 0;
         
    always @ (posedge TCK)
    begin
      if (test_logic_reset == 1)
        jtag_ir[`IR_LENGTH-1:0] <= `IR_LENGTH'b0;
      else if(ir_capture)
        jtag_ir <= latched_jtag_ir;          // This value is fixed for easier fault detection
      else if(ir_shift_ready)
        jtag_ir[`IR_LENGTH-1:0] <= {TDI, jtag_ir[`IR_LENGTH-1:1]};
    end
    
    always @(negedge TCK)
    begin
        if(ir_shift)
            ir_shift_ready <= 1;
        else
            ir_shift_ready <= 0;
    end
    
   assign instruction_tdo = jtag_ir[0];  // This is latched on a negative TCK edge after the output MUX
   
   always @(negedge TCK )
      begin
        if(ir_update)
          latched_jtag_ir <= jtag_ir;
        else if (test_logic_reset == 1)
          latched_jtag_ir[`IR_LENGTH-1:0] <= IDCODE;
      end

   /**********************************************************************************
   *                                                                                 *
   *   Multiplexing TDO data                                                         *
   *                                                                                 *
   **********************************************************************************/
   reg tdo_mux_out;  // just a wire
   reg tdo_out;

   always @ (*)
   begin
     if(ir_shift)
       tdo_mux_out = instruction_tdo;
     else if(dr_shift)
       begin
         case(latched_jtag_ir)    // synthesis parallel_case
           IDCODE:            tdo_mux_out = idcode_tdo;       // Reading ID code
           SAMPLE_PRELOAD:    tdo_mux_out = bs_chain_tdo_i;   // Sampling/Preloading
           EXTEST:            tdo_mux_out = bs_chain_tdo_i;   // External test
           INTEST :           tdo_mux_out = bs_chain_tdo_i;      // INTEST test
           BYPASS:            tdo_mux_out = bypassed_tdo;     // BYPASS instruction
           default:            tdo_mux_out = bypassed_tdo;     // BYPASS instruction
         endcase
       end
   end
    
    
   // TDO changes state at negative edge of TCK
   always @ (negedge TCK)
   begin
       tdo_out = tdo_mux_out;            
   end
   
    always @(negedge TCK )
    begin
       if(ir_shift)
           ir_shift_neg <= 1;
       else
           ir_shift_neg <= 0;
    end
    
    always @(negedge TCK )
    begin
       if(dr_shift)
           dr_shift_neg <= 1;
       else
           dr_shift_neg <= 0;
    end
   
   assign TDO = (dr_shift_neg | ir_shift_neg) ? tdo_out : 1'bz ;        
   
endmodule
