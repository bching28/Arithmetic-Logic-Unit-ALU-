module toplevel_testbench();

	// DUT signals
	logic clock = 1'b0;
	logic [2:0] instruct;
	logic [5:0] A, B;
	logic button = 1'b0;
	logic mode, rst;
	logic nA_LED, nB_LED, nR_LED, over_LED, LED_full, LED_empty;
	logic [6:0] DA7, DA6, DA5, DA4, DA3, DA2;

	// Connect device to check
	toplevel_lab7 dutlab7(.clock(clock), .instruct(instruct), .A(A), .B(B), .button(button), .mode(mode), .rst(rst), .nA_LED(nA_LED), .nB_LED(nB_LED), 
				.nR_LED(nR_LED), .over_LED(over_LED), .LED_full(LED_full), .LED_empty(LED_empty), .DA7(DA7), .DA6(DA6), .DA5(DA5), .DA4(DA4), .DA3(DA3), .DA2(DA2));
		
	// Generate clock
	always #50 clock <= ~clock;
	
	// Generate inputs
	
	// Create task to loop through all possible combinations
	task Write(input logic [2:0]instruct_test, input logic [5:0]in_A, input logic [5:0]in_B, input logic mode_test, input logic rst_test);
		@(negedge clock);
		mode <= mode_test;
		instruct <= instruct_test;
		A <= in_A;
		B <= in_B;
		rst <= rst_test;
		repeat(3)@(negedge clock);
		button <= 1'b1;
		repeat(3)@(negedge clock);
		button <= 1'b0;
		repeat(5)@(negedge clock);
		//@(posedge clock);
		//check: assert() $display("Output correct!");
		
	endtask

	task Read(input logic mode_test, input logic rst_test);
		@(negedge clock)
		mode <= mode_test;
		rst <= rst_test;
		repeat(3) @ (negedge clock);
		button <= 1'b1;
		repeat(3) @ (negedge clock);
		button <= 1'b0;
		repeat(5) @ (negedge clock);
	endtask

	initial
		begin
			Write(3'b000, -6'd5, -6'd7, 1'b1, 1'b1); // ADD: -5 + (-7) = -12
			Write(3'b001, 6'd30, 6'd6, 1'b1, 1'b0); // SUB: 30 - 6 = 24
			Write(3'b100, 6'd23, 6'd23, 1'b1, 1'b1); // EQUAL: 23 = 23
			//Write(3'b100, 6'd28, 6'd23, 1'b1); // EQUAL: 28 != 23
			/*Write(3'b101, 6'd23, 6'd18, 1'b1); // GREATER: 23 > 18
			Write(3'b101, -6'd29, 6'd27, 1'b1); // GREATER: -29 !> 27
			Write(3'b110, -6'd13, 6'd14, 1'b1); // LESS: -13 < 14
			Write(3'b110, 6'd13, 6'd13, 1'b1); // LESS: 13 !< 13
			Write(3'b111, 6'd0, 6'd32, 1'b1); // ZERO: A = 0
			Write(3'b111, 6'd1, 6'd32, 1'b1); // ZERO: A != 0 SHOULD NOT WORK CAUSE FULL

			Read(1'b0);
			Read(1'b0);
			Read(1'b0);
			Read(1'b0);
			Read(1'b0);
			Read(1'b0);*/
			//rst <= 1'b1;
			//repeat(3) @ (negedge clock);
			//Read(1'b0, 1'b0);
			Read(1'b0, 1'b1);
			Read(1'b0, 1'b1);
			Read(1'b0, 1'b1);
			//Read(1'b0, 1'b0);
			//Read(1'b0);
			button <= 1'b1;
			repeat(3) @ (negedge clock);
			button <= 1'b0;
			repeat(5) @ (negedge clock);
			/*Write(3'b101, -6'd29, 6'd27, 1'b1, 1'b1); // GREATER: -29 !> 27
			Write(3'b110, -6'd13, 6'd14, 1'b1, 1'b1); // LESS: -13 < 14
			Write(3'b000, -6'd5, -6'd7, 1'b1, 1'b1); // ADD: -5 + (-7) = -12
			Write(3'b001, 6'd30, 6'd6, 1'b1, 1'b1); // SUB: 30 - 6 = 24
			Write(3'b100, 6'd23, 6'd23, 1'b1, 1'b1); // EQUAL: 23 = 23
			Write(3'b100, 6'd28, 6'd23, 1'b1, 1'b1); // EQUAL: 28 != 23
			Write(3'b101, 6'd23, 6'd18, 1'b1, 1'b1); // GREATER: 23 > 18
			Write(3'b101, -6'd29, 6'd27, 1'b1, 1'b1); // GREATER: -29 !> 27
			Write(3'b110, -6'd13, 6'd14, 1'b1, 1'b1); // LESS: -13 < 14
			Read(1'b0, 1'b1);
			Read(1'b0, 1'b1);
			Read(1'b0, 1'b1);
			Read(1'b0, 1'b0);*/
			repeat(10)@(negedge clock) #1;
			$stop;
		end
endmodule
