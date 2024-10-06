module tpu_testbench;

    reg clk;
    reg reset;
    reg [15:0] matrix_a [0:1][0:1];
    reg [15:0] matrix_b [0:1][0:1];
    reg [15:0] a_in [0:1];
    reg [15:0] b_in [0:1];
    wire [31:0] result [0:1][0:1];

    systolic_array #(.N(2)) uut (
        .clk(clk),
        .reset(reset),
        .a_in(a_in),
        .b_in(b_in),
        .result(result)
    );

    integer i;

    // clock gen.
    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        reset = 1;

        matrix_a[0][0] = 16'd1; matrix_a[0][1] = 16'd2;
        matrix_a[1][0] = 16'd3; matrix_a[1][1] = 16'd4;

        matrix_b[0][0] = 16'd1; matrix_b[0][1] = 16'd2;
        matrix_b[1][0] = 16'd3; matrix_b[1][1] = 16'd4;

        a_in[0] = 0; a_in[1] = 0;
        b_in[0] = 0; b_in[1] = 0;

        #10 reset = 0;

        // total cycles required: 2N - 1 = 3 for N = 2
        for (i = 0; i < 4; i = i + 1) begin
            #10;
            case (i)
                0: begin
                    a_in[0] <= matrix_a[0][0]; // A[0][0]
                    a_in[1] <= 0;
                    b_in[0] <= matrix_b[0][0]; // B[0][0]
                    b_in[1] <= 0;
                end
                1: begin
                    a_in[0] <= matrix_a[0][1]; // A[0][1]
                    a_in[1] <= matrix_a[1][0]; // A[1][0]
                    b_in[0] <= matrix_b[1][0]; // B[1][0]
                    b_in[1] <= matrix_b[0][1]; // B[0][1]
                end
                2: begin
                    a_in[0] <= 0;
                    a_in[1] <= matrix_a[1][1]; // A[1][1]
                    b_in[0] <= 0;
                    b_in[1] <= matrix_b[1][1]; // B[1][1]
                end
                default: begin
                    a_in[0] <= 0;
                    a_in[1] <= 0;
                    b_in[0] <= 0;
                    b_in[1] <= 0;
                end
            endcase
        end

        // wait time
        #50;

        $display("Matrix A:");
        $display("%d %d", matrix_a[0][0], matrix_a[0][1]);
        $display("%d %d", matrix_a[1][0], matrix_a[1][1]);

        $display("Matrix B:");
        $display("%d %d", matrix_b[0][0], matrix_b[0][1]);
        $display("%d %d", matrix_b[1][0], matrix_b[1][1]);

        $display("Result Matrix:");
        $display("%d %d", result[0][0], result[0][1]);
        $display("%d %d", result[1][0], result[1][1]);

        $finish;
    end

endmodule
