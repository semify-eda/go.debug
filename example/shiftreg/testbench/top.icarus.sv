`default_nettype none
`timescale 1ns / 1ns

module top ();
  logic clk; // I; Clock
  logic reset_ni;    // I; Reset (active low)
  int id1;

  parameter CLK_PERIOD = 2; 

  always #(CLK_PERIOD / 2) clk = ~clk;

  initial begin
    if ($test$plusargs("trace") != 0) begin
      $display("[%0t] Tracing to logs/vlt_dump.vcd...\n", $time);
      $dumpfile("logs/vlt_dump.vcd");
      $dumpvars();
    end
    `ifndef GUI
    id1 = $eaVPIAnalyzerCreateCb("Analyzer 1", 0, 24, 0, int'($time), "top.i_u_top_system.trigger", "top.i_u_top_system.data_in_vec", "top.i_u_top_system.dout_parallel");
    `endif
    $display("[%0t] Model running...\n", $time);
    clk = 0;
  end

  top_system i_u_top_system (
    .clk             (clk         ), // I; System clock 
    .reset_ni        (reset_ni    )  // I; system cock reset (active low)  
  );

endmodule
