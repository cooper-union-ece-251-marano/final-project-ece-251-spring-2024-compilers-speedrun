//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: tb_cpu
//     Description: Test bench for cpu
//
// Revision: 1.0 - Initial build
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_CPU
`define TB_CPU

`timescale 1ns/100ps
`include "cpu.sv"
`include "../clock/clock.sv"

module tb_cpu;
    parameter n = 16;
    
    logic clk, en, rst;
    logic MemWrite;
    logic [(n-1):0] INSTR, ReadData;
    logic [(n-1):0] PC, ALU, WriteData;

    initial begin
	$dumpfile("cpu.vcd");
	$dumpvars(0, uut, uut1);
	$monitor("clk = %b, pc = %b, instr = %b, alu = %b, write = %b, read = %b, memwrite = %b", clk, PC, INSTR, ALU, WriteData, ReadData, MemWrite);
    end

    initial begin
	rst <= 0;
	en <= 1;
	INSTR <= 16'b0001000011110111;
	ReadData <= 0;

	#30
	INSTR <= 16'b0001000011100101;
	ReadData <= 7;

	#30 
	INSTR <= 16'b1101111011110111;
	ReadData <= 104;

	#30
	INSTR <= 16'b0110111100000000;
	ReadData <= 500;

	#10
	#20 $finish;	
    end

    cpu uut(.clk(clk), .reset(rst), .pc(PC), .instr(INSTR), .memwrite(MemWrite), .aluout(ALU), .writedata(WriteData), .readdata(ReadData));

    clock #(30) uut1(.ENABLE(en), .CLOCK(clk));

endmodule
`endif // TB_CPU
