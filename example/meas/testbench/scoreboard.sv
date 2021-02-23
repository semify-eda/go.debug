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
// Description       Simple scoreboard
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
module scoreboard #(
  parameter int ANALYZER_TYPE = 0
) ();

  import ea_package::*;
  
  // IDs for Analyzer
  int eaID0;
  int eaID1;


  typedef struct packed {
    bit [11:0] data0;
    bit [11:0] data1;
  } spi_data_t;
  spi_data_t spi_data;

  spi_data_t exp_data_queue  [$];
  spi_data_t read_data_queue [$];

    
  // Init scoreboard  
  function void init(string description);
    string str;
    $display("[%t][%m] Init Scoreboard ", $time);
    if (exp_data_queue.size() > 0) begin 
      exp_data_queue.delete();
    end 
    if (read_data_queue.size() > 0) begin 
      read_data_queue.delete();
    end 
    
    // Create an Error Analyzer
    $sformat(str, "%s Channel 0", description);
    eaID0 = eaAnalyzerCreate(str, ANALYZER_TYPE, 12, 0, $time);
    eaAnalyzerReport(eaID0);
    $sformat(str, "%s Channel 1", description);
    eaID1 = eaAnalyzerCreate(str, ANALYZER_TYPE, 12, 0, $time);
    eaAnalyzerReport(eaID1);
  endfunction


  // Put new expected data --> compare if read data is available  
  function void exp_data_put(bit [11:0] data0, bit [11:0] data1);
    spi_data_t exp_data;
    spi_data_t read_data;
    
    exp_data = '{data0: data0, data1: data1};
    //$display("[%t] exp_data_put: Data0: expected 0x%h unequal read 0x%h!", $time, exp_data.data0, read_data.data0);
    if (read_data_queue.size() > 0) begin
      // Read data available --> compare 
      read_data = read_data_queue.pop_front();
      //$display("  --> Compare");
      compare(read_data, exp_data);
    end else begin
      // No read data available --> store
      exp_data_queue.push_back(exp_data);
    end
  endfunction
  
  // Put new read data --> compare if expected data is available
  function void read_data_put(bit [11:0] data0, bit [11:0] data1);
    spi_data_t exp_data;
    spi_data_t read_data;
    
    read_data = '{data0: data0, data1: data1};
    //$display("[%t] read_data_put: Data0: expected 0x%h unequal read 0x%h!", $time, read_data.data0, read_data.data0);
    if (exp_data_queue.size() > 0) begin
      // Expected data available --> compare 
      exp_data = exp_data_queue.pop_front();
      //$display("  --> Compare");
      compare(read_data, exp_data);
    end else begin
      // No expected data available --> store
      read_data_queue.push_back(read_data);
    end
    
  endfunction
  
  // Compare two samples
  int cnt = 0;
  function void compare(spi_data_t read_data, spi_data_t exp_data);
    eaAnalyzerAddSample(eaID0, int'(read_data.data0), int'(exp_data.data0), $time); 
    eaAnalyzerAddSample(eaID1, int'(read_data.data1), int'(exp_data.data1), $time); 
    // verilator lint_save
    // verilator lint_off BLKSEQ    
    cnt++;
    // verilator lint_restore
    //if ((cnt % 10) == 0) begin
    //  eaAnalyzerSamplesReport(eaID0);        
    //end
      
    if (exp_data.data0 == read_data.data0) begin
      $display("[%t][%m] Ok Data0 0x%h", $time, read_data.data0);
    end else begin 
      $display("[%t][%m] Error Data0: expected 0x%h unequal read 0x%h!", $time, exp_data.data0, read_data.data0);
    end

    if (exp_data.data1 == read_data.data1) begin
      $display("[%t][%m] Ok Data1 0x%h\n", $time, read_data.data1);
    end else begin 
      $display("[%t][%m] Error Data1: expected 0x%h unequal read 0x%h!", $time, exp_data.data1, read_data.data1);
    end    
  endfunction
  
  
  final begin
    // Report analyzer findings at the end
    eaAnalyzerReport(eaID0);  
    //eaAnalyzerSamplesReport(eaID0);
    eaAnalyzerChecksPerform(eaID0);

    eaAnalyzerReport(eaID1);  
    //eaAnalyzerSamplesReport(eaID1);
    eaAnalyzerChecksPerform(eaID1);
    
    // Report summary for all analyzer --> Executed only once all analyzers are checked 
    eaAnalyzersDumpTrace();
    eaAnalyzersReport();    
  end
  
endmodule




