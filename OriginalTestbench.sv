module OriginalTestbench();

  // Inputs
  logic clk;
  logic reset;
  
  // Outputs
  logic [31:0] writedata;
  logic [31:0] dataadr;
  logic [31:0] pc;
  logic [31:0] instr;
  logic [31:0] readdata;
  logic memwrite;

  top dut(clk, reset, writedata, dataadr, pc, instr, readdata, memwrite);
  
  // Clock signal
  always begin
    clk = 1; #2;
    clk = 0; #2;
  end
  
  // Reset
  initial begin
    reset = 1; #4
    reset = 0;  
  end
endmodule

