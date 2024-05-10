//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: alu
//     Description: 16-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.2
// 1.1 - Adjusted slt to make signed comparisons
// 1.2 - Made an extra condition for default just in case
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
    #(parameter n = 16)(
    input logic signed [n-1:0] srca, input logic signed [n-1:0] srcb,
    input logic [2:0] opcode,
    output logic [n-1:0] out, output logic zero
);
	logic [n:0] temp;

	always @(*) begin
		case (opcode)
			3'b000: out = srca & srcb; 

			3'b001: out = srca | srcb;

			3'b010: out = ~srca;

			3'b011: out = srca ^ srcb;

			3'b100: begin
					temp = srca - srcb;
					out = temp[n-1:0];
				end

			3'b101: begin
					temp = srca + srcb;
					out = temp[n-1:0];
				end

			3'b110: out = (srca < srcb) ? 1 : 0;

			3'b111: begin
					temp = srca;
					for (int i = srcb[3:0]; i != 0; i--) begin
						temp = temp << 1;
					end
					out = temp[n-1:0];
				end
			default: out = 'bz;
		endcase

		if (out == 16'b0000000000000000) begin
			zero = 1;
		end
		else begin
			zero = 0;
		end
	end

endmodule

`endif // ALU
