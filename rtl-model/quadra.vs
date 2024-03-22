//
// Quadratic polynomial:  f(x) = a + b*x2 + c*(x2^2)
//

`include "quadra.vh"

module quadra (
    input ck_t clk,
    input rs_t rst,
    input  sq_t sq,
    input  x2_t x2,
    input  a_t  a,
    input  b_t  b,
    input  c_t  c,
    output y_t  y
);
    logic [P_W-1:0] b_mult_x2;
    logic [P_W-1:0] a_mult_sq;

    // a and sq multiplicatoin
    multiplier_carry_save mult_a_sq (
        .a(a),  
        .b(sq),
        .sum(a_mult_sq),
        .carry()
    );

    // b and x2 multiplicatoin
    multiplier_carry_save mult_b_x2 (
        .a(b),  
        .b(x2),
        .sum(b_mult_x2),
        .carry()
    );

	// Synchronous addition and output assignment
    always_ff @(posedge clk) begin
        y_temp <= a_mult_sq + b_mult_x2 + c;
    end

    assign y = y_temp;

endmodule

