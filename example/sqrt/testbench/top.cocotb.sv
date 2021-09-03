// Project F: Test Bench for Integer Square Root
// (C)2021 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

`default_nettype none
`timescale 1ns / 1ps

module top();

  parameter WIDTH = 8;

  logic clk;
  logic start;             // start signal
  logic busy;              // calculation in progress
  logic valid;             // root and rem are valid
  logic [WIDTH-1:0] rad;   // radicand
  logic [WIDTH-1:0] root;  // root
  logic [WIDTH-1:0] rem;   // remainder

  sqrt #(.WIDTH(WIDTH)) sqrt_inst (.*);
  
  `ifdef COCOTB_SIM
  if(`WAVES == 1) begin
    initial begin
      $dumpfile ("top.vcd");
      $dumpvars;
      #1;
    end
  end
  `endif

endmodule
