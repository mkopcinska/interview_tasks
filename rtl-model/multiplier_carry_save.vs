//
// Multiplier_carry_save
//

`include "quadra.vh"

module multiplier_carry_save (
    input logic [P_W-1:0] a,
    input logic [P_W-1:0] b,
    output logic [P_W-1:0] sum,
    output logic [P_W-1:0] carry
);
    logic [P_W-1:0] product;

    // Perform the multiplication
    assign product = a * b;

    // Extract the sum and carry
    assign sum = product[P_W-1:1];
    assign carry = product[P_W-1];

endmodule



