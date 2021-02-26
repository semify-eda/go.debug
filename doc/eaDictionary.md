# ErrorAnalyzer Message Dictionary



## Alphabetical Sorted messages by Message ID:

| MessageID | Message | Description |
| --- | --- | --- |
| AAS | Added sample [%05d] at %8lld%s: Data read: 0x%04x, Data expected: 0x%04x | Reports a new sample added to the given Analyzer |
| ACHKSUM | Analyzer Inspector / Checker result summary: %s | Provides a Analyzer Inspector / Checker analysis summary |
| ANEW | Created new Analyzer with ID=%d. | New Analyzer has been created using identifier ID. |
| ANF | Analyzer %d not found! | Analyzer not found. |
| APIINFO | ErrorAnalyzer uses API version %dv%d. | Information about the used ErrorAnalyzer API version |
| APINOTOK | ErrorAnalyzer API version mismatch between Simulator (%dv%d)) and DPI-C functions (%dv%d). | Check between Simulator and DPI-C functions version shows mismatch. This might result in a Simulator crash. |
| APIOK | ErrorAnalyzer API version matches between Simulator and DPI-C functions (%dv%d). | Check between Simulator and DPI-C function version is ok |
| ASUM | Analyzer summary: %s | Provides an actual Analyzer summary |
| CFGFILE | Using configuration file: %s | Indicates the configuration file that is being used. |
| CFGILLEG | The value "%s" for parameter "%s" is illegal. Using maximum for your license level [ %s ]: %s | Indicates that the license found is not valid, and that the trial version will be used. |
| CFGNOFIL | No config file found. | Issues a warning if no config file is found in any location. |
| CFGRPORT | EA Configuration Report: | Reports EA configuration values |
| CFGVALER | Variable "%s" in configuration file %s has an illegal value: %s. Using default value: %s | Issues a warning if a variable has an illegal value in the configuration file |
| CFGVARER | Variable "%s" in configuration file %s could not be read correctly. See documentation for accepted values. | Issues a warning if a variable fails to be correctly read from the configuration file |
| DUMPFST | Created Analyzer trace file %s and dumped traces in GtkWave fst format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a GtkWave fst file. |
| DUMPVCD | Created Analyzer trace file %s and dumped traces in vcd format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a vcd file. |
| EADATE | Build date %s. | Provides the date of the ErrorAnalyzer build. |
| EAVER | Using ErrorAnalyzer version %s. | Provides the actual ErrorAnalyzer version. |
| GMDEBUG | General message: %s! | Prints a general debug message %s without any specific message ID. Mainly used for debugging purpose |
| GMINFO | General message: %s! | Prints a general info message %s without any specific message ID. |
| INSPREP | Report Inspector %s.%s: %s. | Reports the inspector results. |
| LFCLOSE | Written log file %s. | Indicates that all data is written, and the log file is closed. |
| LFNEW | Created log file %s at %s | Indicates that a new log file has been created. |
| LFSUM | Message summary. | Provides a summary of occurred fatal, error, warning and info messages |
| LICERR | License %s is not valid. Using trial version. | Indicates that the license found is not valid, and that the trial version will be used. |
| LICEXPIR | License %s has expired. | Indicates that the license found has expired |
| LICFILE | Using license file: %s | Indicates the license file that is being used. |
| LICFOUND | Found license file %s | Indicates the locations where we found a license file. |
| LICKEYER | License key mismatch. The licence %s is corrupted. | Indicates that the license found a key mismatch, and therefore is not valid. |
| LICNOFIL | No license file found. Using trial version. | Issues a warning if no license file is found in any location. |
| LICSRCH | Looking for license file in %s | Indicates the locations EA looks in for a license file. |
| LICTYPER | License type is wrong. The licence %s is corrupted. | Indicates that the license found a wrong type, and therefore is not valid. |
| LICVALID | License %s is valid. Level: %s, Expiration date: %s | Indicates that the license found is valid and prints the expiration date |
| MAXANLZR | Can't create a new analyzer, maximum number of Analyzers reached. | Issues a warning if the maximum number of analyzers has been reached. |
| MAXSMPLS | Can't create a new sample, maximum number of samples reached. | Issues a warning if the maximum number of samples has been reached. |
| NOENV | %s environment variable not set. | Issues a warning that the EA_CONFIG environment varible was not set. |
| NOPATH | Could not get current path from system. | The current path could not be found. |
| REPNOPAT | No Analyzer with error pattern proposals available. | Indicates that there is no Analyzer available which found any error pattern so far. This results in an empty summary |
| REPPAT | Analyzer with error pattern proposals available. | Indicates that there are one or more Analyzer available which found an error pattern so far. See summary for details |
| USMID | Unknown standard message ID %s! | The given standard message ID does not exist. |



## Messages sorted by Message Severity:

### EA_SEVERITY_FATAL

