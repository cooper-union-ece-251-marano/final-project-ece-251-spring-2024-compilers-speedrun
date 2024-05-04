//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: tb_controller
//     Description: Test bench for controller
//
// Revision: 1.0 - Initial build
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_CONTROLLER
`define TB_CONTROLLER

`timescale 1ns/100ps
`include "controller.sv"

module tb_controller;
    logic [3:0] OP;
    logic ZERO;
    logic [2:0] ALU;
    logic [7:0] CONTROLS;

    initial begin
	$dumpfile("controller.vcd");
	$dumpvars(0, uut);
	$monitor("op = %b, zero = %b, alu = %b, controls = %b", OP, ZERO, ALU, CONTROLS);
    end

    initial begin
    	ZERO = 0;
	for (int i = 0; i < 16; i++) begin
		#10 OP = i;
		//testing out extra logic for the branch mux
		if (i == 4 | i == 5) begin
			#10 ZERO = 1;
			#10 ZERO = 0;;
		end
	end
    end

    controller uut (.op(OP), .zero(ZERO), .aluop(ALU), .memtoreg(CONTROLS[7]), .regwrite(CONTROLS[6]), .memwrite(CONTROLS[5]), .branch(CONTROLS[4]), .jump(CONTROLS[3]), .alusrc(CONTROLS[2]), .regsrc(CONTROLS[1]), .shortlong(CONTROLS[0]));

endmodule
`endif // TB_CONTROLLER
