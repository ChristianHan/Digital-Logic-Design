`timescale 1ns / 1ps

module tb_flight_attendant_call_system;

reg clk;
reg call_button;
reg cancel_button;

wire light_state;

flight_attendant_call_system u1 (
    .clk(clk),
    .call_button(call_button),
    .cancel_button(cancel_button),
    .light_state(light_state)
   );
   
initial
begin

clk = 0;
call_button = 0;
cancel_button = 0;

#10;

call_button = 1;
cancel_button = 0;

#10;

call_button = 0;
cancel_button = 1;

#10;

call_button = 1;
cancel_button = 1;

#10;

call_button = 0;
cancel_button = 0;

#10;

call_button = 1;
cancel_button = 0;

#10;

cancel_button = 1;

#20;

cancel_button = 0;

#20;

call_button = 0;
cancel_button = 1;

#20;

call_button = 0;
cancel_button = 0;

end

always
#5 clk = ~clk;

endmodule
