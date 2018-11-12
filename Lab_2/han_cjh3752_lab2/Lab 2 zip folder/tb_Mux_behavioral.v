`timescale 1ns / 1ps

module tb_Mux_behavioral;

// Inputs to be defined as registers
reg s1;
reg s0;
reg i0;
reg i1;
reg i2;
reg i3;

// Outputs to be defined as wires
wire d;

// Instantiate the Unit Under Test (UUT)
Mux_behavioral uut (
    .s1(s1),
    .s0(s0),
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .d(d)
);

initial begin
// initialize inputs
s1 = 0;
s0 = 0;
i0 = 0;
i1 = 0;
i2 = 0;
i3 = 0;


// wait 50ns for global reset to finish 
#50;

s1 = 0;
s0 = 0;
i0 = 0;
i1 = 0;
i2 = 0;
i3 = 0;
#50;

s1 = 0;
s0 = 0;
i0 = 1;
i1 = 0;
i2 = 0;
i3 = 0;
#50;

s1 = 0;
s0 = 1;
i0 = 0;
i1 = 0;
i2 = 0;
i3 = 0;
#50;

s1 = 0;
s0 = 1;
i0 = 0;
i1 = 1;
i2 = 0;
i3 = 0;
#50;

s1 = 1;
s0 = 0;
i0 = 0;
i1 = 0;
i2 = 0;
i3 = 0;
#50;

s1 = 1;
s0 = 0;
i0 = 0;
i1 = 0;
i2 = 1;
i3 = 0;
#50;

s1 = 1;
s0 = 1;
i0 = 0;
i1 = 0;
i2 = 0;
i3 = 0;
#50;

s1 = 1;
s0 = 1;
i0 = 0;
i1 = 0;
i2 = 0;
i3 = 1;
#50;

end

endmodule
