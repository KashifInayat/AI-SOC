module mb16_with_load#(parameter WIDTH = 16)(s,d,t,q,n,my,tmy,CLK,RST,s1,d1,t1,q1,n1,my1,tmy1,product1);
parameter group_cnt=(WIDTH>>2)+2; 
input wire [group_cnt-1:0] s;
input wire [group_cnt-1:0] d;
input wire [group_cnt-1:0] t;
input wire [group_cnt-1:0] q;
input wire [group_cnt-1:0] n;
input wire [WIDTH-1:0] my;
input wire [WIDTH+1:0] tmy;
input wire CLK;
input wire RST;
output reg [group_cnt-1:0] s1;
output reg [group_cnt-1:0] d1;
output reg [group_cnt-1:0] t1;
output reg [group_cnt-1:0] q1;
output reg [group_cnt-1:0] n1;
output reg [WIDTH-1:0] my1;
output reg [WIDTH+1:0] tmy1;
output reg [(WIDTH*2)-1:0] product1;

wire [(WIDTH*2)-1:0] product;


always @(posedge CLK) // or negedge RST)
begin
/*
if (!RST)
begin
s1<=6'h0;
d1<=6'h0;
t1<=6'h0;
q1<=6'h0;
n1<=6'h0;
my1<=16'h0;
tmy1<=18'h0;
product1<=32'h0;
end
else
begin
*/
s1<=s;
d1<=d;
t1<=t;
q1<=q;
n1<=n;
my1<=my;
tmy1<=tmy;
product1<=product;
//end
end

		 mb16 uut0 (
		.s(s),
		.d(d),
		.t(t),
		.q(q),
		.n(n), 
		.my(my),
		.tmy(tmy),  
		.CLK(CLK),
		.RST(RST), 
		.product(product)
	);

    
endmodule
