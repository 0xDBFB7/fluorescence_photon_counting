create_clock -name "clock_50_mhz" -period 20.000ns [get_ports {clock_50_mhz}]
create_clock -name "PMT_in" -period 30ns [get_ports {PMT_in}]


derive_pll_clocks
derive_clock_uncertainty