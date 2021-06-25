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


# Hanlding of dedicated errors to show ErrorAnalyzer functionality
EA_SIM_FLAGS =
ifneq ($(EA_ERROR_BITSHIFT),)
  EA_SIM_FLAGS += +define+EA_ERROR_BITSHIFT 
  $(info Inserting failure: Single bit shift)
endif

ifneq ($(EA_ERROR_TIMESHIFT),)
  EA_SIM_FLAGS += +define+EA_ERROR_TIMESHIFT 
  $(info Inserting failure: Time shift)
endif

ifneq ($(EA_ERROR_SAT),)
  EA_SIM_FLAGS += +define+EA_ERROR_SAT 
  $(info Inserting failure: Saturation error)
endif
ifneq ($(EA_ERROR_STUCK),)
  EA_SIM_FLAGS += +define+EA_ERROR_STUCK 
  $(info Inserting failure: Bit stuck at)
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
	@echo "                   none                    ... no error"
	@echo "                   EA_ERROR_BITSHIFT='en'  ... Bit shift error"
	@echo "                   EA_ERROR_TIMESHIFT='en' ... Time shift error "
	@echo "                   EA_ERROR_SAT='en'       ... Saturation error"
	@echo "                   EA_ERROR_STUCK='en'     ... Stuck at error"
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
