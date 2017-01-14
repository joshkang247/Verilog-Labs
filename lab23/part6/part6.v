module part6(SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [1:0] M0, M1, M2, M3, M4, M5, T;
	
	assign T[0] = 1'b1;
	assign T[1] = 1'b1;
	
	
	assign LEDR[9:7] = SW[9:7];
	
	/*
	mux_2bit_6to1 U0 (T, T, T, SW[5:4], SW[3:2], SW[1:0], SW[9:7], M0);
	char_7seg H0 (M0, HEX0);
	
	mux_2bit_6to1 U0 (T, T, SW[5:4], SW[3:2], SW[1:0], T, SW[9:7], M1);
	char_7seg H1 (M1, HEX1);
	
	mux_2bit_6to1 U0 (T, SW[5:4], SW[3:2], SW[1:0], T, T, SW[9:7], M2);
	char_7seg H2 (M2, HEX2);
	
	mux_2bit_6to1 U0 (T, SW[5:4], SW[3:2], SW[1:0], T, T, SW[9:7], M2);
	char_7seg H2 (M2, HEX2);
	*/
	
	
	mux_2bit_6to1 U0 (SW[9:7], T, T, T, SW[5:4], SW[3:2], SW[1:0], M0);
	char_7seg H0 (M0, HEX5);
	
	mux_2bit_6to1 U1 (SW[9:7], T, T, SW[5:4], SW[3:2], SW[1:0], T, M1);
	char_7seg H1 (M1, HEX4);
	
	mux_2bit_6to1 U2 (SW[9:7], T, SW[5:4], SW[3:2], SW[1:0], T, T, M2);
	char_7seg H2 (M2, HEX3);
	
	mux_2bit_6to1 U3 (SW[9:7], SW[5:4], SW[3:2], SW[1:0], T, T, T, M3);
	char_7seg H3 (M3, HEX2);
	
	mux_2bit_6to1 U4 (SW[9:7], SW[3:2], SW[1:0], T, T, T, SW[5:4], M4);
	char_7seg H4 (M4, HEX1);
	
	mux_2bit_6to1 U5 (SW[9:7], SW[1:0], T, T, T, SW[5:4], SW[3:2], M5);
	char_7seg H5 (M5, HEX0);
	
endmodule

/*
module mux_2bit_3to1 (S, U, V, W, M);
	input[1:0] S, U, V, W;
	output[1:0] M;
	//assign M[0] = ((~S[1] & ~S[0]) & U[0]) | ((~S[1] & S[0]) & V[0]) | ((S[1] & ~S[0]) & W[0]) | ((S[1] & S[0]));
	//assign M[1] = ((~S[1] & ~S[0]) & U[1]) | ((~S[1] & S[0]) & V[1]) | ((S[1] & ~S[0]) & W[1]) | ((S[1] & S[0]));
	
	assign M[1] = (~S[1] & ((~S[0] & U[1])|(S[0] & V[1]) )|(S[1] & ( (S[0])|(~S[0] & W[1]) )) );
	assign M[0] = (~S[1] & ((~S[0] & U[0])|(S[0] & V[0]) )|(S[1] & ( (S[0])|(~S[0] & W[0]) )) );
endmodule
*/

module mux_2bit_6to1 (S, U, V, W, X, Y, Z, M);
	input[1:0] U, V, W, X, Y, Z;
	input[2:0] S;
	output[1:0] M;
	
	assign M[1] = ((~S[0] & ~S[1] & ~S[2]) & U[1])|((~S[0] & ~S[1] & S[2]) & V[1])|((~S[0] & S[1] & ~S[2]) & W[1])|((~S[0] & S[1] & S[2]) & X[1])|((S[0] & ~S[1] & ~S[2]) & Y[1])|((S[0] & ~S[1] & S[2]) & Z[1]);
	assign M[0] = ((~S[0] & ~S[1] & ~S[2]) & U[0])|((~S[0] & ~S[1] & S[2]) & V[0])|((~S[0] & S[1] & ~S[2]) & W[0])|((~S[0] & S[1] & S[2]) & X[0])|((S[0] & ~S[1] & ~S[2]) & Y[0])|((S[0] & ~S[1] & S[2]) & Z[0]);
endmodule
	
	
module char_7seg (C, Display);	
	input[1:0] C; 
	output[0:6] Display;
	assign Display[0] = ~C[0]| C[1];
	assign Display[1] = C[0];
	assign Display[2] = C[0];
	assign Display[3] = C[1];
	assign Display[4] = C[1];
	assign Display[5] = ~C[0]| C[1];
	assign Display[6] = C[1];
endmodule

	
	
	