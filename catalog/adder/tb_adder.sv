//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.1
// 1.1 - Changed parameters and more inputs
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "adder.sv"

module tb_adder;
    parameter n = 16;
    logic [(n-1):0] a, b, y;

   initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, uut);
        $monitor("a = %b b = %b y = %b", a, b, y);
    end

    initial begin
        a <= 16'b0000000000000000;
        #10 b <= 16'b0101010101010101;

	#10 a <= 16'b0000111101011000;
	#10 b <= 16'b1111111111111111;

	#10 a <= 16'b1110000000000101;
	#10 b <= 16'b0000000011111111;
    end

    adder uut(
        .a(a), .b(b), .sum(y)
    );
endmodule
`endif // TB_ADDER
