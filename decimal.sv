module decimal (input logic [3:0]digit,
						output logic [6:0]display);

always_comb
begin						
	if (digit == 4'd0)						
		display = 7'b1000000; // 0
	else if (digit == 4'd1)
		display = 7'b1111001; // 1
	else if (digit == 4'd2)
		display = 7'b0100100; // 2
	else if (digit == 4'd3)
		display = 7'b0110000; // 3
	else if (digit == 4'd4)
		display = 7'b0011001; // 4
	else if (digit == 4'd5)
		display = 7'b0010010; // 5
	else if (digit == 4'd6)
		display = 7'b0000010; // 6
	else if (digit == 4'd7)
		display = 7'b1111000; // 7
	else if (digit == 4'd8)
		display = 7'b0000000; // 8
	else if (digit == 4'd9)
		display = 7'b0010000; // 9
	else
		display = 7'b1111111; // nothing
end

endmodule
