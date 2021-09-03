# *ErrorAnalyzer* Integration Documentation
*ErrorAnalyzer* is integrated into the simulations using three different approaches: Direct Programming Interface (DPI), Verilog Procedural Interface (VPI) and Python Integration. In this document an overview of VPI function calls are provided.

## General functions
The functions for which simulation integration is existing are enlisted below together with tables containing function parameters. For each *EA* function, equivalent in VPI integration method is documented. 
### eaAnalyzerCreate()
|  Parameter | Data type  | Description  |   
|---|---|---|
| Name  | const char*  | Name of the instanciated *Analyzer*  |  
| Type  |  int | *Analyzer* type - Logical or Arithmetic  |   
| DataBitWidth  | int  | Data bit width used in the simulation  |
| DataIsSigned  |  int |  Indicates if the data provided is signed or not |
| Time  | long long  | Point in time when the *Analyzer* is created  |

##### `VPI` $eaVPIAnalyzerCreate()
Creates an *Analyzer* instance if previously all checked arguments are valid.
On call, invokes *eaAnalyzerCreate()* function. Passes all parameters to the corresponding *EA* function.
##### `VPI` $eaVPIAnalyzerCreateCb()
Creates an *Analyzer* instance. On call, invokes *eaAnalyzerCreate()* function. In meantime, generates a callback function with provided parameters from the simulation module. In fact, parameters provided are simulation signals contatinig actual and expected data from the simulation, as well as the trigger signal. The insight three additional parameters is shown in the table below.
|  Parameter | Data type  | Description  |   
|---|---|---|
| CbTrigger  | const char*  | XMR pathname of the signal to be registered as a trigger  |  
| DataExpected  |  const char* | XMR pathname of the simulation module parameter containing expected value  |   
| DataRead  | const char*  | XMR pathname of the simulation module parameter containing actual value  |

The callback registers a trigger signal, on which change function *eaAnalyzerAddSample()* is called and a sample is added to the *Analyzer* with specific ID. Parameters for *eaAnalyzerAddSample()* are previously provided by the VPI function. If one of the parameters is invalid or missing, aborts creating *Analyzer* instance. 

---
### eaAnalyzerReport()
|  Parameter | Data type  | Description  |   
|---|---|---|
|  ID |  int | The ID of the *Analyzer* to be reported  |   

##### `VPI` $eaVPIAnalyzerReport()
Reports the *Analyzer* with provided ID. Calls corresponding function from *ErrorAnalyzer* API.

---
### eaAnalyzerChecksPerform()
|  Parameter | Data type  | Description  |   
|---|---|---|
|  ID |  int | The ID of the *Analyzer* on which checks are performed  |  
##### `VPI` $eaVPIAnalyzerChecksPerform()
Performs checks on the *Analyzer* with provided ID number. Calls corresponding function from *ErrorAnalyzer* API.

---
### eaAnalyzersReport()
##### `VPI` $eaVPIAnalyzersReport()
Invokes corresponding *EA* function on call.

---
### eaAnalyzersDumpTrace()
##### `VPI` $eaVPIAnalyzersDumpTrace()
Invokes corresponding *EA* function on call.

---
### eaAnalyzerAddSample()
|  Parameter | Data type  | Description  |   
|---|---|---|
|  ID |  int | The ID of the *Analyzer* to which sample is provided  |
|  DataRead |  int | Actual data read from the simulator  |  
|  DataExpected |  int | Reference data from the simulator  |  
|  Time |  long long | Time when the sample is added to the *Analyzer*  |  

##### `VPI` $eaVPIAnalyzerAddSample()
Manual adding samples on call. Function parameters are passed to the corresponding *EA* function, after previously being checked on validity. If signals provided among parameters do not exist, terminate the execution and return from function.
