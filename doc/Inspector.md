# *Analyzer* and *Inspector* Description

## *Analyzer*

The Analyzer is the basic analysis element of the *ErrorAnalyzer* Tool. For input, it receives a set of samples which consist of the actual read value, the expected value and a time stamp. Theses samples are fed into the so called *Inspectors* for analysis. In case of a fail, indicated by a mismatch between read and expected value, the *Inspectors* try to apply different 'transformations' to reduce the number of failed samples and identfy a specific error pattern. Each *Inspector* has a different strategy for reducing the number of fails. At the end of the analysis process the error pattern with the highest success rate(s) are reported.

Failing samples fed into an *Inspector* can either be **fixable** or **unfixable**. Fixable means that by applying the assumption ('transformations') of the inverse failure mechanism (e.g., a bit shift) to the read values of failed samples change from fail to pass. Unfixable means that although the inverse failure mechanism is applied to the read values failed samples are still failing. 

### Sample

A sample fed to an *Analyzer* contains:

1. Read value:     Represents the value read back from simulation.
2. Expected value: Represents the value calculated / given by the checker.
3. Time stamp:     Point in time when a sample is added to the *Analyzer*


## *Inspector*


An *Inspector* takes the given number of samples and inspects them in order to identify an error pattern. The inspection is done based on a certain assumed failure scenario ('transformation'). There are two different types of *Inspectors* available.

* Sample based *Inspector*
* Segment based *Inspector*

A sample based *Inspector* inspects one single sample at a time and tries to find a relation between the failed sample and the expected sample only within this single sample. A simple example for a sample based *Inspector* is the bit shift *Inspector*. It checks if a failed sample can be made pass by shifting it the read value by a given direction and a given number of bits.

A segment based *Inspector* inspects a whole sequence of samples and analyzes error pattern taking two or more samples into account. A simple example for a segment based *Inspector* is a time shift between expected and failed samples. By shifting the failed samples in time, it is possible to make the failed sample pass.

If, for a given *Inspector*, enough positive inspections are done, the *Inspector* reports a successful inspection. The threshold is a parameter for the *Inspector*.

Beside the two different types (sample or segment based) an *Inspector* can also provide different types of information.

* Fixing (Fix)
* Analysis (Ana)
* Statistic (Stat)

A fixing *Inspector* tries to find a way to make the read sample equal to the expected sample and therefore fixing the fail. The provided information is a pattern which makes the failed samples pass.

A analysis *Inspector* tries to find conditions when the read value does not match to the expected value. The provided information are conditions when the fail occurs. 

A statistic *Inspector* generates statistical information about read and expacted samples. The statistical information is generated for expected and read samples. For the read samples it is also separated for passign and failing samples.


### Categories

Each *Inspector* belongs to a certain category. The categories group the different *Inspectors* depending on their functionality and type of inspection they are performing.

* **[LOG]**: Logical related inspections
* **[TIM]**: Time related inspections
* **[NUM]**: Number related inspections
* **[ARITH]**: Arithmetic related inspections
* **[ANA]**: Analog related inspections
* **[ADDR]**: Addressing (bus) related inspections
* **[STAT]**: Statistical related inspections

The information is provided in two ways.
  * Textual report
  * Waveform
  

### Textual report  

The following table provides an overview about the existing *Inspectors* and their provided errror pattern as part of the `Inspector Inspection Summary`.
  
