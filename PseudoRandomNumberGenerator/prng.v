/*
Author: dmdhrumilmistry
Module: prng (Psuedo Random Number Generator)
Parameter: LSFR_SIZE (int): size of the LSFR, Higher number provides more random numbers.
Description: Generates pseudo 32bit random numbers using LSFR.
*/

module prng #(parameter LSFR_SIZE = 32) (
    input                       clk,    // clk pin
    input                       rst_n,  // reset pin  
    output reg [LSFR_SIZE-1:0]  data    // output data
);

// register to store feedback bit value
reg feedback_bit = 0;

/* 
when positive edge is detected in clock, then
- if reset is high
    - reset data to max value
- else
    - assign new value
*/
always @ (posedge clk) begin
    // active high 
    if (rst_n) begin
        data <= (2**LSFR_SIZE)-1;
    end

    else begin
        data <= {data[LSFR_SIZE-2:0], feedback_bit};
    end // end if (rst_n)
end // end always @ (posedge clk)


/*
When any event is detected then calculate new 
feedback_bit value according to the LSFR_SIZE
parameter primitive polynomial.
*/
always @ (*) begin
    case (LSFR_SIZE)
        2: begin
            feedback_bit = data[1] ^ data[0];
        end

        3: begin
            feedback_bit = data[2] ^ data[1];
        end

        4: begin
            feedback_bit = data[3] ^ data[2];
        end

        5: begin
            feedback_bit = data[4] ^ data[2];
        end

        6: begin
            feedback_bit = data[5] ^ data[4];
        end

        7: begin
            feedback_bit = data[6] ^ data[5];
        end

        8: begin
            feedback_bit = data[7] ^ data[5] ^ data[4] ^ data[3];
        end

        9: begin
            feedback_bit = data[8] ^ data[4];
        end

        10: begin
            feedback_bit = data[9] ^ data[6];
        end

        11: begin
            feedback_bit = data[10] ^ data[8];
        end

        12: begin
            feedback_bit = data[11] ^ data[10] ^ data[9] ^ data[3];
        end

        13: begin
            feedback_bit = data[12] ^ data[11] ^ data[10] ^ data[7];
        end

        14: begin
            feedback_bit = data[13] ^ data[12] ^ data[11] ^ data[1];
        end

        15: begin
            feedback_bit = data[14] ^ data[13];
        end

        16: begin
            feedback_bit = data[15] ^ data[14] ^ data[12] ^ data[3];
        end

        17: begin
            feedback_bit = data[16] ^ data[13];
        end

        18: begin
            feedback_bit = data[17] ^ data[10];
        end

        19: begin
            feedback_bit = data[18] ^ data[17] ^ data[16] ^ data[13];
        end

        20: begin
            feedback_bit = data[19] ^ data[16];
        end

        21: begin
            feedback_bit = data[20] ^ data[18];
        end

        22: begin
            feedback_bit = data[21] ^ data[20];
        end

        23: begin
            feedback_bit = data[22] ^ data[17];
        end

        24: begin
            feedback_bit = data[23] ^ data[22] ^ data[21] ^ data[16];
        end

        32: begin
            feedback_bit = data[31] ^ data[28];
        end
    endcase // end case (LSFT_SIZE)
end // end always @ (*)

endmodule // end prng