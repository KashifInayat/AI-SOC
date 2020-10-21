module mb16_top #(parameter WIDTH = 16)(mx,my,CLK,RST,product,mx2,my2);
input wire [WIDTH-1:0] mx;
input wire [WIDTH-1:0] my;
input wire CLK;
input wire RST;
output wire [(WIDTH*2)-1:0] product;
output reg [WIDTH-1:0] mx2;
output reg [WIDTH-1:0] my2;

wire [WIDTH-1:0] mx1;
wire [WIDTH-1:0] my1;

always @(posedge CLK)
begin
mx2<=mx1;
my2<=my1;
end
mb16_td uut(
	.mx(mx),
	.my(my),
	.CLK(CLK),
	.RST(RST),
	.mx1(mx1),
	.my1(my1),
	.product1(product));
    
endmodule
