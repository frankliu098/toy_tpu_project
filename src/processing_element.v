module processing_element (
    input wire clk,
    input wire reset,
    input wire [15:0] a_in,
    input wire [15:0] b_in,
    output reg [15:0] a_out,
    output reg [15:0] b_out,
    output reg [31:0] c_out
);

    reg [31:0] partial_sum;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_out <= 0;
            b_out <= 0;
            c_out <= 0;
            partial_sum <= 0;
        end else begin
            partial_sum <= partial_sum + a_in * b_in;
            a_out <= a_in;
            b_out <= b_in;
            c_out <= partial_sum;
        end
    end
endmodule
