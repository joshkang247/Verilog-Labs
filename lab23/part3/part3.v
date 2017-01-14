module part3(SW, LEDR);
	input [9:0] SW;
	output [1:0] LEDR;
	
	assign LEDR[0] = ((~SW[9] & ~SW[8]) & SW[0]) | ((~SW[9] & SW[8]) & SW[1]) | ((SW[9] & ~SW[8]) & SW[2]) | ((SW[9] & SW[8]) & SW[2]);
	assign LEDR[1] = ((~SW[9] & ~SW[8]) & SW[3]) | ((~SW[9] & SW[8]) & SW[4]) | ((SW[9] & ~SW[8]) & SW[5]) | ((SW[9] & SW[8]) & SW[5]);

endmodule