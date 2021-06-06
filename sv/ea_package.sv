//  --------------------------------------------------------------------------
//                    Copyright Message
//  --------------------------------------------------------------------------
//
//  CONFIDENTIAL and PROPRIETARY
//  COPYRIGHT (c) Klaus Strohmayer 2020
//
//  All rights are reserved. Reproduction in whole or in part is
//  prohibited without the written consent of the copyright owner.
//
//
//  ----------------------------------------------------------------------------
//                    Description
//  ----------------------------------------------------------------------------
//
//  Package including all functions required for interfacing with 
//  Error Analyzer via DPI
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-12-30  kstrohma   Initial release
//  2020-10-07  kstrohma   Added description for DPI interface functions
//                         Added API version number and corresponding checking functions eaAPIVersionOk()
//                         Added definition of EA_OK, EA_NOTOK
//

package ea_package;
 
  // API version --> needs to match to the API version of the called C functions   
  localparam EA_API_VERSION    = 2;
  localparam EA_API_SUBVERSION = 2;
  
  // OK, not ok 
  localparam EA_OK    = 1;
  localparam EA_NOTOK = 0;
  
  // Verbosity level for messages (similar to UVM)
  localparam EA_VERBOSITY_LEVEL_NONE   =    0;
  localparam EA_VERBOSITY_LEVEL_LOW    =  100;
  localparam EA_VERBOSITY_LEVEL_MEDIUM =  200;
  localparam EA_VERBOSITY_LEVEL_HIGH   =  300;
  localparam EA_VERBOSITY_LEVEL_FULL   =  400;
  localparam EA_VERBOSITY_LEVEL_DEBUG  =  500;

  // Severity (importance) level of logging messages
  localparam EA_SEVERITY_FATAL     =     EA_VERBOSITY_LEVEL_NONE;
  localparam EA_SEVERITY_ERROR     =     EA_VERBOSITY_LEVEL_MEDIUM;
  localparam EA_SEVERITY_WARNING   =     EA_VERBOSITY_LEVEL_HIGH;
  localparam EA_SEVERITY_INFO      =     EA_VERBOSITY_LEVEL_FULL;
  
  // Analyzer Type
  localparam EA_TYPE_LOG          = 0;
  localparam EA_TYPE_ARITH        = 1;
  
  // Data type
  localparam EA_DATA_IS_UNSIGNED  = 0;
  localparam EA_DATA_IS_SIGNED    = 1;
  
  // No analyzer 
  localparam  EA_ANALYZER_NONE = -1;
    
  // External functions 
  `ifndef EA_DPI_USE_DUMMY 
    
    // -----------------------------------------------------------------------
    // General functions 
    // -----------------------------------------------------------------------
    
    /// Checks the locally defined SystemVerilog functions and the C DPI functions use the same API version - (option).
    ///
    /// It is highly recommended to perform this check at the beginning of the simulation in order to avoid any unexpected
    /// simulation results or even simulation crashes.
    /// Result:
    ///   * `EA_NOTOK (0)`: API versions do not match. The Analyzer result might not be as expected. It even can lead to simulation crashes.
    ///   * `EA_OK (1)   `: API versions match.
    /// Indented to be called from the testbench in the following way: `eaAPIVersionOk(EA_API_VERSION, EA_API_SUBVERSION);` 
    import "DPI-C" function int eaAPIVersionOk(input int Version, input int SubVersion);
    
    // -----------------------------------------------------------------------
    // Analyzer specific functions 
    // -----------------------------------------------------------------------
    
    /// Creates an Analyzer instance - (required). 
    /// 
    /// Provides an handle to the Analyzer instance. 
    import "DPI-C" context function int  eaAnalyzerCreate(input string Name, input int Type, input int DataBitWidth, input int DataIsSigned, longint Time);
    
    /// Add an new sample to an existing Analyzer instance - (required).
    ///
    /// Hands over the read data and the expected data as well as the actual time.
    import "DPI-C" function void eaAnalyzerAddSample(input int ID, input int DataRead, input int DataExpected, longint Time);
    
    /// Reports the actual information about an Analyzer - (optional).
    ///
    /// The function only informations about the Analyzer itself. It does not 
    /// trigger any checks or report information about *Inspector* findings.
    /// The information is dumped into the log file.
    import "DPI-C" function void eaAnalyzerReport(int ID);

    /// Reports all actual samples of the given Analyzer - (optional). 
    import "DPI-C" function void eaAnalyzerSamplesReport(int ID);
    
    /// Runs checks and analysis for all *Inspectors* of a given Analyzer - (required).
    ///
    /// After performing the analysis and checks the result is logged using
    /// the defined reporting limit into the log file.
    /// This function needs to be called before the overall summary reporting 
    /// (`eaAnalyzersReport()`) and waveform dumping (`eaAnalyzersDumpTrace()`) is done.
    import "DPI-C" function void eaAnalyzerChecksPerform(int ID);


    // -----------------------------------------------------------------------
    // Functions applied to all Analyzer 
    // -----------------------------------------------------------------------
    
    /// Runs all the stages for all Analyzers at once.
    /// Calls :
    ///   eaAnalyzersChecksPerform() 
    ///   eaAnalyzersReport()
    ///   eaAnalyzersDumpTrace()
    import "DPI-C" function void eaAnalyzersFinal();
    
    /// Runs checks and analysis for all *Inspectors* of all Analyzers
    import "DPI-C" function void eaAnalyzersChecksPerform();

    /// Reports a final summary of all Analyzer showing relevant proposals for potential error pattern - (required).
    ///
    /// Reporting is only done if all Analyzer have run their inspections upfront. 
    /// After reporting the Reporter is shut down.
    import "DPI-C" function void eaAnalyzersReport();
    
    /// Dumps the results of the all Analyzers into a waveforms - (optional).
    ///
    /// Waveform dumping is only done if all Analyzer have run their inspections upfront.
    /// The waveforms are dumped in two formats:
    ///  * vcd ... Generic, ASCII based format which can be read-in with almost every waveform viewer 
    ///  * fst ... Binary format which is GTKWave specific 
    import "DPI-C" function void eaAnalyzersDumpTrace(); 
    
    /// Import Logging Functions
    /// These functions report different kinds of messages that get written into
    /// the eaLogFile and also printed to the console.
    /// Parameters:
    ///  * reportID        - A short descriptive string concerning the message
    ///  * elementID       - The integer ID of the analyzer the message is associated with (can be EA_ANALYZER_NONE, meaning not associated with any analyzer)
    ///  * msg             - The actual message string
    ///  * reportVerbosity - Verbosity level for messages (see top of this file)
    /// Report a fatal message (can't be masked)
    import "DPI-C" function void eaReportFatal(  input string reportID, input int elementID, input string msg);
    /// Report an error message
    import "DPI-C" function void eaReportError(  input string reportID, input int elementID, input string msg);
    /// Report a warning message
    import "DPI-C" function void eaReportWarning(input string reportID, input int elementID, input string msg);
    /// Report an info message (has also a verbosity associated)
    import "DPI-C" function void eaReportInfo(   input string reportID, input int elementID, input string msg, input int reportVerbosity);
    /// Report a debug message
    import "DPI-C" function void eaReportDebug(  input string reportID, input int elementID, input string msg);
    
  `else
     // Function stubs for disabling the ErrorAnalyzer functionality. 
     // 
     // For a description of the functions see above.
     function int eaAPIVersionOk(input int Version, input int SubVersion);
       return EA_OK;
     endfunction  
     
     function int  eaAnalyzerCreate(input string Name, input int Type, input int DataBitWidth, input int DataIsSigned, longint Time);
       return 0;
     endfunction
       
     function void eaAnalyzerAddSample(input int ID, input int DataRead, input int DataExpected, longint Time);
     endfunction
       
     function void eaAnalyzerReport(int ID);
     endfunction
       
     function void eaAnalyzerSamplesReport(int ID);
     endfunction
  
     function void eaAnalyzerChecksPerform(int ID);
     endfunction
     
     function void eaAnalyzersFinal();
     endfunction
     
     function void eaAnalyzersChecksPerform();
     endfunction
      
     function void eaAnalyzersReport(); 
     endfunction

     function void eaAnalyzersDumpTrace(); 
     endfunction
     
     function void eaReportFatal(input string reportID, input int elementID, input string msg);
     endfunction
     
     function void eaReportError(input string reportID, input int elementID, input string msg);
     endfunction
     
     function void eaReportWarning(input string reportID, input int elementID, input string msg);
     endfunction
     
     function void eaReportInfo(input string reportID, input int elementID, input string msg, input int reportVerbosity);
     endfunction
     
     function void eaReportDebug(input string reportID, input int elementID, input string msg);
     endfunction
     
  `endif

endpackage





