`include "define.v"

module ID_EXE_STAGE (
	
	input  clk,  rst, 
	input [`DSIZE-1:0] rdata1_in,			//from register file to ALU
	input [`DSIZE-1:0] rdata2_in,			//from register file to ALU
	input [`DSIZE-1:0] imm_in,				//immediate field to ALU
	
	//control signals in
	input [2:0] ALUop_in,					//from control to ALU
	input ALUSrc_in,							//from control to ALU
	input branch_in,							//from control to branch
	
	//delay 2 cycles
	input memWrite_in,						//from control to Memory	2 cycles
	
	//delay 3 cycles
	input writeEn_in,							//to write back into regfile
	input jal_in,								//to write back into regfile for JAL
	input [`ASIZE-1:0]waddr_in, 			//to delay waddr_in until WB stage
	input [`DSIZE-1:0] nPC_in,				//from nPC to BEQ and jump adder.
	input memToReg_in,

	//output signals
	output reg [`DSIZE-1:0] rdata1_out,			//from register file to ALU
	output reg [`DSIZE-1:0] rdata2_out,			//from register file to ALU
	output reg [`DSIZE-1:0] imm_out,				//immediate field to ALU
	
	//control signals in
	output reg [2:0] ALUop_out,					//from control to ALU
	output reg ALUSrc_out,							//from control to ALU
	output reg branch_out,							//from control to branch
	
	//delay 2 cycles
	output reg memWrite_out,						//from control to Memory	2 cycles
	
	//delay 3 cycles
	output reg writeEn_out,							//to write back into regfile
	output reg jal_out,								//to write back into regfile for JAL
	output reg [`ASIZE-1:0]waddr_out, 		//to delay waddr_in until WB stage
	output reg [`DSIZE-1:0] nPC_out,				//from nPC to BEQ and jump adder.
	output reg memToReg_out
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.
always @ (posedge clk) begin
	if(rst)
	begin
		rdata1_out <=0;
		rdata2_out <=0;
		imm_out <=0;
	
		//control signals in
		ALUop_out <=0;
		ALUSrc_out <=0;
		branch_out <=0;
		
		//delay 2 cycles
		memWrite_out <=0;
		
		//delay 3 cycles
		writeEn_out <=0;
		jal_out <=0;
		waddr_out <=0;
		nPC_out <=0;
		memToReg_out <=0;

	end
   else
	begin
		rdata1_out <=rdata1_in;
		rdata2_out <=rdata2_in;
		imm_out <=imm_in;
	
		//control signals in
		ALUop_out <= ALUop_in;
		ALUSrc_out <= ALUSrc_in;
		branch_out <= branch_in;
		
		//delay 2 cycles
		memWrite_out <= memWrite_in;
		
		//delay 3 cycles
		writeEn_out <=writeEn_in;
		jal_out <= jal_in;
		waddr_out <= waddr_in;
		nPC_out <= nPC_in;
		memToReg_out <= memToReg_in;
	end
 
end
endmodule


