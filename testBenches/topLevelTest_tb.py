import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_add(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
