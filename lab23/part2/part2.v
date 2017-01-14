module part2(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	assign LEDR[0] = (~SW[9] & SW[0]) | (SW[9] & SW[4]);
	assign LEDR[1] = (~SW[9] & SW[1]) | (SW[9] & SW[5]);
	assign LEDR[2] = (~SW[9] & SW[2]) | (SW[9] & SW[6]);
	assign LEDR[3] = (~SW[9] & SW[3]) | (SW[9] & SW[7]);
	
	assign LEDR[9] = SW[9];
	
endmodule
