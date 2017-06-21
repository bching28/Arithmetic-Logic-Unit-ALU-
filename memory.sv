module memory(input logic clock, ren, wen,
						input logic [14:0] dataIn,
						input logic [2:0] wrAddr, rdAddr,
						output logic [14:0] dataOut);

	logic [14:0] memory [7:0];
	
	initial
	begin
		for (int i=15'b0; i<15'd8; i++)
			memory[i] <= i;
	end

	always_ff @(posedge clock)
		begin
		if(wen)
			memory[wrAddr] <= dataIn;
			
		if(ren)
			dataOut <= memory[rdAddr];
		end
	
endmodule
