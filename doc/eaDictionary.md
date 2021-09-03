# *ErrorAnalyzer* Message Dictionary
----------


## Messages sorted by Message ID:

| MessageID | Message | Description | Severity | Verbosity |
| --- | :--- | :--- | --- | --- |
| AAS | Added sample [%05d] at %8lld%s: Data read: 0x%04x, Data expected: 0x%04x | Reports a new sample added to the given Analyzer|INFO|FULL |
| ACHKSUM | Analyzer Inspector / Checker result summary: %s | Provides a Analyzer Inspector / Checker analysis summary|INFO|NONE |
| ANEW | Created new Analyzer with ID=%d. | New Analyzer has been created using identifier ID.|INFO|MEDIUM |
| ANF | Analyzer %d not found! | Analyzer not found.|WARNING|NONE |
| APIINFO | ErrorAnalyzer uses API version %dv%d. | Information about the used ErrorAnalyzer API version|INFO|MEDIUM |
| APINOTOK | ErrorAnalyzer API version mismatch between Simulator (%dv%d)) and DPI-C functions (%dv%d). | Check between Simulator and DPI-C functions version shows mismatch. This might result in a Simulator crash.|WARNING|NONE |
| APIOK | ErrorAnalyzer API version matches between Simulator and DPI-C functions (%dv%d). | Check between Simulator and DPI-C function version is ok|INFO|MEDIUM |
| ASUM | Analyzer summary: %s | Provides an actual Analyzer summary|INFO|MEDIUM |
| CFGFILE | Using configuration file: %s | Indicates the configuration file that is being used.|INFO|NONE |
| CFGILLEG | The value "%s" for parameter "%s" is illegal. Using maximum for your license level [ %s ]: %s | Indicates that the license found is not valid, and that the trial version will be used.|WARNING|NONE |
| CFGNOFIL | No config file found. | Issues a warning if no config file is found in any location.|WARNING|NONE |
| CFGRPORT | EA Configuration Report: | Reports EA configuration values|INFO|FULL |
| CFGVALER | Variable "%s" in configuration file %s has an illegal value: %s. Using default value: %s | Issues a warning if a variable has an illegal value in the configuration file|WARNING|NONE |
| CFGVARER | Variable "%s" in configuration file %s could not be read correctly. See documentation for accepted values. | Issues a warning if a variable fails to be correctly read from the configuration file|WARNING|NONE |
| DUMPFST | Created Analyzer trace file %s and dumped traces in GtkWave fst format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a GtkWave fst file.|INFO|NONE |
| DUMPVCD | Created Analyzer trace file %s and dumped traces in vcd format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a vcd file.|INFO|NONE |
| DUMPYAML | Created Analyzer YAML database file %s and dumped Analyzer information to it. | Indicates that the Analyzer database file has been created and the Analyzer information have been dumped in a YAML file.|INFO|NONE |
| EADATE | Build date %s. | Provides the date of the ErrorAnalyzer build.|INFO|NONE |
| EAVER | Using ErrorAnalyzer version %s. | Provides the actual ErrorAnalyzer version.|INFO|NONE |
| GMDEBUG | General message: %s! | Prints a general debug message %s without any specific message ID. Mainly used for debugging purpose|INFO|DEBUG |
| GMINFO | General message: %s! | Prints a general info message %s without any specific message ID.|INFO|NONE |
| INSPREP | Report Inspector %s.%s: %s. | Reports the inspector results.|INFO|MEDIUM |
| LFCLOSE | Written log file %s. | Indicates that all data is written, and the log file is closed.|INFO|NONE |
| LFNEW | Created log file %s at %s | Indicates that a new log file has been created.|INFO|NONE |
| LFSUM | Message summary. | Provides a summary of occurred fatal, error, warning and info messages|INFO|NONE |
| LICERR | License %s is not valid. Using trial version. | Indicates that the license found is not valid, and that the trial version will be used.|WARNING|NONE |
| LICEXPIR | License %s has expired. | Indicates that the license found has expired|WARNING|NONE |
| LICFILE | Using license file: %s | Indicates the license file that is being used.|INFO|NONE |
| LICFOUND | Found license file %s | Indicates the locations where we found a license file.|INFO|NONE |
| LICKEYER | License key mismatch. The licence %s is corrupted. | Indicates that the license found a key mismatch, and therefore is not valid.|WARNING|NONE |
| LICNOFIL | No license file found. Using trial version. | Issues a warning if no license file is found in any location.|WARNING|NONE |
| LICSRCH | Looking for license file in %s | Indicates the locations EA looks in for a license file.|INFO|NONE |
| LICTYPER | License type is wrong. The licence %s is corrupted. | Indicates that the license found a wrong type, and therefore is not valid.|WARNING|NONE |
| LICVALID | License %s is valid. Level: %s, Expiration date: %s | Indicates that the license found is valid and prints the expiration date|INFO|NONE |
| MAXANLZR | Can't create a new analyzer, maximum number of Analyzers reached. | Issues a warning if the maximum number of analyzers has been reached.|WARNING|NONE |
| MAXSMPLS | Can't create a new sample, maximum number of samples reached. | Issues a warning if the maximum number of samples has been reached.|WARNING|NONE |
| NOENV | %s environment variable not set. | Issues a warning that the EA_CONFIG environment varible was not set.|INFO|NONE |
| NOPATH | Could not get current path from system. | The current path could not be found.|INFO|NONE |
| REPNOPAT | No Analyzer with error pattern proposals available. | Indicates that there is no Analyzer available which found any error pattern so far. This results in an empty summary|INFO|NONE |
| REPPAT | Analyzer with error pattern proposals available. | Indicates that there are one or more Analyzer available which found an error pattern so far. See summary for details|WARNING|NONE |
| USMID | Unknown standard message ID %s! | The given standard message ID does not exist.|ERROR|NONE |



