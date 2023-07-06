`timescale 1ns / 1ps
module sl16 (input  logic[31:0] a, output logic[31:0] y);
     assign y = {a[15:0], 16'b0000000000000000}; // shifts left by 16
endmodule