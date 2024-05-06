//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_computer
//     Description: Test bench for a single-cycle MIPS computer
//
// Revision: 1.2
// 1.1 - Tweaked to fit 16 bit computer
// 1.2 - Changed stop condition to stop on no-op
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_COMPUTER
`define TB_COMPUTER

`timescale 1ns/100ps

`include "computer.sv"
`include "../clock/clock.sv"

module tb_computer;
  parameter n = 16; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
  parameter m = 4;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
  logic clk;
  logic clk_enable;
  logic reset;
  logic [15:0] writedata;
  logic [15:0] dataadr;

  // instantiate the CPU as the device to be tested
  computer dut(clk, reset, writedata, dataadr);
  // generate clock to sequence tests
  // always
  //   begin
  //     clk <= 1; # 5; clk <= 0; # 5;
  //   end

  // instantiate the clock
  clock dut1(.ENABLE(clk_enable), .CLOCK(clk));


  initial begin
    $dumpfile("tb_computer.vcd");
    $dumpvars(0, dut, dut1);
    $monitor("t=%t\twrite=0x%4h\taluout=0x%4h\t",$realtime,writedata,dataadr);
    // $dumpvars(0,clk,a,b,ctrl,result,zero,negative,carryOut,overflow);
    // $display("Ctl Z  N  O  C  A                    B                    ALUresult");
    // $monitor("%3b %b  %b  %b  %b  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)",ctrl,zero,negative,overflow,carryOut,a,a,a,b,b,b,result,result,result);
  end

  // initialize test
  initial begin
    #0 clk_enable <= 0; #50 reset <= 1; # 50; reset <= 0; #50 clk_enable <= 1;
  end

  // monitor what happens at posedge of clock transition
  always @(posedge clk)
  begin
      $display("+");
      $display("\t+pc = %d",dut.mips.dp.pc);
      $display("\t+instr = 0x%h",dut.instr);
      $display("\t+op = %b",dut.mips.c.op);
      $display("\t+controls = %b",dut.mips.c.md.controls);
      $display("\t+alucontrol = %b",dut.mips.c.ad.aluop);
      $display("\t+alu result = %b",dut.mips.dp.alu.out);
      $display("\t+$zero = 0x%4h",dut.mips.dp.rf.rf[0]);
      $display("\t+$sp = 0x%4h",dut.mips.dp.rf.rf[1]);
      $display("\t+$at = 0x%4h",dut.mips.dp.rf.rf[2]);
      $display("\t+$va = 0x%4h",dut.mips.dp.rf.rf[3]);
      $display("\t+$a0 = 0x%4h",dut.mips.dp.rf.rf[4]);
      $display("\t+$a1 = 0x%4h",dut.mips.dp.rf.rf[5]);
      $display("\t+$t0 = 0x%4h",dut.mips.dp.rf.rf[6]);
      $display("\t+$t1 = 0x%4h",dut.mips.dp.rf.rf[7]);
      $display("\t+$t2 = 0x%4h",dut.mips.dp.rf.rf[8]);
      $display("\t+$t3 = 0x%4h",dut.mips.dp.rf.rf[9]);
      $display("\t+$t4 = 0x%4h",dut.mips.dp.rf.rf[10]);
      $display("\t+$t5 = 0x%4h",dut.mips.dp.rf.rf[11]);
      $display("\t+$s0 = 0x%4h",dut.mips.dp.rf.rf[12]);
      $display("\t+$s1 = 0x%4h",dut.mips.dp.rf.rf[13]);
      $display("\t+$s2 = 0x%4h",dut.mips.dp.rf.rf[14]);
      $display("\t+$s3 = 0x%4h",dut.mips.dp.rf.rf[15]);
      $display("\t+regfile -- ra1 = %b",dut.mips.dp.rf.ra1);
      $display("\t+regfile -- ra2 = %b",dut.mips.dp.rf.ra2);
      $display("\t+regfile -- we = %b",dut.mips.dp.rf.we);
      $display("\t+regfile -- wa = %b",dut.mips.dp.rf.wa);
      $display("\t+regfile -- wd = 0x%4h",dut.mips.dp.rf.wd);
      $display("\t+regfile -- rd1 = 0x%4h",dut.mips.dp.rf.rd1);
      $display("\t+regfile -- rd2 = 0x%4h",dut.mips.dp.rf.rd2);
  end

  // run program
  // monitor what happens at negedge of clock transition
  always @(negedge clk) begin
    $display("-");
    $display("\t=pc = %d",dut.mips.dp.pc);
    $display("\t-instr = 0x%h",dut.instr);
    $display("\t-op = %b",dut.mips.c.op);
    $display("\t-controls = %b",dut.mips.c.md.controls);
    $display("\t-alucontrol = %b",dut.mips.c.ad.aluop);
    $display("\t-alu result = %b",dut.mips.dp.alu.out);
    $display("\t-$zero = 0x%4h",dut.mips.dp.rf.rf[0]);
    $display("\t-$sp = 0x%4h",dut.mips.dp.rf.rf[1]);
    $display("\t-$at = 0x%4h",dut.mips.dp.rf.rf[2]);
    $display("\t-$va = 0x%4h",dut.mips.dp.rf.rf[3]);
    $display("\t-$a0 = 0x%4h",dut.mips.dp.rf.rf[4]);
    $display("\t-$a1 = 0x%4h",dut.mips.dp.rf.rf[5]);
    $display("\t-$t0 = 0x%4h",dut.mips.dp.rf.rf[6]);
    $display("\t-$t1 = 0x%4h",dut.mips.dp.rf.rf[7]);
    $display("\t-$t2 = 0x%4h",dut.mips.dp.rf.rf[8]);
    $display("\t-$t3 = 0x%4h",dut.mips.dp.rf.rf[9]);
    $display("\t-$t4 = 0x%4h",dut.mips.dp.rf.rf[10]);
    $display("\t-$t5 = 0x%4h",dut.mips.dp.rf.rf[11]);
    $display("\t-$s0 = 0x%4h",dut.mips.dp.rf.rf[12]);
    $display("\t-$s1 = 0x%4h",dut.mips.dp.rf.rf[13]);
    $display("\t-$s2 = 0x%4h",dut.mips.dp.rf.rf[14]);
    $display("\t-$s3 = 0x%4h",dut.mips.dp.rf.rf[15]);
    $display("\t-regfile -- ra1 = %b",dut.mips.dp.rf.ra1);
    $display("\t-regfile -- ra2 = %b",dut.mips.dp.rf.ra2);
    $display("\t-regfile -- we = %b",dut.mips.dp.rf.we);
    $display("\t-regfile -- wa = %b",dut.mips.dp.rf.wa);
    $display("\t-regfile -- wd = 0x%4h",dut.mips.dp.rf.wd);
    $display("\t-regfile -- rd1 = 0x%4h",dut.mips.dp.rf.rd1);
    $display("\t-regfile -- rd2 = 0x%4h",dut.mips.dp.rf.rd2);
  end
  
  always @(negedge clk or posedge clk) begin
    if (dut.instr == 0) begin
      $finish;
    end
  end

endmodule

`endif // TB_COMPUTER
