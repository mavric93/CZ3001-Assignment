`timescale 1ns / 1ps
`include "define.v"

module pipelined_5stage_(
			clk, rst, fileid, 
			
			//show jump instructions
			jmpPC, nPC2,nPC1,ctrl_jump,ctrl_jr,MEM_WB_jal,
			//fetch
			PCIN, PCOUT, 													
			//decode
			inst,regWAddr,reg_rdata1,reg_rdata2,immData,		wAddr,		
			//execute	
			alu_operand1,alu_operand2, alu_result,	ID_EXE_ALUSrc,	ID_EXE_branch, 
			//memory			
			EXE_MEM_alu_result, EXE_MEM_rdata2,	DM_dataout, EXE_MEM_memWrite,MEM_WB_memToReg,
			//writeback
			wData2, wData1,ctrl_regDst,
			//Jump
			forwardOp1,forwardOp2
			
			);											

//PCOUT, inst, 

input clk;				
											
input	rst;
input fileid; 
 
 //control related system
output [`DSIZE-1:0]jmpPC;
output [`DSIZE-1:0]nPC2;
output ctrl_jump;
output ctrl_jr;
output MEM_WB_jal;
output ctrl_regDst;

 //fetch stage
output [`DSIZE-1:0] PCIN;				//next address for PC
wire [`DSIZE-1:0] PCIN;				//next address for PC
output [`DSIZE-1:0] PCOUT;				//current address for PC

//decode stage
output [`ISIZE-1:0] inst;				//instruction
output [`DSIZE-1:0] reg_rdata1;		//reg data1
output [`DSIZE-1:0] reg_rdata2;		//reg data 2
output [`DSIZE-1:0] immData;			//immediate data
output forwardOp1;
output forwardOp2;

//execute stage
output [`DSIZE-1:0] alu_operand1;
output [`DSIZE-1:0] alu_operand2;
output [`DSIZE-1:0] alu_result;
output ID_EXE_ALUSrc;
output ID_EXE_branch;
output [`DSIZE-1:0] nPC1;

//memory stage
output [`DSIZE-1:0] EXE_MEM_alu_result;		//effective address
output [`DSIZE-1:0] EXE_MEM_rdata2;				//data to be stored to mem
output [`DSIZE-1:0] DM_dataout;					//for load word


//write back stage
output [`DSIZE-1:0] wData2;						
output [`DSIZE-1:0] wData1;
output [`ASIZE-1:0] regWAddr;			
output [`ASIZE-1:0] wAddr;		
output EXE_MEM_memWrite;
output MEM_WB_memToReg;

//Program counter
wire [2:0] ctrl_ALUop;

