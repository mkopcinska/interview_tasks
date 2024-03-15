//
// Quadratic polynomial:  f(x) = a + b*x2 + c*(x2^2)
//

`include "quadra.vh"

module quadra
(
    input  sq_t sq,
    input  x2_t x2,
    input  a_t  a,
    input  b_t  b,
    input  c_t  c,
    output y_t  y
);

    // Local signals for intermediate calculations
    logic [Y_W-1:0] a_sq_mult;
    logic [Y_W-1:0] b_x2_mult;

    // Calculate a * sq 
	 // These are not multipliers in carry-save form
    assign a_sq_mult = a * sq;

    // Calculate b * x2
    assign b_x2_mult = b * x2;

    // Calculate y = a * sq + b * x2 + c
    assign y = a_sq_mult + b_x2_mult + c;

endmodule
