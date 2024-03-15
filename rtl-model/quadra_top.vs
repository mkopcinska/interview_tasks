`include "quadra.vh"

module quadra_top
(
    input  ck_t clk,
    input  rs_t rst_b,
    input  x_t  x,
    input  dv_t x_dv,
    output y_t  y,
    output dv_t y_dv
);
    // Pipeline data valid (3 stages):
    dv_t dv_p0, dv_p1, dv_p2;
	 
	 // Define signals 
	 x2_t x2;
	 sq_t sq;
    a_t a;
    b_t b;
    c_t c;
	 
	 // Divide x into x1 and x2 based on x_dv condition
    logic [23:17] x1;
    logic [16:0] x2;
	 
    always_ff @(posedge clk)
    if (!rst_b) begin
        dv_p0 <= '0;
        dv_p1 <= '0;
        dv_p2 <= '0;
    end
    else begin
        dv_p0 <= x_dv;
        dv_p1 <= dv_p0;
        dv_p2 <= dv_p1;
		  if (x_dv) begin
            x1 <= x[23:17];
            x2 <= x[16:0];
        end else begin
            x1 <= '0;
            x2 <= '0;
        end
    end

 //
 //   always_comb begin
 //      if (x_dv) begin
 //           x1 = x[23:17];
 //          x2 = x[16:0];
 //       end else begin
 //           x1 = '0;
 //           x2 = '0;
 //       end
 //   end

    //square module
    square square_inst (
			//inputs:
        .x2(x2),
		  //outputs:
        .sq(sq)
    );

    //lut module
    lut lut_inst (
			//inputs:
        .x1(x1),
		  //outputs:
        .a(a),
        .b(b),
        .c(c)
    );

    //quadra module
    quadra quadra_inst (
			//inputs:
        .x2(x2),
        .sq(sq),
        .a(a),
        .b(b),
        .c(c),
		  //outputs:
        .y(y),
        .y_dv(y_dv)
    );
	 
    // Outputs:
    always_comb y_dv = dv_p2;
    always_comb y    = '0;
	 

endmodule
