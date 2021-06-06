# *ErrorAnalyzer* API Documentation

## General functions
#### `int eaAPIVersionOk(input int Version, input int SubVersion)`


Checks the locally defined SystemVerilog functions and the C DPI functions 
use the same API version - (option).
It is highly recommended to perform this check at the beginning of the 
simulation in order to avoid any unexpected simulation results or even 
simulation crashes.
  
Result: 
* `EA_NOTOK (0)`: API versions do not match. The Analyzer result 
       might not be as expected. It even can lead to simulation crashes.
* `EA_OK (1)   `: API versions match. 

Intended to be called from the 
       testbench in the following way: `eaAPIVersionOk(EA_API_VERSION, EA_API_SUBVERSION);`
## Analyzer specific functions 
#### `int eaAnalyzerCreate(input string Name, input int Type, input int DataBitWidth, input int DataIsSigned, longint Time)`
Creates an Analyzer instance - (required).  
Provides a handle to the Analyzer instance. 

---
#### `void eaAnalyzerAddSample(input int ID, input int DataRead, input int DataExpected, longint Time)`
Add an new sample to an existing Analyzer instance - (required).
Hands over the read data and the expected data as well as the actual time.

---
#### `void eaAnalyzerReport(int ID)`
Reports the actual information about an Analyzer - (optional).

The function only informs about the Analyzer itself. It does not 
trigger any checks or report information about *Inspector* findings.
The information is dumped into the log file.

---
#### `void eaAnalyzerSamplesReport(int ID)`
Reports all actual samples of the given Analyzer - (optional). 

---
#### `void eaAnalyzerChecksPerform(int ID)`
Runs checks and analysis for all *Inspectors* of a given Analyzer - (required).

After performing the analysis and checks the result is logged using the defined reporting limit into the log file.

This function needs to be called before the overall summary reporting (`eaAnalyzersReport()`) and waveform dumping (`eaAnalyzersDumpTrace()`) is done.

## Functions applied to all Analyzers
#### `void eaAnalyzersFinal()`
Runs all the stages for all Analyzers at once. (required)

Calls :
* eaAnalyzersChecksPerform() 
* eaAnalyzersReport()
* eaAnalyzersDumpTrace()

---
#### `void eaAnalyzersChecksPerform()`
Runs checks and analysis for all *Inspectors* of all Analyzers (required)

---
#### `void eaAnalyzersReport()`
Reports a final summary of all Analyzer showing relevant proposals for potential error pattern - (required).

Reporting is only done if all Analyzer have run their inspections upfront. After reporting the Reporter is shut down.

---
####  `void eaAnalyzersDumpTrace()`
Dumps the results of the all Analyzers into a waveforms - (optional).

Waveform dumping is only done if all Analyzer have run their inspections upfront. 

The waveforms are dumped in two formats:
* `vcd` Generic, ASCII based format which can be read-in with almost every waveform viewer 
* `fst` Binary format which is GTKWave specific 

---
## Logging Functions
These functions report different kinds of messages that get written into
the eaLogFile and also printed to the console.

Parameters:
* reportID        - A short descriptive string concerning the message
* elementID       - The integer ID of the analyzer the message is associated with (can be EA_ANALYZER_NONE, meaning not associated with any analyzer)
* msg             - The actual message string
* reportVerbosity - Verbosity level for messages 

---
#### `void eaReportFatal(  input string reportID, input int elementID, input string msg)`
Reports a fatal message.
#### `void eaReportError(  input string reportID, input int elementID, input string msg)`
Reports an error message.
#### `void eaReportWarning(input string reportID, input int elementID, input string msg)`
Reports a warning message.
#### `void eaReportInfo(   input string reportID, input int elementID, input string msg, input int reportVerbosity)`
Reports an info message.
#### `void eaReportDebug(  input string reportID, input int elementID, input string msg)`
Reports a debug message.
