`timescale 1ns / 1ps

//`define `w=16

module booth_mult (p, x, y);

parameter width = 16;

parameter N = width / 2;

input[width-1:0]x, y;  		// 16 bit

output[2*width-1:0]p; 		//32 bit

 reg [2:0] cc [N-1:0]; 		//3 x 8 case
 
 reg [width:0] pp[N-1:0];  //16 x 8 partial products
 
 reg [width+width-1:0] spp[N-1:0]; 	//32 x 8
 
 reg [width+width-1:0] prod;	//32 bit product reg
 
 wire [width:0] inv_x;		//2's cpmplement of x
 
 integer k,i;				//for loop integers
 
 // 2's complement 
assign inv_x = {~x[width-1],~x}+1;


always @ (x or y or inv_x)
begin

	cc[0] = {y[1],y[0],1'b0};
	for(k=1;k<N;k=k+1)
		cc[k] = {y[2*k+1],y[2*k],y[2*k-1]};
	
	for(k=0;k<N;k=k+1)
	begin
		case(cc[k])
			3'b001 , 3'b010 	: pp[k] = {x[width-1],x};
			3'b011 				: pp[k] = {x,1'b0};
			3'b100 				: pp[k] = {inv_x[width-1:0],1'b0};
			3'b101 , 3'b110 	: pp[k] = inv_x;
			default 				: pp[k] = 0;
		endcase
		
		spp[k] = $signed(pp[k]);
		
		for(i=0;i<k;i=i+1)
		spp[k] = {spp[k],2'b00}; //multiply by 2 to the power x or shifting operation
	
	end //for(k=0;k<N;k=k+1)
 

		prod = spp[0];
 
		for(k=1;k<N;k=k+1)
		prod = prod + spp[k];
end

assign p = prod;


endmodule
