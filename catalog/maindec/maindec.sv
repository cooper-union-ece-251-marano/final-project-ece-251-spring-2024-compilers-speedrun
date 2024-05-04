//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: maindec
//     Description: 32-bit RISC-based CPU main decoder (MIPS)
//
// Revision: 1.1
// 1.1 - Fitted to match new control signals
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module maindec
    (
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [3:0] op,
    output logic       memtoreg, regwrite, memwrite,
    output logic       branch, jump, alusrc,
    output logic       regsrc, shortlong
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [7:0] controls; // 8-bit control vector

    // controls has 8 logical signals
    assign {memtoreg, regwrite, memwrite, branch, jump, alusrc,
            regsrc, shortlong} = controls;

    always @* begin
        case(op)
            4'b0000: controls <= 8'b01000100; // SHFT
            4'b0001: controls <= 8'b01000100; // ADDI
            4'b0010: controls <= 8'b10100100; // SW
            4'b0011: controls <= 8'b11000100; // LW

            4'b0100: controls <= 8'b00010001; // BEQ
            4'b0101: controls <= 8'b00010001; // BNEQ
            4'b0110: controls <= 8'b00001101; // JUMP
	    4'b0111: controls <= 8'b00001101; // 0111 Not assigned, but will just make it a jump operation for convenience sake
 
 	    //R-TYPES
            4'b1000: controls <= 8'b01000010; // AND 
            4'b1001: controls <= 8'b01000010; // OR
            4'b1010: controls <= 8'b01000010; // NOT 
            4'b1011: controls <= 8'b01000010; // XOR

            4'b1100: controls <= 8'b01000010; // SUB 
            4'b1101: controls <= 8'b01000010; // ADD
            4'b1110: controls <= 8'b01000010; // SLT 
            4'b1111: controls <= 8'b01000100; // Not assigned (but is effectively just shft)

            default: controls <= 8'bxxxxxxxx; // illegal operation
        endcase
    end

endmodule

`endif // MAINDEC
