
module mb32_top #(parameter WIDTH = 32)(s,d,t,q,n,my,tmy,CLK,RST,product,s2,d2,t2,q2,n2,my2,tmy2);
parameter group_cnt=(WIDTH>>2)+3;//11bits
input wire [group_cnt-1:0] s;
input wire [group_cnt-1:0] d;
input wire [group_cnt-1:0] t;
input wire [group_cnt-1:0] q;
input wire [group_cnt-1:0] n;
input wire [WIDTH-1:0] my;
input wire [WIDTH+1:0] tmy;
input wire CLK;
input wire RST;
output wire [(WIDTH*2)-1:0] product;
output reg [group_cnt-1:0] s2;
output reg [group_cnt-1:0] d2;
output reg [group_cnt-1:0] t2;
output reg [group_cnt-1:0] q2;
output reg [group_cnt-1:0] n2;
output reg [WIDTH-1:0] my2;
output reg [WIDTH+1:0] tmy2;

wire [group_cnt-1:0] s1;
wire [group_cnt-1:0] d1;
wire [group_cnt-1:0] t1;
wire [group_cnt-1:0] q1;
wire [group_cnt-1:0] n1;
wire [WIDTH-1:0] my1;
wire [WIDTH+1:0] tmy1;

always @(posedge CLK)
begin
s2<=s1;
d2<=d1;
t2<=t1;
q2<=q1;
n2<=n1;
my2<=my1;
tmy2<=tmy1;
//end
end
mb32_td uut(
	.s(s), 
	.d(d), 
	.t(t), 
	.q(q), 
	.n(n), 
	.my(my),
	.tmy(tmy), 
	.CLK(CLK),
	.RST(RST),
	.s1(s1),
	.d1(d1),
	.t1(t1),
	.q1(q1),
	.n1(n1),
	.my1(my1),
	.tmy1(tmy1),
	.product1(product));


    
endmodule