## Messages sorted by Severity:

### EA_SEVERITY_INFO

| MessageID | Message | Description | Verbosity |
| --- | :--- | :--- | --- |
| AAS | Added sample [%05d] at %8lld%s: Data read: 0x%04x, Data expected: 0x%04x | Reports a new sample added to the given Analyzer|FULL |
| ACHKSUM | Analyzer Inspector / Checker result summary: %s | Provides a Analyzer Inspector / Checker analysis summary|NONE |
| ANEW | Created new Analyzer with ID=%d. | New Analyzer has been created using identifier ID.|MEDIUM |
| APIINFO | ErrorAnalyzer uses API version %dv%d. | Information about the used ErrorAnalyzer API version|MEDIUM |
| APIOK | ErrorAnalyzer API version matches between Simulator and DPI-C functions (%dv%d). | Check between Simulator and DPI-C function version is ok|MEDIUM |
| ASUM | Analyzer summary: %s | Provides an actual Analyzer summary|MEDIUM |
| CFGFILE | Using configuration file: %s | Indicates the configuration file that is being used.|NONE |
| CFGRPORT | EA Configuration Report: | Reports EA configuration values|FULL |
| DUMPFST | Created Analyzer trace file %s and dumped traces in GtkWave fst format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a GtkWave fst file.|NONE |
| DUMPVCD | Created Analyzer trace file %s and dumped traces in vcd format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a vcd file.|NONE |
| DUMPYAML | Created Analyzer YAML database file %s and dumped Analyzer information to it. | Indicates that the Analyzer database file has been created and the Analyzer information have been dumped in a YAML file.|NONE |
| EADATE | Build date %s. | Provides the date of the ErrorAnalyzer build.|NONE |
| EAVER | Using ErrorAnalyzer version %s. | Provides the actual ErrorAnalyzer version.|NONE |
| GMDEBUG | General message: %s! | Prints a general debug message %s without any specific message ID. Mainly used for debugging purpose|DEBUG |
| GMINFO | General message: %s! | Prints a general info message %s without any specific message ID.|NONE |
| INSPREP | Report Inspector %s.%s: %s. | Reports the inspector results.|MEDIUM |
| LFCLOSE | Written log file %s. | Indicates that all data is written, and the log file is closed.|NONE |
| LFNEW | Created log file %s at %s | Indicates that a new log file has been created.|NONE |
| LFSUM | Message summary. | Provides a summary of occurred fatal, error, warning and info messages|NONE |
| LICFILE | Using license file: %s | Indicates the license file that is being used.|NONE |
| LICFOUND | Found license file %s | Indicates the locations where we found a license file.|NONE |
| LICSRCH | Looking for license file in %s | Indicates the locations EA looks in for a license file.|NONE |
| LICVALID | License %s is valid. Level: %s, Expiration date: %s | Indicates that the license found is valid and prints the expiration date|NONE |
| NOENV | %s environment variable not set. | Issues a warning that the EA_CONFIG environment varible was not set.|NONE |
| NOPATH | Could not get current path from system. | The current path could not be found.|NONE |
| REPNOPAT | No Analyzer with error pattern proposals available. | Indicates that there is no Analyzer available which found any error pattern so far. This results in an empty summary|NONE |
### EA_SEVERITY_WARNING

