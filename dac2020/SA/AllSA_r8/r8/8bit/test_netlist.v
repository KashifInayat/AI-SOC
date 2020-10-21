`timescale 1ns / 10ps
module test();

parameter WIDTH=8;
parameter HPE=`HPE; 
parameter VPE=`VPE;


reg   [WIDTH-1:0]  A [0:HPE-1];
reg   [WIDTH-1:0]  B [0:HPE-1];

wire   [WIDTH*HPE-1:0]  AA ;
wire   [WIDTH*VPE-1:0]  BB ;


reg           CLK=1'b0;

reg           RST;


reg [16:0] ram_a [0:9999];

wire   [(2*WIDTH*HPE*VPE)-1:0]  Y;
wire [WIDTH*2-1:0] Y_OUT[0:VPE-1][0:HPE-1];

integer k;

initial begin
$readmemh("./inputs/bitwidth_16_n_10000.txt", ram_a);
end


`DUT uut1 ( AA, BB, CLK, RST, Y ); 

genvar i,j;
integer m,n;
  generate 
  for (i = 0; i < HPE; i = i+1) begin:weights
    assign AA[((i+1)*WIDTH)-1 : ((i)*WIDTH)] = A[i]; 
    assign BB[((i+1)*WIDTH)-1 : ((i)*WIDTH)] = B[i];
  end 
  endgenerate

generate
    for (j = 0; j < HPE; j = j + 1) begin: outputss
        for (i = 0; i < VPE; i = i + 1) begin 
           assign Y_OUT[j][i]=Y[((((HPE*VPE)-((j*HPE)+i))*(WIDTH*2))-1):((((HPE*VPE)-((j*HPE)+(i+1)))*(WIDTH*2)))];
        end
        end
endgenerate  

initial begin
CLK=1'b0;
RST=1'b0;
#10
RST=1'b1;
end

initial begin
k = 0;
#1;
while(1)
         begin
            #1.5
	for (n=0;n<HPE;n=n+1)
         begin
            A[n]=ram_a[k][15:8];
            B[n]=ram_a[k][7:0];
	   if(k==9999)
                k = 0;
           else
                k = k + 1;
	 end
            
     end
 end




always
#(1.5/2) CLK<=~CLK;
endmodule
