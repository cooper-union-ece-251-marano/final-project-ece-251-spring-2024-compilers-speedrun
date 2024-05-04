//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: adder
//     Description: simple behavorial adder
//
// Revision: 1.0 - Initial build
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module adder
    #(parameter n = 16)(
	input logic [n-1:0] a, input logic [n-1:0] b,
	output logic [n-1:0] sum
);
    // no enable or carry out needed because it is computing address increments/branches/jumps

	logic [n:0] temp;

	always @(*) begin
	    temp = a + b;
	    sum = temp[n-1:0];
	end

endmodule

`endif // ADDER
