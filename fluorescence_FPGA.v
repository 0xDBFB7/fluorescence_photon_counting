

module fluorescence_FPGA(PMT_in, light_source_pin, clock_50_mhz, pulse_out_pin, LEDs);

	
	reg [31:0] integration_timer= 0;	

	reg [31:0] light_modulation_timer = 0;	

	reg [31:0] pulse_count = 0;	
	
//
   reg [31:0] add_count = 0;	
	reg [31:0] subtract_count = 0;
	
	reg [31:0] pulse_out_accumulator= 0;
	
	reg [31:0] pulse_subtracted_signed_value= 0;
	
	output [7:0] LEDs;
	
	reg [31:0] blank2 = 0;

	reg [31:0] blank = 0;

	reg s_ena = 0;
	reg s_clk = 0;
	
	altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (0),
		.instance_id             ("cnt"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_0 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (pulse_subtracted_signed_value)       //     probes.probe
	);
		altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (1),
		.instance_id             ("addc"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_1 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (add_count)       //     probes.probe
	);
		altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (2),
		.instance_id             ("subc"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_2 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (subtract_count)       //     probes.probe
	);
	
	
	
	
	
	
	
	
	input PMT_in; //GPIO_01 PIN_C3
	input clock_50_mhz; //CLOCK_50 PIN_R8
	output light_source_pin; //GPIO_00 PIN_D3 
	output pulse_out_pin;
	
	reg pulse_out = 0;
	
	reg [31:0] integration_time = 32'd50000000 * 10;
	
	reg [31:0] light_modulation_period = 32'd500000;

//	assign LEDs = add_count;
	assign LEDs = 0;
	
	
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
	
	reg just_integrated = 0;

	
	
	
	always @(posedge clock_50_mhz)
	begin
	
		
	
	
		integration_timer <= integration_timer + 32'd1;
		
		
		if(integration_timer >= integration_time-1)
		begin 
			integration_timer <= 32'd0;
			pulse_subtracted_signed_value <= $signed(add_count) - $signed(subtract_count);
//			if(add_count >= subtract_count)
//			begin
//				pulse_out_accumulator<= add_count - subtract_count;
//			end
//			else
//			begin
//				pulse_out_accumulator <= 0;
//			end
			
			add_count <= 0;
			subtract_count <= 0;
		end
		else
		begin
		/* might drop a pulse or mis-phase once per integration time. not a huge deal I don't think. */
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
		
//		
//		pulse_out <= (pulse_out_accumulator > 0);
//
//		if(pulse_out_accumulator > 0)
//		begin
//			pulse_out_accumulator <= pulse_out_accumulator - 1;
//		end
		
	end

	
	
	
endmodule


//module display();



