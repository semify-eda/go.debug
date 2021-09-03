# Database File Description

The results of *ErrorAnalyzer* after each run could be observed in easily human-readable file. The database file is stored in *YAML* format under the name `eaDatabase.yaml`. See [YAML](https://yaml.org/) for details. Database file is also machine-readable, which allows user to import the *YAML* file using Python script. The database contains *ErrorAnalyzer* general information, including configuration. Further more, database contains information for all *Analyzers* used for sample checks. *AnalyzersSummary* contains information about sample fails and possible fixable samples, including the name of Sample/Segment *Inspector*. Lastly, database contains all *InspectorSamples* and *InspectorSegment* information, including their configuration. The recommended website on which the database is easily uploaded and observable is reachable via this [link](https://jsonformatter.org/yaml-viewer).

## Parameter Descriptions

`General Information:` \
&nbsp;&nbsp;`DatabaseVersion: [str]` Version of the current database used. \
&nbsp;&nbsp;`Generated:` \
&nbsp;&nbsp;&nbsp;&nbsp;`Date: [str]` Date database is generated. \
&nbsp;&nbsp;&nbsp;&nbsp;`Time: [str]` Time the databse is generated at. \
&nbsp;&nbsp;`APIVersion: [str]` *EA* API version used. \
&nbsp;&nbsp;`CfgFiles: [str]` List of configuration files used. \
&nbsp;&nbsp;`Path: [str]` Database and Log file path. \
&nbsp;&nbsp;`LogFile: [str]` Logfile name. \
&nbsp;&nbsp;`Database: [str]` Database file name. \
&nbsp;&nbsp;`DumpFileFst: [str]` Fst dump file name. \
&nbsp;&nbsp;`DumpFileVcd: [str]` Vcd dump file name. \
`AnalyzersReport:` \
&nbsp;&nbsp;`Analyzer1:` Analyzer reported. \
&nbsp;&nbsp;&nbsp;&nbsp;`ID: [int]` ID of reported analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`Name: [str]` Name of reported analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`Type: [int]` Type of the analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`DataFormat:` Data format used. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`DataBitWidth: [int]` Data bit width. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`BitFracWidth: [int]` Bit fractal width. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`DataIsSigned: [bool]` If data is signed or not. \
&nbsp;&nbsp;&nbsp;&nbsp;`IsTimed: [bool]` If time is measured while analyzer working. \
&nbsp;&nbsp;&nbsp;&nbsp;`TimeUnit: [str]` Time unit used. \
&nbsp;&nbsp;&nbsp;&nbsp;`TimeStart: [long long]` When first sample added to analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`TimeEnd: [long long]` When last sample added to analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`DataReadMin: [int]` Minimal data read by the analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`DataReadMax: [int]` Maximal data read by the analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`DataExpectedMin: [int]` Minimal data expected by the analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`DataExpectedMax: [int]` Maximal data expected by the analyzer. \
&nbsp;&nbsp;&nbsp;&nbsp;`SampleNbr: [int]` Number of samples added. \
&nbsp;&nbsp;&nbsp;&nbsp;`SamplePassNbr: [int]` Number of samples passing tests. \
&nbsp;&nbsp;&nbsp;&nbsp;`SampleFailNbr: [int]` Number of samples failing tests. \
&nbsp;&nbsp;&nbsp;&nbsp;`FailReport:` If any sample fail, report.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`SampleFailNbrFirst: [int]` First sample to fail. \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`SampleFailNbrLast: [int]` Last sample to fail. \
&nbsp;&nbsp;&nbsp;&nbsp;`SampleInspector_#:` Sample inspector including all data provided.\
&nbsp;&nbsp;&nbsp;&nbsp;`SegmentInspector_#:` Segment inspector including all data provided.\
`AnalyzersSummary:` Summary if any sample is failing \
&nbsp;&nbsp;`Error_#:` \
&nbsp;&nbsp;&nbsp;&nbsp;`AnalyzerID: [int]` ID of analyzer which detected failure. \
&nbsp;&nbsp;&nbsp;&nbsp;`ErrorPatternID: [str]` ID of the failing pattern. \
&nbsp;&nbsp;&nbsp;&nbsp;`SampleFailCheckNbr: [int]` Number of samples failing used for analyzis. \
&nbsp;&nbsp;&nbsp;&nbsp;`SampleFailCheckPosNbr: [int]` Number of samples with potential fix. \
&nbsp;&nbsp;&nbsp;&nbsp;`SampleFailCheckNegNbr: [int]` Number of sampels without potential fix. \
`InspectorSamples:` All InspectorSamples information reported \
`InspectorSegment:` All InspectorSegment information reported \

## Actual File Example

```

---
General Information:
  DatabaseVersion: 1v2
  Generated:
    Date: 23.8.2021
    Time: 13-37-46
  APIVersion: 2v2
  CfgFiles:
    /mnt/c/Users/VladimirM/Documents/database/ea_dev/eaConfig.yml
    /mnt/c/Users/VladimirM/Documents/database/ea_dev/integration/shiftreg/sim.verilator/eaConfig.yml
  Path: /mnt/c/Users/VladimirM/Documents/database/ea_dev/integration/shiftreg/sim.verilator
  LogFile: eaLogFile.log
  YAMLDatabaseEnable: 1
  YAMLDatabaseFilename: eaDatabase.yaml
  DumpFileFstEnable: 1
  DumpFileFst: eaInspectorWaves.fst
  DumpFileVcdEnable: 1
  DumpFileVcd: eaInspectorWaves.vcd
  ReportSummaryDumpEnable: 1
  ReportSummaryFilename: eaAnalyzerSummary.csv
#  Report all Analyzers
AnalyzersReport:
  Analyzer_001:
    ID: 1
    Name: Bitshift testing
    Type: 0
    DataFormat:
      DataBitWidth: 24
      BitFracWidth: 0
      DataIsSigned: 0
    IsTimed: 1
    TimeUnit: ns
    TimeStart: 64
    TimeEnd: 586
    DataReadMin: 0
    DataReadMax: 4194303
    DataExpectedMin: 0
    DataExpectedMax: 16777215
    SampleNbr: 10
    SamplePassNbr: 3
    SampleFailNbr: 7
    FailReport:
      SampleFailNbrFirst: 1
      SampleFailNbrLast: 7
    SampleInspector_01:
      Category: LOG
      Subcategory: SHIFT
      BitShiftMin: -2
      BitShiftMax: 2
      BitShiftDiff: 5
      ShiftLeft_02:
        SampleCheckNbr: 7
        SampleFailCheckPosNbr: 7
        SampleFailCheckNegNbr: 0
        SampleFailCheckPosPerc: 100.000000%
      ShiftLeft_01:
        SampleCheckNbr: 7
        SampleFailCheckPosNbr: 1
        SampleFailCheckNegNbr: 6
        SampleFailCheckPosPerc: 14.285715%
      ShiftRight_01:
        SampleCheckNbr: 7
        SampleFailCheckPosNbr: 0
        SampleFailCheckNegNbr: 7
        SampleFailCheckPosPerc: 0.000000%
      ShiftRight_02:
        SampleCheckNbr: 7
        SampleFailCheckPosNbr: 0
        SampleFailCheckNegNbr: 7
        SampleFailCheckPosPerc: 0.000000%
    SegmentInspector_02:
      Category: TIM
      Subcategory: SHIFT
      SampleShiftMin: -2
      SampleShiftMax: 2
      ByteShiftMin: -3
      ByteShiftMax: 3
      SamplesShiftDiff: 5
      SamplesShiftOffset: 2
      BytesShiftDiff: 7
      BytesShiftOffset: 3
      DelayedSample_02:
        SampleCheckNbr: 6
        SampleFailCheckPosNbr: 0
        SampleFailCheckNegNbr: 6
        SampleFailCheckPosPerc: 0.000000%
      DelayedSample_01:
        SampleCheckNbr: 7
        SampleFailCheckPosNbr: 1
        SampleFailCheckNegNbr: 6
        SampleFailCheckPosPerc: 14.285715%
      AheadSample_01:
        SampleCheckNbr: 6
        SampleFailCheckPosNbr: 0
        SampleFailCheckNegNbr: 6
        SampleFailCheckPosPerc: 0.000000%
      AheadSample_02:
        SampleCheckNbr: 6
        SampleFailCheckPosNbr: 0
        SampleFailCheckNegNbr: 6
        SampleFailCheckPosPerc: 0.000000%
    ...
AnalyzersSummary:
  Error_001:
    AnalyzerID: 1
    ErrorPatternID: LOG.SHIFT.LEFT_02 
    SampleFailCheckNbr: 7
    SampleFailCheckPosNbr: 7
    SampleFailCheckNegNbr: 0
  Error_002:
    AnalyzerID: 1
    ErrorPatternID: NUM.CONST.PASS
    SampleFailCheckNbr: 3
    SampleFailCheckPosNbr: 3
    SampleFailCheckNegNbr: 0

```
