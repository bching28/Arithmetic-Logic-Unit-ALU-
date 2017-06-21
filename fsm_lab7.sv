module fsm_lab7 (input logic clock,
						input logic mode, rstsync,
						input logic [14:0]dataOut,
						output logic [2:0]out_instruct);
				
logic [2:0]instruct;
		
typedef enum logic [2:0]{Add, Subtract, Equal, Greater, Less, A_0} statetype;

statetype state, nextstate;

always_ff @(posedge clock or negedge rstsync)
	begin
		if (!rstsync)
			state <= Add;
		else
			state <= nextstate;
	end

assign instruct = dataOut[2:0];

always_comb
begin
	case(state)
		Add:
			if (instruct==3'b001 && mode==1'b0)
				nextstate = Subtract;
			else if (instruct==3'b100 && mode==1'b0)
				nextstate = Equal;
			else if (instruct==3'b101 && mode==1'b0)
				nextstate = Greater;
			else if (instruct==3'b110 && mode==1'b0)
				nextstate = Less;
			else if (instruct==3'b111 && mode==1'b0)
				nextstate = A_0;
			else
				nextstate = Add;
		Subtract:
			if (instruct==3'b000 && mode==1'b0)
				nextstate = Add;
			else if (instruct==3'b100 && mode==1'b0)
				nextstate = Equal;
			else if (instruct==3'b101 && mode==1'b0)
				nextstate = Greater;
			else if (instruct==3'b110 && mode==1'b0)
				nextstate = Less;
			else if (instruct==3'b111 && mode==1'b0)
				nextstate = A_0;
			else
				nextstate = Subtract;
		Equal:
			if (instruct==3'b000 && mode==1'b0)
				nextstate = Add;
			else if (instruct==3'b001 && mode==1'b0)
				nextstate = Subtract;
			else if (instruct==3'b101 && mode==1'b0)
				nextstate = Greater;
			else if (instruct==3'b110 && mode==1'b0)
				nextstate = Less;
			else if (instruct==3'b111 && mode==1'b0)
				nextstate = A_0;
			else
				nextstate = Equal;
		Greater:
			if (instruct==3'b000 && mode==1'b0)
				nextstate = Add;
			else if (instruct==3'b001 && mode==1'b0)
				nextstate = Subtract;
			else if (instruct==3'b100 && mode==1'b0)
				nextstate = Equal;
			else if (instruct==3'b110 && mode==1'b0)
				nextstate = Less;
			else if (instruct==3'b111 && mode==1'b0)
				nextstate = A_0;
			else
				nextstate = Greater;
		Less:
			if (instruct==3'b000 && mode==1'b0)
				nextstate = Add;
			else if (instruct==3'b001 && mode==1'b0)
				nextstate = Subtract;
			else if (instruct==3'b100 && mode==1'b0)
				nextstate = Equal;
			else if (instruct==3'b101 && mode==1'b0)
				nextstate = Greater;
			else if (instruct==3'b111 && mode==1'b0)
				nextstate = A_0;
			else
				nextstate = Less;
		A_0:
			if (instruct==3'b000 && mode==1'b0)
				nextstate = Add;
			else if (instruct==3'b001 && mode==1'b0)
				nextstate = Subtract;
			else if (instruct==3'b100 && mode==1'b0)
				nextstate = Equal;
			else if (instruct==3'b101 && mode==1'b0)
				nextstate = Greater;
			else if (instruct==3'b110 && mode==1'b0)
				nextstate = Less;
			else
				nextstate = A_0;
		default: nextstate = Add;
	endcase
end

always_comb
begin
	case(state)
		Add:
			out_instruct = 3'b000;
		Subtract:
			out_instruct = 3'b001;
		Equal:
			out_instruct = 3'b100;
		Greater:
			out_instruct = 3'b101;
		Less:
			out_instruct = 3'b110;
		A_0:
			out_instruct = 3'b111;
	endcase
end

endmodule
