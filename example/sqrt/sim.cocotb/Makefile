SRC := $(shell cat ../rtl/file.f) 
SRC := $(addprefix $(shell pwd)/../rtl/, $(SRC))

tmp := $(shell cat ../testbench/file.cocotb.f) 
SRC := $(SRC) $(addprefix $(shell pwd)/../testbench/, $(tmp))

export PYTHONPATH := $(PYTHONPATH):../testbench/

SIM ?= icarus
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(SRC)
TOPLEVEL = top
MODULE = test_sqrt_int
COMPILE_ARGS = -D WAVES=1

include $(shell cocotb-config --makefiles)/Makefile.sim
