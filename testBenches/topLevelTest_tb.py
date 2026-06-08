import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_add(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
    
    dut.opcode.value = 0b0110011
    dut.funct3.value = 0b000
    dut.funct7.value = 0b0000000
    dut.rs1.value = 
    dut.rs2.value = 
