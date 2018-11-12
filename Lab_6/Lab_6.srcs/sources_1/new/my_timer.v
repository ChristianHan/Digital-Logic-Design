`timescale 1ns / 1ps

//The stopwatch/timer should use the four 7-segment displays on the Basys 3 board to displaytime. 
//The two MSB digits should display seconds. 
//The two LSB digits should be used to display time with the resolution of 10 milliseconds:
// in other words, these digits should go through the sequence 0...99 in one second.


//-2 buttons-
//o First button should start or stop the stopwatch/timer when pressed
//o Second button should reset the values (resetting in modes 3 and 4 means loading the externally loadedvalues) when pressed
//-10 switches-
//o 2  switches  are  required for  mode  selection -00,  01,  10,  11  for  the  four modes the design supports
//o 8 switches are required for preset modes to specify the preset value for two digits corresponding to seconds
//-clock and seven segment displays


//Mode 1 (Counting Upfrom 00.00)-In this mode, 
//the design acts as a normal stopwatch. 
//1) It is initialized to 00.00, 
//2) It starts counting up after the Start/Stop button is pressed, and counts to 99.99, 
//   where it stops if no action is taken, 
//3) It stops counting when the Start/Stop is pressed again,
//4) It resumes counting if the Start/Stop is pressed again, 
//5) It resets to 00.00 if the Reset button is pressed.

module my_timer( 
input clk,
input reset,
input start,
input [7:0] sw,

output [3:0] an,
output dp,
output reg [6:0] sseg
);

reg [19:0] COUNT;//to hold 1,000,000
wire max;// flag used to measure 10ms
wire [6:0] in0, in1, in2, in3;
reg outedge;// flag for button

reg [1:0] state;
reg [1:0] next_state;

always @ (*) begin

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

always @ (posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00;
    else
        state <= next_state;
end        

always @ (posedge clk or posedge reset)
    begin
        if (reset)
            COUNT <= 0;
        else if (COUNT == 1000000)//10 milisecond counter
            COUNT <= 0;
        else if (outedge)// outedge == 1
            COUNT <= COUNT + 1;               
    end
    
    

assign max = (COUNT == 1000000)? 1'b1 : 1'b0;//sets max to 1 every 10 milisecond

reg [3:0] d0, d1, d2, d3;//data registers used for each digit in stop watch
reg flag;
    
always @ (posedge clk or posedge reset)
    begin
    if (reset)
        begin
            flag <= 0;
            d0 <= 0;
            d1 <= 0;
            if (sw[3:0] >= 9) //need to stop values greater than 9
                d2 <= 9;
            else 
                d2 <= sw[3:0];    
            if (sw[7:4] >= 9)// condition off d3 or sw[7:4]
                d3<= 9;
            else 
                d3 <= sw[7:4]; 
        end
    else if (flag)
        begin
            d0 <= 0;
            d1 <= 0;
            d2 <= 0;
            d3 <= 0; 
        end            
    else if (max)//increment every 10 milisecond
      if (~flag)
        begin
          if (d0 == 0)
          begin
            d0 <= 9;
            if (d1 == 0)
            begin    
              d1 <= 9;
              if(d2 == 0)        
              begin
                d2 <= 9;
                if(d3 == 0)
                  begin
                    flag <= 1;
                  end   
                else
                  d3 <= d3 - 1;
              end
              else
                d2 <= d2 - 1;    
            end
            else
              d1 <= d1 - 1;
          end
          else
            d0 <= d0 - 1; 
        end
    end

hexto7seg c0 (.x(d0), .r(in0));
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
    case (COUNT2[19:18]) //Multiplexer 
        2'b00: begin
                sseg = in0;
                an_t = 4'b1110;
                dp_t = 1'b1;
               end 
        2'b01: begin
                sseg = in1;
                an_t = 4'b1101;
                dp_t = 1'b1;
               end 
        2'b10: begin
                sseg = in2;
                an_t = 4'b1011;
                dp_t = 1'b0;
               end
        2'b11: begin        
                sseg = in3;
                an_t = 4'b0111;
                dp_t = 1'b1;
               end          
endcase

end


assign an = an_t;

assign dp = dp_t;

endmodule


//Mode 2 (Counting Up from an Externally Loaded Value)-
//In this mode, the design behaves the same way as in Mode 1 except that it allows loading
//an initialvalue on to the stopwatch and counting up from that value. 
//Only  the  two  most  significant  bits  corresponding  to  "seconds"need  to  be loaded. 
// Eight  switches  on  the  Basys  board  should be  used  to define 
// the initial value(four switches for the tens digit corresponding to "seconds" and
// four switches for the ones digit corresponding to "seconds" 
//-also, both the digits can take values only from 0 to 9, i.e., 0000 to 1001
// and the case when these switches are set to values greater than 1001 can be ignored).

//Mode 3 (Counting Down from 99.99)-
//In this mode, the design acts as a timer counting from "99.99" to "00.00".
//1) It is initialized to 99.99, 
//2) Itstarts counting down after the Start/Stop button is pressed, 
//   and counts to 00.00, where it stopsif no action is taken, 
//3) It stops counting down when the Start/Stop is pressed again, 
//4) It resumes counting if the Start/Stop is pressed again, 
//5) It resets to 99.99 if the Reset button is pressed.

//Mode  4  (Counting  Down  from an  Externally  Loaded Value)-
//In this  mode,  the  design  behaves  the  same  way  as  in  Mode  3 
// except  that  it allows loading an initial value on to the timer
// and counting down from that value. Only the two most significant bits
// corresponding to "seconds" need to be loaded. Eight switches on the Basys board 
//should be used to define the initial value(four switches for the tens digit corresponding 
//to "seconds" and four switches for the ones digit corresponding to "seconds" 
//-also, both the digits can take values only from 0 to 9, i.e., 0000 to 1001 
//and the case when these switches are set to values greater than 1001 can be ignored).
