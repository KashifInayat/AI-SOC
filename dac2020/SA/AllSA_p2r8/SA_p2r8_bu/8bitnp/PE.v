module PE_OS_16_R8( s, d, t, q, n, Y, TMY, CLK, RST, S_OUT, D_OUT, T_OUT, Q_OUT, N_OUT, Y_OUT, TMY_OUT, MAC_OUT );

parameter WIDTH=8;
`define GC (WIDTH>>2)+1
parameter group_cnt=(WIDTH>>2)+1; 

input [group_cnt - 1:0] s, d, t, q, n;

input   [WIDTH-1:0]  Y;

input   [WIDTH+1:0]  TMY;

input           CLK;

input           RST;
 
output [group_cnt - 1:0]S_OUT, D_OUT, T_OUT, Q_OUT, N_OUT;

output  [WIDTH-1:0]  Y_OUT;

output  [WIDTH+1:0]  TMY_OUT;

output reg [2*WIDTH-1:0]  MAC_OUT;

reg [group_cnt - 1:0]S_OUT, D_OUT, T_OUT, Q_OUT, N_OUT;

reg   [WIDTH-1:0]  Y_OUT;

reg   [WIDTH+1:0]  TMY_OUT;

wire     [2*WIDTH-1:0]  product; 

always @(posedge CLK)
begin

           S_OUT <= s;
           
           D_OUT <= d;
           
           T_OUT <= t;
           
           Q_OUT <= q;

	   N_OUT <= n;

	   Y_OUT <= Y;
	       
	   TMY_OUT <= TMY;
end

mb8 b_mult(
 .s(s),
 .d(d),
 .t(t),
 .q(q),
 .n(n),
 .my(Y),
 .tmy(TMY),
 .CLK(CLK),
 .product(product)
);

reg     [2*WIDTH-1:0]  product_reg;
always @(posedge CLK or negedge RST)
begin
        if (RST == 1'b0)
	begin

          MAC_OUT <= 16'b0;
	end	

        else
	begin
          MAC_OUT <=  MAC_OUT+product_reg;
	end
end

always @(posedge CLK)
begin
	  product_reg<=product;

end

endmodule


