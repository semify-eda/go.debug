SRC := $(shell cat ../rtl/file.f) 
SRC := $(addprefix $(shell pwd)/../rtl/, $(SRC))

tmp := $(shell cat ../testbench/file.cocotb.f) 
SRC := $(SRC) $(addprefix $(shell pwd)/../testbench/, $(tmp))

export PYTHONPATH := $(PYTHONPATH):../testbench/

ifneq ($(EA_ERROR_DBZ),)
EA_SIM_FLAGS += -DEA_ERROR_DBZ
$(info Enable simulation error: Division by zero always 0)
endif

ifneq ($(EA_ERROR_SHIFT),)
EA_SIM_FLAGS += -DEA_ERROR_SHIFT
$(info Enable simulation error: Bit shift)
endif

$(info $(EA_SIM_FLAGS))

SIM ?= icarus
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(SRC)
TOPLEVEL = top
MODULE = test_div_int
$(info $(EA_SIM_FLAGS))
COMPILE_ARGS = -D WAVES=1 $(EA_SIM_FLAGS)
export COCOTB_LOG_LEVEL=INFO

include $(shell cocotb-config --makefiles)/Makefile.sim
