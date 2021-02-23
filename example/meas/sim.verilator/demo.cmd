# Run simulation without errors
make 
gtkwave -f ./logs/vlt_dump.vcd -a demo.sim.bitshift.gtkw &


# Run simulation with errors
make EA_ERROR_STUCK="en"


make EA_ERROR_BITSHIFT="en"
nedit ../rtl/spi_adc.sv -line 190 & 
gtkwave -f eaCheckerWaves.trc -a demo.eatrc.bitshift.gtkw &


make EA_ERROR_TIMESHIFT="en"
nedit ../testbench/meas_top_system.sv -line 148 & 
gtkwave -f eaCheckerWaves.trc -a demo.eatrc.bitshift.gtkw &


make EA_ERROR_SAT="en"
nedit ../rtl/avg.sv -line 89 & 
gtkwave -f eaCheckerWaves.trc -a demo.eatrc.sat.gtkw &


