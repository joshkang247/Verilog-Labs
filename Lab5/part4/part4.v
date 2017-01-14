module part4(input [3:0] KEY, input [9:0] SW, output [0:6] HEX3, HEX2, HEX1, HEX0);
	wire [15:0] count;
	counter_16bit(SW[1], KEY[0], SW[0], count);
	
	binary_to_7seg_hex(count[15:12], HEX3);
	binary_to_7seg_hex(count[11:8], HEX2);
	binary_to_7seg_hex(count[7:4], HEX1);
	binary_to_7seg_hex(count[3:0], HEX0);

endmodule


module counter_16bit(input enable, clock, clear, output reg [15:0] count);

	always @ (negedge clear, posedge clock)
		if (clear == 0)
			count <= 16'b 0;
		else if (enable)
			if (count == 65535)
				count <= 16'b 0;
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