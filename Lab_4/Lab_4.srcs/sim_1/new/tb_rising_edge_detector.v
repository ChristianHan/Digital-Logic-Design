`timescale 1ns / 1ps

module tb_rising_edge_detector;

reg clk;
reg signal;
reg reset;

wire outedge;
//wire cur1;
//wire cur0;
//wire clk_display;


rising_edge_detector uut (
.clk(clk),
.signal(signal),
.reset(reset),
.outedge(outedge)
//.cur1(cur1),
//.cur0(cur0),
//.clk_display(clk_display)
);

initial
begin

clk = 0;

signal = 0;
reset = 1;

#80

signal = 0;
reset = 1;

#80

signal = 1;
reset = 1;

#80

signal = 1;
reset = 0;

#80

signal = 1;
reset = 0;

#80

signal = 0;
reset = 0;

#80

signal = 0;
reset = 0;

#80
signal = 1;
reset = 0;

#80
signal = 1;
reset = 0;

#80

signal = 0;
reset = 0;

#80

signal = 0;
reset = 0;

#80

signal = 1;
reset = 0;

#80

signal = 1;
reset = 0;

#80

signal = 1;
reset = 0;


//signal = 0;
//reset = 1;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 0;
//reset = 0;

//#80

//signal = 0;
//reset = 0;

//#80

//signal = 1;
//reset = 1;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 1;
//reset = 1;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 0;
//reset = 0;

//#80

//signal = 0;
//reset = 0;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 0;
//reset = 1;

//#80

//signal = 1;
//reset = 0;

//#80

//signal = 1;
//reset = 0;

end

always
#5 clk = ~clk;

endmodule
