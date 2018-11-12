`timescale 1ns / 1ps

module rising_edge_detector(
    input clk,
    input signal,
    input reset,
    output reg outedge
   // output cur0,
   // output cur1,
   // output clk_display
    );
    
wire slow_clk;

reg [1:0] state;
reg [1:0] next_state;

clkdiv cl(.clk(clk), .reset(reset), .clk_out(slow_clk));


//Combinational logic

always @ (*) begin

case (state)

    2'b00: begin
        outedge = 1'b0;
        if (~signal)
            next_state = 2'b00;
        else
            next_state = 2'b01;
        end
    
    2'b01: begin
        outedge = 1'b1;
        next_state = 2'b10;
//        if (~signal)
//            next_state = 2'b10;
//        else
//            next_state = 2'b01; 
        end
    
    2'b10: begin //insert code
            outedge = 1'b0;
            if (~signal)
                next_state = 2'b00;
            else
                next_state = 2'b10;
           end         
   
    default: begin
        next_state = 2'b00;
        outedge = 1'b0;
        end
endcase

end

//Sequential Logic

always @ (posedge slow_clk) begin
    if (reset)
        state <= 2'b00;
    else
        state <= next_state;
end        
              
//assign cur0 = state[0];
//assign cur1 = state[1]; 
//assign clk_display = slow_clk;
       
endmodule
