*ErrorAnalyzer User Documentation*
==================================

A description of the inspectors can be found under [Inspector.rst](./Inspector.rst). It includes also a list of existing checks.

Logging message format description can be found under [Logging.rst](./Logging.rst)

The file structure of the released data can be found under [filestructure.rst](./filestructure.rst)


Examples
--------

There are examples provided with the *ErrorAnalyzer* showing the functionality of the tool. All examples are setup for 
- Verilator 
- Cadence Xcelium

Within each of the examples different errors can be inserted. The errors can selectively enabled via defines. The simulations are started via `make` command. All available options can be shown via `make help`. 

### meas
This example includes a whole system comprising of a ADC interfaced via an SPI, average filtering and a DAC interfaced via another SPI.  

![](meas_top_tb.svg "Block diagram of `meas` system including testbench")


### shiftreg

A simple shift register.


Supported operating systems
--------------------------

*ErrorAnalyzer* is provided as a shared library. It is currently tested on: 

- Ubuntu 18.04
- CentOS Linux release 7.9.2009 

