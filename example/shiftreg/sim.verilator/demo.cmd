make EA_ERROR_BITREVERSE="en"


make EA_ERROR_BITINV="en"

gtkwave -f ./logs/vlt_dump.vcd -a demo.sim.bitshift.gtkw &
