`timescale 1ns / 1ps

module flight_attendant_call_system_dataflow(
    input wire clk,
    input wire call_button,
    input wire cancel_button,
    output reg light_state
    );
    
wire next_state;    


initial begin
light_state = 1'b0; //initialize light_state
end
    
//Combinational block

assign next_state = call_button || (light_state && !cancel_button);

//Sequential block
always @ (posedge clk) begin
    light_state <= next_state;
end        
    
    
endmodule
