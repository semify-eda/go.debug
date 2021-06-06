# Version 2v0: 30. May 2021

## Improvements
  - (Issue ErrorAnalyzer/ea_dev#158): Example for cocotb --> example/division
  - (Issue ErrorAnalyzer/ea_dev#151): Rename shared library --> see documentation for detail
  - (Issue ErrorAnalyzer/ea_dev#143): VPI support for Icarus Verilog
  - (Issue ErrorAnalyzer/ea_dev#148): An example on VPI Integration added
  - (Issue ErrorAnalyzer/ea_dev#142): Add support for VPI based *ErrorAnalyzer* functionality calls 
  - (Issue ErrorAnalyzer/ea_dev#144): Configurable console color coding. Configuration parameter `ConsoleColorsEnable`
  - (Issue ErrorAnalyzer/ea_dev#139): Add a Python wrapper for the ErrorAnalyzer
  - (Issue ErrorAnalyzer/ea_dev#136): Remove warning messages if a partial config file is used
  - (Issue ErrorAnalyzer/ea_dev#116): Improve output of Message 
  - (Issue ErrorAnalyzer/ea_dev#101): Remove Sample *Inspector* Limit #104
  - (Issue ErrorAnalyzer/ea_dev#107): Provide logging functions from simulation to ErrorAnalyzer
  - (Issue ErrorAnalyzer/ea_dev#23) : Add functions to API `eaAnalyzersChecksPerform()`, `eaAnalyzerFinal()`
  - (Issue ErrorAnalyzer/ea_dev#93) : Provide Analyzer Summary in easy parse able format
  - (Issue ErrorAnalyzer/ea_dev#9)  : Log Messages improvements (Filename, Scope)
  - (Issue ErrorAnalyzer/ea_dev#53):  Print log messages to simulator console
  - (Issue ErrorAnalyzer/ea_dev#154): Log location Reporting
  - (Issue ErrorAnalyzer/ea_dev#156): Console colors configuration switch

## Bug fixes
  - 

# Version 1v6: 21. Feb 2021

## Improvements
  - (Issue ErrorAnalyzer/ea_dev#98): Increase robustness of vcd file dumper
  - (Issue ErrorAnalyzer/ea_dev#108): Improve truncation error pattern handling
  - (Issue ErrorAnalyzer/ea_dev#9): Improve *Analyzer* log messages with filename and scope information
  - (Issue ErrorAnalyzer/ea_dev#23): Add Functions to API

## Bug fixes
  - Several minor bug fixes

# Version 1v5: 19. Feb 2021

## New Features
  - (Issue ErrorAnalyzer/ea_dev#87):  Add a bit swap check to the Statistic Inspector
  - (Issue ErrorAnalyzer/ea_dev#89):  Create message dictionary dumper
  - (Issue ErrorAnalyzer/ea_dev#109): Flow improvement, added setup scripts to export EA_ROOT
  - (Issue ErrorAnalyzer/ea_dev#93): Provide *ErrorAnalyzer* Summary in easy parse able format

## Improvements
  - (Issue ErrorAnalyzer/ea_dev#104): Remove Sample *Inspector* Limit
  - (Issue ErrorAnalyzer/ea_dev#116): Improve output of Message
  - (Issue ErrorAnalyzer/ea_dev#108): Truncation error pattern reporting fixed
  - (Issue ErrorAnalyzer/ea_dev#107): Provide logging functions from ErrorAnalyzer to simulation

## Bug Fixes


# Version 1v4: 17. Feb 2021

## New Features 
  - (Issue ErrorAnalyzer/ea_dev#60): Add new *Inspector* for detecting number related error pattern
  - (Issue ErrorAnalyzer/ea_dev#52): Add license file
  
## Improvements
  - (Issue ErrorAnalyzer/ea_dev#97): Updated configuration dumping
  - (Issue ErrorAnalyzer/ea_dev#71): Improved Logging meassage format
  - (Issue ErrorAnalyzer/ea_dev#70): Updated example `meas` 
  - (Issue ErrorAnalyzer/ea_dev#59): Improved *Analyzer* reporting. Added signal for actual number of errors. 
  
## Bug Fixes
  - (Issue ErrorAnayzer/ea_dev#95): Fixed wrong signal values for Integer *Inspector*
  - (Issue ErrorAnayzer/ea_dev#91): Fixed wrong sample number provided by reporting
  - (Issue ErrorAnayzer/ea_dev#79): Fixed wrong function definition in `ea_package.sv` for unused *ErrorAnalyzer* 
  - (Issue ErrorAnayzer/ea_dev#70): Fixed two regressions concerning the C-tests

# Version 1v3: 29. Dec 2020

Improvements and new Features
-----------------------------


Completely reworked version of *ErrorAnalyzer*. 

  * New logging format
  * Add possibility for a configuration file (`eaConfig.yml`)
  * New Inspectors
  * Dumping of .vcd and .fst data bases supported
  * Improved signal representation
  * Logging
    * Added summary
    * Improved error pattern description
  * Updated examples
  * Updated documentation


# Version 1v2: 9. Oct 2020

Improvements and new Features
-----------------------------

* General
  Changed the verbosity of `eaAnalyzerAddSample()` to HIGH.
  Changed the verbosity of `eaAnalyzersReport()` to LOW.

* *ErrorAnalyzer*
    * Sample Inspector Single Bit: Add signals vector to indicate for each bit if it is pass or fail. (ead_dev#14)
        * Analyzerxxx.Samples.FailPerBit: Vector, indicating failing bits
        * Analyzerxxx.Samples.FailBitCnt: Number of failing bits per sample
    
    * Improved reporting 
      * Several minor improvements (ead_dev#11) 
      * Adapted statistic reporting depending on Analyzer type (ead_dev#17)
       
    * Segment *Inspector* Shift. Updated signal naming (ead_dev#13)
    
    * Waveform data base name changed from `eaInspectorWaves.trc` to `eaInspectorWaves.fst`. (ead_dev#12)
    
* `ea_apckage.sv`: 
    * Added documentation within comments
    
    * Added new functions `eaAPIVerisonOk` in order to check API compatibility (ead_dev#20)
    


# Version 1v1: 25. Sep 2020


Improvements and new Features
-----------------------------

* *ErrorAnalyzer*
    * Improved reporting:
      * General improvements for root cause descriptions
      * Clean-up of summary report including error pattern IDs
    * Updated *Inspector* Single Bit to support also whole word inversion errors
    * Added vcd file dumping (enabled by default)
        * File name: eaInspectorWaves.vcd
    * Updated Naming of traced signals
    * Added indication in waveform tracing hierarchy in case of fixable fails
      * Indication is done by adding  `__FF` to the hierarchy name 

* Shared library
Updated directory structure for storing the *ErrorAnalyzer* shared objects.

```
    lib
      verilator
         libea.so
      xcelium
         libea.so
```

* Documentation
    * Updated *Inspector* descriptions

* Examples
    * All examples have now a separate simulation directory
        * Verilator: `sim.verilator` 
        * Xcelium: `sim.xcelium`
    * All examples can be started via a `make` inside the corresponding simulation directory
    * All examples are now based on shared library for calling the *ErrorAnalyzer* functions
      
Example `shiftreg`
    * Added example for showing error bit inversion
 
 
Known Issues
------------

* Waveform 
    * Hierarchy naming of Bit shift misses shift direction and number of shifts --> Planned to be fixed by updated *Inspector*
    
* Examples
    * Full separation of user examples and *ErrorAnalyzer* development tests required --> Planned to be fixed



# 1v0: 4. Sep 2020
 
 
- Initial release
