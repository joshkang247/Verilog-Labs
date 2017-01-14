module part3(input [9:0] SW, output [9:0] LEDR);
	wire [3:0] A, B;
	wire [2:0] C;
	assign A = SW[7:4];
	assign B = SW[3:0];
	
	full_adder U0 (SW[8], A[0], B[0], LEDR[0], C[0]);
	full_adder U1 (C[0], A[1], B[1], LEDR[1], C[1]);
	full_adder U2 (C[1], A[2], B[2], LEDR[2], C[2]);
	full_adder U3 (C[2], A[3], B[3], LEDR[3], LEDR[4]);
	
endmodule

module full_adder(input ci, a, b, output s, co);
	wire x;
	assign x = a ^ b;
	assign s = ci ^ x;
	
	mux_1bit_2to1 U0 (x, b, ci, co);

endmodule

module mux_1bit_2to1(input s, x, y, output f);
	assign f = (~s & x) | (s & y);
	
endmodule
	