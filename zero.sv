module zero ( input logic [5:0]A,
					output logic [5:0]result,
					output logic nA_LED);

always_comb
begin				
	if (A == 6'd0)
		result = 6'd1;
	else
		result = 6'd0;
end

// Checking for Negative A
	always_comb
	begin
		if (A[5] == 1'b1)
			nA_LED = 1'b1;
		else
			nA_LED = 1'b0;
	end
					
endmodule
