`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2019 11:00:44 AM
// Design Name: 
// Module Name: test1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test1();
	// Inputs
	reg [7:0] mx;
	reg [7:0] my;
	reg [9:0] tmy;

	// Outputs
	wire [15:0] product;
reg [15:0] p;
    integer i,j,ce;
	// Instantiate the Unit Under Test (UUT)
	 mb8_radix8 uut (
		.mx(mx), 
		.my(my),
		.tmy(tmy),     
		.product(product)
	);
	
// Input vectors
initial begin
mx=8'b00000000;
my=8'b00000000;
end
initial begin
ce=0;
for (i=0;i<256;i=i+1)
  begin 
     for (j=0;j<256;j=j+1)
         begin
            #1
            mx=i;
            my=j;
            tmy<=my+(my<<1);
            p<=mx*my;
            if(product!=p)
            ce<=ce+1;
     end
 end
 end
      
initial
$monitor("time=%.3f ps, mx=%b, my=%b, product=%b\n",$realtime,mx,my,product);
endmodule


