`include "define.v"

module MEM_WB_stage (
	
	input  clk,  rst, 
	
	input [`ASIZE-1:0] waddr_in, 
	input [`DSIZE-1:0] nPC_in,
	input [`DSIZE-1:0] dataWB_in,
	
	
	//control signals
	input jal_in,
	input writeEn_in,
	input memtoReg_in,
	
	output reg [`ASIZE-1:0] waddr_out, 
	output reg [`DSIZE-1:0] nPC_out,
	output reg [`DSIZE-1:0] dataWB_out,
	
	//control signals
	output reg jal_out,
	output reg writeEn_out,
	output reg memtoReg_out
);

always @ (posedge clk) begin
	if(rst)
	begin
		waddr_out <= 0;
		nPC_out <=0;
		dataWB_out <=0;
		
		//control signals
		jal_out <= 0;
		writeEn_out <= 0;
		memtoReg_out<=0;
	end
   else
	begin
		waddr_out <= waddr_in;
		nPC_out<=nPC_in;
		dataWB_out <=dataWB_in;
		
		//controls signals
		jal_out <= jal_in;
		writeEn_out <= writeEn_in;
		memtoReg_out <= memtoReg_in;
	end
end
endmodule

/*
wire [`ASIZE-1:0] MEM_WB_waddr;
wire MEM_WB_jal;
wire MEM_WB_writeEn;
wire MEM_WB_MemtoReg;
wire [`DSIZE-1:0] MEM_WB_nPC;

MEM_WB_stage PIPE3(
	.waddr_in(EXE_MEM_waddr),
	.jal_in(EXE_MEM_jal),
	.writeEn_in(EXE_MEM_writeEn),
	.MemtoReg_in(EXE_MEM_MemtoReg_in),
	.nPC_in(EXE_MEM_nPC_in),
	.waddr_out(MEM_WB_waddr),
	.jal_out(MEM_WB_jal),
	.writeEn_out(MEM_WB_writeEn),
	.MemtoReg_out(MEM_WB_MemtoReg),
	.nPC_out(MEM_WB_nPC)
);

*/


