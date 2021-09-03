# sine example

First make sure `/lib/lib64/libea-vpi.so` exists.

To start the example in interactive mode issue:

```
make run-gui
```

In the console of Cadence Xcelium run

```
call eaVPIAnalyzerCreateCb \"Analyzer_1\" 0 18 0 0 \"wfg_stim_sine_tb.trigger\" \"wfg_stim_sine_tb.expected_sine\" \"wfg_stim_sine_tb.wfg_stim_spi_tdata_i\"
```

to create an Analyzer. After that just write

```
run
```

for the simulation to finish.

# Console output

Example output of the console:

```
xmsim: *W,DSEM2009: This SystemVerilog design is simulated as per IEEE 1800-2009 SystemVerilog simulation semantics. Use -disable_sem2009 option for turning off SV 2009 simulation semantics.
xcelium> 
xcelium> source /opt/cadence/XCELIUM1909/tools/xcelium/files/xmsimrc
xcelium> call
No C functions available

$eaVPIAnalyzersReport
$eaVPIAnalyzerCreate
$eaVPIAnalyzerChecksPerform
$eaVPIAnalyzerReport
$eaVPIDumpTrace
$eaVPIAnalyzerAddSample
$eaVPIAnalyzerCreateCb
xcelium> call eaVPIAnalyzerCreateCb \"Analyzer_1\" 0 18 0 0 \"wfg_stim_sine_tb.trigger\" \"wfg_stim_sine_tb.expected_sine\" \"wfg_stim_sine_tb.wfg_stim_spi_tdata_i\"
32'b00000000000000000000000000000001
xcelium> run
Simulation complete via $finish(1) at time 504 NS + 0
../testbench/wfg_stim_sine_tb.sv:69     $finish;
xcelium>
```
