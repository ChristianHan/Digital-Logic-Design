`timescale 1ns / 1ps


module tb_RCA_4bits;

reg clk;
reg enable;
reg [3:0] A;
reg [3:0] B;
reg Cin;
wire [4:0] Q; 

RCA_4bits uut (
.clk(clk),
.enable(enable),
.A(A),
.B(B),
.Cin(Cin),
.Q(Q)
);

initial
begin

clk = 0;
enable = 0;

#50
enable = 1;
A = 4'b0001;
B = 4'b0101;
Cin = 1'b0;

#50
enable = 1;
A = 4'b0111;
B = 4'b0111;
Cin = 1'b0;

#50
enable = 1;
A = 4'b1000;
B = 4'b0111;
Cin = 1'b1;

#50
enable = 1;
A = 4'b1100;
B = 4'b0100;
Cin = 1'b0;

#50
enable = 1;
A = 4'b1000;
B = 4'b1000;
Cin = 1'b1;

#50
enable = 1;
A = 4'b1001;
B = 4'b1010;
Cin = 1'b1;

#50
enable = 1;
A = 4'b1111;
B = 4'b1111;
Cin = 1'b0;

end
 
always
#5 clk = ~clk;

endmodule
