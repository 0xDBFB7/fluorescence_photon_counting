

module fluorescence_FPGA(PMT_in, light_source_pin, clock_50_mhz, pulse_out_pin, LEDs);

	
	reg [63:0] integration_timer= 0;	

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
	

	localparam [31:0] num_waveform_samples = 40;

	reg [31:0] waveform [(num_waveform_samples-1):0]; 
	reg [31:0] readout_waveform_index; 
	wire [31:0] current_waveform_value; 

	assign current_waveform_value = waveform[readout_waveform_index];

	

	wire main_clock;
//	wire locked;
	assign main_clock = clock_50_mhz;
//	
//	clkgen clock_generator(clock_50_mhz, main_clock);
	
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
		altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (4),
		.instance_id             ("wfvl"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_4 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (current_waveform_value)       //     probes.probe
	);
		altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (5),
		.instance_id             ("wfix"),
		.probe_width             (32),
		.source_width            (32),
		.source_initial_value    ("0"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_5 (
		.source     (blank2),     //    sources.source
		.source_ena (s_clk), //           .source_ena
		.source_clk (s_ena), // source_clk.clk
		.probe      (readout_waveform_index)       //     probes.probe
	);
	
	
	
	
	
	
	
	input PMT_in; //GPIO_01 PIN_C3
	input clock_50_mhz; //CLOCK_50 PIN_R8
	output light_source_pin; //GPIO_00 PIN_D3 
	output pulse_out_pin;
	
	reg pulse_out = 0;
	
	localparam [63:0] main_clock_frequency = 32'd50000000;

	localparam [63:0] integration_time = main_clock_frequency * 10;
	
	localparam [31:0] light_frequency = 100000;
	localparam [31:0] light_modulation_period = ((main_clock_frequency)/(light_frequency)); // * 4
//	assign LEDs = add_count;
	assign LEDs = 0;
	
	
	assign pulse_out_pin = pulse_out;
	
	reg previous_clear_flag = 0;

	reg pulse_captured = 0;
	reg prev_pulse_captured = 0;
	reg [31:0] light_timer_flag = 0;	


	
	always @(posedge PMT_in)
	begin
		if(PMT_in)
		begin
			pulse_captured <= !pulse_captured;
			in_phase_flag <= in_phase;
			quadrature_flag <= quadrature;
			light_timer_flag <= light_timer;
			
			if((light_timer_flag >= gate_begin) && (light_timer_flag < gate_end) && !reading_out)
			begin
				temp <= waveform[pulse_timer_flag_idx] + 1;
			end

		end
		
	end
	
	wire [31:0] pulse_timer_flag_idx ;

	assign pulse_timer_flag_idx = light_timer_flag - gate_begin;
	
	reg in_phase = 0;
	reg quadrature = 0;
	
	reg in_phase_flag = 0;
	reg quadrature_flag = 0;
	
//	assign LEDs[0] = in_phase;
//	assign LEDs[1] = quadrature;

	reg double_light_clock = 0;
	reg [31:0] double_light_timer = 0;	
	reg [31:0] light_timer = 0;	

	always @(posedge main_clock)
	begin
	 
		
		double_light_timer <= double_light_timer + 32'd1;
		light_timer <= light_timer + 32'd1;

		if(double_light_timer >= (light_modulation_period/2)-1)
		//div 2 because the I/Q divides
		begin 
			double_light_timer <= 32'd0;
			double_light_clock <= !double_light_clock;
		end	
		
		if(light_timer >= (light_modulation_period*2)-1)
		begin 
			light_timer <= 32'd0;
		end
		
	end
	
	always @(posedge double_light_clock)
	begin
		in_phase <= !in_phase;
	end
	
	always @(negedge double_light_clock)
	begin
		quadrature <= !quadrature;
	end
	
	
	assign light_source_pin = in_phase;
	

	localparam [31:0] gate_begin = light_modulation_period+(light_modulation_period/2);
	localparam [31:0] gate_end = (light_modulation_period+(light_modulation_period/2)+num_waveform_samples)-1;

	reg [8:0] temp  = 0;
	
	
	always @(posedge main_clock)
	begin
	
		pulse_out <= (light_timer >= gate_begin) && (light_timer < gate_end);


		integration_timer <= integration_timer + 64'd1;
				
		if(integration_timer >= integration_time-1)
		begin 
			integration_timer <= 64'd0;
			in_phase_subtracted_signed_value <= $signed(in_phase_add_count) - $signed(in_phase_subtract_count);
			quadrature_subtracted_signed_value <= $signed(quadrature_add_count) - $signed(quadrature_subtract_count);

			in_phase_count <= in_phase_add_count;
			quadrature_count <= quadrature_add_count;
			
			
			in_phase_add_count <= 0;
			in_phase_subtract_count <= 0;
			quadrature_add_count <= 0;
			quadrature_subtract_count <= 0;
			
			begin_readout_flag <= !begin_readout_flag;	
			
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
				
				
				
				
				if((light_timer_flag >= gate_begin) && (light_timer_flag < gate_end) && !reading_out)
				begin
					//waveform is captured in the second quadrant.
					waveform[pulse_timer_flag_idx] <= temp;
				end
				
				
			end
		end
	
		if(reading_out && readout_waveform_index > 0)
		begin
			waveform[readout_waveform_index - 1] = 32'd0;
		end
		
	end

	

	localparam [31:0] readout_frequency = 100;
	localparam [31:0] readout_clock_period = ((main_clock_frequency)/(readout_frequency)); // * 4
	reg [31:0] readout_timer = 0;
	
	reg begin_readout_flag = 0;

	reg prev_readout_flag = 0;
	
	reg reading_out = 0;
	
	always @(posedge main_clock)
	begin
	 
		
		readout_timer <= readout_timer + 32'd1;

		if(readout_timer >= (readout_clock_period)-1 && readout_waveform_index < num_waveform_samples-2)
		begin 
			readout_timer <= 32'd0;
			readout_waveform_index <= readout_waveform_index + 1;			
		end
		
		reading_out <= (readout_waveform_index < num_waveform_samples-2);
	
		if(prev_readout_flag != begin_readout_flag) //reset, begin counting again.
		begin
			readout_waveform_index <= 0;
			prev_readout_flag <= begin_readout_flag;
		end
	
	end
		

	
endmodule




