module part2 (input [9:0] SW, input [3:0] KEY, output [0:6] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, output [9:0] LEDR);
	
	wire [7:0] A, B, S;
	wire [6:0] C;
	
	assign A = SW[7:0];
	
	reg [7:0] Q;
	always @(negedge KEY[0], posedge KEY[1])
		if (KEY[0] == 0)
			Q <= 8'b 00000000;

		else
			Q <= A;
	
	binary_to_7seg_hex U00 (Q[7:4], HEX3);
	binary_to_7seg_hex U01 (Q[3:0], HEX2);
	binary_to_7seg_hex U10 (A[7:4], HEX1);
	binary_to_7seg_hex U11 (A[3:0], HEX0);
	
	full_adder U0 (1'b 0, A[0], Q[0], S[0], C[0]);
	full_adder U1 (C[0], A[1], Q[1], S[1], C[1]);
	full_adder U2 (C[1], A[2], Q[2], S[2], C[2]);
	full_adder U3 (C[2], A[3], Q[3], S[3], C[3]);
	full_adder U4 (C[3], A[4], Q[4], S[4], C[4]);
	full_adder U5 (C[4], A[5], Q[5], S[5], C[5]);
	full_adder U6 (C[5], A[6], Q[6], S[6], C[6]);
	full_adder U7 (C[6], A[7], Q[7], S[7], LEDR[0]);
	
	binary_to_7seg_hex U20 (S[7:4], HEX5);
	binary_to_7seg_hex U21 (S[3:0], HEX4);

endmodule
	
	
module binary_to_7seg_hex(input [3:0] A, output [0:6] DISP);
	assign DISP[6] = (~A[3] & ~A[2] & ~A[1]) | (~A[3] & A[2] & A[1] & A[0]) | (A[3] & A[2] & ~A[1] & ~A[0]);
	assign DISP[5] = (~A[3] & ~A[2] & A[0]) | (~A[3] & ~A[2] & A[1]) | (~A[3] & A[1] & A[0]) | (A[3] & A[2] & ~A[1] & A[0]);
	assign DISP[4] = (~A[3] & A[0]) | (~A[2] & ~A[1] & A[0]) + (~A[3] & A[2] & ~A[1]);
	assign DISP[3] = (~A[2] & ~A[1] & A[0]) | (A[2] & A[1] & A[0]) | (~A[3] & A[2] & ~A[1] & ~A[0]) | (A[3] & ~A[2] & A[1] & ~A[0]);
	assign DISP[2] = (A[3] & A[2] & ~A[0]) | (A[3] & A[2] & A[1]) | (~A[3] & ~A[2] & A[1] & ~A[0]);
	assign DISP[1] = (A[2] & A[1] & ~A[0]) | (A[3] & A[1] & A[0]) | (A[3] & A[2] & ~A[0]) | (~A[3] & A[2] & ~A[1] & A[0]);
	assign DISP[0] = (~A[3] & ~A[2] & ~A[1] & A[0]) | (~A[3] & A[2] & ~A[1] & ~A[0]) | (A[3] & ~A[2] & A[1] & A[0]) | (A[3] & A[2] & ~A[1] & A[0]);

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

	