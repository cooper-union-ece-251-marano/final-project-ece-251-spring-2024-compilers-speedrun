//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: tb_aludec
//     Description: Test bench for simple behavorial ALU decoder
//
// Revision: 1.1
// 1.1 - $dumpfile was accidentally dumping the module file itself (oops)
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ALUDEC
`define TB_ALUDEC

`timescale 1ns/100ps
`include "aludec.sv"

module tb_aludec;
    
    logic [3:0] OP;
    logic [2:0] ALU;

    initial begin
	$dumpfile("aludec.vcd");
	$dumpvars(0, uut);
	$monitor("op = %b, alu = %b", OP, ALU);
    end

    initial begin
        logic [4:0] i;
	for (int i = 0; i < 16; i = i + 1) begin
		#10 OP <= i[3:0];
	end
    end

    aludec uut(.opcode(OP), .aluop(ALU));

endmodule
`endif // TB_ALUDEC