| Inspector Type | Category | Sub Category | Info Type | Summary ID               | Description                                                 |
|----------------|----------|--------------|-----------|:-------------------------|:------------------------------------------------------------|
| Sample         | LOG      | SHIFT        | Fix       | LOG.SHIFT.RIGHT_\<n\>    | Fixable by shifting the read data right by \<n\> bit relative to the expected value      |
| Sample         | LOG      | SHIFT        | Fix       | LOG.SHIFT.LEFT_\<n\>     | Fixable by shifting the read data left by \<n\> bit relative to the expected value       |
| Sample         | LOG      | BIT          | Fix       | LOG.BIT.STUCK0_\<n\>     | Fixable by forcing bit \<n\> of read data to 0              |
| Sample         | LOG      | BIT          | Fix       | LOG.BIT.STUCK1_\<n\>     | Fixable by forcing bit \<n\> of read data to 1              |
| Sample         | LOG      | BIT          | Fix       | LOG.BIT.FLIP_\<n\>       | Fixable by flipping (inverting) bit \<n\> of read data      |
| Sample         | LOG      | BIT          | Fix       | LOG.BIT.INVERSE          | Fixable by inverting the whole read data                    |
| Sample         | LOG      | BIT          | Fix       | LOG.BIT.REVERSE          | Fixable by reversing the bit order                          |
| Sample         | LOG      | BIT          | Fix       | LOG.BIT.SWAP             | Fixable by aplying different type of byte swaps including little and big endian swapping |
| Sample         | LOG      | INTEGER      | Fix       | LOG.INTEGER.TRUNC_\<n\>  | Fixable by truncating the last \<n\> bits                   |
| Sample         | LOG      | INTEGER      | Fix       | LOG.INTEGER.ROUND_\<n\>  | Fixable by rounding the last \<n\> bits with the specified rounding mode (default: EAROUND\_NEAREST\_HALF\_UP) |
| Sample         | LOG      | INTEGER      | Fix       | LOG.INTEGER.SIGN_FLP     | Fixable by flipping the sign of the integer                 |
| Sample         | LOG      | INTEGER      | Fix       | LOG.INTEGER.CONV_UNS     | Fixable by converting the integer to unsigned               |
| Sample         | LOG      | INTEGER      | Fix       | LOG.INTEGER.CONV_SIG     | Fixable by converting the integer to signed                 |
| Sample         | NUM      | INTEGER      | Fix       | LOG.INTEGER.ABSDF        | Fixable by adding/subtracting absolute difference value     |
| Segment        | TIM      | SHIFT        | Fix       | TIM.SHIFT.DELAY_\<val\>  | Fixable by delaying the read data by \<val\> sample(s)      |
| Segment        | TIM      | SHIFT        | Fix       | TIM.SHIFT.DELAY_\<val\>  | Fixable by delaying the read data by \<val\> sample(s)      |
| Segment        | NUM      | CONST        | Fix       | NUM.CONST.PASS         | Fixable by using a constant value for all passing samples     |
| Segment        | NUM      | CONST        | Fix       | NUM.CONST.FAILREAD     | Fixable by using a constant value for all read values of failed samples     |
| Segment        | NUM      | CONST        | Fix       | NUM.CONST.FAILEXPECTED | Fixable by using a constant value for all expected values of failed samples |
| Segment        | NUM      | SWAPPED      | Fix       | NUM.BIT.SWAPPED        | Fixable by swapping the two swapped bits back                 |
| Segment        | ARITH    | RANGE        | Ana       | ARITH.RANGE.FP\_Range\<val\>\_\<pf\>   | Tries to split read values into two ranges \<val\> one failing \<pf\>-Fail  and one passing \<pf\>-Pass |
| Segment        | ARITH    | RANGE        | Ana       | ARITH.RANGE.PF\_Range\<val\>\_\<pf\>   | Tries to split read values into two ranges \<val\> one passing \<pf\>-Pass and one failing \<pf\>-Fail  |
| Segment        | ARITH    | RANGE        | Ana       | ARITH.RANGE.FPF\_Range\<val\>\_\<pf\>  | Tries to split read values into three ranges \<val\> one failing \<pf\>-Fail, one passing \<pf\>-Pass and one failing \<pf\>-Fail |
| Segment        | ARITH    | RANGE        | Ana       | ARITH.RANGE.PFB\_Range\<val\>\_\<pf\>  | Tries to split read values into three ranges \<val\> one passing \<pf\>-Pass, one failing \<pf\>-Fail and one passing \<pf\>-Pass |



The following table provides an overview about the generated statistics which are dumped into the log file.

| Inspector Type | Category | Sub Category | Info Type | Summary ID             | Description                                               |
|:---------------|----------|--------------|-----------|------------------------|:----------------------------------------------------------|
| Segment        | NUM      | STAT         | Stat      | N/A                    | Distribution of zeros and ones within values              |
| Segment        | NUM      | STAT         | Stat      | N/A                    | Distribution of failing bits                              |
| Segment        | NUM      | STAT         | Stat      | N/A                    | General statistic (min, max...)                           |
| Segment        | NUM      | STAT         | Stat      | N/A                    | Value distribution based on linear distributed bins       |
| Segment        | NUM      | STAT         | Stat      | N/A                    | Value distribution based on power of 2 distributed bins   |


## Sample *Inspectors*

### Data Shift *Inspector*

Category: [LOG]

Sub Category: [SHIFT]

Information type: Fixable

The data shift *Inspector* tries to fix failed samples by shifting the read value a certain number of bits (left or right) and match it to the corresponding expected samples.


Parameter: 

* Number of bits shifts to be checked
* Direction of bit shift


