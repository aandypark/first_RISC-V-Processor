import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_add(dut):    
    dut.opcode.value = 0b0110011
    dut.funct3.value = 0b000
    dut.funct7.value = 0b0000000
    dut.rs1.value = 2
    dut.rs2.value = 2
    
    await Timer(1, units="ns")

    assert dut.result.value == 4
