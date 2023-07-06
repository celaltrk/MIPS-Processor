`timescale 1ns / 1ps
module maindec (input logic[5:0] op, 
	              output logic memtoreg, memwrite, branch,
	              output logic alusrc, regdst, regwrite, jump,
	              output logic[1:0] aluop, output logic[1:0] ZeroExt);
   logic [10:0] controls;

   assign {regwrite, regdst, alusrc, branch, memwrite,
                memtoreg,  aluop, jump, ZeroExt} = controls;

  always_comb
    case(op)
      6'b000000: controls <= 11'b11000010000; // R-type
      6'b100011: controls <= 11'b10100100000; // LW
      6'b101011: controls <= 11'b00101000000; // SW
      6'b000100: controls <= 11'b00010001000; // BEQ
      6'b001000: controls <= 11'b10100000000; // ADDI
      6'b000010: controls <= 11'b00000000100; // J
      6'b001111: controls <= 11'b10000000001; // lui
      6'b001110: controls <= 11'b10000000010; // xori
      default:   controls <= 11'bxxxxxxxxxxx; // illegal op
    endcase
endmodule
