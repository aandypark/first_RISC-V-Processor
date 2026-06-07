import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_add(dut):

    dut.a.value = 10
    dut.b.value = 5
    dut.alu_sel.value = 0  

    await Timer(1, units="ns")

    assert dut.result.value == 15

@cocotb.test()
async def test_sub(dut):

    dut.a.value = 10
    dut.b.value = 5
    dut.alu_sel.value = 1

    await Timer(1, units="ns")

    assert dut.result.value == 5

@cocotb.test()
async def test_mult(dut):

    dut.a.value = 10
    dut.b.value = 5
    dut.alu_sel.value = 2

    await Timer(1, units="ns")

    assert dut.result.value == 50

@cocotb.test()
async def test_add(dut):

    dut.a.value = 10
    dut.b.value = 5
    dut.alu_sel.value = 0  

    await Timer(1, units="ns")

    assert dut.result.value == 15