PC1 pc ( .clk(clk), .rst(rst), .nextPC(PCIN),
			//output
			.currPC(PCOUT));
 memory IM( .clk(clk), .rst(rst), .wen(1'b0), .addr(PCOUT), .data_in(32'b0), .fileid(4'b0),
				//instruction memory output
				.data_out(inst));    

 control ctrl( 	.inst_cntrl(inst),
					
						//output
						//all instructions requires these
						.writeEn(ctrl_writeEn),						//0 to disallow write;	1 to allow write
						.regDst(ctrl_regDst),						//0 to use RT			;	1 to use RD
						.ALUSrc(ctrl_ALUSrc),						//0 to use Rdata2		;	1 to use imm
						.ALUop (ctrl_ALUop),							//3bits signals to send to ALU
					  
						//Memory related control signals
						.memWrite(ctrl_memWrite),				 	//0 for all inst		;	1 for storeWord
						.memToReg(ctrl_memToReg),					//0 for all inst		;	1 for loadWord
  
						//branch related control signals
						.branch(ctrl_branch),						//0 for all inst		; 1 for BEW
						.jump(ctrl_jump),							//0 for all inst		; 1 for jump related
						.jal(ctrl_jal),								//0 for all inst		; 1 for JAL
						.jr(ctrl_jr),									//0 for all inst		; 1 for JR
						
						//dataforward
						.forwardOp1(forwardOp1),
						.forwardOp2(forwardOp2)
						);
					
wire [`ISIZE-1:0] nPC = PCOUT +1;	  
wire [`ASIZE-1:0]regWAddr;
assign jmpPC = {{2'd00},nPC[29:26],inst[25:0]};
assign wAddr = (ctrl_regDst) ?  inst[15:11] : inst[20:16];		//toogle between rt or rd based on regDst
assign immData = (inst[15]) ? {{16'hFFFF},inst[15:0]} : {{16'h0000},inst[15:0]};			//sign extending

 regfile	RF(	.clk(clk),.rst(rst),.wen(MEM_WB_writeEn),	
					.raddr1(inst[25:21]), 					//rs
					.raddr2(inst[20:16]), 					//rt
					.waddr(regWAddr), 							//rd
					.wdata(wData2),

					//output from register file
					.rdata1(reg_rdata1),
					.rdata2(reg_rdata2)
					);
					
assign PCIN = (ctrl_jr) ? reg_rdata1 : nPC3 ; 


assign nPC2 = (PCSrc) ? nPC1 : nPC;
wire [`DSIZE-1:0] nPC3;
assign nPC3 = (ctrl_jump) ? jmpPC : nPC2;
					
wire [`DSIZE-1:0] ID_EXE_rdata1;
wire [`DSIZE-1:0] ID_EXE_rdata2;
wire [`DSIZE-1:0] ID_EXE_immData;
wire [`DSIZE-1:0] ID_EXE_nPC_out;
wire [`ASIZE-1:0] ID_EXE_wAddr;

wire [2:0] ID_EXE_ALUop_out;
wire [2:0] ID_EXE_ALUop;
wire [`ASIZE-1:0] ID_EXE_waddr;
 ID_EXE_STAGE pipe1 (
					.clk(clk),  
					.rst(rst), 
					.rdata1_in(reg_rdata1),			//from register file to ALU
					.rdata2_in(reg_rdata2),			//from register file to ALU
					.imm_in(immData),				//immediate field to ALU
	
					//control signals in
					.ALUop_in(ctrl_ALUop),					//from control to ALU
					.ALUSrc_in(ctrl_ALUSrc),							//from control to ALU
					.branch_in(ctrl_branch),							//from control to branch
	
					//delay 2 cycles
					.memWrite_in(ctrl_memWrite),						//from control to Memory	2 cycles
	
				//delay 3 cycles
					.writeEn_in(ctrl_writeEn),							//to write back into regfile
					.jal_in(ctrl_jal),								//to write back into regfile for JAL
					.memToReg_in(ctrl_memToReg),
					.waddr_in(wAddr), 		//to delay waddr_in until WB stage
					.nPC_in(nPC),				//from nPC to BEQ and jump adder.

				//output signals
				.rdata1_out(ID_EXE_rdata1),			//from register file to ALU
				.rdata2_out(ID_EXE_rdata2),			//from register file to ALU
				.imm_out(ID_EXE_immData),				//immediate field to ALU
				
				//control signals in
				.ALUop_out(ID_EXE_ALUop),					//from control to ALU
				.ALUSrc_out(ID_EXE_ALUSrc),							//from control to ALU
				.branch_out(ID_EXE_branch),							//from control to branch
				
				//delay 2 cycles
				.memWrite_out(ID_EXE_memWrite),						//from control to Memory	2 cycles
				
				//delay 3 cycles
				.writeEn_out(ID_EXE_writeEn),						//to write back into regfile
				.jal_out(ID_EXE_jal),								//to write back into regfile for JAL
				.waddr_out(ID_EXE_wAddr), 							//to delay waddr_in until WB stage
				.nPC_out(ID_EXE_nPC_out),												//from nPC to BEQ and jump adder.
				.memToReg_out(ID_EXE_memToReg)
				);
				

assign alu_operand1 = ID_EXE_rdata1; 
assign alu_operand2 = (ID_EXE_ALUSrc) ? ID_EXE_immData : ID_EXE_rdata2;

alu ALU (
			.a(alu_operand1), 
			.b(alu_operand2),
			.op(ID_EXE_ALUop),
   
			.zero(alu_zero),
			.out(alu_result)
			);

assign PCSrc = (ID_EXE_branch & alu_zero);			//for BEQ

wire [`DSIZE-1:0] res;
assign nPC1 = (ID_EXE_nPC_out + ID_EXE_immData);		//to calculate jump address

wire [`ASIZE-1:0] EXE_MEM_wAddr;
wire [`DSIZE-1:0] EXE_MEM_nPC_out;
wire [`DSIZE-1:0] EXE_MEM_alu_result;
wire [`DSIZE-1:0] EXE_MEM_rdata2;

EXE_MEM pipe2(.clk(clk), .rst(rst), 
	
	//Input signal
	//delay 3 cycle
	.jal(ID_EXE_jal),
	.WriteEn(ID_EXE_writeEn),
	.MemtoReg(ID_EXE_memToReg),
	.WAddr(ID_EXE_wAddr),
	.nPC(ID_EXE_nPC_out),
	
	//delay 2 cycle
	.MemWrite(ID_EXE_memWrite),
	
	//signal in
	.ALU_out(alu_result),
	.RData2(ID_EXE_rdata2),
	
	///////////////////////////////////////////////////////////////////////////////////
	//Output
	//delay 3 cycle
	.jal_out(EXE_MEM_jal),
	.WriteEn_out(EXE_MEM_writeEn),
	.MemtoReg_out(EXE_MEM_memToReg),
	.WAddr_out(EXE_MEM_wAddr),							//5bit
	.nPC_out(EXE_MEM_nPC_out),									//32bit
	
	//delay 2 cycles
	.MemWrite_out(EXE_MEM_memWrite),

	//delay 1 cycles
	.ALU_OUT_out(EXE_MEM_alu_result),			//32bit
	.RData2_out(EXE_MEM_rdata2)					//32bit
);


memory DM( .clk(clk), .rst(rst), .wen(EXE_MEM_memWrite), .addr(EXE_MEM_alu_result), .data_in(EXE_MEM_rdata2), .fileid(4'b1000),
				//instruction memory output
				.data_out(DM_dataout));    

wire [`ASIZE-1:0] MEM_WB_wAddr;
wire [`DSIZE-1:0] MEM_WB_nPCout;
wire [`DSIZE-1:0] MEM_WB_result;
//wire [`DSIZE-1:0] EXE_MEM_memToReg;

MEM_WB_stage pipe3 ( .clk(clk), .rst(rst),	
	.waddr_in(EXE_MEM_wAddr), 
	.nPC_in (EXE_MEM_nPC_out),
	.dataWB_in(EXE_MEM_alu_result),
	
	
	//control signals
	.jal_in (EXE_MEM_jal),
	.writeEn_in(EXE_MEM_writeEn),
	.memtoReg_in(EXE_MEM_memToReg),
	
	//output
	.waddr_out(MEM_WB_wAddr), 						//5bit signal
	.nPC_out(MEM_WB_nPCout),							//32bit 
	.dataWB_out(MEM_WB_result),						//32bit
	
	//control signals
	.jal_out(MEM_WB_jal),
	.writeEn_out(MEM_WB_writeEn),
	.memtoReg_out (MEM_WB_memToReg));


assign wData1 = (MEM_WB_memToReg)? MEM_WB_result : DM_dataout; 
assign wData2 = (MEM_WB_jal) ? MEM_WB_nPCout : wData1;

assign regWAddr = (MEM_WB_jal) ? 5'b11111 : MEM_WB_wAddr ; 				//toogle between r31 or rt/rd should be from  third pipeline
endmodule

