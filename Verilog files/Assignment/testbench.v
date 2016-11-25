`timescale 1ns / 1ps
`include "define.v"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:56:19 03/18/2016
// Design Name:   pipelined_5stage_
// Module Name:   Y:/Application Data/Assignment/testbench.v
// Project Name:  Assignment
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelined_5stage_
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg rst;
	reg fileid;

	// Outputs
	wire [31:0] PCIN;
	wire [31:0] PCOUT;
	
	wire [31:0] nPC2;
	wire [31:0] jmpPC;
	wire ctrl_jr;
	wire ctrl_jump;
	wire MEM_WB_jal;
	
	wire [31:0] inst;
	wire [31:0] reg_rdata1;
	wire [31:0] reg_rdata2;
	wire [31:0]	immData;
	
	wire [31:0] alu_operand1;
	wire [31:0] alu_operand2;
	wire [31:0] alu_result;
	wire ID_EXE_ALUSrc;
	wire ID_EXE_branch;
	wire [31:0] nPC1;
	
	wire [31:0] effectiveAddress;	//effective address
	wire [31:0] EXE_MEM_rdata2;
	wire [31:0] DM_dataout;
	wire EXE_MEM_memWrite;
	wire MEM_WB_memToReg;
	
	wire [31:0] wData1;
	wire [31:0] wData2;
	wire [4:0] regWAddr;
	wire [4:0] wAddr;
	wire ctrl_regDst;
	
	wire forwardOp1;
	wire forwardOp2;
//	clk, rst, fileid, PCIN, PCOUT, inst,wAddr,reg_rdata1,alu_operand1,alu_operand2,alu_result,wData2, wData1,reg_rdata2, immData, EXE_MEM_alu_result, EXE_MEM_rdata2
	// Instantiate the Unit Under Test (UUT)
	pipelined_5stage_ uut (
			
			.clk(clk), .rst(rst), .fileid(fileid), .ctrl_regDst(ctrl_regDst), .forwardOp1(forwardOp1), .forwardOp2(forwardOp2),
			
			.jmpPC(jmpPC), .nPC2(nPC2), .ctrl_jr(ctrl_jr), .ctrl_jump(ctrl_jump), .MEM_WB_jal(MEM_WB_jal), .wAddr(wAddr),
			//fetch
			.PCIN(PCIN), .PCOUT(PCOUT), 													
			//decode
			.inst(inst),.reg_rdata1(reg_rdata1),.reg_rdata2(reg_rdata2),.immData(immData),				
			//execute	
			.alu_operand1(alu_operand1),.alu_operand2(alu_operand2), .alu_result(alu_result),	.ID_EXE_ALUSrc(ID_EXE_ALUSrc),	.ID_EXE_branch(ID_EXE_branch), .nPC1(nPC1),
			//memory			
			.EXE_MEM_alu_result(effectiveAddress), .EXE_MEM_rdata2(EXE_MEM_rdata2),	.DM_dataout(DM_dataout), .EXE_MEM_memWrite(EXE_MEM_memWrite), .MEM_WB_memToReg(MEM_WB_memToReg),
			//writeback
			.wData2(wData2), .wData1(wData1), .regWAddr(regWAddr) 		
	);


always #15 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		fileid = 0;


		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#50 rst =1;
		#50 rst=0;


	end
      endmodule