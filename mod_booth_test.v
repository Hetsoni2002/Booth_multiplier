`timescale 1ns / 1ps

module mod_booth_test;

	// Inputs
	reg [15:0] x;
	reg [15:0] y;

	// Outputs
	wire [31:0] p;

	// Instantiate the Unit Under Test (UUT)
	booth_mult uut (
		.p(p), 
		.x(x), 
		.y(y)
	);

	initial begin
		// Initialize Inputs
		x = 16'sd25;
		y = -16'sd2;
		#10;
       
		x = 16'sd25;
		y = 16'b0110000110001110;
		#10;
		
		x = 16'sd58;
		y = -16'sd98;
		#10;
		
		x = 16'sd5;
		y = -16'sd100;
		#10;
		
		x = 16'h7fff;//0111  8421
		y = 16'h7fff;
		#10;
		x = 16'h8000;
		y = 16'h7fff;
		#10;
		// Add stimulus here

	end
      
endmodule

