ifeq ($(EA_ROOT),)
$(error Missing Environment Variable: EA_ROOT environment variable not defined)
endif


SRC := $(shell cat ../rtl/file.f) 
SRC := $(addprefix ../rtl/, $(SRC))

TESTBENCH := $(shell cat ../testbench/file.icarus.f) 
TESTBENCH := $(addprefix ../testbench/, $(TESTBENCH))


EA_SIM_FLAGS =
ifneq ($(EA_ERROR_BITSHIFT),)
EA_SIM_FLAGS += -DEA_ERROR_BITSHIFT
$(info Enable simulation error: Bit shift)
endif


default: run

${EA_ROOT}/lib/lib64/libea-vpi.so:
	@cd ${EA_ROOT}/release/build_library; make build-release-lib64-vpi

help:
	@echo "------------------------------"
	@echo "Possible run options: "
	@echo "    help     ... This message"
	@echo "    clean    ... Remove all files from the actual directory except the link to Makefile"
	@echo "    run   ... Run simulation using ErrorAnalyzer with 64bit shared library "
	@echo "  make EA_ERROR_BITSHIFT='en' "

Vtop.vvp: $(TESTBENCH) $(SRC)
	iverilog -o Vtop.vvp -s top $(TESTBENCH) $(EA_SIM_FLAGS) $(SRC) -g2012 

run: Vtop.vvp ${EA_ROOT}/lib/lib64/libea-vpi.so
	vvp -M. -m${EA_ROOT}/lib/lib64/libea-vpi.so Vtop.vvp -fst 
	
clean:
	rm -f Vtop.vvp eaAnalyzerSummary.csv eaInspectorWaves.fst eaInspectorWaves.vcd eaLogFile.log

