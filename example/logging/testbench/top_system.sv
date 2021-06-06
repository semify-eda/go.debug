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
//  File             top_system.sv
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
module top_system (
  input  wire               clk        , // I; Clock
  input  wire               reset_ni     // I; Reset (active low)
);

  import ea_package::*;

  logic        din;            // Shift input data
  logic [23:0] din_parallel;   // Parallel input data    
  logic        shift_clr;      // Shift register clear
  logic        shift_en;       // Shift enable
  logic        shift_ld;       // Shift load  
  logic        dout;           // Shift out
  logic [23:0] dout_parallel;   // Parallel output data 


  int eaIDShifted;
  int eaIDInversed;
  int eaIDReversed;
  int eaIDByteSwap;
  
  initial begin   
    eaReportInfo("INIT_TEST", EA_ANALYZER_NONE, "Testing eaInit() function before analyzer create", EA_VERBOSITY_LEVEL_NONE); 
    eaIDShifted = eaAnalyzerCreate("Bitshift testing", EA_TYPE_LOG, 24, EA_DATA_IS_UNSIGNED, $time);
    eaAnalyzerReport(eaIDShifted);
    eaReportInfo("A_NEW", eaIDShifted, "Created new analyzer for Bitshift testing", EA_VERBOSITY_LEVEL_NONE);
    eaIDInversed = eaAnalyzerCreate("Bits inversion testing", EA_TYPE_LOG, 24, EA_DATA_IS_UNSIGNED, $time);
    eaIDReversed = eaAnalyzerCreate("Reversed bits testing", EA_TYPE_LOG, 24, EA_DATA_IS_UNSIGNED, $time);
    eaIDByteSwap = eaAnalyzerCreate("Test byte swapping", EA_TYPE_LOG, 24, EA_DATA_IS_UNSIGNED, $time);
  end  
   
   
  ste_shift_reg #(
    .SHIFT_W(24)     // _INFO_ Parameter
  ) i_shift_reg (
    .clk             (clk         ), // I; System clock 
    .reset_ni        (reset_ni    ), // I; system cock reset (active low)  
    .din_i           (din         ), // I; Shift inptut data
    .din_parallel_i  (din_parallel), // I; Prallel input data    
    .shift_clr_i     (shift_clr   ), // I; Shift register clear
    .shift_en_i      (shift_en    ), // I; Shift enable
    .shift_ld_i      (shift_ld    ), // I; Shift load  
    .dout_o          (dout        ), // O; Shift out
    .dout_parallel_o  (dout_parallel)  // O; Prallel output data 
  );


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
  
  int clk_cnt;
  int my_clk_cnt;
  int start = 0;
  
  always @(negedge reset_ni or negedge clk) begin
    if (~reset_ni) begin
      clk_cnt <= 0;
    end else begin
      clk_cnt <= clk_cnt + 1; 
    end
  end
  
  
  // Test sequence
  always @(negedge clk) begin 
    my_clk_cnt = 0;
    if (clk_cnt == my_clk_cnt) begin 
      if(start == 0) begin
        eaReportInfo("S_START", 0, "Simulation started", EA_VERBOSITY_LEVEL_NONE);
        start = 1;
      end
      din          = 1'b0;
      din_parallel = 24'h000000;
      shift_clr    = 1'b0;
      shift_en     = 1'b0;
      shift_ld     = 1'b0;
    end
    my_clk_cnt = my_clk_cnt + 2; 
    
    // Check shift
    for (int word=0; word<=9; word=word+1) begin
      data_in_vec = data_in_array[word];
        for (int i=23; i>=0; i=i-1) begin 
          if (clk_cnt == my_clk_cnt) begin 
            shift_en = 1'b1;
            din      = data_in_vec[i];
        end
        my_clk_cnt = my_clk_cnt + 1;       
      end
      
      if (clk_cnt == my_clk_cnt) begin
        shift_en = 1'b0;
      end
      my_clk_cnt = my_clk_cnt + 5;
    end 
    
    if (clk_cnt == my_clk_cnt) begin 
      shift_en = 1'b0;
    end
    my_clk_cnt = my_clk_cnt + 1;

    // Check clear
    my_clk_cnt = my_clk_cnt + 2;
    if (clk_cnt == my_clk_cnt) begin 
      shift_clr = 1'b1;
    end
    
    my_clk_cnt = my_clk_cnt + 1;
    if (clk_cnt == my_clk_cnt) begin 
      shift_clr = 1'b0;
    end  

    // Check parallel load
    my_clk_cnt = my_clk_cnt + 2;
    if (clk_cnt == my_clk_cnt) begin 
      shift_ld     = 1'b1;
      din_parallel = 24'ha5aa5a;
    end
    
    my_clk_cnt = my_clk_cnt + 1; 
    if (clk_cnt == my_clk_cnt) begin 
      shift_ld     = 1'b0;
      din_parallel = 24'h000000;
    end
      
    my_clk_cnt = my_clk_cnt + 20; 
    if (clk_cnt == my_clk_cnt) begin 
      eaReportInfo("S_FIN", 0, "Simulation finished", EA_VERBOSITY_LEVEL_NONE);
      eaReportWarning("EX_WARN", 0, "Example warning message for demonstration purposes");
      eaReportDebug("EX_DEB", 0, "Example debug message for demonstration purposes");
      eaReportError("EX_ERR", 0, "Example error message for demonstration purposes");
      eaReportFatal("EX_FAT", EA_ANALYZER_NONE, "Example fatal message for demonstration purposes"); 
      
      /// Runs all the stages for all Analyzers at once.
      /// Calls :
      ///   eaAnalyzersChecksPerform() 
      ///   eaAnalyzersReport()
      ///   eaAnalyzersDumpTrace()
      eaAnalyzersFinal();
    
      $display("[%0t] Finish simulation \n", $time);
      $finish();
      $display("[%0t] ... \n", $time);
    end  
  end
  
  
endmodule
