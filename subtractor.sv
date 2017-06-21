module subtractor (input logic [5:0]A, 
						input logic [5:0]B,
						output logic [5:0]out_Val,
						output logic nA_LED, nB_LED, nR_LED,
						output logic over_LED);
						
logic [5:0]new_B;
assign new_B = (~B+1'b1);
		
assign out_Val = A + (~B+1'b1);

// Checking for Overflow
always_comb
begin
	if (A[5] == 1'b0 && new_B[5] == 1'b0 && out_Val[5] == 1'b1)
		over_LED = 1'b1;
	else if (A[5] == 1'b1 && new_B[5] == 1'b1 && out_Val[5] == 1'b0)
		over_LED = 1'b1;
	else
		over_LED = 1'b0;
end

// Checking for Negative Results
always_comb
begin
	if (out_Val[5] == 1'b1)
		nR_LED = 1'b1;
	else
		nR_LED = 1'b0;
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
