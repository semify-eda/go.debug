import math
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.utils import get_sim_time

from erroranalyzer import eaAnalyzer, eaAnalyzersFinal

@cocotb.test()
async def test_div_int_simple(dut):

  log = cocotb.logging.getLogger("cocotb.test")
  log.info("Starting sqrt testbench")
  
  analyzer_root = eaAnalyzer("Analyzer root", 8, False, get_sim_time())
  analyzer_remainder = eaAnalyzer("Analyzer remainder", 8, False, get_sim_time())
  analyzer_valid = eaAnalyzer("Analyzer valid", 1, False, get_sim_time())

  clock = Clock(dut.clk, 10, units="ns")  # Create a 10ns period clock on port clk
  cocotb.fork(clock.start())  # Start the clock

  await ClockCycles(dut.clk, 10) 

  radicand = [0, 1, 121, 81, 90, 255]

  for i in range(len(radicand)):

    dut.rad <= radicand[i]
    
    # Set start for one clk cycle
    dut.start <= 1
    await ClockCycles(dut.clk, 1) 
    dut.start <= 0
    
    await cocotb.triggers.RisingEdge(dut.valid)
    await ClockCycles(dut.clk, 1) 

    log.info("{}:\tsqrt({}) = {} (rem = {})".format(get_sim_time(), dut.rad.value, dut.root.value, dut.rem.value));

    #assert dut.valid.value == 1
    analyzer_valid.add_sample(dut.valid.value, 1, get_sim_time())

    #assert dut.root.value == int(math.sqrt(radicand[i]))
    analyzer_root.add_sample(dut.root.value, int(math.sqrt(radicand[i])), get_sim_time())
    #assert dut.rem.value == (radicand[i] - int(math.sqrt(radicand[i]))**2)
    analyzer_remainder.add_sample(dut.rem.value, (radicand[i] - int(math.sqrt(radicand[i]))**2), get_sim_time())
  
  eaAnalyzersFinal()
