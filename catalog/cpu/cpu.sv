//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: cpu
//     Description: 16-bit RISC-based CPU (MIPS)
//
// Revision: 1.1
// 1.1 - Tweaked to fit 16-bit CPU
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../controller/controller.sv"
`include "../datapath/datapath.sv"

module cpu
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic           clk, reset,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    // cpu internal components
    logic       memtoreg, regwrite, branch, jump, alusrc, regsrc, shortlong, zero;
    logic [2:0] alucontrol;
    
    controller c(instr[15:12], zero,
                    memtoreg, regwrite, memwrite,
                    branch, jump, alusrc, regsrc, shortlong,
                    alucontrol);

    datapath dp(clk, reset, memtoreg, regwrite,
                    branch, jump, alusrc, regsrc, shortlong,
                    alucontrol,
                    zero, pc, instr,
                    aluout, writedata, readdata);

endmodule

`endif // CPU