| MessageID | Message | Description | Verbosity |
| --- | :--- | :--- | --- |
| ANF | Analyzer %d not found! | Analyzer not found.|NONE |
| APINOTOK | ErrorAnalyzer API version mismatch between Simulator (%dv%d)) and DPI-C functions (%dv%d). | Check between Simulator and DPI-C functions version shows mismatch. This might result in a Simulator crash.|NONE |
| CFGILLEG | The value "%s" for parameter "%s" is illegal. Using maximum for your license level [ %s ]: %s | Indicates that the license found is not valid, and that the trial version will be used.|NONE |
| CFGNOFIL | No config file found. | Issues a warning if no config file is found in any location.|NONE |
| CFGVALER | Variable "%s" in configuration file %s has an illegal value: %s. Using default value: %s | Issues a warning if a variable has an illegal value in the configuration file|NONE |
| CFGVARER | Variable "%s" in configuration file %s could not be read correctly. See documentation for accepted values. | Issues a warning if a variable fails to be correctly read from the configuration file|NONE |
| LICERR | License %s is not valid. Using trial version. | Indicates that the license found is not valid, and that the trial version will be used.|NONE |
| LICEXPIR | License %s has expired. | Indicates that the license found has expired|NONE |
| LICKEYER | License key mismatch. The licence %s is corrupted. | Indicates that the license found a key mismatch, and therefore is not valid.|NONE |
| LICNOFIL | No license file found. Using trial version. | Issues a warning if no license file is found in any location.|NONE |
| LICTYPER | License type is wrong. The licence %s is corrupted. | Indicates that the license found a wrong type, and therefore is not valid.|NONE |
| MAXANLZR | Can't create a new analyzer, maximum number of Analyzers reached. | Issues a warning if the maximum number of analyzers has been reached.|NONE |
| MAXSMPLS | Can't create a new sample, maximum number of samples reached. | Issues a warning if the maximum number of samples has been reached.|NONE |
| REPPAT | Analyzer with error pattern proposals available. | Indicates that there are one or more Analyzer available which found an error pattern so far. See summary for details|NONE |
### EA_SEVERITY_ERROR

| MessageID | Message | Description | Verbosity |
| --- | :--- | :--- | --- |
| USMID | Unknown standard message ID %s! | The given standard message ID does not exist.|NONE |



## Messages sorted by Verbosity:

### EA_VERBOSITY_LEVEL_NONE

