`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2020 03:35:01 PM
// Design Name: 
// Module Name: tb_FPMAC
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


module tb_FPMAC( );
 `include "parameters.v"

reg [WIDTH-1:0] A,B;
reg [CWIDTH-1:0] C;
reg [CWIDTH-1:0]idealfloat;
reg [CSIG_WIDTH:0]idealsig;
reg [7:0] idealExp;
reg [1:0] rnd;  
wire [SIG_WIDTH:0] aSig={1'b1,A[SIG_WIDTH-1:0]};
wire [SIG_WIDTH:0] bSig={1'b1,B[SIG_WIDTH-1:0]};
wire [CSIG_WIDTH:0] cSig={1'b1,C[CSIG_WIDTH-1:0]};
wire [CWIDTH-1:0] result;

  
  FFPMAC uut (.A(A),.B(B),.C(C),.rnd(rnd),.result(result));
 integer fd;
  initial begin
    rnd=2'b01;
    fd=$fopen("sub_inputsbf16.txt", "r");//fd=$fopen("testInputs.txt", "r");
    //op=0;
  end
   
  integer i; 
  always @ * begin
	$display("===============================================================");
	$display("BF-FPMAC-Radix 4 Results Vs C Generated Ideal Results");	
     $display("===============================================================");
	for(i=1;i<3;i=i+1) begin//400-950
      $fscanf(fd, "%x %x %x %x", A, B, C, idealfloat);
     idealExp=idealfloat[30:23];
     idealsig={1'b1,idealfloat[CSIG_WIDTH-1:0]};
      #5
		$display("INPUTS: A=%x, B=%x, C=%x, Result=%\n", A, B, C, result);
     $
	    $display("===============================================================");
	 	 	 
   end
 
  
  end
 //wire sig_compare = (uut.result_pre[CSIG_WIDTH-1:0]!=idealsig)
// wire res_compare = result!=idealfloat;
/*   initial begin
 A=0; B=0; C=0;

#3  A=16'b0100000101000001; B=16'b1100000001000000; C=32'b01000001010000000000000000000000;//7*2+1=15
#3  A=16'b0100000101000001; B=16'b1100000001000000; C=32'b01000001010000000000000000000000;//7*2+1=15
#3  A=16'b0100000101000001; B=16'b1100000001000000; C=32'b01000001010000000000000000000000;//7*2+1=15

end

//$display("SpecialCases: shamt=%d\n",uut.ALGN.i);
	 
	 //$display("SpecialCases: NZ=%b, NaN=%b, Ninf=%b, Pinf=%b\n",uut.setResultZero,uut.setResultNaN,uut.setResultPInf,uut.setResultNInf);	
	 /* $display("SpecialCases: prenormalized=%b\n",uut.NORMALIZE.prenormalized);
	 $
	 $display("SpecialCases:  Normalized1=%b\n",uut.NORMALIZE.normalized1);
	 $display("SpecialCases: normalized2=%b\n",uut.NORMALIZE.normalized2);
	 $display("SpecialCases: normalized3=%b, shamtportion=%b\n",uut.NORMALIZE.normalized3,uut.NORMALIZE.shamt_portion);
	 $display("SpecialCases: normalized=%b\n",uut.NORMALIZE.normalized);
	 
	 $display("SpecialCases: lza_shamt=%d\n",uut.NORMALIZE.lza_shamt);
	 $display("SpecialCases: A=%b\n",uut.LZA.opA);
	 $display("SpecialCases: B=%b\n",uut.LZA.opB);
	 $display("SpecialCases: f=%b\n",uut.LZA.f);
	 $display("SpecialCases: lza_shamt=%d\n",uut.LZA.ldCount);	 
	 $display("SpecialCases: lza_corrected1=%d\n",uut.NORMALIZE.lza_corrected1);
	 $display("SpecialCases: res_exp=%d\n",uut.NORMALIZE.res_exp);
	 $display("SpecialCases: exp_update1=%d\n",uut.NORMALIZE.exp_update1);
	 $display("SpecialCases: exp_update2=%d\n",uut.NORMALIZE.exp_update2);  
 */
endmodule
