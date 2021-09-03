# sine example

First make sure `/lib/lib64/libea-vpi.so` exists.

To start the example in interactive mode issue:

```
make run-gui
```

In the console of Cadence Xcelium run

```
call eaVPIAnalyzerCreateCb \"Analyzer_1\" 0 24 0 0 \"top.i_u_top_system.trigger\" \"top.i_u_top_system.data_in_vec\" \"top.i_u_top_system.dout_parallel\"
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
xcelium> call eaVPIAnalyzerCreateCb \"Analyzer_1\" 0 24 0 0 \"top.i_u_top_system.trigger\" \"top.i_u_top_system.data_in_vec\" \"top.i_u_top_system.dout_parallel\"
32'b00000000000000000000000000000001
xcelium> run
[0] Model running...

[500] Finish simulation 

Simulation complete via $finish(1) at time 500 NS + 0
../testbench/top_system.icarus.sv:114     $finish();
xcelium> 
```