### Data Shift Direction *Inspector*

Category: [LOG]

Sub Category: [SHIFT]

Information type: Fixable

The data shift direction *Inspector* tries to fix failed samples by inverting the bit order of the read value and match it to the corresponding expected sample.


### Single Bit *Inspector*

Category: [LOG]

Sub Category: [BIT]

Information type: Fixable

The single bit *Inspector* tries to fix fails by masking single bits in the read and expected value in order to get the failed samples pass. The following failure scenarios are analyzed:

* **[STUCK1]**: Single bit stuck at 0 
* **[STUCK0]**: Single bit stuck at 1
* **[FLIP]**: Single bit flip
* **[INV]**: Whole data word inversion
  
Stuck at failure scenario and bit flip scenario are overlapping. Therefore, the reporting flags if a bit flip is more likely to be a stuck at than a bit flip.

Parameter: 

None

### Integer *Inspector*

Category: [LOG]

Sub Category: [INTEGER]

Information type: Fixable

The integer *Inspector* tries to fix fails by doing various operations with integers. Namely truncation, rounding, sign flipping and converting between unsigned and signed representations.

The following failure scenarios are analyzed:

* **[TRUNC]**: Truncates the last \<n\> bits
* **[ROUND]**: Rounds the last \<n\> bits with the specified rounding mode
* **[SIGN_FLP]**: Flips the sign of the integer
* **[CONV_UNS]**: Converts the integer to unsigned
* **[CONV_SIG]**: Converts the integer to signed
* **[ABSDIFF]**: Checks absolute difference of \<n\>

Parameter: 

| Parameter        | Description                                                      |
|:-----------------|:-----------------------------------------------------------------|
| MaxTruncatedBits | Maximum number of bits considered for truncation (default: -1)   |
| MaxRoundedBits   | Maximum number of bits considered for rounding (default: -1)     |
| RoundingMode     | The mode used for rounding (default: EAROUND\_NEAREST\_HALF\_UP) |
| MaxAbsDiff       | Maximum range in which absolute difference is checked (default: -1)|

Note: -1 translates to 1/4 of the bit width

**Histogram:** The histogram with absolute difference between read and expected data is provided. The histogram separates the value range into 2**MaxAbsDiff* bins. Bins represent how many samples are fail fixable using specific absolute difference value. To handle this case an additional bin of underflow (UF) and an additional bin for overflow (OV) is added to the histogram.

## Segment *Inspectors*

The following section describes the set of available segment *Inspector*s.


### Sample Shift *Inspector*

Category: [TIM]

Sub Category: [SHIFT]

Information type: Fixable

The sample shift *Inspector* tries to fix fails by comparing the next or the previous read values with the expected values in order to get the samples pass.  

Parameter:

| Parameter      | Description                                        |
|:---------------|:---------------------------------------------------|
| SampleShiftMin | Minimum number of expected sample shift for fixing |
| SampleShiftMax | Maximum number of expected sample shift for fixing |


### Range *Inspector*

Category: [ARITH]

Sub Category: [RANGE]

Information type: Fixable

The range *Inspector* checks, if failing samples occur within certain ranges.

The *Inspector* assumes that the failing samples occur only within certain ranges. There are four different types of ranges assumed.
   * Pass-Fail (PF)
   * Fail-Pass (FP)
   * Pass-Fail-Pass (PFP)
   * Fail-Pass-Fail (FPF)

The range limits are automatically determined by the pass samples.

All fails which fall into a pass range are considered as unfixable.

All fails which fall into a fail range are considered as fixable.


### Statistic *Inspector*

Category: [NUM]

Sub Category: [STAT]

Information type: Informal

The statistic *Inspector* provides statistical information based on the following grouping:
  * Pass samples: Read values
  * Fail samples:
      + Read values
      + Expected values
        
For each group the following information is reported:
  * Min value
  * Max value
  * Mean value
  * Standard deviation
  * Histogram showing the value distrubution
      + Linear binning
      + Logrithmic (base  two) binning
  * Histogram showing the number of zero and ones for each digit of the value 
    
    
The actual defined number format for the signal is not considered. As the *Inspector* does not provide proposals for an error pattern the reporting is always done. There is no summary report for this *Inspector*. 

**Histogram:** The histogram separates the value range into 10 bins. The bin limits and the bin width is automatically derived out of the pass samples. Therefore, there are not any pass samples outside the range of the bins. This is not necessarily true for the failed samples. To handle this case an additional bin of underflow (UF) and an additional bin for overflow (OV) is added to the histogram.

