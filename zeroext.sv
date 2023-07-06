`timescale 1ns / 1ps
module zeroext(input  logic[15:0] a, output logic[31:0] y);
  assign y = {16'b0000000000000000, a};    // zero-extends 16-bit a
endmodule
