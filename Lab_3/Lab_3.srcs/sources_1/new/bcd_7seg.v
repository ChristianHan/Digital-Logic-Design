`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2018 12:48:31 PM
// Design Name: 
// Module Name: bcd_7seg
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


module bcd_7seg(
    input A,
    input B,
    input C,
    input D,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output AN0,
    output AN1,
    output AN2,
    output AN3,
    output dp
    );
        
     assign   AN0 = 1'b0;
     assign   AN1 = 1'b1;
     assign   AN2 = 1'b1;
     assign   AN3 = 1'b1;
     assign   dp = 1'b1;
        
       //Defining wires for not signals
       wire A_not, B_not, C_not, D_not;
       
       //defining wires into or gate
       wire A0, A1, A2, A3;// 4 and gates for a
       wire B0, B1, B2, B3;// 4 and gates for b
       wire C0, C1, C2;// 3 and gates for c
       wire D0, D1, D2, D3, D4;//5 and gates for d
       wire E0, E1;//2 and gates for e
       wire F0, F1, F2, F3;//4 and gates for f
       wire G0, G1, G2, G3;//4 and gates for g
            
       //Instantiating Not gates as per the schematic
       not n0 (A_not, A);
       not n1 (B_not, B);
       not n2 (C_not, C);
       not n3 (D_not, D);
       
       //Instantiating And gates as per the schematic
       
       //for a
       and a0 (A0, A, C);
       and a1 (A1, A, B);
       and a2 (A2, B, C_not, D_not);
       and a3 (A3, A_not, B_not, C_not, D);
       
       or a4 (a, A0, A1, A2, A3);
       
       //for b
       and b0 (B0, A, C);
       and b1 (B1, A, B);
       and b2 (B2, B, C_not, D);
       and b3 (B3, B, C, D_not);
       
       or b4 (b, B0, B1, B2, B3);
       
       //for c
       and c0 (C0, A, C);
       and c1 (C1, A, B);
       and c2 (C2, B_not, C, D_not);
       
       or c3 (c, C0, C1, C2);
       
       //for d
       and d0 (D0, A, C);
       and d1 (D1, A, B);
       and d2 (D2, B, C_not, D_not);
       and d3 (D3, B, C, D);
       and d4 (D4, A_not, B_not, C_not, D);
       
       or d5 (d, D0, D1, D2, D3, D4);
       
       //for e
       and e0 (E0, A, C);
       and e1 (E1, B, C_not);
       
       or e2 (e, D, E0, E1);
       
       //for f
       and f0 (F0, A, B);
       and f1 (F1, C, D);
       and f2 (F2, B_not, C);
       and f3 (F3, A_not, B_not, D);
       
       or f4 (f, F0, F1, F2, F3);
       
       //for g
       and g0 (G0, A, C);
       and g1 (G1, A, B);
       and g2 (G2, B, C, D);
       and g3 (G3, A_not, B_not, C_not);
       
       or g4 (g, G0, G1, G2, G3);
        
endmodule
