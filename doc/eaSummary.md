# *ErrorAnalyzer* Summary

*ErrorAnalyzer* would generate after each successful run `eaAnalyzerSummary.csv` file, which includes information about errors found with potential error fixes.
More precisely, previously mentioned file consists of five columns, each representing:
 - Analyzer ID: ID number of the *Analyzer* where the error is found
 - Error Pattern ID: ID of the pattern recognized by the *Inspectors*
 - Number of total fail samples: How many samples are failing *Inspector's* checks
 - Number of total fixable samples: For how many samples potential fix has been found
 - Number of total unfixable samples: For how many samples potential fix has not been found

 Additionaly, `SummaryIncremental` parameter is included in config file, which represents if the reports written to the `eaAnalyzerSummary.csv` after each run
 should be appended or overwritten by the following *ErrorAnalyzer* run. 
 If `SummaryIncremental = false`, previous report is overwritten by report of the following run. 
 If `SummaryIncremental = true`, the report of the next run would be appended to the, without losing any data on the previous runs.