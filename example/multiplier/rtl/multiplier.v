
module array4x4multipler(input [3:0]A,
                         input [3:0]B,
                         output [7:0]P);
    wire [15:1]w;
    wire [16:0]g;
    and(P[0],A[0],B[0]);
    and(w[1],A[0],B[1]);
    and(w[2],A[0],B[2]);
    and(w[3],A[0],B[3]);
    and(w[4],A[1],B[0]);
    and(w[5],A[1],B[1]);
    and(w[6],A[1],B[2]);
    and(w[7],A[1],B[3]);
    and(w[8],A[2],B[0]);
    and(w[9],A[2],B[1]);
    and(w[10],A[2],B[2]);
    and(w[11],A[2],B[3]);
    and(w[12],A[3],B[0]);
    and(w[13],A[3],B[1]);
    and(w[14],A[3],B[2]);
    and(w[15],A[3],B[3]);
    /*Had h1(.a(),.b(),.c(),.s());
     fadd f1(.A(),.B(),.Cin(),.Sum(),.Carry()); */
    Had h1(.a(w[1]),.b(w[4]),.c(g[0]),.s(P[1]));
    fadd f1(.A(w[5]),.B(w[8]),.Cin(g[0]),.Sum(g[1]),.Carry(g[2]));
    fadd f2(.A(g[1]),.B(g[2]),.Cin(w[2]),.Sum(P[2]),.Carry(g[3]));
    fadd f3(.A(w[9]),.B(w[12]),.Cin(g[3]),.Sum(g[4]),.Carry(g[5]));
    fadd f4(.A(w[6]),.B(g[5]),.Cin(g[4]),.Sum(g[6]),.Carry(g[7]));
    fadd f5(.A(w[3]),.B(g[6]),.Cin(g[7]),.Sum(P[3]),.Carry(g[8]));
    fadd f6(.A(w[13]),.B(w[10]),.Cin(g[8]),.Sum(g[9]),.Carry(g[10]));
    fadd f7(.A(g[10]),.B(g[9]),.Cin(w[7]),.Sum(P[4]),.Carry(g[11]));
    fadd f8(.A(g[11]),.B(w[14]),.Cin(w[11]),.Sum(P[5]),.Carry(g[12]));
    fadd f9(.A(w[15]),.B(1'b0),.Cin(g[12]),.Sum(P[6]),.Carry(P[7]));
endmodule

module fadd(
  input A,
  input B,
  input Cin,
  output Sum,
  output Carry
  );
  wire W1,W2,W3;
  Had H1 (.a(A),.b(B),.c(W2),.s(W1));
  Had H2 (.a(W1),.b(Cin),.s(Sum),.c(W3));
  or o1(Carry,W2,W3);
endmodule

module Had(
   input a,b,
   output c,s);
   wire T1,T2;
   and(c,a,b);
   assign T1 = ~c;
   or(T2,a,b);
   and(s,T1,T2);
endmodule
            
