//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Klaus Strohmayer 
// 
// Create Date:   
// Design Name: 
// Module Name:    seg7_ctrl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 4 digit 7 segement display controller
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module seg7_ctrl(
  input rst_ni,
  input clk,
  input [15:0] x,
  input clr,
  output reg [6:0] a_to_g,
  output reg [3:0] an,
  output wire dp 
);
	 
	 
  wire  [1:0] s;	 
  reg   [3:0] digit;
  wire  [3:0] aen;
  reg  [19:0] clkdiv;
  
  assign dp  = 1;
  assign s   = clkdiv[19:18];
  assign aen = 4'b1111; // all turned off initially

  // quad 4to1 MUX.
  always @(posedge clk or negedge rst_ni) begin
    if (~rst_ni) begin	
      digit <= x[3:0];
    end else begin  
      case(s)
        0:       digit <= x[3:0];   // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
        1:       digit <= x[7:4];   // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
        2:       digit <= x[11:8];  // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
        3:       digit <= x[15:12]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]	
        default: digit <= x[3:0];
      endcase
    end
  end    
	
  //decoder or truth-table for 7a_to_g display values
  //         a
  //        __			
  //     f/    /b
  //        g
  //        __	
  // 	   e/    /c
  //        __
  //         d  
  always @(*) begin
    case(digit)
      //////////<---MSB-LSB<---
      ////////////////gfedcba////////////////////////////////////////////     
      0:a_to_g   = 7'b1000000;////0000									
      1:a_to_g   = 7'b1111001;////0001										
      2:a_to_g   = 7'b0100100;////0010							                                               
      3:a_to_g   = 7'b0110000;////0011									
      4:a_to_g   = 7'b0011001;////0100									
      5:a_to_g   = 7'b0010010;////0101                                        
      6:a_to_g   = 7'b0000010;////0110
      7:a_to_g   = 7'b1111000;////0111                                          
      8:a_to_g   = 7'b0000000;////1000
      9:a_to_g   = 7'b0010000;////1001
      'hA:a_to_g = 7'b0111111; // dash-(g)
      'hB:a_to_g = 7'b1111111; // all turned off
      'hC:a_to_g = 7'b1110111;        
      default: a_to_g = 7'b0000000; // U      
    endcase
  end
  
  always @(*)begin
    an=4'b1111;
    if (aen[s] == 1)
      an[s] = 0;
  end

  // clkdiv
  always @(posedge clk or negedge rst_ni) begin
    if (~rst_ni) begin
      clkdiv <= 0;
    end else begin
      if (clr) begin
        clkdiv <= 0;
      end else begin
        clkdiv <= clkdiv+1;
      end
    end    
  end


endmodule
