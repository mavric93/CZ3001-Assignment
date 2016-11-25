`include "define.v"// defines DSIZE, ADD, SUB etc

//		3 BITS WILL BE USED BY ALUCONTROL
//		ADD 		= 000
//		SUB 		= 001
//		AND		= 010
//		OR			= 011
//		XOR		= 100
//		MUL		= 101		(RESERVED FOR FUTURE IMPLEMENTATION) TENTATIVELY MUL
//		NOT	 	= 110
//		EQ/COM	= 111

module alu(
   a,   //1st operand
   b,   //2nd operand
   op,   //3-bit operation
	
	//output
	zero,
   out   //output
   );


   
   input [`DSIZE-1:0] a, b;
   input [2:0] op;
   output reg [`DSIZE-1:0] out;
	output zero;
	
	assign zero = (a==b);
	
	
always @(a or b or op )
begin
	
   case(op)
       `ADD: out = a + b;
       `SUB: out = a - b;
       `AND: out = a & b; 
		 `OR : out = a | b;
       `XOR: out = a^b;
		 `NOT: out = ~a;
       `MUL: out = a*b;
       `COM: out = a<=b;
default: out = 0;  
   endcase
end

endmodule
   
       
