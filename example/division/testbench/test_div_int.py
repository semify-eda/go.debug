import cocotb
import logging
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.utils import get_sim_time

from erroranalyzer import eaAnalyzer, eaAnalyzersFinal

@cocotb.test()
async def test_div_int_simple(dut):

  log = cocotb.logging.getLogger("cocotb.test")
  log.info("Starting division testbench")
  
  analyzer_quotient = eaAnalyzer("Analyzer quotient", 4, False, get_sim_time())
  analyzer_remainder = eaAnalyzer("Analyzer remainder", 4, False, get_sim_time())
  analyzer_valid = eaAnalyzer("Analyzer valid", 4, False, get_sim_time())
  analyzer_dbz = eaAnalyzer("Analyzer division by zero", 4, False, get_sim_time())

  clock = Clock(dut.clk, 10, units="ns")  # Create a 10ns period clock on port clk
  cocotb.fork(clock.start())  # Start the clock

  await ClockCycles(dut.clk, 10) 

  dividend = [0, 2, 7, 15, 1, 8]
  divisor = [2, 0, 2, 5, 1, 9]

  for i in range(len(dividend)):

    try: 
      quotient = dividend[i] // divisor[i]
      remainder = dividend[i] % divisor[i]
    except ZeroDivisionError:
      quotient = 'x'
      remainder = 'x'

    dut.x <= dividend[i]
    dut.y <= divisor[i]

    # Set start for one clk cycle
    dut.start <= 1
    await ClockCycles(dut.clk, 1) 
    dut.start <= 0
    
    await ClockCycles(dut.clk, 10) # Wait for the calculation to finish

    log.info("{}:\t{} / {} = {} (r = {}) (V={}) (DBZ={})".format(get_sim_time(), dut.x.value, dut.y.value, dut.q.value, dut.r.value, dut.valid.value, dut.dbz.value))
    
    if (divisor[i] == 0):
      # assert dut.valid.value == 0
      # assert dut.dbz.value == 1
      
      analyzer_valid.add_sample(dut.valid.value, 0, get_sim_time())
      analyzer_dbz.add_sample(dut.dbz.value, 1, get_sim_time())
      
    else:
      # assert dut.valid.value == 1
      # assert dut.dbz.value == 0
      
      analyzer_valid.add_sample(dut.valid.value, 1, get_sim_time())
      analyzer_dbz.add_sample(dut.dbz.value, 0, get_sim_time())
    
      # assert dut.q.value == quotient
      # assert dut.r.value == remainder
      
      analyzer_quotient.add_sample(dut.q.value, quotient, get_sim_time())
      analyzer_remainder.add_sample(dut.r.value, remainder, get_sim_time())
      
  eaAnalyzersFinal()
