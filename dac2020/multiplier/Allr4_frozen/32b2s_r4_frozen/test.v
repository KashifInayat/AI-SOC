
module test_m_booth_mult();
	// Inputs
	reg [31:0] mx;
	reg [31:0] my;
reg CLK;
reg RST;
	// Outputs 
wire [63:0] product;
reg [63:0] p;
    integer i,j,ce;
	// Instantiate the Unit Under Test (UUT)
	mb32 uut (
		.mx(mx), 
		.my(my),
		.CLK(CLK),
		.RST(RST),
		.product(product)
	);
	
//Input Vectors
initial begin
mx=32'h00000000;
my=32'h00000000;

end
initial begin
ce=0;
//while (i<65536)
for (i=0;i<655360000; i=i+10000)
  begin 
     for (j=0;j<655360000;j=j+10000)
         begin
            #1 mx=i;
            my=j;
            p<=mx*my;
            if(product!=p)
            ce<=ce+1;
     end
 end
 end

endmodule

