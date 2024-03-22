// quadra.vh

`ifndef QUADRA_VH
`define QUADRA_VH

typedef logic ck_t; // clock
typedef logic rs_t; // reset
typedef logic dv_t; // data valid

// --------------------------------------------------------------------------------
// I/O precision
// --------------------------------------------------------------------------------

// x in [0,2) -> u1.23
localparam int  X_I =  1;          //         =  1
localparam int  X_F = 23;          //         = 23
localparam int  X_W = X_I + X_F;   //  1 + 23 = 24 (u1.23)

typedef logic [X_W-1:0] x_t;

// y [-2,2) -> s2.23
localparam int  Y_I =  2;          //         =  2
localparam int  Y_F = 23;          //         = 23
localparam int  Y_W = X_I + X_F;   //  2 + 23 = 25 (s2.23)

typedef logic signed [Y_W-1:0] y_t;

// --------------------------------------------------------------------------------
// Internal precision:
// --------------------------------------------------------------------------------

// Define precision for multiplier_carry_save module
localparam int P_I = 1;           // Integer bits
localparam int P_F = 23;          // Fractional bits
localparam int P_W = P_I + P_F;   // Total width

// Define types for quadra module
//typedef logic [P_W-1:0] a_t;  // Type for 'a' input
//typedef logic [P_W-1:0] b_t;  // Type for 'b' input
//typedef logic [P_W-1:0] c_t;  // Type for 'c' input
//typedef logic [P_W-1:0] x2_t; // Type for 'x2' input
//typedef logic [P_W-1:0] sq_t; // Type for 'sq' input
//typedef logic [P_W-1:0] y_t;  // Type for 'y' output

`endif
