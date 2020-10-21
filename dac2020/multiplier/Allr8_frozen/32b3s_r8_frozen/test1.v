`timescale 1ns / 1ps
module test1();
parameter WIDTH = 32;
parameter ht= 0.75;//halfclocktime
reg [WIDTH-1:0] mx;
reg [WIDTH-1:0] my;
reg CLK;
reg RST;
// Outputs
wire [(WIDTH*2)-1:0] product;
wire [WIDTH-1:0] mx_load;
wire [WIDTH-1:0] my_load;
reg [(WIDTH*2)-1:0] p;
reg [(WIDTH*2)-1:0] p1;
reg [(WIDTH*2)-1:0] p2;
reg [(WIDTH*2)-1:0] p3;
reg [(WIDTH*2)-1:0] p4;
reg [WIDTH-1:0] ram_a [0:9999];
reg [WIDTH-1:0] ram_b [0:9999];
integer i,j,ce;
// Instantiate the Unit Under Test (UUT)
mb32_top uut1(
		.mx(mx),
		.my(my),
		.CLK(CLK),
		.RST(RST),
		.mx2(mx_load),
		.my2(my_load),
		.product(product));
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

