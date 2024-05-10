# 16-bit Verilog CPU by Jason Hao and Daniel Park

This file contains the documentation and details for the CPU Final Project for ECE251. The "green card", CPU diagram, and a timing diagram for various instructions are provided as images in the same directory.

## Overall Design

The CPU implemented here is a 16-bit RISC single-cycle processor, which means that for every clock cycle one instruction is processed at a time. The bit-width of the operands and registers are all 16 bits long, which allows for convenient instruction formatting and a compact design so that the CPU can be simulated smoothly on most computers. The CPU is modelled after the 32-bit MIPS CPU presented in the textbook, but some tweaks were made for our specific CPU. For example, the CPU is word-addressable instead of byte-addressable as the instructions we had did not provide much use for specifically using a byte-addressable scheme. Even so, the basic stages of an instruction and the overall design are similar to the original CPU in the textbook.

## Modules in CPU

The CPU is comprised of multiple modules that simulate the digital logic to physically implement the CPU. This includes a clock, memory registers, ALUs for computation, and more.

### Clock

The clock module is what allows the CPU to run at all because it provides a steady signal that indicates when the registers should update their contents. The clock simply toggles between a high and low signal at a given rate/period and outputs this toggling signal. The clock is then connected to all of the memory modules so that the registers all synchronously update their contents to progress through a program.

### Arithmetic Logic Unit

The ALU performs all of the calculations that are needed by the instructions in the program running. The ALU takes in 2 16-bit operands and an opcode as inputs and outputs the result of the calculation and a zero bit. The ALU opcode is 3 bits long, which allows for 8 possible operations to be implemented for the ALU. The operations include adding, subtracting, and logical operations. The result of the operation is then outputed to be stored in a register. The zero bit also is high when the result is exactly 16 zeroes, and this allows the branch operations to be implemented with some additional logic.

### Sign Extenders

Sometimes, only parts of the instruction bits are used for a computation. However, the adders and ALU only take 16-bit operands and the size of the parts of the instruction is not compatible with the modules. As a result, sign extenders were implemented to allow the instruction portions to be the right size. The sign extenders used in the CPU allow the immediate fields of instructions to be extended to 16 bits so that they can be used in future computations. By copying the contents of the most significant bit into the extended bits, the sign extenders also preserve the sign of the immediate to allow for signed operations.

### Memory Registers

In order to save the results of a program, multiple different forms of registers are used to store data and keep track of where the program is.  

The register file holds 16 registers, each with 16 bits, that can be used as inputs or outputs for instructions to use. The register file has 2 read address ports, a write address port, 2 read data ports, and a write data port. The read address ports can take a register address and displays it on the corresponding read data port. Similarly, the write address port specifies which register should write whatever data is being inputted into the write data port.

The program counter is a set of D flip-flops that stores what instruction address the program is currently on. The value stored within the program counter can thne be fed to the instruction memory registers to output whatever instruction that needs to be decoded. Updating the value of the program counter is also how the CPU progresses through a program. Usually the value of the program counter is incremented by one, but branch and jump instructions can change what value is loaded into the program counter to change the flow of the program.

The instruction memory holds all of the instructions in the program currently running. The instruction is displayed using the value from the program counter which is then decoded by other modules into portions that can be used as immediates, register addresses, or opcodes later. For this CPU, the instruction memory is a read-only memory over the course of a program's execution.

The data memory holds any data that cannot fit within the 16 registers provided by the register file. The data memory contains an address port, a read data port, and a write data port. When an address is inputted into the address port, the read data port will read whatever is in the data memory at that address, and the data memory will update the address with whatever data is in the write data port when prompted.

### Control Unit/Multiplexers

Because multiple potential inputs may feed into a single port or pathway to accommodate the different instruction types, a control unit and multiplexers are needed in order to select the right signal/input to pass into certain paths/ports. The control unit itself takes in the opcode field of the instruction (as the control bits only depend on the type of instruction it is performing) and translates the opcode into many different signals that signify which input should pass through the multiplexers in the CPU.

The multiplexers are components that receive two signals and uses a selection bit to decide which signal should be outputed. This is to prevent two signals from colliding and creating a short circuit on an actual physical implementation as well as to avoid unpredictable consequences from merging two signals together. The select bits are provided by the control unit after it has translated the opcode into the appropriate signals for each multiplexer.

## Instruction Set Architecture

The CPU is designed to allow a certain set of instructions to be able to be executed on the given modules. The instruction set is a 16-bit RISC based instruction set which means that there is a small number of instructions available, each of them being 16 bits long. This CPU's instruction set allows for basic computations such as addition, subtraction, and logical operations to be performed.

### Instruction Formats

The instruction set architecture supports 3 types of instruction formats, an R-type, an I-type, and a J-type. Each of the bit fields for each of the instructions are either 4 or 8 bits long, which conveniently fits within a 16-bit address.

