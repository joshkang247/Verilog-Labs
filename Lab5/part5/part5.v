module part5(input [9:0] SW, input CLOCK_50, output [0:6] HEX0);
	
	wire [25:0] count1;
	wire [3:0] count2;
	counter_50million U0(SW[1], CLOCK_50, SW[0], count1);
	
	reg enable;
	always @ (count1, enable)
		if (count1 == 50000000)
			enable = 1'b 1;
		else
			enable = 1'b 0;
	
	counter_4bit N0(enable, CLOCK_50, SW[0], count2);
	
	binary_to_7seg_hex(count2, HEX0);
endmodule

module counter_50million(input enable, clock, clear, output reg [25:0] count);
	always @ (negedge clear, posedge clock)
		if (clear == 0)
			count <= 26'b 0;
		else if (enable)
			if (count == 50000000)
				count <= 26'b 0;
			else
				count <= count + 1;
endmodule 

module counter_4bit(input enable, clock, clear, output reg [3:0] count);
	always @ (negedge clear, posedge clock)
		if (clear == 0)
			count <= 4'b 0;
		else if (enable)
			if (count == 9)
				count <= 4'b 0;
			else
				count <= count + 1;
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