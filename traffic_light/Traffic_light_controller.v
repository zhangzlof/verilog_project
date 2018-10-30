module traffic_light(light_highway, light_farm, C, clk, rst_n);
	parameter HGRE_FRED=2'b00, // Highway green and farm red
          	  HYEL_FRED = 2'b01,// Highway yellow and farm red
          	  HRED_FGRE=2'b10,// Highway red and farm green
          	  HRED_FYEL=2'b11;// Highway red and farm yellow
    input C, //sensor
    	  clk,
    	  rst_n;
    output reg[2:0] light_highway,light_farm;
    reg[1:0] state,next_state;
    reg delay10s, delay3s1,delay3s2;
    reg RED_count_en,YELLOW_count_en1,YELLOW_count_en2;
    reg[27:0] count=0,count_delay=0;
    wire clk_enable;
    always @(posedge clk or negedge rst_n) begin
    	if (~rst_n) begin
    		state<=HGRE_FRED;
    		
    	end
    	else begin
    		state<=next_state;
    	end
    end
    //FSM
    always@(*) begin
    	case(state)
    		HGRE_FRED:
    			begin
    				light_highway=3'b001;
    				light_farm=3'b100;
    				RED_count_en=0;
 					YELLOW_count_en1=0;
 					YELLOW_count_en2=0;
    				if(C) next_state=HYEL_FRED;
    				else next_state=HGRE_FRED;
    			end
    		HYEL_FRED:
    			begin
    				light_highway=3'b010;
    				light_farm=3'b100;
    				RED_count_en=0;
 					YELLOW_count_en1=1;
 					YELLOW_count_en2=0;
    				if(delay3s1) next_state=HRED_FGRE; // yellow for 3s, then red
    				else next_state=HYEL_FRED;
    			end
    		HRED_FGRE:
    			begin
    				light_highway=3'b100;
    				light_farm=3'b001;
    				RED_count_en=1;
 					YELLOW_count_en1=0;
 					YELLOW_count_en2=0;
    				if(delay10s) next_state=HRED_FYEL;
    				else next_state=HRED_FGRE;
    			end
    		HRED_FYEL:
    			begin
    				light_highway=3'b100;
    				light_farm=3'b010;
    				RED_count_en=0;
 					YELLOW_count_en1=0;
 					YELLOW_count_en2=1;
    				if(delay3s2) next_state=HGRE_FRED;
    				else next_state=HRED_FYEL;
    			end
    		default: next_state=HGRE_FRED;
    	endcase
    end
    always@(posedge clk) begin
    	if(clk_enable==1) begin
    		if(RED_count_en||YELLOW_count_en1||YELLOW_count_en2)
  				count_delay <=count_delay + 1;
  					if((count_delay == 9)&&RED_count_en) begin
   									delay10s=1;
   									delay3s1=0;
   									delay3s2=0;
   									count_delay<=0;
  							end
  					else if((count_delay == 2)&&YELLOW_count_en1) begin
   									delay10s=0;
   									delay3s1=1;
   									delay3s2=0;
   									count_delay<=0;
  							end
  					else if((count_delay == 2)&&YELLOW_count_en2) begin
   									delay10s=0;
   									delay3s1=0;
   									delay3s2=1;
   									count_delay<=0;
  							end
  					else
  						begin
   								delay10s=0;
   								delay3s1=0;
   								delay3s2=0;
  						end 
 			
    	   end
    end
    // create 1s clock enable 
	always @(posedge clk)
	begin
 		count <=count + 1;
 		//if(count == 50000000) // 50,000,000 for 50 MHz clock running on real FPGA
 		if(count == 3) // for testbench
  			count <= 0;
	end
 	assign clk_enable = count==3 ? 1: 0; // 50,000,000 for 50MHz running on FPGA
endmodule 
