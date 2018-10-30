module register(clk,in_data,out_data,reset);
	input clk;
	input reset;
	input[3:0] in_data;
	output[3:0] out_data;
	D_FF reg1(.clk(clk),.reset(reset),.in_data(in_data[0]),.out_data(out_data[0]));
	D_FF reg2(.clk(clk),.reset(reset),.in_data(in_data[1]),.out_data(out_data[1]));
	D_FF reg3(.clk(clk),.reset(reset),.in_data(in_data[2]),.out_data(out_data[2]));
	D_FF reg4(.clk(clk),.reset(reset),.in_data(in_data[3]),.out_data(out_data[3]));
endmodule