`timescale 1ns / 1ps
// 32-bit 3-to-1 MUX
module mux3  (input  logic[31:0] d0, d1, d2,
              input  logic[1:0] s,
              output logic[31:0] y);
  
  always_comb begin
    case (s)
      2'b00: y = d0;
      2'b01: y = d1;
      2'b10: y = d2;
      default: y = 32'hxxxxxxxx;
    endcase
  end
endmodule
