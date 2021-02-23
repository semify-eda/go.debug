//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2014 11:45:54 PM
// Design Name: 
// Module Name: bin_to_bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Convert a 16bit binary number into 4 digital BCD code
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module bin_to_bcd(
  input      [15:0] dbin_i,  // I; binary number
  output reg [19:0] dbcd_o   // O; BCD coded number (4 digits)
);



	
  reg [35:0] z;
  integer i;

  always @(*) begin
    for(i = 0; i <= 35; i = i+1) begin
	  z[i] = 0;
	end  
	z[18:3] = dbin_i; // shift b 3 places left

    repeat (13) begin
      if (z[19:16] > 4)	
        z[19:16] = z[19:16] + 3;
      if (z[23:20] > 4) 	
        z[23:20] = z[23:20] + 3;
      if (z[27:24] > 4) 	
        z[27:24] = z[27:24] + 3;
      if (z[31:28] > 4) 	
        z[31:28] = z[31:28] + 3;
      if (z[35:32] > 4) 	
        z[35:32] = z[35:32] + 3;
      z[35:1] = z[34:0];
	end      
    dbcd_o = z[35:16];  //20 bits
  end         
  
endmodule