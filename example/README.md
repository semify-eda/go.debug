# Examples for the *ErrorAnalyzer*

The following matrix shows which example runs with which simulator and interface.

| Example  | Verilator DPI | Icarus Verilog VPI | Cadence Xcelium DPI | Cadence Xcelium VPI | cocotb |
|----------|:-------------:|:------------------:|:-------------------:|:-------------------:|:------:|
| division |               |                    |                     |                     |    x   |
| logging  |       x       |                    |                     |                     |        |
| meas     |       x       |                    |          x          |                     |        |
| shiftreg |       x       |          x         |          x          |          x          |        |
| sine     |               |          x         |                     |          x          |        |
| sqrt     |               |                    |                     |                     |    x   |

An 'x' in the corresponding field means support for the simulator.
