//Realize An D Flip-flop wWth  Asynchronous Reset low Level
module D_FF(clk,in_data,out_data,reset);
	input in_data;
	input clk;
	input reset;
	output out_data;
	reg out_data;
	always @(posedge clk or negedge reset) begin
		if(!reset)
			out_data<=1'b0;
		else
			out_data<=in_data;
	end
endmodule