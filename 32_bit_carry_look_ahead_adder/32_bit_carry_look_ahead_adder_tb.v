`timescale 1ns/10ps
module carry_look_ahead_adder_tb();
	parameter data_width = 32;
	reg[data_width-1:0] in1,in2;
	reg carry_in;
	wire [data_width-1:0] sum;
	wire carry_out;
	carry_look_ahead_adder my_test(.in1(in1),.in2(in2),.carry_in(carry_in),.sum(sum),.carry_out(carry_out));
	initial 
		begin
			in1 = 32'b0;
			in2 = 32'b0;
			carry_in = 1'b0;
			#10  in1 = 16'd10;
   			#10  in1 = 16'd22;
  			#10  in2 = 16'd10;
  			#10  in2 = 16'd20;
  			#10  in2 = 16'd0;
  			#30  in1 = 16'hFFFF; in2 = 16'hFFFF;
  			#30  in1 = 16'h7FFF; in2 = 16'hFFFF;
  			#30  in1 = 16'hBFFF; in2 = 16'hFFFF;
		end
endmodule