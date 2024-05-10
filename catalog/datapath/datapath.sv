//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: datapath
//     Description: 16-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.1
// 1.1 - Changed the parts to fit the 16-bit computer
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../regfile/regfile.sv"
`include "../alu/alu.sv"
`include "../dff/dff.sv"
`include "../adder/adder.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"

module datapath
    #(parameter n = 16, parameter r = 4)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, reset,
    input  logic        memtoreg, regwrite,
    input  logic        branch, jump,
    input  logic        alusrc, regsrc, shortlong,
    input  logic [2:0]  alucontrol,
    output logic        zero,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    logic [(n-1):0] instrshort, instrlong;
    logic [(n-1):0] immediate, result;
    logic [(r-1):0] writereg;
    logic [(n-1):0] read1, source2;
    logic [(n-1):0] addfactor, pcadded, pcnext;

    //program counter
    dff #(n)          pcreg(clk, reset, pcnext, pc);

    signext #(16, 4)  short(instr[3:0], instrshort);
    signext #(16, 8)  long(instr[7:0], instrlong);

    regfile           rf(clk, regwrite, instr[11:8], instr[7:4], writereg, result, read1, writedata);

    adder             pcadd(pc, addfactor, pcadded);
    alu               alu(read1, source2, alucontrol, aluout, zero);

    mux2 #(n)         slmux(instrshort, instrlong, shortlong, immediate);
    mux2 #(r)         regsrcmux(instr[7:4], instr[3:0], regsrc, writereg);
    mux2 #(n)         branchmux(16'b0000000000000001, instrshort, branch, addfactor);
    mux2 #(n)         jumpmux(pcadded, aluout, jump, pcnext);
    mux2 #(n)         alusrcmux(writedata, immediate, alusrc, source2);
    mux2 #(n)         memtoregmux(aluout, readdata, memtoreg, result);

endmodule

`endif // DATAPATH
