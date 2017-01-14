module part3 (input [9:0] SW, input [3:0] KEY, input CLOCK_50, output reg [9:0] LEDR);
	wire start, reset;
	
	assign start = KEY[1];
	assign reset = KEY[0];
	
	reg [25:0] count;	
	reg [2:0] counter;
	
	reg [3:0] y, Y, Q;
	wire [3:0] m;
	wire [2:0] length;
	letter_to_morse A1(SW[2:0], m, length);
	
	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;
	
	always @(Q[3], start, reset, counter, y) 							
	begin: state_table
		case (y)
			// State A = Idle State 
			A: if (start) Y = B; 
				else Y = A; 
			  
			B: if (!Q[3]) Y = E; 
				else Y = C; 
		
			C: if (reset) Y = A; 
				else Y = D;			
			D: if (reset) Y = A; 
				else Y = E;			 
			 
			E: if (counter == 0) Y = A; 
				else Y = B;					
		endcase
	end	//state table
	

	
	always @(posedge CLOCK_50)
	begin
		if (reset)
		begin
			count <= 0;
			Q <= 4'b 0;
			y <= 4'b 0;
		end
		else
		begin
			if (count < 50000000)  
				count <= count + 1;
			else
			begin
				count <= 0;
				y <= Y;  
				if (Y == A) begin 
					counter <= length;
					Q <= m;
				end
				if (Y == E) begin    
					counter <= counter - 1; 
					 
					Q[3] = Q[2];
					Q[2] = Q[1];
					Q[1] = Q[0];
					Q[0] = 1'b 0;
				end
			end
		end
	end
	
	always @(y)
	if ((y==B)|(y==C)|(y==D))
		LEDR[0] = 1;
	else
		LEDR[0] = 0;
	
endmodule

module letter_to_morse(input [2:0] D, output reg[3:0] morse, output reg[2:0] length);
	parameter	WA = 3'b 000, WB = 3'b 001, WC = 3'b 010,
					WD = 3'b 011, WE = 3'b 100, WF = 3'b 101,
					WG = 3'b 110, WH = 3'b 111;
	always @(D)
		case (D)
		WA:begin 	morse = 4'b 0100;
						length = 3'b 010; end
			
		WB:begin 	morse = 4'b 1000;
						length = 3'b 100; end
			
		WC:begin		morse = 4'b 1010;
						length = 3'b 100; end
			
		WD:begin 	morse = 4'b 1000;
						length = 3'b 011; end
			
		WE:begin 	morse = 4'b 0000;
						length = 3'b 001; end
			
		WF:begin 	morse = 4'b 0010;
						length = 3'b 100; end
			
		WG:begin		morse = 4'b 1100;
						length = 3'b 011; end
			
		WH:begin		morse = 4'b 0000;
						length = 3'b 100; end
		endcase
endmodule







