`timescale 1ns/100ps
`include "uart.v"
module uart_tx_test();

reg [7:0] data;
reg clk;
reg enable;
reg rdy_clr;

wire tx_busy;
wire rdy;
wire [7:0] rxdata;
wire loopback;

uart test_uart(.din(data),
	       .wr_en(enable),
	       .clk_50m(clk),
	       .tx(loopback),
	       .tx_busy(tx_busy),
	       .rx(loopback),
	       .rdy(rdy),
	       .rdy_clr(rdy_clr),
	       .dout(rxdata));

initial begin
		$dumpfile("uart.vcd");
		$dumpvars(0,uart_tx_test);
		enable <= 1'b1;
		#20 enable <= 1'b0;

end

always #20 clk = ~clk;

always @(posedge rdy) begin
	#20 rdy_clr <= 1;
	#20 rdy_clr <= 0;
	if (rxdata != data) begin
		$display("FAIL: rx data %x does not match tx %x", rxdata, data);
		$finish;
	end else begin
		if (rxdata == 8'hff) begin
			$display("SUCCESS: all bytes verified");
			$finish;
		end
		data <= data + 1'b1;
		enable <= 1'b1;
		#20 enable <= 1'b0;
	end
end

endmodule