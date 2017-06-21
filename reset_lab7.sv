module reset_lab7(input logic clock, rst,
						output logic rstsync);
	
	logic intRst;
	always_ff@(posedge clock or negedge rst)
		if (!rst)
			begin
				intRst <= 1'b0;
				rstsync <= 1'b0;
			end
		else
			begin
				intRst <= 1'b1;
				rstsync <= intRst;
			end
endmodule

			