######################################################################
#
# DESCRIPTION: xcelium Makefile
#
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

EA_LIB_DIR = ${EA_ROOT}/dev/release/xcelium


# Handling of dedicated errors to show ErrorAnalyzer functionality
EA_SIM_FLAGS =
ifneq ($(EA_ERROR_BITSHIFT),)
  EA_SIM_FLAGS += +define+EA_ERROR_BITSHIFT
  $(info Inserting failure: Bitshift)
endif
ifneq ($(EA_ERROR_BITSINVERSED),)
  EA_SIM_FLAGS += +define+EA_ERROR_BITSINVERSED
  $(info Inserting failure: Bits inversed)
endif
ifneq ($(EA_ERROR_BITSREVERSED),)
  EA_SIM_FLAGS += +define+EA_ERROR_BITSREVERSED
  $(info Inserting failure: Bits reversed)
endif
ifneq ($(EA_ERROR_BYTESSWAPPED),)
  EA_SIM_FLAGS += +define+EA_ERROR_BYTESSWAPPED
  $(info Inserting failure: Bytes swapped)
endif


######################################################################
default: run

help:
	@echo "(INFO) ErrorAnalyzer root path: ${EA_ROOT}"
	@echo "Makefile for simulation start"
	@echo "  Targets:"
	@echo "    help     ... (default) This message"
	@echo "    clean    ... Remove all files from the actual directory except the link to Makefile"
	@echo "    run      ... Run simulation using ErrorAnalyzer with 32bit shared library "
	@echo "    run64    ... Run simulation using ErrorAnalyzer with 64bit shared library "
	@echo "                 Arguments for enablings design / verification errors"
	@echo "                   none                       ... no error"
	@echo "                   EA_ERROR_BITSHIFT='en'     ... Bit shift error"
	@echo "                   EA_ERROR_BITSINVERSED='en' ... Inverted bits"
	@echo "                   EA_ERROR_BITSREVERSED='en' ... Reversed bit order"
	@echo "                   EA_ERROR_BYTESSWAPPED='en' ... Byte swap"
	@echo ""

run:
	@echo "------------------------------"
	@echo "(INFO) Start simulation via xrun..."
	@echo "------------------------------"
	@echo "(INFO) ErrorAnalyzer root path: ${EA_ROOT}"
	xrun -F ../testbench/file.xcelium.f -F ../rtl/file.f $(EA_SIM_FLAGS) -dpi -sv_lib $(EA_ROOT)/lib/lib32/libea-vpi-dpi.so -disable_sem2009 -linedebug -top top -gui -clean

run64:
	@echo "------------------------------"
	@echo "(INFO) Start simulation via xrun..."
	@echo "------------------------------"
	@echo "(INFO) ErrorAnalyzer root path: ${EA_ROOT}"
	xrun -F ../testbench/file.xcelium.f -F ../rtl/file.f $(EA_SIM_FLAGS) -64bit -dpi -sv_lib $(EA_ROOT)/lib/lib64/libea-vpi-dpi.so -disable_sem2009 -linedebug -top top -gui -clean



######################################################################
# Other targets

show-config:
	xrun -verison

maintainer-copy::
clean mostlyclean distclean maintainer-clean::
	@echo "(INFO) Clean actual directory except Makefile"
	find . -maxdepth 1 -not -name "Makefile" -not -name ".gitignore" -and -not -name "." -exec rm -rf {} \;
