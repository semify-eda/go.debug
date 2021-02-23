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
// Description       Generic shift register testbench
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       

// Testbench  
module top ();

  initial begin
    if ($test$plusargs("trace") != 0) begin
      $display("[%0t] Tracing to logs/vlt_dump.trc...\n", $time);
      $dumpfile("logs/vlt_dump.trc");
      $dumpvars();
    end
    $display("[%0t] Model running...\n", $time);
  end

  bit        clk;      // Clock
  bit        reset_ni; // Reset (active low)
  bit [15:0] sw;
  
  always begin 
    #100ns;
    clk <= 1'b0;
    #100ns;
    clk <= 1'b1;
  end
  
  initial begin 
    sw       = 16'h0000;
    reset_ni = 1'b0;
    @(negedge clk);
    @(negedge clk);
    reset_ni = 1'b1;
    @(negedge clk);
    @(negedge clk);
    sw       = 16'h0001;
    #30ms;
    $finish();
    
  end


  meas_top_system u_meas_top_system(
    .clk             (clk         ), // I; System clock 
    .reset_ni        (reset_ni    ), // I; system cock reset (active low)  
    .sw              (sw)
  );

endmodule
