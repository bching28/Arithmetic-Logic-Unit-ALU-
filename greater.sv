module greater (input logic [5:0]A, 
					input logic [5:0]B,
					output logic [5:0]result,
					output logic nA_LED, nB_LED);

	logic [5:0]new_A;
	logic [5:0]new_B;
						
	always_comb
	begin
		if (A[5] == 1'b1)
			new_A = ~A+1'b1;
		else
			new_A = A;
	end

	always_comb
	begin
		if (B[5] == 1'b1)
			new_B = ~B+1'b1;
		else
			new_B = B;
	end

	always_comb
	begin
		if (A[5] == B[5] && A[5] == 1'b0)
			begin
				if (new_A > new_B)
					result = 6'd1;
				else
					result = 6'd0;
			end
		else if (A[5] == B[5] && A[5] == 1'b1)
			begin
				if (new_A > new_B)
					result = 6'd0;
				else
					result = 6'd1;
			end
		else if (A[5] == 1'b1 && B[5] == 1'b0)
			begin
				result = 6'd0;
			end
		else
			begin
				result = 6'd1;
			end
	end
	
	// Checking for Negative A
	always_comb
	begin
		if (A[5] == 1'b1)
			nA_LED = 1'b1;
		else
			nA_LED = 1'b0;
	end

	// Checking for Negative B
	always_comb
	begin
		if (B[5] == 1'b1)
			nB_LED = 1'b1;
		else
			nB_LED = 1'b0;
	end
					
endmodule
