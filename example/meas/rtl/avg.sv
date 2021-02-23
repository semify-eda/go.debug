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
// Description       Averaging via IIR (1st order)
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       

`default_nettype none
module avg #(
  parameter integer DATA_W      = 16     // _INFO_ Parameter
) (
  input   wire                clk             , // I; System clock 
  input   wire                reset_ni        , // I; system cock reset (active low)  
  input   wire  [DATA_W-1:0]  din_i           , // I; Input data    
  input   wire                din_update_i    , // I; Input data update 
  input   wire                avg_clr_i       , // I; Clear average data 
  output  logic [DATA_W-1:0]  dout_o          , // O; Averaged data 
  output  logic               dout_update_o     // O; Input data update 
);
  
    
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  localparam logic [DATA_W-1:0] zero = {(DATA_W) {1'b0}};      
  
  // delayed output value  
  logic [DATA_W-1:0]  yn1_ff;

  logic [DATA_W-1:0]  avg_ff;
  logic               avg_update_ff;  

  logic [DATA_W-1:0] sum1 , sum2;
  logic [DATA_W  :0] sum;
  logic [DATA_W-1:0] sum_sat; // Saturated value
  
  
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

  // Shift register
  always_ff @(posedge clk or negedge reset_ni) begin
    if (~reset_ni) begin
      yn1_ff <= {(DATA_W) {1'b0} };      
    end else begin 
      if          (avg_clr_i) begin
        yn1_ff <= {(DATA_W) {1'b0} };       
      end else if (din_update_i) begin 
        // _INFO_ This works because unsigend values are used 
        yn1_ff <= sum_sat;
      end        
    end  
  end
  
  // Adder
  // a   = 0.125
  // 1-a = 0.875;
  // _INFO_ There is no multiplier used!
  assign sum1 = (din_i >> 3);
  assign sum2 = (yn1_ff >> 3) + (yn1_ff >> 2) + (yn1_ff >> 1);
  assign sum  = sum1 + sum2;
  // Saturation
  `ifdef EA_ERROR_SAT
    // Saturation occurs at wrong limit
    assign sum_sat = (sum[DATA_W-1]) ? {(DATA_W) {1'b1} } : sum[DATA_W-1:0];
  `else 
    // Correct saturation limit
    assign sum_sat = (sum[DATA_W]) ? {(DATA_W) {1'b1} } : sum[DATA_W-1:0];
  `endif
  
  // Output register plus divide by 4
  always_ff @(posedge clk or negedge reset_ni) begin
    if (~reset_ni) begin
      avg_ff        <= {(DATA_W) {1'b0}};  
      avg_update_ff <= 1'b0;    
    end else begin
      if (avg_clr_i) begin
        avg_ff        <= {(DATA_W) {1'b0}};
        avg_update_ff <= 1'b0;
      end else if (din_update_i) begin       
        avg_ff        <= sum_sat;
        avg_update_ff <= 1'b1;
      end else begin
        avg_update_ff <= 1'b0;
      end      
    end  
  end  
  
  assign dout_o         = avg_ff;
  assign dout_update_o  = avg_update_ff;
  
endmodule
`default_nettype wire  
