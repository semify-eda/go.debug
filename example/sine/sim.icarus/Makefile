
ifeq ($(EA_ROOT),)
$(error Missing Environment Variable: EA_ROOT environment variable not defined)
endif


SRC := $(shell cat ../rtl/file.f) 
SRC := $(addprefix ../rtl/, $(SRC))

TESTBENCH := $(shell cat ../testbench/file.icarus.f) 
TESTBENCH := $(addprefix ../testbench/, $(TESTBENCH))

default: run

${EA_ROOT}/lib/lib64/libea-vpi.so:
	@cd ${EA_ROOT}/release/build_library; make build-release-lib64-vpi

help:
	@echo "------------------------------"
	@echo "Possible run options: "
	@echo "    help     ... This message"
	@echo "    clean    ... Remove all files from the actual directory except the link to Makefile"
	@echo "    run      ... Run simulation using ErrorAnalyzer with 64bit shared library "

Vtop.vvp: $(TESTBENCH) $(SRC)
	iverilog -o Vtop.vvp -s wfg_stim_sine_tb $(TESTBENCH) $(EA_SIM_FLAGS) $(SRC) -g2012 

run: Vtop.vvp ${EA_ROOT}/lib/lib64/libea-vpi.so
	vvp -M. -m${EA_ROOT}/lib/lib64/libea-vpi.so Vtop.vvp -fst 
	
clean:
	rm -f Vtop.vvp eaAnalyzerSummary.csv eaInspectorWaves.fst eaInspectorWaves.vcd eaLogFile.log

