`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2018 11:38:34 AM
// Design Name: 
// Module Name: tb_bcd_7seg
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


module tb_bcd_7seg;

//inputs defined as registers
reg A;
reg B;
reg C;
reg D;

//outputs defined as wires

wire a;
wire b;
wire c;
wire d;
wire e;
wire f;
wire g;
wire AN0;
wire AN1;
wire AN2;
wire AN3;
wire dp;

//instantiate the unit under test UUT
bcd_7seg uut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g),
    .AN0(AN0),
    .AN1(AN1),
    .AN2(AN2),
    .AN3(AN3),
    .dp(dp)
 );
 
 initial begin
 //initialize inputs
 
 A = 0; //should display 0 on 7 seg
 B = 0;
 C = 0;
 D = 0;
 
 #50
 
 A = 0;
 B = 0;
 C = 0;
 D = 1;
 
 #50
 
 A = 0;
 B = 0;
 C = 1;
 D = 0;
  
 #50
 
 A = 0;
 B = 0;
 C = 1;
 D = 1;
 
 #50
 
 A = 0;
 B = 1;
 C = 0;
 D = 0;
 
 #50
 
 A = 0;
 B = 1;
 C = 0;
 D = 1;
 
  #50
 
 A = 0;
 B = 1;
 C = 1;
 D = 0;
 
  #50
 
 A = 0;
 B = 1;
 C = 1;
 D = 1;
 
  #50
 
 A = 1;
 B = 0;
 C = 0;
 D = 0;
 
  #50
 
 A = 1;
 B = 0;
 C = 0;
 D = 1;
 
  #50
 
 A = 1; //10
 B = 0;
 C = 1;
 D = 0;
 
  #50
 
 A = 1; //11
 B = 0;
 C = 1;
 D = 1;
 
  #50
 
 A = 1; //12
 B = 1;
 C = 0;
 D = 0;
 
  #50
 
 A = 1; //13
 B = 1;
 C = 0;
 D = 1;
 
  #50
 
 A = 1;//14
 B = 1;
 C = 1; 
 D = 0;
 
  #50
 
 A = 1;//15
 B = 1;
 C = 1;
 D = 1;
 
 end
 
 endmodule

