`timescale 1ns / 1ps
module datapath (input  logic clk, reset, memtoreg, pcsrc, alusrc, regdst,
                 input  logic regwrite, jump, 
		 input  logic[2:0]  alucontrol, 
		 input logic[1:0] ZeroExt,
		 output logic[31:0] mux4_out,
                 output logic zero, 
		 output logic[31:0] pc, 
	         input  logic[31:0] instr,
                 output logic[31:0] writedata, 
	         input  logic[31:0] readdata);

  logic [4:0]  writereg;
  logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  logic [31:0] signimm, signimmsh, srca, srcb, result;
  // New logic
  logic [31:0] zeroimm, srca_xor_zeroimm, zeroimm_sl16, aluout;
 
  // next PC logic
  flopr #(32) pcreg(clk, reset, pcnext, pc);
  adder       pcadd1(pc, 32'b100, pcplus4);
  sl2         immsh(signimm, signimmsh);
  adder       pcadd2(pcplus4, signimmsh, pcbranch);
  mux2 #(32)  pcbrmux(pcplus4, pcbranch, pcsrc,
                      pcnextbr);
  mux2 #(32)  pcmux(pcnextbr, {pcplus4[31:28], 
                    instr[25:0], 2'b00}, jump, pcnext);

// register file logic
   regfile     rf (clk, regwrite, instr[25:21], instr[20:16], writereg,
                   result, srca, writedata);

   mux2 #(5)    wrmux (instr[20:16], instr[15:11], regdst, writereg);
   mux2 #(32)  resmux (mux4_out, readdata, memtoreg, result);
   signext         se (instr[15:0], signimm);
  

  // ALU logic
   mux2 #(32)  srcbmux (writedata, signimm, alusrc, srcb);
   alu         alu (srca, srcb, alucontrol, aluout, zero);
   
   // New logic to add xori and lui
   zeroext ze(instr[15:0], zeroimm);
   xor32 xor_32(zeroimm, srca, srca_xor_zeroimm);
   sl16 sl16_32(zeroimm, zeroimm_sl16);
   mux3 mux3_32(aluout, zeroimm_sl16, srca_xor_zeroimm, ZeroExt, mux4_out);
endmodule
