# Overview
*ErrorAnalyzer* is a productivity EDA tool for digital verification. It reduces the debugging effort by analyzing error patterns and proposing the most likely error pattern.

## References
* [Release Notes](Release.md) for latest improvements 
* [Documentation](doc/ea.md) for detailed *ErrorAnalyzer* documentation

## Description
During the development of an ASIC or FPGA digital verification consumes up between half and two third of the overall effort. Therefore, it is important to speed-up the verification process in order to achieve a productivity gain during the digital design process. Taking a closer look into the digital verification process we can identify four main activities. The data is based on **The 2018 Wilson Research Group Functional Verification Study** https://blogs.mentor.com/verificationhorizons/blog/2018/11/19/part-1-the-2018-wilson-research-group-functional-verification-study.  
1. (44%) Debug 
1. (21%) Creating Tests and Running Simulations
1. (19%) Testbench Development
1. (13%) Test Planning
1. (3%) Other (neglectable)

It can be seen clearly that the Debugging is the most time-consuming part of the digital verification process. Therefore, for achieving a high productivity gain it makes sense to focus on speeding up the debugging process. 

Taking a closer look into the debugging process it turns out that this process is still a task which consists of many manual steps. In general, debugging follows the sequences shown below.
* Detect erroneous behavior --> Checker fail during simulation 
* Analyze and understand wrong behavior --> Waveform and logfile analysis
  * Search for **the** mismatch pattern causing the error
* Trace back to root cause --> Design and verification environment analysis

Especially, searching for the mismatch pattern is a very time intensive task. This is mainly caused by three facts
* Error reporting messages are often incomplete and hard to read 
* Error reporting messages are often hard to assign to a checker
* It is hard for the human brain to detect certain error pattern

*ErrorAnalyzer* focus exactly on this issue. It provides a structured reporting and complete reporting of simulation errors and provides a suggestion for the error pattern with the highest probability for being the reason of the error. By using this information, it is much easier for the verification engineer to find the root cause of a simulation fail.

# Integration
During the development of the *ErrorAnalyzer*, special attention has been paid to an easy and smooth integration into existing verification environments. The integration is done by using the SystemVerilog DPI interface which allows an integration into UVM and also non UVM based verification environments. All required functions are defined in a SystemVerilog package called `ea_package.sv`. 
The most suitable places to integrate the *ErrorAnalyzer* into a verification environment are scoreboards and checker. The integration is done by following three steps.
1. Create (`eaAnalyzerCreate`) 
1. Add Samples (`eaAnalyzerAddSample`)
1. Report (`eaAnalyzerReport`)

# Installation

Clone the git repository from GitHub

    git clone https://github.com/kstrohmayer/ea.git

Set environment variable

    Bash: Export EA_ROOT=`pwd`
    Csh: setenv EA_ROOT `pwd`

##Supported operating systems

*ErrorAnalyzer* is provide as shared library. It is currently tested for: 

- Ubuntu 18.04 (tested with Verilator)
- CentOS Linux release 7.9.2009 (tested with Verilator and Cadence Xcelium)
- Redhat (tested with Cadence Xcelium)

## Digital Simulation
For digital simulations two simulator were used:

* Verilator (4.034 2020-05-03 rev v4.034-6-gf8381751) simulator is used. A description on how to download and install Verilator can be found under: https://www.veripool.org/wiki/verilator/Manual-verilator
* Cadence Xcelium 19.09

## Waveform Viewer
As waveform viewer GTKWave (v3.3.104 (w)1999-2020 BSI) is used. A description on how to download and install GTKWave can be found under http://gtkwave.sourceforge.net/.

## *ErrorAnalyzer*
The *ErrorAnalyzer* is based on C++. For compiling the C++ code g++ (7.5.0) is used.

# Examples
There are several examples available to demonstrate the functionality of the *ErrorAnalyzer*.
For running the examples a `Makefile` is available for each example. All examples can be run either with Verilator or Cadence Xcelium.

The directory structure of the examples looks as follows:

    <example>
      - rtl … containing the RTL design
      -	testbench … containing the testbench / verification environment
      -	sim.verilator … simulation directory for Verilator including a make file (`Makefile`) for starting the simulation
      -	sim.xcelium … simulation directory for Cadence Xcelium including a make file (`Makefile`) for starting the simulation

For running examples, first clone the GIT repository to your local machine. Make sure that all required software described above is installed. 
Change to the simulation directory.

    cd ea/example/<example>/sim.verilator 
    cd ea/example/<example>/sim.xcelium 

Start the simulation

    call `make` for running the example
    
This will compile and run the simulation. Running the simulation using the simple `make` command runs the simulation without any error. Therefore, *ErrorAnalyzer* can't provide any error pattern proposal. To show the *ErrorAnalyzer* features some errors must be present. Errors are enabled by running the make command with different macro definitions. The required macro definitions are example dependent and can be obtained by calling `make help` . This allows the *ErrorAnalyer* to provide error pattern suggestions.

Beside the console output *ErrorAnalyzer* generates the following files.

* `eaLogFile.log`: *ErrorAnalyzer* log file including reporting of each Analyzer
* `eaInspectorWaves.fst`: *ErrorAnalyzer* traces giving details regarding the result of each Analyzer and Inspector in GTKWave FST format
* `eaInspectorWaves.vcd`: *ErrorAnalyzer* traces giving details regarding the result of each Analyzer and Inspector in vcd format
    
## Example `meas`
The example `meas` consists of an RTL design called meas_top. It contains an SPI master with two channels for reading in ADC data, an average for each channel and a second SPI master for transferring the averaged data to a DAC. The ADC and the DAC are modeled within the verification environment as VIPs.

The block diagram of the example design can be found under [meas_top_tb](doc/meas_top_tb.svg).

The following four commands modify the design and the verification environment to trigger simulation fails. 

    make EA_ERROR_BITSHIFT="en"
    make EA_ERROR_TIMESHIFT="en"
    make EA_ERROR_SAT="en"
    make EA_ERROR_STUCK="en"

## Example `shiftreg`
The example `shiftreg` consists of an RTL design called ste_shift_reg. It contains simple shift register with synchronous clear and a parallel load.

The following four commands modify the design and the verification environment to trigger simulation fails. 

    make EA_ERROR_BITSHIFT='en'    
    make EA_ERROR_BITSINVERSED='en'
    make EA_ERROR_BITSREVERSED='en'
    make EA_ERROR_BYTESSWAPPED='en'
    


