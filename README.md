# Overview
*ErrorAnalyzer* is a productivity EDA tool for digital verification. It reduces the debugging effort by analyzing error patterns of failing simulations. As a result, the verification engineer receives detailed information about the characteristics of the failing signals and gets error pattern proposals represented in textual and graphical form. The availability of these error patterns and the additional information about the characteristics of the involved signals speeds up the interactive debugging process and allows to identify the underlying root cause of the failures much faster.

## References
* See the [documentation](doc/ea.md) to get a detailed *ErrorAnalyzer* description
* See the [release notes](Release.md) to learn about the latest improvements of the *ErrorAnalyzer*

## Background and Motivation
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

For more details on the integration see the provided examples described under [Examples](./doc/ea.md#Examples).


# Installation

Clone the git repository from GitHub

    git clone https://github.com/semify-eda/go.debug.git

Change to the root directory of the repository and run the setup.

    Bash:  source Setup.sh
    Csh:   source Setup.csh

The given command sets the environment variable `EA_ROOT` which is used to reference to the root directory of the *ErrorAnalyzer*.


## Supported operating systems

*ErrorAnalyzer* is integrated via shared libraries. The shared libraries are currently tested for: 

- Ubuntu 18.04 (tested with Verilator)
- CentOS Linux release 7.9.2009 (tested with Verilator and Cadence Xcelium)
- Redhat (tested with Cadence Xcelium)


## Digital Simulation
For digital simulations two simulator were used and tested:

* Verilator (4.034 2020-05-03 rev v4.034-6-gf8381751) simulator is used. A description on how to download and install Verilator can be found under: https://www.veripool.org/wiki/verilator/Manual-verilator
* Cadence Xcelium 19.09


## Waveform Viewer
As waveform viewer GTKWave (v3.3.104 (w)1999-2020 BSI) is used. A description on how to download and install GTKWave can be found under http://gtkwave.sourceforge.net/.


## Licensing 

The basic version of *ErrorAnalyzer* can be used free of charge. The free version is limited in terms of maximal number of supported *Analyzer* (5) and maximal support number of samples per *Analyzer* (256).

In case a full *ErrorAnalyzer* version is required please get in contact with the *semify* team via
- email: office@semify-eda.com
- Webpage (request a demo): [semify](www.semify-eda.com)
