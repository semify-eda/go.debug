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

`default_nettype none
`timescale 1ns / 1ns

// Testbench  
module top_system (
  input  wire logic              clk        , // I; Clock
  input  wire logic              reset_ni     // I; Reset (active low)
);

  logic        din;            // Shift input data
  logic [23:0] din_parallel;   // Parallel input data    
  logic        shift_clr;      // Shift register clear
  logic        shift_en;       // Shift enable
  logic        shift_ld;       // Shift load  
  logic        dout;           // Shift out
  logic [23:0] dout_parallel;   // Parallel output data 
  bit  [9:0][23:0] data_in_array  = {
    24'h000001,
    24'h000000,
    24'haaaaaa,
    24'h555555,
    24'hffffff,
    24'h000000,
    24'h234567,
    24'hdfeabc,
    24'h111111,
    24'h000000
  };
  bit [23:0] data_in_vec;
  bit trigger;

  ste_shift_reg #(
    .SHIFT_W(24)     // _INFO_ Parameter
  ) i_shift_reg (
    .clk             (clk         ), // I; System clock 
    .reset_ni        (reset_ni    ), // I; system cock reset (active low)  
    .din_i           (din         ), // I; Shift input data
    .din_parallel_i  (din_parallel), // I; Parallel input data    
    .shift_clr_i     (shift_clr   ), // I; Shift register clear
    .shift_en_i      (shift_en    ), // I; Shift enable
    .shift_ld_i      (shift_ld    ), // I; Shift load  
    .dout_o          (dout        ), // O; Shift out
    .dout_parallel_o (dout_parallel) // O; Parallel output data 
  );

  // Test sequence
  always @(negedge clk) begin 
    din          = 1'b0;
    din_parallel = 24'h000000;
    shift_clr    = 1'b0;
    shift_en     = 1'b0;
    shift_ld     = 1'b0;

    // Check shift register
    for (int word=0; word<=9; word=word+1) begin
      // Fill expected data
      data_in_vec = data_in_array[word];

      // Load shift register
      for (int i=23; i>=0; i=i-1) begin
        #2
        shift_en = 1'b1;
        din      = data_in_vec[i];
      end
      #2
      shift_en = 1'b0;
      
      // Scoreboard
      if (dout_parallel != data_in_vec) begin
        $error("Error: expected and read data mismatch");
      end
      trigger = ~trigger;
    end

    shift_en = 1'b0;
    shift_clr = 1'b1;
    shift_clr = 1'b0;
    shift_ld     = 1'b1;
    din_parallel = 24'ha5aa5a;
    shift_ld     = 1'b0;
    din_parallel = 24'h000000;
    $display("[%0t] Finish simulation \n", $time);
    $finish();
    $display("[%0t] ... \n", $time);
  end

endmodule