R-type instructions are used for instructions that require two registers as inputs that would be written onto another register. This includes most of the instructions that have an operation hardcoded onto the ALU such as the logical operations AND, OR, NOT, and XOR, and addition.The R-type format contains a 4-bit field for an opcode, and 3 4-bit register fields (2 for input, 1 for output).

I-type instructions allow for an immediate value to be used to calculate the results of a computation. This allows a wide variety of instructions to use the format, including the two branch instructions, the store/load word instructions, and immediate versions of some R-type instructions. The I-type format uses a 4-bit field for an opcode, 2 4-bit register fields, and a 4-bit immediate field.

The J-type format is exclusively used for the jump instruction as the name suggests. The J-type format allows for one 4-bit field for the opcode, one 4-bit register field, and one 8-bit immediate field. This is to allow the jump instruction to have a wider range of available jumping distance as the immediate is added to the register to give an address to jump to.

### Instruction Implementation

Most of the R-type instructions had their operations hardcoded directly into the ALU, so the ALU opcode was directly taken from the last three bits of the instruction opcode. The register addresses were also simply put directly into the appropriate register file ports.

The shft and addi instructions also had their operations hardcoded, so their implementation was similar to that of the the R-type instructions. The only difference, was the write address input and the immediate value being inputted into the ALU.

The branch instructions used subtraction to determine whether or not two registers were equal or not (i.e. whether the zero bit was high or low). If the zero bit was in the correct state for the instruction, then the offset in the instruction would be added to the next PC input. Otherwise, the instruction effectively does nothing.

The jump instruction calculates an address to jump to by adding the immediate and register provided in the instruction. This would then overwrite the usual next PC input. This implementation allows for the usually j, jal, and jr instructions from the MIPS instruction set to be implemented in a limited scope. The $zero register can be added to an immediate value to act as a j instruction, or a register can act as the usual $ra register and the immediate field be 0 so that the jump instruction can turn into a jal and jr instruction.

The store and load word instructions use addition to calculate the correct offset from a register needed for the data memory. Then, the other register acts as either the write address input of the register file or the write data input of the data memory.

### Instruction Table

|OpCode|Instruction|Type|Description|
|------|-----------|----|---|
|0000  |shft       |I   |Shift logical left Operation|
|0001  |addi       |I   |Adds an immediate to a register|
|0010  |sw         |I   |Stores the contents of a register into data memory|
|0011  |lw         |I   |Loads data from data memory into a register|
|0100  |beq        |I   |Branches when two registers are equal|
|0101  |bne        |I   |Branches when two registers are not equal|
|0110  |jump       |J   |Jumps to a specified address|
|1000  |and        |R   |Logical AND Operation|
|1001  |or         |R   |Logical OR Operation|
|1010  |not        |R   |Logical NOT Operation|
|1011  |xor        |R   |Logical XOR Operation|
|1100  |sub        |R   |Subtracts a register from another|
|1101  |add        |R   |Adds two registers together|
|1110  |slt        |R   |Sets a register to 1 or 0 depending on if one register is less than another|

## Registers

Each of the 16 registers in the register file is designated a specific purpose that the programmer can use for their programs. For example, the 0th register in the register file is hardwired to always contain the constant zero for ease of use. The registers are also assigned a name for use in writing the assembly code and a number for translating the assembly code into machine code.

### Register Table

|Name  |Number|Use                |
|------|------|-------------------|
|$zero |0     |Constant Zero      |
|$sp   |1     |Stack Pointer      |
|$at   |2     |Assembler Temporary|
|$va   |3     |Return Value       |
|$a0-a1|4-5   |Arguments          |
|$t0-t5|6-11  |Temporaries        |
|$s0-s3|12-15 |Saved Temporaries  |

## How to Run Programs

The process of running a program in the CPU is similar for both the pre-prepared programs and any custom programs. Along with the CPU, three pre-prepared programs are provided for an example of a program written in machine code and asssembly language. These instructions assume that the github repository has been cloned onto your computer beforehand.

### Prepared programs

1. Rename the desired program to "prog_exe" because the instruction memory reads out of the file named "prog_exe".

2. Type "make" into the terminal to compile the program.

3. Type "make simulate" to display the results of the program.

### Custom programs

1. (Optional) Write the custom program using the instruction set architecture that the CPU uses.

2. Translate the program into machine code using hexadecimal with one instruction per line. Make sure that the file is exactly 64 lines longand that there is a 0000 inserted at the end of the program (this effectively acts as a halt command for the CPU).

3. Follow steps 1-3 of the pre-prepared program instructions for the machine code file you made.

### Outputs

There is no output or display instruction included with the instruction set. So, the contents of the register file, the program counter, the instruction, and other important signals are printed on every positive and negative clock edge. In order to view the output of a program, the result should be put in a register in the register file so that it is printed out at the end of execution.
