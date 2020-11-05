

module fluorescence_FPGA(PMT_in, light_source_pin, clock_50_mhz, pulse_out_pin, LEDs);

	
	reg [31:0] integration_timer= 0;	
	reg [31:0] light_modulation_timer = 0;	

//	reg [31:0] pulse_count = 0;	

   reg [31:0] add_count = 0;	
	reg [31:0] subtract_count = 0;
	
	reg [31:0] pulse_out_accumulator= 0;
	
	output [7:0] LEDs;
	
	input PMT_in; //GPIO_01 PIN_C3
	input clock_50_mhz; //CLOCK_50 PIN_R8
	output light_source_pin; //GPIO_00 PIN_D3 
	output pulse_out_pin;
	
	reg pulse_out = 0;
	
	reg [31:0] integration_time = 32'd50000000 * 1;
	
	reg [31:0] light_modulation_period = 32'd5000;

	assign LEDs = add_count;
	
	
	reg light_source_flag = 0;
	
	assign pulse_out_pin = pulse_out;
	
	reg previous_clear_flag = 0;

	reg pulse_captured = 0;
	reg prev_pulse_captured = 0;
	reg light_source_capture_flag = 0;
	
	always @(posedge PMT_in)
	begin
		if(PMT_in)
		begin
			pulse_captured <= !pulse_captured;
			light_source_capture_flag <= light_source_flag;
		end
//		else
//		begin
//			if(clear_flag == previous_clear_flag)
//			begin
//				previous_clear_flag = !clear_flag;
//				pulse_count <=0;
//			end
//		end
		
	end
	
	
	always @(posedge clock_50_mhz)
	begin
		light_modulation_timer <= light_modulation_timer + 32'd1;
		
		if(light_modulation_timer >= light_modulation_period-1)
		begin 
			light_modulation_timer <= 32'd0;
			light_source_flag <= !light_source_flag;
		end	
	end
	
	
	
	/*
	Integration time handler
	*/
	
	assign light_source_pin = light_source_flag;

	reg clear_flag = 0;

	
	
	always @(posedge clock_50_mhz)
	begin
	
		
	
	
		integration_timer <= integration_timer + 32'd1;
		
		
		if(integration_timer >= integration_time-1)
		begin 
			integration_timer <= 32'd0;
			if(add_count >= subtract_count)
			begin
				pulse_out_accumulator<= add_count - subtract_count;
			end
			else
			begin
				pulse_out_accumulator <= 0;
			end
			
			add_count <= 0;
			subtract_count <= 0;

			clear_flag = !clear_flag;
		end
		else
		begin
			if(pulse_captured != prev_pulse_captured)
			begin
				prev_pulse_captured <= pulse_captured;
				
				if(light_source_capture_flag)
				begin
					if(add_count < {32{1'b1}})
					begin
						add_count <= add_count + 1;
					end
				end
				else
				begin  
					if(subtract_count < {32{1'b1}})
					begin
						subtract_count <= subtract_count + 1;
					end
				end
			end
		end
		
		
		pulse_out <= (pulse_out_accumulator > 0);

		if(pulse_out_accumulator > 0)
		begin
			pulse_out_accumulator <= pulse_out_accumulator - 1;
		end
		
		
	end

	
	
	
endmodule


//module display();



