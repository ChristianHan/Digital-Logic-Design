`timescale 1ns / 1ps


module tb_time_multiplexing_main;

reg clk;
reg reset;
reg [15:0] sw;
wire [3:0] an;
wire [6:0] sseg;

time_multiplexing_main uut (
.clk(clk),
.reset(reset),
.sw(sw),
.an(an),
.sseg(sseg)
);

initial
begin

clk = 0;
reset = 1;

#50

reset = 0;
sw = 16'b0000000000000000;

#350

sw = 16'b1000100010001000;

#350

sw = 16'b0100001100100001;

#350

sw = 16'b0001001000110100;

end

always
#5 clk = ~clk;


endmodule
