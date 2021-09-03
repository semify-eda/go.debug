//  --------------------------------------------------------------------------
//                    Copyright Message
//  --------------------------------------------------------------------------
//
//  CONFIDENTIAL and PROPRIETARY
//  COPYRIGHT (c) XXXX 2019
//
//  All rights are reserved. Reproduction in whole or in part is
//  prohibited without the written consent of the copyright owner.
//
//
//  ----------------------------------------------------------------------------
//                    Design Information
//  ----------------------------------------------------------------------------
//
//  File             $URL: http://.../ste.sv $
//  Author
//  Date             $LastChangedDate: 2019-02-15 08:18:28 +0100 (Fri, 15 Feb 2019) $
//  Last changed by  $LastChangedBy: kstrohma $
//  Version          $Revision: 2472 $
//
// Description       Generic shift register
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       

`default_nettype none
module ste_shift_reg #(
  parameter integer SHIFT_W      = 16     // _INFO_ Parameter
) (
  input   wire                clk             , // I; System clock 
  input   wire                reset_ni        , // I; system cock reset (active low)  
  input   wire                din_i           , // I; Shift input data
  input   wire  [SHIFT_W-1:0] din_parallel_i  , // I; Parallel input data    
  input   wire                shift_clr_i     , // I; Shift register clear
  input   wire                shift_en_i      , // I; Shift enable
  input   wire                shift_ld_i      , // I; Shift load  
  output  logic               dout_o          , // O; Shift out
  output  logic [SHIFT_W-1:0] dout_parallel_o    // O; Parallel output data 
);
  
  
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  
  // delayed input value  
  logic [SHIFT_W-1:0]   shift_ff;


  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------


  // Shift register
  always_ff @(posedge clk or negedge reset_ni) begin
    if (~reset_ni) begin
      // _INFO_ Repelication operator 
      shift_ff <= { (SHIFT_W) {1'b0}};      
      // _INFO_ SystemVerilog style 
      // shift_ff  <= '0;
    end else begin 
      // _INFO_ Priority must be clear 
      if          (shift_clr_i) begin
        shift_ff <= { (SHIFT_W) {1'b0}};       
      end else if (shift_en_i) begin 
        shift_ff <= {shift_ff[SHIFT_W-2:0], din_i};
      end else if (shift_ld_i) begin  
        shift_ff <= din_parallel_i;
      end        
    end  
  end
  
  `ifdef EA_ERROR_BITSHIFT
  assign dout_parallel_o = shift_ff<<2;
  `else
  assign dout_parallel_o = shift_ff;
  `endif
  assign dout_o         = shift_ff[SHIFT_W-1];
  
endmodule
`default_nettype wire  
