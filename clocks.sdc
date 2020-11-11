create_clock -name "clock_50_mhz" -period 20.0ns [get_ports {clock_50_mhz}]
create_clock -name "main_clock" -period 5.0ns [get_ports {main_clock}]

create_clock -name "PMT_in" -period 5.0ns [get_ports {PMT_in}]
create_clock -name "light_source_pin" -period 300ns [get_ports {light_source_pin}]


derive_pll_clocks
derive_clock_uncertainty