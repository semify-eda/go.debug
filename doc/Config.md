# Configuration File Description
*ErrorAnalyzer* can be configured via a configuration file. The configuration file is stored in *YAML* format under the name `eaConfig.yml`. See [YAML](http://www.yaml.org) for details.  

There are three possible locations for storing the configuration file `eaConfig.yml`. All three locations are checked during start-up and read in a fixed order. If a configuration parameter is present in more than one configuration file the parameter which occurs last has the highest priority. In other words, the configuration parameters are always overwritten. 

The following order is used:
1. *ErrorAnalyzer* installation directory defined via environment variable `$EA_ROOT`
2. User defined location defined via environment variable `$EA_CONFIG`
3. Actual *ErrorAnalyzer* execution directory 

The configuration is separated into sections.
The naming of the configuration parameter fits to the naming of the corresponding variable within the configuration object 'eaConfig'.

Values can have the following types:

- Boolean: true | false | 0 | 1
- Integer: \<integer\>
- String: \"\<string\>\"

A string delimiter can be either `'` or `"`.

Integer numbers can be given as
- Decimal (no prefix)
- Hexadecimal (0x)
- Binary (0b)

The parameters `Dump:ConsoleVerbosity` and `Dump:FileVerbosity` can be given as
- Integers: `0 | 1 | 2 | 3 | 4 | 5` or `0 | 100 | 200 | 300 | 400 | 500` (corresponding to levels NONE, LOW, MEDIUM, HIGH, FULL, DEBUG)
- Strings: "EA_VERBOSITY_LEVEL_{NONE, LOW, MEDIUM, HIGH, FULL, DEBUG}"

## Parameter Descriptions
`Analyzer:`\
&nbsp;&nbsp;`MaxNbr: [int]` The maximum number of Analyzers that can be used. \
`Samples:` \
&nbsp;&nbsp;`MaxNbr: [int]` The maximum number of samples that can be used. \
`Inspector:` \
&nbsp;&nbsp;`Sample:` \
&nbsp;&nbsp;&nbsp;&nbsp;`DataShift:` \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`Enable: [bool]` Enables the DataShift Inspector \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`BitShiftMin: [int]` Min bit shift to be checked \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`BitShiftMax: [int]` Max bit shift to be checked \
&nbsp;&nbsp;&nbsp;&nbsp;`Bit:` \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`Enable: [bool]` Enables the Bit Inspector \
&nbsp;&nbsp;&nbsp;&nbsp;`Integer:` \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`Enable: [bool]` Enables the Integer Inspector \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`MaxTruncatedBits: [int]` The maximum number of bits that are tested for truncation \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`MaxRoundedBits: [int]` The maximum number of bits that are tested for rounding \
&nbsp;&nbsp;`Segment:` \
&nbsp;&nbsp;&nbsp;&nbsp;`SampleShift:` \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`Enable: [bool]` Enables the SampleShift Inspector \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`SampleShiftMin: [int]` Min shift to be checked in samples \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`SampleShiftMax: [int]` Max shift to be checked in samples \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ByteShiftMin: [int]` Min shift to be checked in bytes \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`ByteShiftMax: [int]` Max shift to be checked in bytes \
&nbsp;&nbsp;&nbsp;&nbsp;`Statistic:` \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`Enable: [bool]` Enables the Statistic Inspector \
&nbsp;&nbsp;&nbsp;&nbsp;`Range:` \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`Enable: [bool]` Enables the Range Inspector \
`Dump:`\
&nbsp;&nbsp;`FileFstEnable: [bool]` Enable waveform dumping to fst file \
&nbsp;&nbsp;`FileFstName: [str]` Fst file name \
&nbsp;&nbsp;`FileVcdEnable: [bool]` Enable waveform dumping to vcd file \
&nbsp;&nbsp;`FileVcdName: [str]` Vcd file name \
&nbsp;&nbsp;`FailAnalzerOnly: [bool]` Control if all waveforms or only the waveforms of failing Analyzers are dumped \
&nbsp;&nbsp;`FailInspectorOnly: [bool]` Control if all waveforms or only the waveforms of failing Inspectors are dumped \
`Log:` \
&nbsp;&nbsp;`ToConsoleEnable: [bool]` Enable logging to console \
&nbsp;&nbsp;`ConsoleVerbosity: [str]` Verbosity level for writing to console (accepted values explained above) \
&nbsp;&nbsp;`ConsoleColorsEnable: [bool]` Enable colored output for the console \
&nbsp;&nbsp;`ToSimConsoleEnable: [bool]` Enable logging to the simulator console \
&nbsp;&nbsp;`ToFileEnable: [bool]` Enable logging to file \
&nbsp;&nbsp;`FileVerbosity: [str]` Verbosity level for writing to file (accepted values explained above) \
&nbsp;&nbsp;`FileName: [str]` Log file name \
&nbsp;&nbsp;`ReportPathEnable: [bool]` Enable reporting the path where report files are saved \
&nbsp;&nbsp;`SumSkipPass: [bool]` In summary, skip Analyzer which are all pass \
`Report:` \
&nbsp;&nbsp;`PosPercLimit: [float]` Percentage of positive fail checks to be reported \
&nbsp;&nbsp;`SummaryDumpEnable: [bool]` Enable dumping analyzer summary into csv file \
&nbsp;&nbsp;`SummaryFilename: [string]` Filename for analyzer summary csv dumping \
&nbsp;&nbsp;`SummaryIncremental: [bool]` Switch between overwriting and appending .csv summary dump file \
&nbsp;&nbsp;`DatabaseFilename: [string]` Filename for dumping Analyzers results database \
&nbsp;&nbsp;`DatabaseDumpEnable: [bool]` Enable dumping Analyzers results to database



## Actual file

```
---
Analyzer:
  MaxNbr: "999"  # up to 999
Samples:
  MaxNbr: "65535" # up to 2^16-1 (65535)
Inspector:
  Sample:
    DataShift:
      Enable:           true
      BitShiftMin:      "-2"
      BitShiftMax:      "2"
    Bit:
      Enable:           true
    Integer:
      Enable:           true
      MaxTruncatedBits: "-1"
      MaxRoundedBits:   "-1"
  Segment:
    SampleShift:
      Enable:           true
      SampleShiftMin:   "-2"
      SampleShiftMax:   "2"
      ByteShiftMin:     "-3"
      ByteShiftMax:     "3"
    Statistic:
      Enable:           true
    Range:
      Enable:           true
Dump:
  FileFstEnable:     true
  FileFstName:       "eaInspectorWaves.fst"
  FileVcdEnable:     true
  FileVcdName:       "eaInspectorWaves.vcd"
  FailAnalzerOnly:   false
  FailInspectorOnly: true
Log:
  ToConsoleEnable:     true
  ConsoleVerbosity:    "EA_VERBOSITY_LEVEL_LOW" # EA_VERBOSITY_LEVEL_LOW
  ConsoleColorsEnable: false
  ToSimConsoleEnable:  false
  ToFileEnable:        true
  FileVerbosity:       "EA_VERBOSITY_LEVEL_FULL" # (EA_VERBOSITY_LEVEL_FULL)
  FileName:            "eaLogFile.log"
  ReportPathEnable: true
  SumSkipPass:         true
Report:
  PosPercLimit:      "50.0"
  SummaryDumpEnable: true
  SummaryFilename:  "eaAnalyzerSummary.csv"
  SummaryIncremental: false
  DatabaseFilename:  "eaDatabase.yaml"
  DatabaseDumpEnable: true
  SummaryFilename:   "eaAnalyzerSummary.csv"
  
```
