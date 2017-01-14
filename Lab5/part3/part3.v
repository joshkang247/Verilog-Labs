module part3(input [3:0] KEY, input [9:0] SW, output [0:6] HEX1, HEX0);
	
	wire [7:0] count;
	
	counter_8bit(SW[1], KEY[0], SW[0], count);
	
	binary_to_7seg_hex(count[3:0], HEX0);
	binary_to_7seg_hex(count[7:4], HEX1);
endmodule


module counter_8bit(input enable, clock, clear, output [7:0] count);
		
	tflipflop U0 (enable, clock, clear, count[0]);
	tflipflop U1 ((enable & count[0]), clock, clear, count[1]);
	tflipflop U2 ((count[0] & count[1]), clock, clear, count[2]);
	tflipflop U3 ((count[0] & count[1] & count[2]), clock, clear, count[3]);
	tflipflop U4 ((count[0] & count[1] & count[2] & count[3]), clock, clear, count[4]);
	tflipflop U5 ((count[0] & count[1] & count[2] & count[3] & count[4]), clock, clear, count[5]);
	tflipflop U6 ((count[0] & count[1] & count[2] & count[3] & count[4] & count[5]), clock, clear, count[6]);
	tflipflop U7 ((count[0] & count[1] & count[2] & count[3] & count[4] & count[5] & count[6]), clock, clear, count[7]);
	
endmodule


module tflipflop(Enable, Clock, Resetn, Q);
	input Enable, Clock, Resetn;
	output reg Q;
	wire D;
	assign D = Enable ^ Q;

	always @ (negedge Resetn, posedge Clock)
		if (Resetn == 0)
			Q <= 1'b 0;
		else 
		
			Q <= D;
			
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