| MessageID | Message | Description | Severity |
| --- | :--- | :--- | --- |
| ACHKSUM | Analyzer Inspector / Checker result summary: %s | Provides a Analyzer Inspector / Checker analysis summary|INFO |
| ANF | Analyzer %d not found! | Analyzer not found.|WARNING |
| APINOTOK | ErrorAnalyzer API version mismatch between Simulator (%dv%d)) and DPI-C functions (%dv%d). | Check between Simulator and DPI-C functions version shows mismatch. This might result in a Simulator crash.|WARNING |
| CFGFILE | Using configuration file: %s | Indicates the configuration file that is being used.|INFO |
| CFGILLEG | The value "%s" for parameter "%s" is illegal. Using maximum for your license level [ %s ]: %s | Indicates that the license found is not valid, and that the trial version will be used.|WARNING |
| CFGNOFIL | No config file found. | Issues a warning if no config file is found in any location.|WARNING |
| CFGVALER | Variable "%s" in configuration file %s has an illegal value: %s. Using default value: %s | Issues a warning if a variable has an illegal value in the configuration file|WARNING |
| CFGVARER | Variable "%s" in configuration file %s could not be read correctly. See documentation for accepted values. | Issues a warning if a variable fails to be correctly read from the configuration file|WARNING |
| DUMPFST | Created Analyzer trace file %s and dumped traces in GtkWave fst format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a GtkWave fst file.|INFO |
| DUMPVCD | Created Analyzer trace file %s and dumped traces in vcd format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a vcd file.|INFO |
| DUMPYAML | Created Analyzer YAML database file %s and dumped Analyzer information to it. | Indicates that the Analyzer database file has been created and the Analyzer information have been dumped in a YAML file.|INFO |
| EADATE | Build date %s. | Provides the date of the ErrorAnalyzer build.|INFO |
| EAVER | Using ErrorAnalyzer version %s. | Provides the actual ErrorAnalyzer version.|INFO |
| GMINFO | General message: %s! | Prints a general info message %s without any specific message ID.|INFO |
| LFCLOSE | Written log file %s. | Indicates that all data is written, and the log file is closed.|INFO |
| LFNEW | Created log file %s at %s | Indicates that a new log file has been created.|INFO |
| LFSUM | Message summary. | Provides a summary of occurred fatal, error, warning and info messages|INFO |
| LICERR | License %s is not valid. Using trial version. | Indicates that the license found is not valid, and that the trial version will be used.|WARNING |
| LICEXPIR | License %s has expired. | Indicates that the license found has expired|WARNING |
| LICFILE | Using license file: %s | Indicates the license file that is being used.|INFO |
| LICFOUND | Found license file %s | Indicates the locations where we found a license file.|INFO |
| LICKEYER | License key mismatch. The licence %s is corrupted. | Indicates that the license found a key mismatch, and therefore is not valid.|WARNING |
| LICNOFIL | No license file found. Using trial version. | Issues a warning if no license file is found in any location.|WARNING |
| LICSRCH | Looking for license file in %s | Indicates the locations EA looks in for a license file.|INFO |
| LICTYPER | License type is wrong. The licence %s is corrupted. | Indicates that the license found a wrong type, and therefore is not valid.|WARNING |
| LICVALID | License %s is valid. Level: %s, Expiration date: %s | Indicates that the license found is valid and prints the expiration date|INFO |
| MAXANLZR | Can't create a new analyzer, maximum number of Analyzers reached. | Issues a warning if the maximum number of analyzers has been reached.|WARNING |
| MAXSMPLS | Can't create a new sample, maximum number of samples reached. | Issues a warning if the maximum number of samples has been reached.|WARNING |
| NOENV | %s environment variable not set. | Issues a warning that the EA_CONFIG environment varible was not set.|INFO |
| NOPATH | Could not get current path from system. | The current path could not be found.|INFO |
| REPNOPAT | No Analyzer with error pattern proposals available. | Indicates that there is no Analyzer available which found any error pattern so far. This results in an empty summary|INFO |
| REPPAT | Analyzer with error pattern proposals available. | Indicates that there are one or more Analyzer available which found an error pattern so far. See summary for details|WARNING |
| USMID | Unknown standard message ID %s! | The given standard message ID does not exist.|ERROR |
### EA_VERBOSITY_LEVEL_MEDIUM

| MessageID | Message | Description | Severity |
| --- | :--- | :--- | --- |
| ANEW | Created new Analyzer with ID=%d. | New Analyzer has been created using identifier ID.|INFO |
| APIINFO | ErrorAnalyzer uses API version %dv%d. | Information about the used ErrorAnalyzer API version|INFO |
| APIOK | ErrorAnalyzer API version matches between Simulator and DPI-C functions (%dv%d). | Check between Simulator and DPI-C function version is ok|INFO |
| ASUM | Analyzer summary: %s | Provides an actual Analyzer summary|INFO |
| INSPREP | Report Inspector %s.%s: %s. | Reports the inspector results.|INFO |
### EA_VERBOSITY_LEVEL_FULL

| MessageID | Message | Description | Severity |
| --- | :--- | :--- | --- |
| AAS | Added sample [%05d] at %8lld%s: Data read: 0x%04x, Data expected: 0x%04x | Reports a new sample added to the given Analyzer|INFO |
| CFGRPORT | EA Configuration Report: | Reports EA configuration values|INFO |
### EA_VERBOSITY_LEVEL_DEBUG

| MessageID | Message | Description | Severity |
| --- | :--- | :--- | --- |
| GMDEBUG | General message: %s! | Prints a general debug message %s without any specific message ID. Mainly used for debugging purpose|INFO |


Created on Fri Sep  3 11:39:35 2021

