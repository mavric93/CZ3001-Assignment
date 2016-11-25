//control unit for write enable and ALU control

`include "define.v"

module control(
  //input [5:0] inst_cntrl, 
  input [31:0] inst_cntrl, //take in full instruction instead of only opcode
  
  //all instructions requires these
  output reg writeEn,					//0 to disallow write;	1 to allow write
  output reg regDst,						//0 to use RT			;	1 to use RD
  output reg ALUSrc,						//0 to use Rdata2		;	1 to use imm
  output reg [2:0] ALUop,				//3bits signals to send to ALU
  
  //Memory related control signals
  output reg memWrite,					//0 for all inst		;	1 for storeWord
  output reg memToReg,					//0 for all inst		;	1 for loadWord
  
  //branch related control signals
  output reg branch,						//0 for all inst		; 1 for BEW
  output reg jump,						//0 for all inst		; 1 for jump related
  output reg jal,							//0 for all inst		; 1 for JAL
  output reg jr,							//0 for all inst		; 1 for JR
  
  //data forwarding related
  output reg forwardOp1,
  output reg forwardOp2
  );
  
  reg[`ASIZE-1:0] oldWaddr;
  
  always@(*)
  begin
 
    case(inst_cntrl)
			`ADD: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 1;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end
			`SUB: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 1;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end
			`AND: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 1;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end
			`OR: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 1;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end
			`XOR: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 1;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end		
			`MUL: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 1;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end	
			`NOT: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 1;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end	
			`COM: begin
					//basic instructions requres these
					writeEn 	= 0;
					regDst 	= 1;		//not using as not writing into regfile
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[15:11];
					end	
			`BEQ: begin
					//basic instructions requres these
					writeEn 	= 0;
					regDst 	= 0;	//not using as not writing into reg file
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1; 
					
					//branch related control signals
					branch 	= 1;
					jump 		= 0;
					jal 		= 0;  
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = (oldWaddr == inst_cntrl[20:16]);
					oldWaddr = inst_cntrl[20:16];
					end	
			`ADDI: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 0;	
					ALUSrc 	= 1;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = 0;
					oldWaddr = inst_cntrl[20:16];
					end	
			`SUBI: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 0;	
					ALUSrc 	= 1;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = 0;
					oldWaddr = inst_cntrl[20:16];
					end			
			`ANDI: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 0;	
					ALUSrc 	= 1;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 0;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = 0;
					oldWaddr = inst_cntrl[20:16];
					end		
			`ORI: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 0;	
					ALUSrc 	= 1;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 1;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = 0;
					oldWaddr = inst_cntrl[20:16];
					end	
			`LW: begin
					//basic instructions requres these
					writeEn 	= 1;
					regDst 	= 0;	
					ALUSrc 	= 1;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 0;		//is needed because happends in different cycle from memRead
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = 0;
					oldWaddr = inst_cntrl[20:16];
					end	
			`SW: begin
					//basic instructions requres these
					writeEn 	= 0;
					regDst 	= 0;	
					ALUSrc 	= 1;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 1;
					memToReg = 0;		//is needed because happends in different cycle from memRead
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
					
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = (oldWaddr == inst_cntrl[25:21]);
					forwardOp2 = 0;
					oldWaddr = inst_cntrl[20:16];
					end	
			`JR: begin
					//basic instructions requres these
					writeEn = 0;		//doesnt matter because not writing tor register file
					regDst 	= 0;		//doesnt matter because not writing to register file	
					ALUSrc 	= 0;		//doesnt matter because not adding
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 0;		//is needed because happens in different cycle from memRead
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;		//not using
					jal 		= 0;
					jr 		= 1;
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = 0;
					forwardOp2 = 0;
					oldWaddr = 5'b00000;
					end	
			`JMP: begin
					//basic instructions requres these
					writeEn = 0;		//doesnt matter because not writing tor register file
					regDst 	= 0;		//doesnt matter because not writing to register file	
					ALUSrc 	= 0;		//doesnt matter because not adding
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 0;		//is needed because happens in different cycle from memRead
					
					//branch related control signals
					branch 	= 0;
					jump 	= 1;		//not using
					jal 	= 0;
					jr 		= 0;
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = 0;
					forwardOp2 = 0;
					oldWaddr = 5'b00000;
					end	
			`JAL: begin
					//basic instructions requres these
					writeEn = 1;		
					regDst 	= 0;		//always register 31	
					ALUSrc 	= 0;		//no immediate field
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 0;		//is needed because happens in different cycle from memRead
					
					//branch related control signals
					branch 	= 0;
					jump 	= 1;		//not using
					jal 	= 1;
					jr 		= 0;
					//forward compare oldWaddr vs incoming signals
					forwardOp1 = 0;
					forwardOp2 = 0;
					oldWaddr = 5'b00000;
					end	
		default: begin
					//basic instructions requres these
					writeEn 	= 0;
					regDst 	= 0;
					ALUSrc 	= 0;
					ALUop 	= inst_cntrl[2:0];
					
					//Memory related control signals
					memWrite = 0;
					memToReg = 0;
					
					//branch related control signals
					branch 	= 0;
					jump 		= 0;
					jal 		= 0;
					jr 		= 0;
			end	
		
    endcase
		end
  
endmodule
