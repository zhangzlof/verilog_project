module transmitter(tx,tx_busy,din,wr_en,clk_50m,clken);
	input [7:0] din; //输入的数据
	input wr_en; //发送命令，上升沿有效
	input clk_50m; //top时钟
	input clken;  //发送数据脉冲
	output tx; //产生发送数据信号
	output wire tx_busy; //线路状态指示，高为线路忙

	initial begin
		tx = 1'b1;
	end
	
    parameter STATE_IDLE=2'b00, STATE_START=2'b01, STATE_DATA = 2'b10, STATE_STOP = 2'b11;
	reg [7:0] data;
	reg [1:0] state = STATE_IDLE;
	reg [2:0] bitpos = 3'h0;
	reg tx;
	always @(posedge clk_50m)
		begin
			case(state)
			STATE_IDLE: begin
					if(wr_en) begin
						state <= STATE_START;
						data <= din;
						bitpos <=3'h0;
					end
			    end
			STATE_START: begin
					if(clken) begin
						tx <= 1'b0;
						state <= STATE_DATA;
					end
			    end
			STATE_DATA: begin
					if(clken) begin
						if(bitpos == 3'h7) begin
							state <= STATE_STOP;
						end
						else
							bitpos <= bitpos + 3'h1;
						tx <= data[bitpos];
					end				
			    end
			STATE_STOP: begin
					if(clken) begin
						tx <= 1'b1;
						state <= STATE_IDLE;
					end
				end
			default: begin
					tx <=1'b1;
					state <= STATE_IDLE;
				end
		    endcase
		end

	assign tx_busy = (state != STATE_IDLE);
	endmodule