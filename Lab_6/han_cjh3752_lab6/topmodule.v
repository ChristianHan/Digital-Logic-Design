`timescale 1ns / 1ps


module topmodule( 
input clk,
input reset,
input start,
input [15:0] sw,

output [3:0] an,
output dp,
output reg [6:0] sseg
);

wire [6:0] sseg1, sseg2, sseg3, sseg4; //wires to temporarily store each sseg value from each module
wire [3:0] an1, an2, an3, an4;//wires "                                " an value from each module
wire dp1, dp2, dp3, dp4;//      wires "                                " dp value from each module 
reg [19:0] COUNT;//to hold 1,000,000
wire max;// flag used to measure 10ms
wire [6:0] in0, in1, in2, in3;//wire used to store encoded inputs from hexto7seg
reg outedge;// flag for button

reg [1:0] state;
reg [1:0] next_state;

always @ (*) begin// this always block is a mux and its control signal is the switches to select between the modes 
                  //  with each input being the sseg output from each module
    case (sw[15:14]) //Decoder
        2'b00: sseg = sseg1;
        2'b01: sseg = sseg2;  
        2'b10: sseg = sseg3; 
        2'b11: sseg = sseg4;
    endcase
end

always @ (*) begin// this always block is used to debounce the start button. it creates an outedge signal when the button is pressed 
                  // the outedge is used as a flag to start the count register in the clock divider

case (state)

    2'b00: begin
        outedge = 1'b0;
        if (~start)
            next_state = 2'b00;
        else if (start)
            next_state = 2'b01;
        else if (reset)
            next_state = 2'b00;
        end
    
    2'b01: begin
        outedge = 1'b1;
        if (start)
            next_state = 2'b01;
        else if (~start)
            next_state = 2'b10;
        else if (reset)
            next_state = 2'b00;                
        end
    
    2'b10: begin //insert code
        outedge = 1'b1;
        if (~start)
            next_state = 2'b10;
        else if (start)
            next_state = 2'b11;
        else if (reset)
                next_state = 2'b00;            
        end       
 
   2'b11: begin   
        outedge = 1'b0; 
        if (~start)
            next_state = 2'b00;
        else if (start)
            next_state = 2'b11; 
        else if (reset)
                next_state = 2'b00;                
        end
  
  default: begin
            next_state = 2'b00;
            outedge = 1'b0;
           end

endcase
end

always @ (posedge clk or posedge reset) begin // this always block drives the button debouncing FSM continuously at every posedge clk
    if (reset)
        state <= 2'b00;
    else
        state <= next_state;
end        

always @ (posedge clk or posedge reset) // this always block is running to start the COUNT up whenever start is pressed
    begin
        if (reset)// resets the counter to 0
            COUNT <= 0;
        else if (COUNT == 1000000)//10 milisecond counter
            COUNT <= 0;
        else if (outedge)// outedge == 1 means button is pressed
            COUNT <= COUNT + 1;               
    end
    
assign max = (COUNT == 1000000)? 1'b1 : 1'b0;//sets max to 1 every 10 milisecond
    
    reg [3:0] d0, d1, d2, d3;//data registers used for each digit in stop watch
    reg flag;// flag used to stop the stopwatch/timer
    always @ (posedge clk or posedge reset) // this always block triggers whenever start is pressed. 
                                            //It updates each digit register whenever the max flag is set whenever COUNT reaches 1,000,000 (signaling 10ms has passed)      
        begin
        if (reset)
            begin
                flag <= 0;
                d0 <= 0;
                d1 <= 0;
                d2 <= 0;
                d3 <= 0;
            end 
        else if (flag)
            begin
                d0 <= 9;
                d1 <= 9;
                d2 <= 9;
                d3 <= 9;
            end       
        else if (max)//increment every 10 milisecond
            if (~flag)
                      
            begin
              if (d0 == 9)
              begin
                d0 <= 0;
                if (d1 == 9)
                begin    
                  d1 <= 0;
                  if(d2 == 9)        
                  begin
                    d2 <= 0;
                    if(d3 == 9)
                     begin
                      flag <= 1;  
                     end
                    else
                      d3 <= d3 + 1;
                  end
                  else
                    d2 <= d2 + 1;    
                end
                else
                  d1 <= d1 + 1;
              end
              else
                d0 <= d0 + 1; 
            end
        end
    hexto7seg c0 (.x(d0), .r(in0));//instantiate each of the digit registers to send as an input to the 7-segment display
    hexto7seg c1 (.x(d1), .r(in1));
    hexto7seg c2 (.x(d2), .r(in2));
    hexto7seg c3 (.x(d3), .r(in3));
    
    reg [19:0] COUNT2;
    reg [3:0] an_t;
    reg dp_t;
    
    always @ (posedge clk or posedge reset) begin
        if (reset)
        COUNT2 <= 0;
        else 
        COUNT2 <= COUNT2 + 1;
        end
    
    always @ (*) begin
        case (COUNT2[19:18]) //Multiplexer for the an and dp signals to update every 10ms to think all the lights are on simultaneously.
            2'b00: begin
                    //sseg = in0;
                    an_t = 4'b1110;
                    dp_t = 1'b1;
                   end 
            2'b01: begin
                    //sseg = in1;
                    an_t = 4'b1101;
                    dp_t = 1'b1;
                   end 
            2'b10: begin
                    //sseg = in2;
                    an_t = 4'b1011;
                    dp_t = 1'b0;
                   end
            2'b11: begin        
                    //sseg = in3;
                    an_t = 4'b0111;
                    dp_t = 1'b1;
                   end          
    endcase
    
    end
    assign an = an_t;
    assign dp = dp_t;    
    

stopwatch a1 ( // instantiate each module
.clk(clk),
.reset(reset),
.start(start),
.sw(sw),
.an(an1),
.dp(dp1),
.sseg(sseg1)
);

my_stopwatch a2 (
.clk(clk),
.reset(reset),
.start(start),
.sw(sw),
.an(an2),
.dp(dp2),
.sseg(sseg2)
);

timer a3 (
.clk(clk),
.reset(reset),
.start(start),
.sw(sw),
.an(an3),
.dp(dp3),
.sseg(sseg3)
);

my_timer a4 (
.clk(clk),
.reset(reset),
.start(start),
.sw(sw),
.an(an4),
.dp(dp4),
.sseg(sseg4)
);


endmodule
