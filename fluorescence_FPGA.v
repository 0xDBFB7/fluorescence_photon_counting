

module fluorescence_FPGA(PMT_in,light_source_pin);


	reg [32:0] clock = 0;	
	reg [32:0] count = 0;	
	reg [32:0] subtract_count = 0;
	reg [32:0] add_count = 0;
	input PMT_in;
	reg light_source_flag = 0;
	
	output light_source_pin;
	
	assign light_source_pin = light_source_flag;
	
	always @(posedge PMT_in)
	begin
		if(light_source_flag)
		begin
			
		end
	end
		
	always @(posedge PMT_in)
	begin
	end

	
	
//	output [6:0] HEX1_display;
//	output [6:0] HEX2_display;
//
//	wire[3:0] low_bytes;
//	wire[3:0] high_bytes;
//
//	input clock_in;
//	wire clock_out;
//	input reset;
//
//	output clock_view;
//
//
//	reg previous_reset_flag = 0;
//
//	always @(posedge clock_in)
//	begin
//
//		if(previous_reset_flag && reset) //edge detector
//			previous_reset_flag <= 0;
//
//			
//		if(!reset && !previous_reset_flag)
//		begin
//			count <= 24;
//			clock_count <= 32'd0;
//			previous_reset_flag <= 1;
//		end
//		
//		else
//		begin
//			clock_count <= clock_count + 32'd1;
//			if ((clock_count >= D-1) && count > 0)
//			begin
//				count <= count - 1;
//				clock_count <= 32'd0;
//			end
//		end
//
//	
//	end
	
	
	
endmodule


