######################################################################
#
# DESCRIPTION: Verilator Example: Small Makefile
#
# This calls the object directory makefile.  That allows the objects to
# be placed in the "current directory" which simplifies the Makefile.
#
# Copyright 2003-2020 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0
#
######################################################################
# Check for sanity to avoid later confusion

ifneq ($(words $(CURDIR)),1)
 $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
endif

######################################################################
# Set up variables
ifeq ($(EA_ROOT),)
  $(error Missing Environment Variable: EA_ROOT environment variable not defined)
endif

# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a
# package install, and verilator is in your path. Otherwise find the
# binary relative to $VERILATOR_ROOT (such as when inside the git sources).
ifeq ($(VERILATOR_ROOT),)
  VERILATOR = verilator
  VERILATOR_COVERAGE = verilator_coverage
else
  export VERILATOR_ROOT
  VERILATOR = $(VERILATOR_ROOT)/bin/verilator
  VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif

# Shared library path is requird to use ErrorAnalyzer library via DPI
export LD_LIBRARY_PATH=${EA_ROOT}/lib/lib32/:${EA_ROOT}/lib/lib64/

VERILATOR_FLAGS =
# Generate C++ in executable form
VERILATOR_FLAGS += -cc --exe 
# Generate makefile dependencies (not shown as complicates the Makefile)
#VERILATOR_FLAGS += -MMD
# Optimize
VERILATOR_FLAGS += -Os -x-assign 0
# Warn abount lint issues; may not want this on less solid designs
#VERILATOR_FLAGS += -Wall
# Make waveforms
VERILATOR_FLAGS += --trace-fst 
#VERILATOR_FLAGS += -LDFLAGS -lz 
VERILATOR_FLAGS += --trace --trace-structs
# Check SystemVerilog assertions
#VERILATOR_FLAGS += --assert
# Generate coverage analysis
#VERILATOR_FLAGS += --coverage
# Run Verilator in debug mode
#VERILATOR_FLAGS += --debug
# Add this trace to get a backtrace in gdb
#VERILATOR_FLAGS += --gdbbt
# Add XML output file geneation
#VERILATOR_FLAGS += --xml-output ./Vtop.xml --xml-only --flatten --bbox-sys
# Add user specific files
VERILATOR_FLAGS += $(ARG)

# Input files for Verilator
VERILATOR_INPUT = -f input.vc -F ../testbench/file.f -F ../rtl/file.f -LDFLAGS "-L ${EA_ROOT}/lib/lib32 -L ${EA_ROOT}/lib/lib64 -lea"

# Handling of dedicated errors to show ErrorAnalyzer functionality
EA_SIM_FLAGS =
ifneq ($(EA_ERROR_BITSHIFT),)
  EA_SIM_FLAGS += +define+EA_ERROR_BITSHIFT 
  $(info Enable simulation error: Bit shift)
endif

ifneq ($(EA_ERROR_TIMESHIFT),)
  EA_SIM_FLAGS += +define+EA_ERROR_TIMESHIFT 
  $(info Enable simulation error: Time shift)
endif

ifneq ($(EA_ERROR_SAT),)
  EA_SIM_FLAGS += +define+EA_ERROR_SAT 
  $(info Enable simulation error: Saturation)
endif

ifneq ($(EA_ERROR_STUCK),)
  EA_SIM_FLAGS += +define+EA_ERROR_STUCK 
  $(info Enable simulation error: Bits are stuck at 0/1)
endif

ifneq ($(EA_DISABLE),)
  EA_SIM_FLAGS += +define+EA_DPI_USE_DUMMY 
  $(info Disable ErrorAnalyzer: No error pattern analysis is done)
endif


######################################################################
default: run

help:
	@echo "(INFO) ErrorAnalyzer root path: ${EA_ROOT}"
	@echo "Makefile for simulation start"
	@echo "  Targets:"
	@echo "    help     ... (default) This message"
	@echo "    clean    ... Remove all files from the actual directory except the link to Makefile"
	@echo "    run      ... Run simulation using ErrorAnalyzer as compiled code"
	@echo "                 Arguments for enablings design / verification errors"
	@echo "                   none                       ... no error"
	@echo "                   EA_ERROR_BITSHIFT='en'     ... Bit shift error"
	@echo "                   EA_ERROR_TIMESHIFT='en'    ... Time shift error"
	@echo "                   EA_ERROR_SAT='en'          ... Saturation error"
	@echo "                   EA_ERROR_STUCK='en'        ... Stuck at error"
	@echo "                 Arguments for isabling ErrorAnalyzer 
	@echo "                   EA_DISABLE='en'            ... Disable ErrorAnalyzer"
	@echo ""


run:
	@echo
	@echo "-- Verilator tracing example"
	@echo
	@echo "-- VERILATE ----------------"
	$(VERILATOR) $(VERILATOR_FLAGS) $(EA_SIM_FLAGS) $(VERILATOR_INPUT) 

	@echo
	@echo "-- BUILD -------------------"
# To compile, we can either
# 1. Pass --build to Verilator by editing VERILATOR_FLAGS above.
# 2. Or, run the make rules Verilator does:
#	$(MAKE) -j -C obj_dir -f Vtop.mk
# 3. Or, call a submakefile where we can override the rules ourselves:
	$(MAKE) -j -C obj_dir -f ../Makefile_obj

	@echo
	@echo "-- RUN SIMULATION ----------"
	@rm -rf logs
	@echo "  -- LD_LIBRARY_PATH: ${LD_LIBRARY_PATH}"
	@mkdir -p logs
	obj_dir/Vtop +trace
#	@echo
#	@echo "-- COVERAGE ----------------"
#	@rm -rf logs/annotated
#	$(VERILATOR_COVERAGE) --annotate logs/annotated logs/coverage.dat

#	@echo
#	@echo "-- Generate stems (top.stems) file for GTK-Wave"
#        xml2stems 

	@echo
	@echo "-- SIMULATION DONE ---------"
	@echo "  To see ErrorAnalyzer waveforms open eaInspectorWaves.trc (GTKWave only) or eaInspectorWaves.vcd (vcd file, all Simulator)"
	@echo "  To see log file open eaLogFile.log (text file)"
	@echo
	@echo "  To see simulation waveforms open ./logs/vlt_dump.vcd (file format depends on Verilator flags)"
	@echo
        

######################################################################
# Other targets

show-config:
	$(VERILATOR) -V

maintainer-copy::
clean mostlyclean distclean maintainer-clean::
	@echo "(INFO) Clean actual directory except Makefile"
	-rm -rf obj_dir logs *.log *.dmp *.vpd coverage.dat core
