//  --------------------------------------------------------------------------
//                    Copyright Message
//  --------------------------------------------------------------------------
//
//  CONFIDENTIAL and PROPRIETARY
//  COPYRIGHT (c) Klaus Strohmayer 2020
//
//  All rights are reserved. Reproduction in whole or in part is
//  prohibited without the written consent of the copyright owner.
//
//
//  ----------------------------------------------------------------------------
//                    Description
//  ----------------------------------------------------------------------------
//
//  top module 
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-12-30  kstrohma   Initial release
//  (rev xxxxx)       

`default_nettype none
module top(
  input  wire               clk        , // I; Clock
  input  wire               reset_ni   , // I; Reset (active low)
  input  wire  [15:0]       sw           // I; SW
);
  
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
   
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

  initial begin
    if ($test$plusargs("trace") != 0) begin
      $display("[%0t] Tracing to logs/vlt_dump.vcd...\n", $time);
      $dumpfile("logs/vlt_dump.vcd");
      $dumpvars();
    end
    $display("[%0t] Model running...\n", $time);
  end
  
//  cover property (@(posedge clk) dith_out_o==2'b00);

  meas_top_system u_meas_top_system(  
    .clk        (clk),      // I; Clock
    .reset_ni   (reset_ni), // I; Reset (active low)
    .sw         (sw)        // I; SW
  );
	
endmodule
`default_nettype wire
