`timescale 1ns / 10ps
module test();

parameter WIDTH=32;
parameter HPE=64; 
parameter VPE=64;


reg   [WIDTH-1:0]  A [0:HPE-1];
reg   [WIDTH-1:0]  B [0:HPE-1];

wire   [WIDTH*HPE-1:0]  AA ;
wire   [WIDTH*VPE-1:0]  BB ;


reg           CLK=1'b0;

reg           RST;


wire   [(2*WIDTH*HPE*VPE)-1:0]  Y;
wire [WIDTH*2-1:0] Y_OUT[0:VPE-1][0:HPE-1];

sa_2D uut1 ( AA, BB, CLK, RST, Y ); 

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

initial
begin
for (n=0;n<HPE;n=n+1)
         begin
            
            A[n]=32'h00000000;
            B[n]=32'h00000000;
	 end
#200
for (n=0;n<HPE;n=n+1)
         begin
            
            A[n]=32'h00000000;
            B[n]=32'h00000000;
	 end
#2 CLK=1'b0;
#1  RST=1'b0;
#1000
#2   RST=1'b1;
#3
for (m=0;m<HPE;m=m+1)
  begin 
  #10
     for (n=0;n<VPE;n=n+1)
         begin
            if(((m+1)-n)>0)
            begin
            A[n]=(m+1)-n;
            B[n]=(m+1)-n;
            end
            else
            begin
            A[n]=32'h00000000;
            B[n]=32'h00000000;
            end
         end
  end
 end


always @( CLK )
#5 CLK<=~CLK;
endmodule