| MessageID | Message | Description |
| --- | --- | --- |
| AAS | Added sample [%05d] at %8lld%s: Data read: 0x%04x, Data expected: 0x%04x | Reports a new sample added to the given Analyzer |
| ACHKSUM | Analyzer Inspector / Checker result summary: %s | Provides a Analyzer Inspector / Checker analysis summary |
| ANEW | Created new Analyzer with ID=%d. | New Analyzer has been created using identifier ID. |
| APIINFO | ErrorAnalyzer uses API version %dv%d. | Information about the used ErrorAnalyzer API version |
| APIOK | ErrorAnalyzer API version matches between Simulator and DPI-C functions (%dv%d). | Check between Simulator and DPI-C function version is ok |
| ASUM | Analyzer summary: %s | Provides an actual Analyzer summary |
| CFGFILE | Using configuration file: %s | Indicates the configuration file that is being used. |
| CFGRPORT | EA Configuration Report: | Reports EA configuration values |
| DUMPFST | Created Analyzer trace file %s and dumped traces in GtkWave fst format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a GtkWave fst file. |
| DUMPVCD | Created Analyzer trace file %s and dumped traces in vcd format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a vcd file. |
| EADATE | Build date %s. | Provides the date of the ErrorAnalyzer build. |
| EAVER | Using ErrorAnalyzer version %s. | Provides the actual ErrorAnalyzer version. |
| GMDEBUG | General message: %s! | Prints a general debug message %s without any specific message ID. Mainly used for debugging purpose |
| GMINFO | General message: %s! | Prints a general info message %s without any specific message ID. |
| INSPREP | Report Inspector %s.%s: %s. | Reports the inspector results. |
| LFCLOSE | Written log file %s. | Indicates that all data is written, and the log file is closed. |
| LFNEW | Created log file %s at %s | Indicates that a new log file has been created. |
| LFSUM | Message summary. | Provides a summary of occurred fatal, error, warning and info messages |
| LICFILE | Using license file: %s | Indicates the license file that is being used. |
| LICFOUND | Found license file %s | Indicates the locations where we found a license file. |
| LICSRCH | Looking for license file in %s | Indicates the locations EA looks in for a license file. |
| LICVALID | License %s is valid. Level: %s, Expiration date: %s | Indicates that the license found is valid and prints the expiration date |
| NOENV | %s environment variable not set. | Issues a warning that the EA_CONFIG environment varible was not set. |
| NOPATH | Could not get current path from system. | The current path could not be found. |
| REPNOPAT | No Analyzer with error pattern proposals available. | Indicates that there is no Analyzer available which found any error pattern so far. This results in an empty summary |
### EA_SEVERITY_ERROR

| MessageID | Message | Description |
| --- | --- | --- |
| ANF | Analyzer %d not found! | Analyzer not found. |
| APINOTOK | ErrorAnalyzer API version mismatch between Simulator (%dv%d)) and DPI-C functions (%dv%d). | Check between Simulator and DPI-C functions version shows mismatch. This might result in a Simulator crash. |
| CFGILLEG | The value "%s" for parameter "%s" is illegal. Using maximum for your license level [ %s ]: %s | Indicates that the license found is not valid, and that the trial version will be used. |
| CFGNOFIL | No config file found. | Issues a warning if no config file is found in any location. |
| CFGVALER | Variable "%s" in configuration file %s has an illegal value: %s. Using default value: %s | Issues a warning if a variable has an illegal value in the configuration file |
| CFGVARER | Variable "%s" in configuration file %s could not be read correctly. See documentation for accepted values. | Issues a warning if a variable fails to be correctly read from the configuration file |
| LICERR | License %s is not valid. Using trial version. | Indicates that the license found is not valid, and that the trial version will be used. |
| LICEXPIR | License %s has expired. | Indicates that the license found has expired |
| LICKEYER | License key mismatch. The licence %s is corrupted. | Indicates that the license found a key mismatch, and therefore is not valid. |
| LICNOFIL | No license file found. Using trial version. | Issues a warning if no license file is found in any location. |
| LICTYPER | License type is wrong. The licence %s is corrupted. | Indicates that the license found a wrong type, and therefore is not valid. |
| MAXANLZR | Can't create a new analyzer, maximum number of Analyzers reached. | Issues a warning if the maximum number of analyzers has been reached. |
| MAXSMPLS | Can't create a new sample, maximum number of samples reached. | Issues a warning if the maximum number of samples has been reached. |
| REPPAT | Analyzer with error pattern proposals available. | Indicates that there are one or more Analyzer available which found an error pattern so far. See summary for details |
### EA_SEVERITY_WARRNING

| MessageID | Message | Description |
| --- | --- | --- |
| USMID | Unknown standard message ID %s! | The given standard message ID does not exist. |



## Messages sorted by Message Verbosity:

### EA_VERBOSITY_LEVEL_NONE

