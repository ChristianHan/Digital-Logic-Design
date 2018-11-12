`timescale 1ns / 1ps

module full_adder(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );

assign Cout = (B && Cin) || (A && Cin) || (A && B); 
assign S = A ^ B ^ Cin;
      
endmodule
