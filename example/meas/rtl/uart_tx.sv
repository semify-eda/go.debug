//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2020 03:07:06 PM
// Design Name: 
// Module Name: spi_adc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module uart_tx (
  input wire       reset_ni, // I; Asynchronous reset (active low)
  input wire       clk_i,    // I; System clock  
  input wire       send_i,   // I; start to send a new data byte
  input wire [7:0] data_i,   // I; data to send
  output logic     ready_o,  // O; ready to take new data
  output logic     tx_o      // O; Serial UART data stream
);

  // -------------------------------------------------------------------------
  // Definition
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  assign ready_o = 1'b0;
  assign tx_o    = 1'b1;
  
 
endmodule
 