| MessageID | Message | Description |
| --- | --- | --- |
| ACHKSUM | Analyzer Inspector / Checker result summary: %s | Provides a Analyzer Inspector / Checker analysis summary |
| ANF | Analyzer %d not found! | Analyzer not found. |
| APINOTOK | ErrorAnalyzer API version mismatch between Simulator (%dv%d)) and DPI-C functions (%dv%d). | Check between Simulator and DPI-C functions version shows mismatch. This might result in a Simulator crash. |
| CFGFILE | Using configuration file: %s | Indicates the configuration file that is being used. |
| CFGILLEG | The value "%s" for parameter "%s" is illegal. Using maximum for your license level [ %s ]: %s | Indicates that the license found is not valid, and that the trial version will be used. |
| CFGNOFIL | No config file found. | Issues a warning if no config file is found in any location. |
| CFGVALER | Variable "%s" in configuration file %s has an illegal value: %s. Using default value: %s | Issues a warning if a variable has an illegal value in the configuration file |
| CFGVARER | Variable "%s" in configuration file %s could not be read correctly. See documentation for accepted values. | Issues a warning if a variable fails to be correctly read from the configuration file |
| DUMPFST | Created Analyzer trace file %s and dumped traces in GtkWave fst format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a GtkWave fst file. |
| DUMPVCD | Created Analyzer trace file %s and dumped traces in vcd format. | Indicates that the Analyzer trace file has been created and the traces have been dumped in a vcd file. |
| EADATE | Build date %s. | Provides the date of the ErrorAnalyzer build. |
| EAVER | Using ErrorAnalyzer version %s. | Provides the actual ErrorAnalyzer version. |
| GMINFO | General message: %s! | Prints a general info message %s without any specific message ID. |
| LFCLOSE | Written log file %s. | Indicates that all data is written, and the log file is closed. |
| LFNEW | Created log file %s at %s | Indicates that a new log file has been created. |
| LFSUM | Message summary. | Provides a summary of occurred fatal, error, warning and info messages |
| LICERR | License %s is not valid. Using trial version. | Indicates that the license found is not valid, and that the trial version will be used. |
| LICEXPIR | License %s has expired. | Indicates that the license found has expired |
| LICFILE | Using license file: %s | Indicates the license file that is being used. |
| LICFOUND | Found license file %s | Indicates the locations where we found a license file. |
| LICKEYER | License key mismatch. The licence %s is corrupted. | Indicates that the license found a key mismatch, and therefore is not valid. |
| LICNOFIL | No license file found. Using trial version. | Issues a warning if no license file is found in any location. |
| LICSRCH | Looking for license file in %s | Indicates the locations EA looks in for a license file. |
| LICTYPER | License type is wrong. The licence %s is corrupted. | Indicates that the license found a wrong type, and therefore is not valid. |
| LICVALID | License %s is valid. Level: %s, Expiration date: %s | Indicates that the license found is valid and prints the expiration date |
| MAXANLZR | Can't create a new analyzer, maximum number of Analyzers reached. | Issues a warning if the maximum number of analyzers has been reached. |
| MAXSMPLS | Can't create a new sample, maximum number of samples reached. | Issues a warning if the maximum number of samples has been reached. |
| NOENV | %s environment variable not set. | Issues a warning that the EA_CONFIG environment varible was not set. |
| NOPATH | Could not get current path from system. | The current path could not be found. |
| REPNOPAT | No Analyzer with error pattern proposals available. | Indicates that there is no Analyzer available which found any error pattern so far. This results in an empty summary |
| REPPAT | Analyzer with error pattern proposals available. | Indicates that there are one or more Analyzer available which found an error pattern so far. See summary for details |
| USMID | Unknown standard message ID %s! | The given standard message ID does not exist. |
### EA_VERBOSITY_LEVEL_MEDIUM

| MessageID | Message | Description |
| --- | --- | --- |
| ANEW | Created new Analyzer with ID=%d. | New Analyzer has been created using identifier ID. |
| APIINFO | ErrorAnalyzer uses API version %dv%d. | Information about the used ErrorAnalyzer API version |
| APIOK | ErrorAnalyzer API version matches between Simulator and DPI-C functions (%dv%d). | Check between Simulator and DPI-C function version is ok |
| ASUM | Analyzer summary: %s | Provides an actual Analyzer summary |
| INSPREP | Report Inspector %s.%s: %s. | Reports the inspector results. |
### EA_VERBOSITY_LEVEL_FULL

| MessageID | Message | Description |
| --- | --- | --- |
| AAS | Added sample [%05d] at %8lld%s: Data read: 0x%04x, Data expected: 0x%04x | Reports a new sample added to the given Analyzer |
| CFGRPORT | EA Configuration Report: | Reports EA configuration values |
### EA_VERBOSITY_LEVEL_DEBUG

| MessageID | Message | Description |
| --- | --- | --- |
| GMDEBUG | General message: %s! | Prints a general debug message %s without any specific message ID. Mainly used for debugging purpose |


Thu Feb 18 19:10:10 2021

