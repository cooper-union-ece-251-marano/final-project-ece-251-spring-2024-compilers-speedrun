//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: controller
//     Description: 16-bit RISC-based CPU controller (MIPS)
//
// Revision: 1.1
// 1.1 - Changed to fit the control variables in our CPU
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"

module controller
    (
    input  logic [3:0] op,
    input  logic       zero,
    output logic       memtoreg, regwrite, memwrite,
    output logic       branch, jump, alusrc,
    output logic       regsrc, shortlong,
    output logic [2:0] aluop
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic       Branch;
    
    // CPU main decoder
    maindec md(op, memtoreg, regwrite, memwrite, Branch, jump, alusrc, regsrc, shortlong);
    // CPU's ALU decoder
    aludec  ad(op, aluop);

  assign branch = Branch & (zero ^ op[0]);

endmodule

`endif // CONTROLLER
