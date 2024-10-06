module systolic_array #(
    parameter N = 2
)(
    input wire clk,
    input wire reset,
    input wire [15:0] a_in [0:N-1],  
    input wire [15:0] b_in [0:N-1],  
    output wire [31:0] result [0:N-1][0:N-1]
);

    wire [15:0] a_wire [0:N-1][0:N]; 
    wire [15:0] b_wire [0:N][0:N-1]; 

    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin: row
            for (j = 0; j < N; j = j + 1) begin: col
                wire [15:0] a_in_pe;
                wire [15:0] b_in_pe;

                
                if (j == 0) begin
                    assign a_in_pe = a_in[i];  
                end else begin
                    assign a_in_pe = a_wire[i][j-1];  
                end

                if (i == 0) begin
                    assign b_in_pe = b_in[j];  
                end else begin
                    assign b_in_pe = b_wire[i-1][j];  
                end

                processing_element pe (
                    .clk(clk),
                    .reset(reset),
                    .a_in(a_in_pe),
                    .b_in(b_in_pe),
                    .a_out(a_wire[i][j]),   
                    .b_out(b_wire[i][j]),   
                    .c_out(result[i][j])
                );
            end
        end
    endgenerate
endmodule
