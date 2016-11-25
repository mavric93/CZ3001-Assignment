`include "define.v"

module EXE_MEM(
	
	input  clk,  rst, 
	//delay 2 Cycle
	input jal, WriteEn, MemtoReg,
	input [`ASIZE-1:0] WAddr,
	input [`DSIZE-1:0] nPC,
	
	//delay 1 Cycle
	input MemWrite,
	// Control Signal
	
	// input Signal
	input [`DSIZE-1:0] ALU_out,
	input [`DSIZE-1:0] RData2,

	//output Signal
	//delay 1 Cycle
	output reg jal_out, 
	output reg WriteEn_out, 
	output reg MemtoReg_out,
	output reg [`ASIZE-1:0] WAddr_out,
	output reg [`DSIZE-1:0] nPC_out,
	
	//delay 2 Cycle
	output reg MemWrite_out,
	output reg [`DSIZE-1:0] ALU_OUT_out,
	output reg [`DSIZE-1:0] RData2_out
);


always @ (posedge clk) begin
	if(rst)
	begin
		//delay 3 Cycle 
		jal_out <=0;
		WriteEn_out <=0;
		MemtoReg_out <=0;
		WAddr_out <=0;
		nPC_out <=0;
		
		//delay 2 cycles
		MemWrite_out <=0;
	
		//delay 1 cycles
		ALU_OUT_out <=0;
		RData2_out <=0;

	end
   else
	begin
		//delay 3 cycle
		jal_out <=jal;
		WriteEn_out <=WriteEn;
		MemtoReg_out <=MemtoReg;
		WAddr_out <=WAddr;
		nPC_out <=nPC;
		
		//delay 2 cycles
		MemWrite_out <=MemWrite ;
	
		//delay 1 cycles
		ALU_OUT_out <=ALU_out;
		RData2_out <=RData2;
	end
end
endmodule


