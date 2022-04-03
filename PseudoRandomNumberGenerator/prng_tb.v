`include "prng.v"
`timescale 1ns/1ns

module prng_tb;

    reg clk, rst;
    parameter lsfr_size = 32;
    wire [lsfr_size-1:0] data;
    prng#(.LSFR_SIZE(lsfr_size)) random_num_generator(clk, rst, data);

    initial begin
        clk = 0;
        rst = 1;
        #15 rst = 0;
        $dumpfile("prng_tb.vcd");
        $dumpvars(0, prng_tb);
        // $monitor("%d\t%b", data, data);
        $display("Test Complete and data written to prng_tb.vcd");
        #2000 $finish;
    end

    always #1 clk = ~clk;

endmodule
