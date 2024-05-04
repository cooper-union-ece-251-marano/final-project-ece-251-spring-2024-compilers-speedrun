//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: alu
//     Description: 16-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0 - Initial Build
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
    #(parameter n = 16)(
    input logic [n-1:0] srca, input logic [n-1:0] srcb,
    input logic [2:0] opcode,
    output logic [n-1:0] out, output logic zero
);
	logic [n:0] temp;
	logic [n-1:0] bnot;

	always @(*) begin
		case (opcode) begin
			case 3'b000: out = srca & srcb; 

			case 3'b001: out = srca | srcb;

			case 3'b010: out = ~srca;

			case 3'b011: out = srca ^ srcb;

			case 3'b100: begin
					bnot = ~b + 1;
					temp = srca + srcb;
					out = temp[n-1:0];
				     end

			case 3'b101: begin
					temp = srca + srcb;
					out = temp[n-1:0];
				     end

			case 3'b110: out = (srca < srcb) ? 1 : 0;

			case 3'b111: begin
					temp = srca;
					for (int i = srcb[3:0]; i != 0; i--) begin
						 = temp << 1;
					end
					out = temp[n-1:0];
				     end
		end

		if (out == 0) begin
			zero = 1;
		end
		else begin
			zero = 0;
		end
	end

endmodule

`endif // ALU
