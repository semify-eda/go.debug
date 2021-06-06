// Project F: Test Bench for Integer Division
// (C)2021 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

`default_nettype none
`timescale 1ns / 1ps

module top();
  parameter WIDTH = 4;

  logic clk;
  logic start;            // start signal
  logic busy;             // calculation in progress
  logic valid;            // quotient and remainder are valid
  logic dbz;              // divide by zero flag
  logic [WIDTH-1:0] x;    // dividend
  logic [WIDTH-1:0] y;    // divisor
  logic [WIDTH-1:0] q;    // quotient
  logic [WIDTH-1:0] r;    // remainder

  div_int #(.WIDTH(WIDTH)) div_int_inst (.*);

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

