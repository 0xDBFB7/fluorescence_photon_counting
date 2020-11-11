

module fluorescence_FPGA(PMT_in, light_source_pin, clock_50_mhz, pulse_out_pin, LEDs);

	
	reg [31:0] integration_timer= 0;	

	reg [31:0] light_modulation_timer = 0;	
//
   reg [31:0] in_phase_add_count = 0;	
	reg [31:0] in_phase_subtract_count = 0;
	
	reg [31:0] quadrature_add_count = 0;	
	reg [31:0] quadrature_subtract_count = 0;
	
	reg [31:0] pulse_out_accumulator= 0;
	
	reg signed [31:0] in_phase_subtracted_signed_value= 0;
	reg signed [31:0] quadrature_subtracted_signed_value= 0;

	reg [31:0] in_phase_count = 0;	
	reg [31:0] quadrature_count = 0;
	
	output [7:0] LEDs;
	

	
//	clkgen clock_generator(clock_50_mhz, in_phase_clock, quadrature_clock);
	
	reg [31:0] blank2 = 0;
	reg [31:0] blank = 0;
	reg s_ena = 0;
	reg s_clk = 0;
	altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (0),
		.instance_id             ("inpc"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_0 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (in_phase_subtracted_signed_value)       //     probes.probe
	);
	
		altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (1),
		.instance_id             ("qadc"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_1 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (quadrature_subtracted_signed_value)       //     probes.probe
	);
			altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (2),
		.instance_id             ("ipcn"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_2 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (in_phase_count)       //     probes.probe
	);
			altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (3),
		.instance_id             ("qacn"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_3 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (quadrature_count)       //     probes.probe
	);
	
	
	
	
	
	
	
	
	input PMT_in; //GPIO_01 PIN_C3
	input clock_50_mhz; //CLOCK_50 PIN_R8
	output light_source_pin; //GPIO_00 PIN_D3 
	output pulse_out_pin;
	
	reg pulse_out = 0;
	
	localparam [31:0] main_clock_frequency = 32'd50000000;

	reg [31:0] integration_time = main_clock_frequency * 60;
	
	localparam [31:0] light_frequency = 100000;
	reg [31:0] light_modulation_period = ((main_clock_frequency)/(light_frequency*2)); // * 4
//	assign LEDs = add_count;
	assign LEDs = 0;
	
	
	assign pulse_out_pin = pulse_out;
	
	reg previous_clear_flag = 0;

	reg pulse_captured = 0;
	reg prev_pulse_captured = 0;
	
	always @(posedge PMT_in)
	begin
		if(PMT_in)
		begin
			pulse_captured <= !pulse_captured;
			in_phase_flag <= in_phase;
			quadrature_flag <= quadrature;

		end
		
	end
	
	
	reg in_phase = 0;
	reg quadrature = 0;
	
	reg in_phase_flag = 0;
	reg quadrature_flag = 0;
	
//	assign LEDs[0] = in_phase;
//	assign LEDs[1] = quadrature;

	reg light_source_flag = 0;

	
	always @(posedge clock_50_mhz)
	begin
	 
		
		light_modulation_timer <= light_modulation_timer + 32'd1;
		
		if(light_modulation_timer >= (light_modulation_period)-1)
		begin 
			light_modulation_timer <= 32'd0;
			light_source_flag <= !light_source_flag;
		end	
	end
	
	always @(posedge light_source_flag)
	begin
		in_phase <= !in_phase;
	end
	
	always @(negedge light_source_flag)
	begin
		quadrature <= !quadrature;
	end
	
	
	assign light_source_pin = in_phase;
	
	

	always @(posedge clock_50_mhz)
	begin
	
		
	
	
		integration_timer <= integration_timer + 32'd1;
		
		
		if(integration_timer >= integration_time-1)
		begin 
			integration_timer <= 32'd0;
			in_phase_subtracted_signed_value <= $signed(in_phase_add_count) - $signed(in_phase_subtract_count);
			quadrature_subtracted_signed_value <= $signed(quadrature_add_count) - $signed(quadrature_subtract_count);

			in_phase_count <= in_phase_add_count;
			quadrature_count <= quadrature_add_count;

			
			in_phase_add_count <= 0;
			in_phase_subtract_count <= 0;
			quadrature_add_count <= 0;
			quadrature_subtract_count <= 0;
		end
		else
		begin
		/* might drop a pulse or mis-phase once per integration time. not a huge deal I don't think. */
			if(pulse_captured != prev_pulse_captured)
			begin
				prev_pulse_captured <= pulse_captured;
				
				if(in_phase_flag)
				begin
					if(in_phase_add_count < {32{1'b1}})
					begin
						in_phase_add_count <= in_phase_add_count + 1;
					end
				end
				else
				begin  
					if(in_phase_subtract_count < {32{1'b1}})
					begin
						in_phase_subtract_count <= in_phase_subtract_count + 1;
					end
				end
				
				
				if(quadrature_flag)
				begin
					if(quadrature_add_count < {32{1'b1}})
					begin
						quadrature_add_count <= quadrature_add_count + 1;
					end
				end
				else
				begin  
					if(quadrature_subtract_count < {32{1'b1}})
					begin
						quadrature_subtract_count <= quadrature_subtract_count + 1;
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




