// defines

//LAST 3 BITS WILL BE USED BY ALUCONTROL
//		ADD 		= 000
//		SUB 		= 001
//		AND		= 010
//		OR			= 011
//		XOR		= 100
//		MUL		= 101		(RESERVED FOR FUTURE IMPLEMENTATION) TENTATIVELY MUL
//		NOT	 	= 110
//		EQ/COM	= 111
//R-type instructions will have 00xxxx as opcode
`define ADD 	6'b00_0000
`define SUB 	6'b00_0001
`define AND 	6'b00_0010
`define OR	 	6'b00_0011
`define XOR  	6'b00_0100
`define MUL 	6'b00_0101
`define NOT  	6'b00_0110
`define COM 	6'b00_0111

//special jump R type instrcutions start with 001
`define JR	 	6'b00_1000		//R type because need 1 source address


//I-type instructions will have or 10xxxx 11xxxx as opcode
`define ADDI 	6'b10_0000
`define SUBI	6'b10_0001
`define ANDI	6'b10_0010
`define ORI		6'b10_0011
`define XORI 	6'b10_0100

`define LW	 	6'b11_1000
`define SW	 	6'b11_0000
`define BEQ 	6'b11_1111		//I type because of imm field

//J-type instructions will have 01xxxx as opcode
`define JMP 	6'b01_0000
`define JAL	 	6'b01_0001

//for fileIO
`timescale 1ns / 10ps
`define EOF 32'hFFFF_FFFF
`define NULL 0
`define MAX_LINE_LENGTH 1000
`define DSIZE 32 // Bitwidth of each register 
`define NREG 32 //Number of registers 
`define ISIZE 32 //instuction size
`define ASIZE 5//Address size

