`timescale 1ns / 1ps

module RCA_4bits(
    input clk,
    input enable,
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [4:0] Q //load registers, should contain the 4sum bits and Cout (concatenated)
    );

wire Cout0, Cout1, Cout2;
wire [4:0] Sum;

full_adder c1 (.A(A[0]), .B(B[0]), .Cin(Cin), .S(Sum[0]), .Cout(Cout0));
full_adder c2 (.A(A[1]), .B(B[1]), .Cin(Cout0), .S(Sum[1]), .Cout(Cout1));
full_adder c3 (.A(A[2]), .B(B[2]), .Cin(Cout1), .S(Sum[2]), .Cout(Cout2));
full_adder c4 (.A(A[3]), .B(B[3]), .Cin(Cout2), .S(Sum[3]), .Cout(Sum[4])); 
 
register_logic c5 (.clk(clk), .enable(enable), .Data(Sum), .Q(Q));

endmodule
