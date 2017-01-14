module part1 (input D, Clk, output reg Qa, Qb, Qc);
	
	always @ (D, Clk)
		if (Clk == 1)
			Qa = D;
	
	
	always @ (posedge Clk)
		Qb <= D;
		
	
	always @ (negedge Clk)
		Qc <= D;
endmodule