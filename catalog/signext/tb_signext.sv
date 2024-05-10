//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_signext
//     Description: Test bench for sign extender
//
// Revision: 1.1
// 1.1 - Changed parameters and added multiple test inputs
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_SIGNEXT
`define TB_SIGNEXT

`timescale 1ns/100ps
`include "signext.sv"

module tb_sl2;
    parameter n = 16; // #bits for an operand
    parameter i = n/4; // #bits for an immediate
    logic [(i-1):0] a;
    logic [(n-1):0] y;

   initial begin
        $dumpfile("signext.vcd");
        $dumpvars(0, uut);
        //$monitor("a = %b (0x%0h)(%0d) y = %b (0x%0h)(%0d) ", a, a, a, y, y, y);
        $monitor("time=%0t \t a=%b y=%b",$realtime, a, y);
    end

    initial begin
        a <= #i'b0000;
	#10 a <= #i'b0001;
	#10 a <= #i'b0010;
	#10 a <= #i'b0011;
	#10 a <= #i'b0100;
	#10 a <= #i'b0101;
	#10 a <= #i'b0110;
	#10 a <= #i'b0111;
	#10 a <= #i'b1000;
	#10 a <= #i'b1001;
	#10 a <= #i'b1010;
	#10 a <= #i'b1011;
	#10 a <= #i'b1100;
	#10 a <= #i'b1101;
	#10 a <= #i'b1110;
	#10 a <= #i'b1111;
    end

    signext uut(
        .A(a), .Y(y)
    );
endmodule
`endif // TB_SIGNEXT
