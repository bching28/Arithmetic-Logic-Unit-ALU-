module fsm_rw_lab7 (input logic clock,
						input logic mode, button, rstsync,
						output logic ren, wen,
						output logic empty, full,
						output logic [3:0] r_addr=4'd0, w_addr=4'd0); // read and write addresses are the same as ptrs
		
	typedef enum logic [1:0] {IDLE, READ, WRITE} statetype;

	statetype state, nextstate;

	always_ff @(posedge clock or negedge rstsync)
	begin
		if (!rstsync)
			state <= IDLE;
		else
			state <= nextstate;
	end

	always_comb
		begin
			case(state)
				IDLE:
					if (mode==1'b0 && button==1'b1 && empty==1'b0)
						nextstate = READ;
					else if (mode==1'b1 && button==1'b1 && full==1'b0)
						nextstate = WRITE;
					else
						nextstate = IDLE;
				READ:
					if (mode==1'b0 && button==1'b1 && empty==1'b0)
						nextstate = READ;
					else
						nextstate = IDLE;
				WRITE:
					if (mode==1'b1 && button==1'b1 && full==1'b0)
						nextstate = WRITE;
					else
						nextstate = IDLE;
				default: nextstate = IDLE;
			endcase
		end
		
	always_comb
		begin
			case(state)
				IDLE:
				begin
					ren = 1'b0;
					wen = 1'b0;
				end
				READ:
				begin
					ren = 1'b1;
					wen = 1'b0;
				end
				WRITE:
				begin
					ren = 1'b0;
					wen = 1'b1;
				end
			endcase
		end
	
	always_ff @(posedge clock or negedge rstsync)
	begin
		if (!rstsync)
			begin
			r_addr = 4'd0;
			w_addr = 4'd0;
			end
		else
			begin
			if (ren==1'b1)
				r_addr = r_addr + 1'b1;
			if (wen==1'b1)
				w_addr = w_addr + 1'b1;
			end
	end
	
	// empty and full
	always_comb
	begin
			// Checking empty
		if (r_addr[2:0]==w_addr[2:0] && r_addr[3]==w_addr[3])
			empty = 1'b1;
		else
			empty = 1'b0;

			// Checking full
		if (r_addr[2:0]==w_addr[2:0] && r_addr[3]!=w_addr[3])
			full = 1'b1;
		else
			full = 1'b0;
	end
		
endmodule
