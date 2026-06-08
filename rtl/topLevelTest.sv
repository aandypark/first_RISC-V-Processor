module alu_control_test (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    input  logic [31:0] rs1,
    input  logic [31:0] rs2,

    output logic [31:0] result
);

    logic [3:0] aluControl;
    logic regWrite;

    controlUnit cu (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .aluControl(aluControl),
        .regWrite(regWrite)
    );

    alu alu0 (
        .a(rs1),
        .b(rs2),
        .aluControl(aluControl),
        .result(result)
    );

endmodule