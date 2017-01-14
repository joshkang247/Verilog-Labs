module part2(input [9:0] SW, output [0:6] HEX0, HEX1);
	wire [3:0]Z, G, Y;
	assign Z[0] = (SW[3] & SW[2]) | (SW[3] & SW[1]);
	assign Z[1] = 0;
	assign Z[2] = 0;
	assign Z[3] = 0;
	
	binary_to_7seg U0 (Z, HEX1);
	circuitA A0 (SW[2:0], G);
	mux_4bit_2to1 B0 (Z[0], SW[3:0], G, Y);
	binary_to_7seg U1 (Y, HEX0);
	
endmodule
	
module mux_4bit_2to1(input S, input [3:0] V, A, output [3:0] F);
	assign F[0] = (~S & V[0]) | (S & A[0]);
	assign F[1] = (~S & V[1]) | (S & A[1]);
	assign F[2] = (~S & V[2]) | (S & A[2]);
	assign F[3] = (~S & V[3]) | (S & A[3]);
	
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

