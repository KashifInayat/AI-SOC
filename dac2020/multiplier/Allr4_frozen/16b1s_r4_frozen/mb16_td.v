`timescale 1ns / 1ps
module mb16_td (mx1, my1, CLK, RST, product1, mx_reg, my_reg);

parameter WIDTH=16;   
input wire [WIDTH-1:0] mx1;
input wire [WIDTH-1:0] my1;
input wire CLK;
input wire RST;
output reg [(2*WIDTH)-1:0] product1;
output reg [WIDTH-1:0] mx_reg;
output reg [WIDTH-1:0] my_reg;


wire [(2*WIDTH)-1:0] product;


always@ (posedge CLK)
begin
/*
if (!RST)
begin
mx_reg<=16'h0;
my_reg<=16'h0;
product1<=32'h0;
end
else
begin
*/
mx_reg<=mx1;
my_reg<=my1;
product1<=product;
//end
end



	 mb16 uut0 (
		.mx(mx_reg), 
		.my(my_reg),
		.CLK(CLK), 
		.RST(RST),     
		.product(product)

	);


endmodule
