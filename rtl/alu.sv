module alu(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0] alu_sel,

    output logic [31:0] result,
    output logic zero
);

localparam ADD = 4'b0000;
localparam SUB = 4'b0001;
localparam AND_OP = 4'b0010;
localparam OR_OP  = 4'b0011;
localparam XOR_OP = 4'b0100;
localparam SLL = 4'b0101;
localparam SRL = 4'b0110;
localparam SRA = 4'b0111;
localparam SLT = 4'b1000;
localparam SLTU = 4'b1001;


always_comb begin
    case(alu_sel)

        ADD: result = a + b;
        SUB: result = a - b;
        AND_OP: result = a & b;
        OR_OP: result = a | b;
        XOR_OP: result = a ^ b;
        SLL: result = a << b[4:0];
        SRL: result = a >> b[4:0];
        SRA: result = $signed(a) >>> b[4:0];
        SLT: result = ($signed(a) < $signed(b));
        SLTU: result = (a < b);

        

        default: result = 32'b0;

    endcase
end

assign zero = (result == 0);

endmodule
