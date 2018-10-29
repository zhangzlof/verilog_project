`timescale 1ns/100ps
`define half_period 100
module d_ff_tb;
	reg clk,reset;
	reg in_data;
	wire out_data;
	initial begin
		clk<=1'b0;
		reset<=1'b1;
		in_data<=1'b0;
		#150 reset<=1'b0;
		     in_data<=1;
		#100 reset<=0'b1;
			 in_data<=0;
		#200 in_data<=1;
		#1000 $stop;
	end
	always #`half_period clk=~clk;
	D_FF my_design(.clk(clk),.reset(reset),.in_data(in_data),.out_data(out_data));
endmodule