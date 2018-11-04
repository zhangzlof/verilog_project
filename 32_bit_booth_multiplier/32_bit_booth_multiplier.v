module booth_mul(a,b,c,clk,rst,bingo);
	input [31:0] a,b;
	output wire[63:0] c;
	input clk,rst;
	output wire bingo;
	reg [32:0]z;
    reg [32:0]x_c;
    reg [32:0]x;
    reg [32:0]y;
    reg [5:0]index_i;
    reg [1:0] current_state, next_state;
	parameter Init=2'b00, Ready=2'b01, Acc=2'b10, Done=2'b11;
	reg finished;
	always @(posedge clk or negedge rst)
		begin
			if(!rst) 
				current_state = Init;
			else 
				current_state = next_state;
		end

	always @(current_state or index_i)
		begin
			case(current_state)
				Init:
					begin
						finished = 0;
						next_state = Ready;
					end
				Ready:
					begin
						x= {a[31],a[31:0]};
						x_c =~{a[31],a[31:0]} + 1;
						y ={b[31:0],1'b0};
						z = 33'd0;
						next_state = Acc;
					end
				Acc:
					begin
						case(y[1:0])
							2'b01:
								begin
									z = z + x;
									{z[32:0],y[32:0]} = {z[32],z[32:0],y[32:1]};
								end
							2'b10:
								begin
									z = z + x_c;
									{z[32:0],y[32:0]} = {z[32],z[32:0],y[32:1]};
								end
							default:
								begin
									{z[32:0],y[32:0]} = {z[32],z[32:0],y[32:1]};
								end
						endcase
						if(index_i==6'h1f)   
							begin
					        	next_state = Done;
				            end
				        else
				        	begin
				        		next_state = Acc;
				        	end
					end
				default:
					begin
						finished = 1;
					end
			endcase
		end
	always @(posedge clk)
		if(current_state==Acc)
			index_i<=index_i+1;
		else 
			index_i<=0;
	assign  bingo = finished;
	assign  c = {z[31:0],y[32:1]};
endmodule