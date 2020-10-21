`timescale 1ns / 1ps
module test1();
parameter WIDTH = 32;
parameter group_cnt=(WIDTH>>2)+3; 
parameter ht= 0.75;//halfclocktime
//`define il 16//input length
reg [WIDTH-1:0] mx;
reg [WIDTH-1:0] my;
reg [WIDTH+1:0] tmy;
reg CLK;
reg RST;
wire [group_cnt-1:0] s;
wire [group_cnt-1:0] d;
wire [group_cnt-1:0] t;
wire [group_cnt-1:0] q;
wire [group_cnt-1:0] n;
// Outputs
wire [(WIDTH*2)-1:0] product;
wire [group_cnt-1:0] s_load;
wire [group_cnt-1:0] d_load;
wire [group_cnt-1:0] t_load;
wire [group_cnt-1:0] q_load;
wire [group_cnt-1:0] n_load;
wire [WIDTH-1:0] my_load;
wire [WIDTH+1:0] tmy_load;
reg [(WIDTH*2)-1:0] p;
reg [(WIDTH*2)-1:0] p1;
reg [(WIDTH*2)-1:0] p2;
reg [(WIDTH*2)-1:0] p3;
reg [(WIDTH*2)-1:0] p4;
reg [WIDTH-1:0] ram_a [0:9999];
reg [WIDTH-1:0] ram_b [0:9999];
integer i,j,ce,il;
// Instantiate the Unit Under Test (UUT)
mb32_top uut1(
		.s(s),	
		.d(d),
		.t(t),
		.q(q),
		.n(n),
		.my(my),
		.tmy(tmy),
		.CLK(CLK),
		.RST(RST),
		.s2(s_load),
		.d2(d_load),
		.t2(t_load),
		.q2(q_load),
		.n2(n_load),
		.my2(my_load),
		.tmy2(tmy_load),
		.product(product)
);
/*	 mb16 uut1 (
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
	*/
// Input vectors
initial begin
$readmemh(`INPUT_FILE_NAMEX, ram_a);
$readmemh(`INPUT_FILE_NAMEY, ram_b);
end

initial begin
mx=0;
my=0;
 RST=1'b0;
#2 RST=1'b1;
#2 CLK=1'b0;
end
initial begin
ce=0;
i = 0;
while(1)
         begin
            #(2*ht)//1.5
	    mx=ram_a[i][WIDTH-1:0];
            my=ram_b[i][WIDTH-1:0];
            tmy<=my+(my<<1);
            p<=mx*my;
            if(product!=p4) begin
            ce<=ce+1;
		$display("Error!!");
		end

		if(i==9999) 
		i = 0;
	    else
		i = i + 1;

     end
 end
 pre_process_be be(mx, s, d, t, q, n);
  always @(CLK)
#(ht) CLK<=~CLK;
 
always @( posedge CLK)
    begin
        p1<=p;
        p2<=p1;
        p3<=p2;
        p4<=p3;
    end 
endmodule

