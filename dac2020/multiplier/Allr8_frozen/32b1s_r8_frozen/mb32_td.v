module mb32_td (mx,my,CLK,RST,mx1,my1, product1);
parameter WIDTH=32;   
input wire [WIDTH-1:0] mx;
input wire [WIDTH-1:0] my;
input wire CLK;
input wire RST;

output reg [WIDTH-1:0] mx1;
output reg [WIDTH-1:0] my1;
output reg [(WIDTH*2)-1:0] product1;

wire [(WIDTH*2)-1:0] product;
always @(posedge CLK) 
begin
mx1<=mx;
my1<=my;
product1<=product;
end

	mb32 uut0 (
		.mx(mx1),
		.my(my1),
		.CLK(CLK),
		.RST(RST),
		.product(product)
	);


endmodule
