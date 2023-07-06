`timescale 1ns / 1ps

module debounced_top(input logic next_button, reset_button, basys_clk, clr, 
                     output logic memwrite, output logic[6:0] seg, output logic dp, output logic[3:0] an);
	     logic[31:0] writedata, dataadr;
         logic[31:0] pc, instr, readdata; 
	     logic debounced_clk, debounced_reset;
	     
	     pulse_controller pul1(basys_clk, next_button, clr, debounced_clk);
	     pulse_controller pul2(basys_clk, reset_button, clr, debounced_reset);
	     top tp(debounced_clk, debounced_reset, writedata, dataadr, pc, instr, readdata, memwrite);
	    
	     display_controller(basys_clk, pc[7:4], pc[3:0], dataadr[7:4], dataadr[3:0], seg, dp, an);
endmodule
