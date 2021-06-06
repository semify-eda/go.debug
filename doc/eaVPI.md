# *ErrorAnalyzer* VPI Documentation



## General functions
#### `PLI_INT32 eaVPIAnalyzerCreate(PLI_BYTE8 *user_data)`
Creates an Analyzer instance if previously all checked arguments are valid.
On call, invokes *eaAnalyzerCreate()* function. Passes all parameters to the corresponding *EA* function.

#### `PLI_INT32 eaVPIAnalyzerCreateCb(PLI_BYTE8 *user_data)`
Creates an Analyzer instance.
On call, invokes *eaAnalyzerCreate()* function.
In meantime, generates a callback function with provided signals from the simulation module.
Signal contain names for expected and actual data 
The callback registers a trigger signal, on which change function *eaAnalyzerAddSample()* function
is called. Arguments for *eaAnalyzerAddSample()* are previously provided by the VPI function.
If one of the parameters is invalid or missing, aborts creating analyzer instance. 

#### `PLI_INT32 eaVPIAnalyzerReport(PLI_BYTE8 *user_data)`
Reports the Analyzer with provided ID. Calls corresponding function from *ErrorAnalyzer* API.

#### `PLI_INT32 eaVPIAnalyzerChecksPerform(PLI_BYTE8 *user_data)`
Reports the Analyzer with provided ID.
Calls corresponding function from *ErrorAnalyzer* API.

#### `PLI_INT32 eaVPIReportAnalyzers(PLI_BYTE8 *user_data)`
Invokes corresponding *EA* function on call.

#### `PLI_INT32 eaVPIDumpTrace(PLI_BYTE8 *user_data)`
Invokes corresponding *EA* function on call.

#### `PLI_INT32 eaVPIAnalyzerAddSample(PLI_BYTE8 *user_data)`
Manual adding samples on call. Function parameters are passed to the
corresponding *EA* function, after previously being checked if valid. 