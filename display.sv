module display ( input logic [5:0]A,
						input logic [5:0]B,
						input logic [5:0]result,
						output logic [6:0]DA7, // A
						output logic [6:0]DA6,
						output logic [6:0]DA5, // B
						output logic [6:0]DA4,
						output logic [6:0]DA3, // Result
						output logic [6:0]DA2);

// For Result
logic [5:0]new_result;
logic [3:0]digit_1; // first digit (tens)
logic [3:0]digit_2; // second digit (ones)
logic [6:0]display_1; // 7 segment display
logic [6:0]display_2;	

// For A
logic [5:0]new_A;
logic [3:0]digit_1A;
logic [3:0]digit_2A;			
logic [6:0]display_1A;
logic [6:0]display_2A;

// For B	
logic [5:0]new_B;
logic [3:0]digit_1B;
logic [3:0]digit_2B;	
logic [6:0]display_1B;
logic [6:0]display_2B;


// Results	
always_comb
begin
	if (result[5] == 1'b1)
		new_result = ~result+1'b1;
	else
		new_result = result;
end
					
assign digit_1 = new_result/4'd10; // tens 
assign digit_2 = new_result%4'd10; // ones			
						
decimal firstR (.digit(digit_1), .display(display_1));
assign DA3 = display_1;

decimal secondR (.digit(digit_2), .display(display_2));
assign DA2 = display_2;


// A 
// 2's Complement
always_comb
begin
	if (A[5] == 1'b1)
		new_A = ~A+1'b1;
	else
		new_A = A;
end

// 7-segments
assign digit_1A = new_A/4'd10;
assign digit_2A = new_A%4'd10;

decimal firstA (.digit(digit_1A), .display(display_1A));
assign DA7 = display_1A;

decimal secondA (.digit(digit_2A), .display(display_2A));
assign DA6 = display_2A;


// B
// 2's Complement
always_comb
begin
	if (B[5] == 1'b1)
		new_B = ~B+1'b1;
	else
		new_B = B;
end

// 7-segments
assign digit_1B = new_B/4'd10;
assign digit_2B = new_B%4'd10;

decimal firstB (.digit(digit_1B), .display(display_1B));
assign DA5 = display_1B;

decimal secondB (.digit(digit_2B), .display(display_2B));
assign DA4 = display_2B;
		
endmodule
