`timescale 1ns/100ps
module booth_mul_tb;
	reg [31:0] a;
	reg [31:0] b;
	reg clk,rst;
	wire done;
	wire [63:0] c;
	booth_mul my_test(.a(a),.b(b),.c(c),.clk(clk),.rst(rst),.bingo(done));
	always #100 clk = ~clk ;
	initial 
		begin
			clk = 1'b0;
			rst = 1'b1;
			a=32'h00_00_00_ff;
                        b=32'h00_00_00_ff;
			#80 rst = 1'b0;
			#100 rst = 1'b1;
			#10000 $stop;
		end
endmodule