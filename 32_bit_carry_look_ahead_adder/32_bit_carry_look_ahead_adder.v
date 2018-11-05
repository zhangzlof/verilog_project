module carry_look_ahead_adder(in1,in2,carry_in,sum,carry_out);
	parameter data_width = 32;
	input[data_width-1:0] in1,in2;
	input carry_in;
	output [data_width-1:0] sum;
	output carry_out;

	wire [data_width-1:0] gen;
	wire [data_width-1:0] pro;
	wire [data_width:0] carry_tmp;
	
	generate
		genvar j,i;
		assign carry_tmp[0] = carry_in;
		for (j = 0; j < data_width; j = j+1) 
			begin:carry_generator
				assign gen[j] = in1[j] & in2[j] ;
				assign pro[j] = in1[j] ^ in2[j] ;
				assign carry_tmp[j+1] = gen[j] | (pro[j]&carry_tmp[j]);
			end
    	assign carry_out = carry_tmp[data_width];
		for (i = 0; i< data_width; i = i+1)
			begin:sum_without_carry
				assign sum[i] = (in1[i] ^ in2[i]) ^ carry_tmp[i];
			end
	endgenerate
endmodule