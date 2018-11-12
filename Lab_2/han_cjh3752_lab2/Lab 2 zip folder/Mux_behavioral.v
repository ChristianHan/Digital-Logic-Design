`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2018 04:05:58 PM
// Design Name: 
// Module Name: Mux_behavioral
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


module Mux_behavioral(
    input s1,
    input s0,
    input i0,
    input i1,
    input i2,
    input i3,
    output reg d
    );
    
    always @(s1, s0, i0, i1, i2, i3)
    begin
    
    case ({s1, s0})
        2'b00 : d = i0;
        2'b01 : d = i1;
        2'b10 : d = i2;
        2'b11 : d = i3;
    endcase
       
    end
    
endmodule
