`timescale 1ns / 1ps

module clkdiv(
    input clk,
    input reset,
    output clk_out
);

reg [20:0] COUNT;

assign clk_out = COUNT[20];

always @ (posedge clk or posedge reset)
    begin
        if (reset)
            COUNT <= 0;
        else if (start)
            COUNT <= COUNT + 1;
    end
endmodule
