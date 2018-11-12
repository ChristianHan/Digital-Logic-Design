`timescale 1ns / 1ps

module flight_attendant_call_system(
    input wire clk,
    input wire call_button,
    input wire cancel_button,
    output reg light_state
    );
    
    reg next_state;
    
//Combinational Block

always @(*) begin

case ({call_button, cancel_button, light_state})
    3'b000: next_state = 1'b0;
    3'b001: next_state = 1'b1;
    3'b010: next_state = 1'b0;
    3'b011: next_state = 1'b0;
    3'b100: next_state = 1'b1;
    3'b101: next_state = 1'b1;
    3'b110: next_state = 1'b1;
    3'b111: next_state = 1'b1;
    default: begin
    light_state = 1'b0;
    next_state = 1'b0;
    end
    endcase
end

//Sequential block
always @(posedge clk) begin
    light_state <= next_state;
end
    
endmodule
