module toplevel_lab7 (input logic clock,
								input logic [2:0] instruct,
								input logic [5:0] A, B,
								input logic button, mode, rst,
								output logic nA_LED, nB_LED, nR_LED, over_LED, LED_full, LED_empty,
								output logic [6:0] DA7, DA6, DA5, DA4, DA3, DA2);
						
	logic [2:0] out_instruct, r_addr, w_addr;
	logic rise, ren, wen, full, empty, rstsync;
	logic [14:0] dataOut;
	logic [5:0] in_A, in_B;
	logic [5:0] result, result_Add, result_Sub, result_equal, result_greater, result_less, result_zero;
	logic [6:0] display7, display6, display5, display4, display3, display2;
	logic nA_LED_Add, nB_LED_Add, nR_LED_Add, over_LED_Add;
	logic nA_LED_Sub, nB_LED_Sub, nR_LED_Sub, over_LED_Sub;
	logic nA_LED_Great, nB_LED_Great, nA_LED_Less, nB_LED_Less, nA_LED_Equal, nB_LED_Equal, nA_LED_Zero;
	
	/*always_ff @ (posedge clock)
	begin
		if (!rstsync)
			dataOut <= 15'd0;
	end*/
	
	always_comb
		if (out_instruct == 3'b000)
			result = result_Add;
		else if (out_instruct == 3'b001)
			result = result_Sub;
		else if (out_instruct == 3'b100)
			result = result_equal;
		else if (out_instruct == 3'b101)
			result = result_greater;
		else if (out_instruct == 3'b110)
			result = result_less;
		else
			result = result_zero;
			
	always_ff @ (posedge clock or negedge rstsync)
	begin
	if (!rstsync)
		begin
			nA_LED <= 1'b0;
			nB_LED <= 1'b0;
			nR_LED <= 1'b0;
			over_LED <= 1'b0;
			DA7 <= 7'b1000000;
			DA6 <= 7'b1000000;
			DA5 <= 7'b1000000;
			DA4 <= 7'b1000000;
			DA3 <= 7'b1000000;
			DA2 <= 7'b1000000;
		end
	else if (out_instruct == 3'b000)
		begin
			nA_LED <= nA_LED_Add;
			nB_LED <= nB_LED_Add;
			nR_LED <= nR_LED_Add;
			over_LED <= over_LED_Add;
			DA7 <= display7;
			DA6 <= display6;
			DA5 <= display5;
			DA4 <= display4;
			DA3 <= display3;
			DA2 <= display2;
		end
	else if (out_instruct == 3'b001)
		begin
			nA_LED <= nA_LED_Sub;
			nB_LED <= nB_LED_Sub;
			nR_LED <= nR_LED_Sub;
			over_LED <= over_LED_Sub;
			DA7 <= display7;
			DA6 <= display6;
			DA5 <= display5;
			DA4 <= display4;
			DA3 <= display3;
			DA2 <= display2;
		end
	else if (out_instruct == 3'b100)
		begin
			nA_LED <= nA_LED_Equal;
			nB_LED <= nB_LED_Equal;
			nR_LED <= 1'b0;
			over_LED <= 1'b0;
			DA7 <= display7;
			DA6 <= display6;
			DA5 <= display5;
			DA4 <= display4;
			DA3 <= display3;
			DA2 <= display2;
		end
	else if (out_instruct == 3'b101)
		begin
			nA_LED <= nA_LED_Great;
			nB_LED <= nB_LED_Great;
			nR_LED <= 1'b0;
			over_LED <= 1'b0;
			DA7 <= display7;
			DA6 <= display6;
			DA5 <= display5;
			DA4 <= display4;
			DA3 <= display3;
			DA2 <= display2;
		end
	else if (out_instruct == 3'b110)
		begin
			nA_LED <= nA_LED_Less;
			nB_LED <= nB_LED_Less;
			nR_LED <= 1'b0;
			over_LED <= 1'b0;
			DA7 <= display7;
			DA6 <= display6;
			DA5 <= display5;
			DA4 <= display4;
			DA3 <= display3;
			DA2 <= display2;
		end
	else
		begin
			nA_LED <= nA_LED_Zero;
			nB_LED <= 1'b0;
			nR_LED <= 1'b0;
			over_LED <= 1'b0;
			DA7 <= display7;
			DA6 <= display6;
			DA5 <= display5;
			DA4 <= display4;
			DA3 <= display3;
			DA2 <= display2;
		end
	end
	
	assign LED_full = full;
	assign LED_empty = empty;
	assign in_A = dataOut[14:9];
	assign in_B = dataOut[8:3];

	fsm_lab7 module1 (.clock(clock), .mode(mode), .rstsync(rstsync), .dataOut(dataOut), .out_instruct(out_instruct));
	
	fsm_rw_lab7 module11 (.clock(clock), .mode(mode), .button(rise), .rstsync(rstsync), .ren(ren), .wen(wen), 
								.empty(empty), .full(full), .r_addr(r_addr), .w_addr(w_addr));
	
	synchronizer_lab7 module2 (.clock(clock), .button(button), .rstsync(rstsync), .rise(rise));
	
	memory module3 (.clock(clock), .ren(ren), .wen(wen), .dataIn({A, B, instruct}), .wrAddr(w_addr),
							.rdAddr(r_addr), .dataOut(dataOut));
							
	adder module4 (.A(in_A), .B(in_B), .out_Val(result_Add), .nA_LED(nA_LED_Add), .nB_LED(nB_LED_Add), 
						.nR_LED(nR_LED_Add), .over_LED(over_LED_Add));
				
	subtractor module5 (.A(in_A), .B(in_B), .out_Val(result_Sub), .nA_LED(nA_LED_Sub), .nB_LED(nB_LED_Sub), 
						.nR_LED(nR_LED_Sub), .over_LED(over_LED_Sub));
						
	equal module6 (.A(in_A), .B(in_B), .result(result_equal), .nA_LED(nA_LED_Equal), .nB_LED(nB_LED_Equal));
	
	greater module7 (.A(in_A), .B(in_B), .result(result_greater), .nA_LED(nA_LED_Great), .nB_LED(nB_LED_Great));
	
	less module8 (.A(in_A), .B(in_B), .result(result_less), .nA_LED(nA_LED_Less), .nB_LED(nB_LED_Less));
	
	zero module9 (.A(in_A), .result(result_zero), .nA_LED(nA_LED_Zero));
	
	display module10 (.A(in_A), .B(in_B), .result(result), .DA7(display7), .DA6(display6), .DA5(display5), 
							.DA4(display4), .DA3(display3), .DA2(display2));
							
	reset_lab7 module12 (.clock(clock), .rst(rst), .rstsync(rstsync));
							
endmodule
