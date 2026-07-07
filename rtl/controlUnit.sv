module controlUnit(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output logic [3:0] aluControl,
    output logic regWrite,
    output logic memRead,
    output logic memWrite,
    output logic aluSrc,
    output logic memToReg,
    output logic branch

);

always_comb begin

    // Default values
    aluControl = 4'b0000;
    regWrite   = 1'b0;
    memRead    = 1'b0;
    memWrite   = 1'b0;
    aluSrc     = 1'b0;
    memToReg   = 1'b0;
    branch     = 1'b0;

    case(opcode)
        // R-type instructions
        7'b0110011: begin

            regWrite = 1'b1;

            case({funct7, funct3})

                // ADD
                {7'b0000000, 3'b000}:
                    aluControl = 4'b0000;

                // SUB
                {7'b0100000, 3'b000}:
                    aluControl = 4'b0001;

                // AND
                {7'b0000000, 3'b111}:
                    aluControl = 4'b0010;

                // OR
                {7'b0000000, 3'b110}:
                    aluControl = 4'b0011;

                default:
                    aluControl = 4'b0000;

            endcase
        end

        // I-type ALU instructions
        7'b0010011: begin
            regWrite = 1'b1;
            aluSrc   = 1'b1;
            // Decode operation based on funct3
            case(funct3)
                3'b000: aluControl = 4'b0000;  // ADDI
                3'b111: aluControl = 4'b0010;  // ANDI
                3'b110: aluControl = 4'b0011;  // ORI
                3'b100: aluControl = 4'b0100;  // XORI
                default: aluControl = 4'b0000;
            endcase
        end

        // Load instructions
        7'b0000011: begin
            regWrite = 1'b1;
            memRead  = 1'b1;
            aluSrc   = 1'b1;
            memToReg = 1'b1;
        end

        // Store instructions
        7'b0100011: begin
            memWrite = 1'b1;
            aluSrc   = 1'b1;
        end

        // Branch instructions
        7'b1100011: begin
            branch = 1'b1;
        end

        default: begin
            regWrite = 1'b0;
            aluControl = 4'b0000;
        end

    endcase

end
endmodule
