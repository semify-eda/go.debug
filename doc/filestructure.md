# File Structure Description

The overall directory structure looks as follows:
```
    .
    ├── README.md
    ├── Release.md
    ├── eaConfig.yml
    ├── doc
    |   ├── API.md
    |   ├── Config.md
    |   ├── Inspector.md
    |   ├── License.md
    │   ├── Inspector.rst
    │   ├── Logging.rst
    │   ├── ea.md
    |   ├── eaDictionary.md
    |   ├── eaVPI.md
    │   ├── ea.rst
    │   ├── filestructure.rst
    │   └── meas_top_tb.svg
    ├── example
    │   ├── meas
    │   │   ├── rtl
    │   │   ├── sim.verilator
    │   │   ├── sim.xcelium
    │   │   └── testbench
    |   |       ├── top.sv
    │   │       └── top.xcelium.sv
    │   ├── shiftreg
    │   |   ├── rtl
    │   |   ├── sim.verilator
    │   |   ├── sim.xcelium
    |   |   ├── sim.icarus
    │   |   └── testbench
    |   |       ├── top.sv
    |   |       ├── top.xcelium.sv
    |   |       └── top.icarus.sv
    |   ├── division
    |   |   ├── rtl
    |   |   ├── sim.cocotb
    |   |   └── testbench
    |   |       └── top.cocotb.sv
    |   └── logging
    |       ├── rtl
    |       ├── sim.verilator
    |       └── testbench
    |           └── top.sv
    ├── lib
    │   ├── lib32
    │   │   ├── libea-dpi.so
    |   |   ├── libea-vpi.so
    |   |   ├── libea-vpi-dpi.so
    |   |   └── libea.so
    │   └── lib64
    |       ├── libea-dpi.so
    |       ├── libea-vpi.so
    |       ├── libea-vpi-dpi.so
    │       └── libea.so
    └── sv
        └── ea_package.sv

```
- README.md ... readme file
- Release.md ... Release notes 
- eaConfig.yml ... Default configuration file

- doc ... Documentation

- example ... *ErrorAnalyzer* examples
  - meas ... Example containng a measurement system (ADC / averaging / DAC)
  - shiftreg ... Example a simple shift register
  - division ... Example which divides an integer by another integer and results in a quotient and remainder
  - logging ... Example shows how to use the various logging functions through the API

- lib ... *ErrorAnalyzer* shared librarires 

- sv ... SystemVerilog package for *ErrorAnalyzer* integration




