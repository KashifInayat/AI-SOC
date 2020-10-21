module PE_OS_16( X, Y, CLK, RST, X_OUT, Y_OUT, MAC_OUT);

parameter WIDTH=16;
`define P_WW 32
`define M_W 16

input   [WIDTH-1:0]  X;

input   [WIDTH-1:0]  Y;

input   CLK;

input   RST;
 


output  [WIDTH-1:0]  X_OUT;

output  [WIDTH-1:0]  Y_OUT;

output reg     [2*WIDTH-1:0]  MAC_OUT;

reg   [WIDTH-1:0]  X_OUT;

reg   [WIDTH-1:0]  Y_OUT;


wire  [2*WIDTH-1:0]  product; 


always @(posedge CLK )
begin
           X_OUT <= X;

	   Y_OUT <= Y;
         
end	 
	
reg     [2*WIDTH-1:0]  product_reg; 

always @(posedge CLK )
begin

 product_reg<=product;

end

always @(posedge CLK or negedge RST)
begin
        if (RST == 1'b0)
	begin

          MAC_OUT <= `P_WW'b0;
	end	

        else
	begin

          MAC_OUT <=  MAC_OUT+product_reg;
	end
end


mb16 b_mult(
 .mx(X),
 .my(Y),
 .CLK(CLK),
 .RST(RST),
 .product(product)
);

endmodule

