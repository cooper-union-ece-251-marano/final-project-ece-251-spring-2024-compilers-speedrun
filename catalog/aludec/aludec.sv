//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao
// 
//     Create Date: 2023-02-07
//     Module Name: aludec
//     Description: 16-bit RISC ALU decoder
//
// Revision: 1.1
// 1.1 - Fixed typos on case conditions
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec
    (
	input logic [3:0] opcode,
	output logic [2:0] aluop
    );
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
	always @(*) begin
		if (opcode[3] == 1) begin
			aluop = opcode[2:0];
		end

		else begin
			case (opcode)
				4'b0000: aluop = 3'b111;
				4'b0001: aluop = 3'b101;
				4'b0010: aluop = 3'b101;
				4'b0011: aluop = 3'b101;
				4'b0100: aluop = 3'b100;
				4'b0101: aluop = 3'b100;
				4'b0110: aluop = 3'b101;
				4'b0111: aluop = 3'b101;
			endcase
		end
	end

    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

endmodule

`endif // ALUDEC
