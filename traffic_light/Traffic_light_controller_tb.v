`timescale 10ns/1ps
`define delay 1
module traffic_light_tb;
	reg  C, clk, rst_n;
	wire[2:0] light_highway, light_farm;
	traffic_light tb(light_highway, light_farm, C, clk, rst_n);
	initial begin
		clk=1'b0;
		rst_n=1'b1;
		C=1'b0;
	end
	initial begin
		main;
	end
	task main;
		fork
		clock_gen;
		reset_gen;
		operation_flow;
		debug_output;
		endsimulation;
		join
	endtask

	task clock_gen;
		begin
			forever #`delay clk=~clk;
		end
	endtask

	task reset_gen;
		begin
			rst_n=1;
			#20 rst_n=0;
			#20 rst_n=1;
		end
	endtask

	task operation_flow;
		begin
			C=1'b0;
			#600 
			C=1'b1;
			#1200
			C=1'b0;
			#1200
			C=1'b1;

		end
	endtask

	task debug_output;
		begin
			$display("----------------------------------------------");
        	$display("------------------     -----------------------");
 			$display("----------- SIMULATION RESULT ----------------");
 			$display("--------------             -------------------");
 			$display("----------------         ---------------------");
 			$display("----------------------------------------------");
 			$monitor("TIME = %d, reset = %b, sensor = %b, light of highway = %h, light of farm road = %h",$time,rst_n ,C,light_highway,light_farm );
		end
	endtask

	task endsimulation;
		begin
			#400000
			$display("-------------- THE SIMUALTION END ------------");
			$finish;
		end
	endtask

endmodule
