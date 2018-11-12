`timescale 1ns / 1ps

module tb_topmodule;

reg clk;
reg reset;
reg start;
reg [15:0] sw;

wire [3:0] an;
wire dp;
wire [6:0] sseg;

reg outedge;

topmodule uut (
.clk(clk),
.reset(reset),
.start(start),
.sw(sw),
.an(an),
.dp(dp),
.sseg(sseg)
);

initial
begin

clk = 0;
reset = 1;
start = 0;

#50

reset = 0;
sw = 16'b0000000000000000;
start = 1;

#50
start = 0;

#50
sw = 16'b0100000000000001;
reset = 1;

#50
reset = 0;
start = 1;

#50
start = 0;
reset = 1;

#50
reset = 0;
sw = 16'b1000000000000000;
start = 1;






end




always
#5 clk = ~clk;


endmodule
