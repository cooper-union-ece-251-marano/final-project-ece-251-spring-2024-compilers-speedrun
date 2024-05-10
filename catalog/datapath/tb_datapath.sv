//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: tb_datapath
//     Description: Test bench for datapath
//
// Revision: 1.0 - Initial build
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_DATAPATH
`define TB_DATAPATH

`timescale 1ns/100ps
`include "datapath.sv"
`include "../clock/clock.sv"

module tb_datapath;
    parameter n = 16;

    logic clk, en, rst;
    logic [(n-1):0] INSTR, ReadData;
    logic [6:0] controls;
    logic [2:0] aluop;

    logic ZR;
    logic [(n-1):0] PC, ALU, WriteData;

    initial begin
	$dumpfile("datapath.vcd");
	$dumpvars(0, uut, uut1);
	$monitor("clk = %b, instr = %b, read = %b, controls = %b, aluop = %b, zero = %b, pc = %b, alu = %b, write = %b", clk, INSTR, ReadData, controls, aluop, ZR, PC, ALU, WriteData);
    end

    initial begin
	rst <= 0;
	en <= 1;
	INSTR <= 16'b0001000011110111;
	aluop <= 3'b101;
	controls <= 7'b0100100;
	ReadData <= 0;

	#30
	INSTR <= 16'b0001000011100101;
	aluop <= 3'b101;
	controls <= 7'b0100100;
	ReadData <= 7;

	#30 
	INSTR <= 16'b1101111011110111;
	aluop <= 3'b101;
	controls <= 7'b0100010;
	ReadData <= 104;

	#30
	INSTR <= 16'b0110111100000000;
	aluop <= 3'b101;
	controls <= 7'b0001101;
	ReadData <= 500;

	#10
	#20 $finish;
    end

    datapath uut(.clk(clk), .reset(rst), .memtoreg(controls[6]), .regwrite(controls[5]), .branch(controls[4]), .jump(controls[3]),
    .alusrc(controls[2]), .regsrc(controls[1]), .shortlong(controls[0]), .alucontrol(aluop), .zero(ZR), .pc(PC), .instr(INSTR),
    .aluout(ALU), .writedata(WriteData), .readdata(ReadData));

    clock #(30) uut1(.ENABLE(en), .CLOCK(clk));

endmodule
`endif // TB_DATAPATH
