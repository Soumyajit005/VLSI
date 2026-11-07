
`timescale 1ns/1ps

module tb_rca;

reg [3:0] A, B;
reg Cin;

wire [3:0] Sum;
wire Cout;

reg [4:0] expected;

integer i, j, k;
integer errors;

ripple_carry_adder uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0, tb_rca);

    errors = 0;

    $display("Starting 4-bit RCA verification...");

    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            for (k = 0; k < 2; k = k + 1) begin

                A = i;
                B = j;
                Cin = k;

                expected = i + j + k;

                #10;

                if ({Cout, Sum} !== expected) begin

                    $display("FAIL: A=%d B=%d Cin=%d | Expected=%d Got=%d",
                             A, B, Cin, expected, {Cout, Sum});

                    errors = errors + 1;

                end

            end
        end
    end

    if (errors == 0)
        $display("PASS: All 512 test cases passed!");
    else
        $display("FAIL: Total errors = %d", errors);

    $finish;

end

endmodule
