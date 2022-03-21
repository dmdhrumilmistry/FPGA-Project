`include "prng.v"
`timescale 1ns/1ps

module prng_tb;
    reg clk, rst;
    wire [31:0] data;
    prng random_num_generator(clk, rst, data);

    initial begin
        clk = 0;
        rst = 1;
        #15 rst = 0;
        $monitor("%d\t%b", data, data);
        #2000 $finish;
    end

    always #5 clk = ~clk;

endmodule