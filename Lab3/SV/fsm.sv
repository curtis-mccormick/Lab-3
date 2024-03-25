module FSM (
    input logic clk,
    input logic reset,
    input logic LI,
    input logic RI,
    output logic [5:0] y
);

typedef enum logic [3:0] {
    S0, S1, S2, S3, S4, S5, S6, S7, S8, S9
} statetype;

statetype state, nextstate;

//state register
always_ff @(posedge clk or posedge reset) begin
    if (reset) 
        state <= S0;
    else       
        state <= nextstate;
end
   
//next state logic and output logic
always_comb 
    case (state)
        S0: begin
          y <= 6'b000000;
            if (LI && !RI) 
                nextstate = S1;
            else if (RI && !LI)
                nextstate = S4;
            else if (LI && RI)
                nextstate = S7;
            else   
                nextstate = S0;
        end
        // Left Signal 
        S1: begin
            y = 6'b001000;
            nextstate = S2;
        end
        S2: begin
            y = 6'b011000;
            nextstate = S3;
        end 
        S3: begin
            y = 6'b111000;
            nextstate = S0;
        end
        // Right Signal
        S4: begin
            y = 6'b000100;
            nextstate = S5;
        end
        S5: begin
            y = 6'b000110;
            nextstate = S6;
        end 
        S6: begin
            y = 6'b000111;
            nextstate = S0;
        end
        // Hazards
        S7: begin
            y = 6'b001100;
            nextstate = S8;
        end
        S8: begin
            y = 6'b011110;
            nextstate = S9;
        end 
        S9: begin
            y = 6'b111111;
            nextstate = S0;
        end
        default: begin
            nextstate = S0; //Defualt State
        end
    endcase


endmodule