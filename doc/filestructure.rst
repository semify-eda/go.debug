Directory and File structure
============================

The overall directory structure looks as follows: ::

    .
    ├── README.md
    ├── Release.md
    ├── doc
    │   ├── Inspector.rst
    │   ├── Logging.rst
    │   ├── ea.md
    │   ├── ea.rst
    │   ├── filestructure.rst
    │   └── meas_top_tb.svg
    ├── example
    │   ├── meas
    │   │   ├── rtl
    │   │   ├── sim.verilator
    │   │   ├── sim.xcelium
    │   │   └── testbench
    │   │       └── top.xcelium.sv
    │   └── shiftreg
    │       ├── rtl
    │       ├── sim.verilator
    │       ├── sim.xcelium
    │       └── testbench
    ├── lib
    │   ├── lib32
    │   │   └── libea.so
    │   └── lib64
    │       └── libea.so
    └── sv
        └── ea_package.sv
        
* README.md ... readme file

* Release.md ... Release notes 

* doc ... Documentation

* example ... *ErrorAnalyzer* examples
  * meas ... Example containng a measurement system (ADC / averaging / DAC)
  * shiftreg ... Example a simple shift register

* lib ... *ErrorAnalyzer* shared librarires 

* sv ... SystemVerilog package for *ErrorAnalyzer* integration




