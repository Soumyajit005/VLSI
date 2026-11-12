
module carry_lookahead_adder(
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Cout
);

wire [3:0] P;
wire [3:0] G;
wire [4:0] C;

// Propagate and Generate
assign P = A ^ B;
assign G = A & B;

// Initial carry
assign C[0] = Cin;

// Carry Look-Ahead equations
assign C[1] = G[0] | (P[0] & C[0]);

assign C[2] = G[1] |
              (P[1] & G[0]) |
              (P[1] & P[0] & C[0]);

assign C[3] = G[2] |
              (P[2] & G[1]) |
              (P[2] & P[1] & G[0]) |
              (P[2] & P[1] & P[0] & C[0]);

assign C[4] = G[3] |
              (P[3] & G[2]) |
              (P[3] & P[2] & G[1]) |
              (P[3] & P[2] & P[1] & G[0]) |
              (P[3] & P[2] & P[1] & P[0] & C[0]);

// Sum outputs
assign Sum = P ^ C[3:0];

// Final carry
assign Cout = C[4];

endmodule
