`timescale 1ns / 1ps
// External instruction memory used by MIPS single-cycle
// processor. It models instruction memory as a stored-program 
// ROM, with address as input, and instruction as output
module imem ( input logic [5:0] addr, output logic [31:0] instr);

// imem is modeled as a lookup table, a stored-program byte-addressable ROM
	always_comb
	   case ({addr,2'b00})		   	// word-aligned fetch
//		address		instruction
//		-------		-----------
        	8'h00: instr = 32'h2014fff6;  	// disassemble, by hand 
        	8'h04: instr = 32'h20090007;  	// or with a program,
        	8'h08: instr = 32'h22820003;  	// to find out what
        	8'h0c: instr = 32'h01342025;  	// this program does!
        	8'h10: instr = 32'h00822824;
        	8'h14: instr = 32'h00a42820;
        	8'h18: instr = 32'h1045003d;
        	8'h1c: instr = 32'h0054202a;
        	8'h20: instr = 32'h10040001;
        	8'h24: instr = 32'h00002820;
        	8'h28: instr = 32'h0289202a;
        	8'h2c: instr = 32'h00853820;
        	8'h30: instr = 32'h00e23822;
        	8'h34: instr = 32'hac470057;
        	8'h38: instr = 32'h8c020050;
        	8'h3c: instr = 32'h08000011;
        	8'h40: instr = 32'h20020001;
        	8'h44: instr = 32'h2282005a;
        	// 8'h48: instr = 32'h08000012;  // j 48, so it will loop here
        	8'h48: instr = 32'h3C0880FF; // lui $t0, 0x80FF
        	8'h4c: instr = 32'h01000020; // add $zero, $t0, $zero
        	
        	8'h50: instr = 32'h20087FFF; // addi $t0, $zero, 0x7FFF
        	8'h54: instr = 32'h21080001; // addi $t0, $t0, 1
        	8'h58: instr = 32'h2009FFFF; // addi $t1, $zero, -1
        	8'h5c: instr = 32'h39298000; // xori $t1, $t1, 0x8000
        	8'h60: instr = 32'h21290001; // addi $t1, $t1, 1
        	8'h64: instr = 32'h01285020; // add $t2, $t1, $t0 # result should be 0

        	8'h68: instr = 32'h0800001A;  // j 68, so it will loop here
	     default:  instr = {32{1'bx}};	// unknown address
	   endcase
endmodule