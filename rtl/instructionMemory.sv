module instructionMemory(
    input  logic [31:0] address,
    output logic [31:0] instruction
);

    // 64 instructions of 32 bits each
    logic [31:0] memory [0:63];

    // Initialize the memory
    initial begin
        memory[0] = 32'h00500093; // addi x1, x0, 5
        memory[1] = 32'h00A00113; // addi x2, x0, 10
        memory[2] = 32'h002081B3; // add x3, x1, x2
        memory[3] = 32'h40110233; // sub x4, x2, x1
    end

    // Combinational read
    always_comb begin
        instruction = memory[address[31:2]];
    end

endmodule
