import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_write_and_read(dut):
    """Generate a clock and verify a register write/read."""

    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    dut.rst.value = 0
    dut.rst.value = 1
    dut.read1.value = 1
    dut.read2.value = 2
    dut.writeEnable.value = 0
    dut.writeReg.value = 0
    dut.writeData.value = 0
    
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)

    dut.writeEnable.value = 1
    dut.writeReg.value = 1
    dut.writeData.value = 0xDEADBEEF

    await RisingEdge(dut.clk)
    dut.writeReg.value = 2
    dut.writeData.value = 0x12345678

    await RisingEdge(dut.clk)

    dut.writeEnable.value = 0
    await RisingEdge(dut.clk)

    assert dut.readOut1.value == 0xDEADBEEF, f"readOut1 was {int(dut.readOut1.value)}"
    
    assert dut.readOut2.value == 0x12345678, f"readOut1 was {int(dut.readOut1.value)}"



