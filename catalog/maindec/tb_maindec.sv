//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: tb_maindec
//     Description: Test bench for simple behavorial main decoder
//
// Revision: 1.0 - Initial build
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MAINDEC
`define TB_MAINDEC

`timescale 1ns/100ps
`include "maindec.sv"

module tb_maindec;
    logic [3:0] opcode;
    logic MemToReg, MemWrite, RegWrite, Branch, Jump, AluSrc, RegSrc, ShortLong;

    initial begin
	$dumpfile("maindec.vcd");
	$dumpvars(0, uut);
	$monitor("op = %b, memtoreg = %b, memwrite = %b, regwrite = %b, branch = %b, jump = %b, alusrc = %b, regsrc = %b, shortlong = %b",
	opcode, MemToReg, MemWrite, RegWrite, Branch, Jump, AluSrc, RegSrc, ShortLong);
    end

    initial begin
	for (int i = 0; i < 16; i = i + 1) begin
		#10 opcode = i;
	end
    end

    maindec uut (.op(opcode), .memtoreg(MemToReg), .memwrite(MemWrite), .regwrite(RegWrite), .branch(Branch), .jump(Jump), .alusrc(AluSrc), .regsrc(RegSrc), .shortlong(ShortLong));

endmodule
`endif // TB_MAINDEC
