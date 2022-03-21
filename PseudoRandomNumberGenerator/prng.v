/*
Module : prng (Psuedo Random Number Generator)
Description : Generates pseudo 32bit random numbers using LSFR
*/
module prng(
    input clk,
    input rst_n,
    output reg [31:0] data // 32 bit data
);

wire feedback;
assign feedback = data[31] ^ data[28]; 

always @ (posedge clk)
    // active high 
    if (rst_n) begin
        data <= 32'b1111_1111_1111_1111;
    end
    else begin
        data <= {data[30:0], feedback};
    end
endmodule