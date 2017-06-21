module equal (input logic [5:0]A, B,
					output logic [5:0] result,
					output logic nA_LED, nB_LED);

always_comb
begin					
	if (A == B)
		result = 6'd1; // true
	else
		result = 6'd0; // false
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
