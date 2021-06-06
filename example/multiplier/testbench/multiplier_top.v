//TEST BENCH
module multipliertb; 
    
    reg [3:0] A;
    reg [3:0] B; 
    wire [7:0] P; 
    
    array4x4multipler uut (.A(A), .B(B), .P(P));
    
    initial begin
        // Initialize Inputs
        A = 4'b1000;
        B = 4'b0100;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b0100;
        B = 4'b0110;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b1100;
        B = 4'b1001;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b0100;
        B = 4'b0111;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b0100;
        B = 4'b0101;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b1100;
        B = 4'b1111;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b1101;
        B = 4'b1111;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b0111;
        B = 4'b0111;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b1110;
        B = 4'b0111;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b1101;
        B = 4'b0111;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b0101;
        B = 4'b0111;
        
        // Wait 100 ns for global reset to finish
        #100;
        A = 4'b1111;
        B = 4'b0111;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        
        
        
        endmodule
