module part2 (input [9:0] SW, input [3:0] KEY, output [9:0] LEDR);
	reg [3:0] y, Y;
	wire w, z, resetn, Clock;
	assign Clock = KEY[0];
	assign resetn = SW[0];
	assign w = SW[1];
	assign LEDR[3:0] = y;
	assign LEDR[9] = z;
	parameter 	A = 4'b 0000, B = 4'b 0001, C = 4'b 0010, D = 4'b 0011,
					E = 4'b 0100, F = 4'b 0101, G = 4'b 0110, H = 4'b 0111,
					I = 4'b 1000;
					
	always @(w, y)
	begin: state_table
		case(y)
			A: if (~w) Y = B;
				else Y = F;
				
			B: if (~w) Y = C;
				else Y = F;
			
			C: if (~w) Y = D;
				else Y = F;
			
			D: if (~w) Y = E;
				else Y = F;
			
			E: if (~w) Y = E;
				else Y = F;
			
			F: if (~w) Y = B;
				else Y = G;
				
			G: if (~w) Y = B;
				else Y = H;
				
			H: if (~w) Y = B;
				else Y = I;
				
			I: if (~w) Y = B;
				else Y = I;
			
			endcase
	end // state_table
	
	always @ (posedge Clock)
	begin: state_FFs
		if (!resetn)
			y <= A;
		else
			y <= Y;
	end // state_FFs
	assign z = ((y==E)|(y==I));
	
endmodule
