//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Jason Hao and Daniel Park
// 
//     Create Date: 2023-02-07
//     Module Name: tb_regfile
//     Description: Test bench for simple behavorial register file
//
// Revision: 1.0 - Initial build
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_REGFILE
`define TB_REGFILE

`timescale 1ns/100ps
`include "regfile.sv"
`include "../clock/clock.sv"

module tb_regfile;
    parameter n = 16;
    parameter r = 4;

    logic [(n-1):0] RD1, RD2, WD;
    logic [(r-1):0] RA1, RA2, WA;
    logic WE;
    logic CLK, ENABLE;

    initial begin
	$dumpfile("regfile.vcd");
	$dumpvars(0, uut, uut1);
	$monitor("time = %0t, we = %b, ra1 = %b, ra2 = %b, wa = %b, wd = %b, rd1 = %b, rd2 = %b", $realtime, WE, RA1, RA2, WA, WD, RD1, RD2);
    end

    initial begin
	#10 ENABLE <= 1;
	WE <= 0;
	#20 RA1 <= 4'b0000;
	RA2 <= 4'b0000;
	WD <= 16'b1111111111111111;
	WA <= 4'b0000;
	#20 WE <= 1;
	#20 WE <= 0;

	#20 WA <= 4'b0001;
	#20 WE <= 1;
	#20 WE <= 0;

	#20 RA2 <= 4'b0001;
	WA <= 4'b0010;
	WD <= 16'b0101000010101111;
	#20 WE <= 1;
	#20 WE <= 0;

	#20 RA1 <= 4'b0010;
	WA <= 4'b0011;
	WD <= 16'b1100110010101010;
	#20 WE <= 1;
	#20 WE <= 0;
	#20 RA2 <= 4'b0011;

	$finish;

    end

    regfile uut(.ra1(RA1), .ra2(RA2), .wa(WA), .we(WE), .clk(CLK), .rd1(RD1), .rd2(RD2), .wd(WD));

    clock uut1(.ENABLE(ENABLE), .CLOCK(CLK));
endmodule
`endif // TB_REGFILE
