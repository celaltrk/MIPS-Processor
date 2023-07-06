`timescale 1ns / 1ps
module pulse_controller(input logic clk, B, reset, output logic Q);
typedef enum logic[2:0]{S0, S1, S2} statetype;
    statetype state, nextstate;
    always_ff@(posedge clk, posedge reset)
        if (reset) state <= S0;
        else state <= nextstate;
    always_comb
        case(state)
            S0: if(B) nextstate = S1;
                else nextstate = S0;
            S1: if (B) nextstate = S1;
                else nextstate = S2;
            S2: nextstate = S0;
        endcase
    assign Q = state == S2;
endmodule
