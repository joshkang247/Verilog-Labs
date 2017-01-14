module part4(input [9:0] SW, output [9:0] LEDR, output [0:6] HEX5, HEX3, HEX1, HEX0);
	wire [3:0] X, Y, L, K, B, D1, D0;
	wire [4:0] V;
	wire Cin;
	assign Cin = SW[8];
	assign X = SW[7:4];
	assign Y = SW[3:0];
	
	binary_to_7seg U0 (X, HEX5);
	binary_to_7seg U1 (Y, HEX3);
	
	four_bit_full_adder J0 (X, Y, Cin, LEDR);
	
	assign V = LEDR[4:0];
	
	circuitA A0 (V[2:0], L);
	
	mux_4bit_2to1 C0 (D1[0], V[3:0], L, K);
	
	circuitB B0 (V[3:0], B);
	
	mux_4bit_2to1 C1 (V[4], K, B, D0);
	
	assign D1[0] = V[4] | (V[3] & V[2]) | (V[3] & V[1]);
	assign D1[1] = 0;
	assign D1[2] = 0;
	assign D1[3] = 0;
	
	binary_to_7seg U2 (D1, HEX1);
	binary_to_7seg U3 (D0, HEX0);
	
endmodule
	
module mux_4bit_2to1(input S, input [3:0] V, A, output [3:0] F);
	assign F[0] = (~S & V[0]) | (S & A[0]);
	assign F[1] = (~S & V[1]) | (S & A[1]);
	assign F[2] = (~S & V[2]) | (S & A[2]);
	assign F[3] = (~S & V[3]) | (S & A[3]);
	
endmodule

module circuitB(input [3:0] M, output [3:0] B);
	assign B[3] = ~M[3] & ~M[2] & M[1];
	assign B[2] = ~M[3] & ~M[2] & ~M[1];
	assign B[1] = B[2];
	assign B[0] = ~M[3] & ~M[2] & M[0];
	
endmodule
	
module circuitA(input [2:0] X, output [3:0] F);
	assign F[3] = 0;
	assign F[2] = X[2] & X[1];
	assign F[1] = X[2] & ~X[1];
	assign F[0] = (X[1] & X[0]) | (X[2] & X[0]);
	
endmodule

module binary_to_7seg(input [3:0] V, output [0:6] DISP);
	assign DISP[0] = (V[2] & ~V[1] & ~V[0]) | (~V[3] & ~V[2] & ~V[1] & V[0]);
	assign DISP[1] = (V[2] & ~V[1] & V[0]) | (V[2] & V[1] & ~V[0]);
	assign DISP[2] = ~V[2] & V[1] & ~V[0];
	assign DISP[3] = (V[3] & V[0]) | (V[2] & ~V[1] & ~V[0]) | (~V[2] & ~V[1] & V[0]) | (V[2] & V[1] & V[0]);
	assign DISP[4] = V[0] | (V[2] & ~V[1]);
	assign DISP[5] = (V[1] & V[0]) | (~V[3] & ~V[2] & V[0]) | (~V[3] & ~V[2] & V[1]);
	assign DISP[6] = (V[2] & V[1] & V[0]) | (~V[3] & ~V[2] & ~V[1]);
	
endmodule

module four_bit_full_adder(input [3:0] A, B, input Cin, output [9:0] F);
	wire [2:0] C;
	
	full_adder A0 (Cin, A[0], B[0], F[0], C[0]);
	full_adder A1 (C[0], A[1], B[1], F[1], C[1]);
	full_adder A2 (C[1], A[2], B[2], F[2], C[2]);
	full_adder A3 (C[2], A[3], B[3], F[3], F[4]);
	
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