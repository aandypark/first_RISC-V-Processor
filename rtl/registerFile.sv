module registerFile(
    input  logic clk,
    input logic rst,

    input  logic [4:0] read1,
    input  logic [4:0] read2,

    input  logic writeEnable,
    input  logic [31:0] writeData,
    input logic [4:0] writeReg,

    output logic [31:0] readOut1,
    output logic [31:0] readOut2
);

logic [31:0] regFile [31:0];
integer i;

always_ff @(posedge clk) begin
    if (!rst) begin
        for (i = 0; i < 32; i = i + 1) begin
            regFile[i] <= 32'b0;
            // Often, Register 0 is tied to 0 in architectures like RISC-V/MIPS
        end    
    end
    else if (writeEnable && writeReg != 5'b0) begin
        regFile[writeReg] <= writeData;
    end
end

assign readOut1 = (read1 == 5'b0) ? 32'b0 : regFile[read1];
assign readOut2 = (read2 == 5'b0) ? 32'b0 : regFile[read2];


    initial begin
        $dumpfile("waveform.vcd"); // Specifies the name of the output VCD file
        $dumpvars(0);      // Dumps all signals in 'tb_top' and everything below it
    end

endmodule
