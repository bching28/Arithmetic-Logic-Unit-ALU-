module synchronizer_lab7 (input logic clock,
									input logic button, rstsync,
									output logic rise);

	logic in_ff1, in_ff2, in_ff3; // in_ff2 == in_sync1, in_ff3 == in_sync2
	
	assign rise = (in_ff2 && !in_ff3);
	
	always_ff @ (posedge clock or negedge rstsync)
	begin
		if (rstsync == 1'b0)
			begin
			in_ff1 <= 1'b0;
			in_ff2 <= 1'b0;
			in_ff3 <= 1'b0;
			end
		else
			begin
			in_ff1 <= button;
			in_ff2 <= in_ff1;
			in_ff3 <= in_ff2;
			end
	end
	
endmodule
