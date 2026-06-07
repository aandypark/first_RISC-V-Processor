module regFileClock();
    reg clk = 0;
    always #5 clk = ~clk; 

    reg rst;
    wire [7:0] data_out;

    registerFile dut_inst (
        .clk(clk),
        .rst(rst),
        .data_out(data_out)
    );
endModule