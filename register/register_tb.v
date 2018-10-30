`timescale 1ns/100ps
`define half_period 100
module register_tb;
	reg clk,reset;
	reg[3:0] in_data;
	wire[3:0] out_data;
	initial begin
		clk<=1'b0;
		reset<=1'b1;
		in_data<=4'b0000;
		#150 reset<=1'b0;
		     in_data<=4'b0100;
		#100 reset<=0'b1;
			 in_data<=4'b1010;
		#200 in_data<=4'b0101;
		#1000 $stop;
	end
	always #`half_period clk=~clk;
	register my_design(.clk(clk),.reset(reset),.in_data(in_data),.out_data(out_data));
endmodule