module immediateGen(
    input logic [31:0] instruction,
    output logic [31:0] imm
);

logic [6:0] opcode;
assign opcode = instruction[6:0];

always_comb begin
    case (opcode)
        // R-type instructions
        7'b0110011: begin
            imm = 32'b0;
        end

        // I-type ALU/load/jump-register instructions
        7'b0010011, 7'b0000011, 7'b1100111: begin
            imm = {{20{instruction[31]}}, instruction[31:20]};
        end

        // S-type store instructions
        7'b0100011: begin
            imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        end

        // B-type branch instructions
        7'b1100011: begin
            imm = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
        end

        // U-type upper-immediate instructions
        7'b0110111, 7'b0010111: begin
            imm = {instruction[31:12], 12'b0};
        end

        // J-type jump instructions
        7'b1101111: begin
            imm = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], 1'b0};
        end

        default: begin
            imm = 32'b0;
        end
    endcase
end

endmodule
