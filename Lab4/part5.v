module part5(input [9:0] SW, output [0:6] HEX5, HEX3, HEX1, HEX0);
	wire [3:0] A, B;
	wire Cin;
	assign Cin = SW[8];
	assign A = SW[7:4];
	assign B = SW[3:0];
	
	binary_to_7seg U0 (A, HEX5);
	binary_to_7seg U1 (B, HEX3);
	
	reg T0, Z0, C1, S1, S0;
	always @ (T0, A, B, Cin, Z0, C1, S1, S0)
	begin
		T0 = (A[3] + B[3])*8 + (A[2] + B[2])*4 + (A[1] + B[1])*2 + A[0] + B[0] + Cin;
		
		if (T0 > 9)
		begin
			Z0 = 10;
			C1 = 1;
		end
		
		else
		begin
			Z0 = 0;
			C1 = 0;
		end
		
		S0 = T0 - Z0;
		S1 = C1;
			
	end
	
	decimal_to_7seg(S0, HEX0);
	decimal_to_7seg(S1, HEX1);
endmodule

module decimal_to_7seg(input S, output [0:6] DISP);
	reg [3:0]V;
	always @ (S, V)
	begin
		if (S == 0)
		begin
			V[3] = 0;
			V[2] = 0;
			V[1] = 0;
			V[0] = 0;
		end
		
		else if (S == 1)
		begin
			V[3] = 0;
			V[2] = 0;
			V[1] = 0;
			V[0] = 1;
		end
		
		else if (S == 2)
		begin
			V[3] = 0;
			V[2] = 0;
			V[1] = 1;
			V[0] = 0;
		end
		
		else if (S == 3)
		begin
			V[3] = 0;
			V[2] = 0;
			V[1] = 1;
			V[0] = 1;
		end
		
		else if (S == 4)
		begin
			V[3] = 0;
			V[2] = 1;
			V[1] = 0;
			V[0] = 0;
		end
		
		else if (S == 5)
		begin
			V[3] = 0;
			V[2] = 1;
			V[1] = 0;
			V[0] = 1;
		end
		
		else if (S == 6)
		begin
			V[3] = 0;
			V[2] = 1;
			V[1] = 1;
			V[0] = 0;
		end
		
		else if (S == 7)
		begin
			V[3] = 0;
			V[2] = 1;
			V[1] = 1;
			V[0] = 1;
		end
		
		else if (S == 8)
		begin
			V[3] = 1;
			V[2] = 0;
			V[1] = 0;
			V[0] = 0;
		end
		
		else if (S == 9)
		begin
			V[3] = 1;
			V[2] = 0;
			V[1] = 0;
			V[0] = 1;
		end
		
	end
	
	binary_to_7seg(V, DISP);
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


