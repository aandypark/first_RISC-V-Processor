module cpu(
    input logic clk,
    input logic rst
);

    // ============ Internal Signals ============
    logic [31:0] pc;
    logic [31:0] next_pc;
    logic [31:0] instruction;

    // Decoded instruction fields
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    // Register File outputs
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    // Immediate value
    logic [31:0] imm;

    // ALU inputs and outputs
    logic [31:0] alu_a;
    logic [31:0] alu_b;
    logic [31:0] alu_result;
    logic alu_zero;

    // Control signals
    logic [3:0] aluControl;
    logic regWrite;
    logic memRead;
    logic memWrite;
    logic aluSrc;
    logic memToReg;
    logic branch;

    // ============ Module Instantiations ============

    // Program Counter Module - stores current instruction address
    programCounter pc_module (
        .clk(clk),
        .reset(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Next PC calculation (simple increment by 4 for now)
    assign next_pc = pc + 32'd4;

    // Instruction Memory Module - reads instruction from memory
    instructionMemory imem (
        .address(pc),
        .instruction(instruction)
    );

    // Instruction Decoder Module - extracts fields from instruction
    instructionDecoder decoder (
        .instruction(instruction),
        .opcode(opcode),
        .funct7(funct7),
        .funct3(funct3),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2)
    );

    // Control Unit Module - generates control signals based on opcode/funct
    controlUnit ctrl (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .aluControl(aluControl),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .memToReg(memToReg),
        .branch(branch)
    );

    // Immediate Generator Module - generates immediate value based on instruction type
    immediateGen imm_gen (
        .instruction(instruction),
        .imm(imm)
    );

    // Register File Module - reads source registers and writes destination register
    registerFile rf (
        .clk(clk),
        .rst(rst),
        .read1(rs1),
        .read2(rs2),
        .writeEnable(regWrite),
        .writeData(alu_result),
        .writeReg(rd),
        .readOut1(rs1_data),
        .readOut2(rs2_data)
    );

    // ALU B Multiplexer - selects between register value (R-type) or immediate (I-type)
    assign alu_b = (aluSrc) ? imm : rs2_data;

    // ALU A is always rs1
    assign alu_a = rs1_data;

    // ALU Module - performs arithmetic/logic operations
    alu alu_module (
        .a(alu_a),
        .b(alu_b),
        .alu_sel(aluControl),
        .result(alu_result),
        .zero(alu_zero)
    );

endmodule