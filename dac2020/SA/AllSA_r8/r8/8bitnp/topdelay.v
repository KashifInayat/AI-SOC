module top_sa_2D (A1, B1, CLK, RST, YY1);

parameter HPE=`HPE;  // step 1 horizontal processing elements
parameter VPE=`VPE;  // vertical processing elements
parameter WIDTH=8;   // step 2 operands width  
//`define AB_WIDTH HPE*WIDTH
//`define Y_WIDTH HPE*VPE*WIDTH*2


input  wire [WIDTH*HPE-1:0]  A1;
input  wire [WIDTH*HPE-1:0]  B1;
input  wire  CLK;
input  wire     RST;
output reg [(2*WIDTH*HPE*VPE)-1:0]  YY1;
//output [(2*WIDTH*HPE*VPE)-1:0]  YY1;

reg [WIDTH*HPE-1:0]  A;
reg [WIDTH*HPE-1:0]  B;
wire [(2*WIDTH*HPE*VPE)-1:0]  YY;

always @(posedge CLK)
begin
A<=A1;
B<=B1;
YY1<=YY;
end
//assign YY1 = YY;

sa_2D #(HPE, VPE) core(A, B, CLK, RST, YY);

endmodule
