`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2020 03:05:23 PM
// Design Name: 
// Module Name: CLA_N
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


module CLA_N ( OPA, OPB, CIN, PHI, SUM, COUT );
parameter N=8;
input  [N-1:0] OPA;
input  [N-1:0] OPB;
input  CIN;
input  PHI;
output [N-1:0] SUM;
output COUT;
   wire [N-1:0] INTPROP;
   wire [N:0] INTGEN;
   wire [0:0] PBIT;
   wire [N:0] CARRY;
   PRESTAGE_N U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_N U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_N U3 (OPA[N-1:0] , OPB[N-1:0] , PBIT , PHI , CARRY[N:0] , SUM , COUT );
endmodule

//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_N ( A, B, CIN, PHI, POUT, GOUT );
parameter N=8;
input  [N-1:0] A;
input  [N-1:0] B;
input  CIN;
input  PHI;
output [N-1:0] POUT;
output [N:0] GOUT;


INVBLOCK U2 (CIN , PHI , GOUT[0] );
genvar i;
  generate
  for(i=0;i<=N-1;i=i+1) begin: gen_prop
  BLOCK0 U(A[i] , B[i] , PHI , POUT[i] , GOUT[i+1] );
  end
  endgenerate
 
endmodule
//******************** Carry Look Ahead Adder Tree ********************//
module DBLCTREE_N ( PIN, GIN, PHI, GOUT, POUT );
parameter N=8;
input  [N-1:0] PIN;
input  [N:0] GIN;
input  PHI;
output [N:0] GOUT;
output [0:0] POUT;


   wire [N-2:0] INTPROP_0;
   wire [N:0] INTGEN_0;
   wire [N-4:0] INTPROP_1;
   wire [N:0] INTGEN_1;
   wire [N-8:0] INTPROP_2;
   wire [N:0] INTGEN_2;
 
   DBLC_0_N U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_N U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_N U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
endmodule

module DBLC_0_N ( PIN, GIN, PHI, POUT, GOUT );
parameter N=8;
input  [N-1:0] PIN;
input  [N:0] GIN;
input  PHI;
output [N-2:0] POUT;
output [N:0] GOUT;
INVBLOCK U00 (GIN[0] , PHI , GOUT[0] );
BLOCK1A U01 (PIN[0] , GIN[0] , GIN[1] , PHI , GOUT[1] );
genvar j;
  generate
  for(j=0;j<=N-2;j=j+1) begin: gen_prop
  BLOCK1 UN (PIN[j] , PIN[j+1] , GIN[j+1] , GIN[j+2] , PHI , POUT[j] , GOUT[j+2] );
  end
  endgenerate
endmodule


module DBLC_1_N ( PIN, GIN, PHI, POUT, GOUT );
parameter N=8;
input  [N-2:0] PIN;
input  [N:0] GIN;
input  PHI;
output [N-4:0] POUT;
output [N:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   BLOCK2A U22 (PIN[0] , GIN[0] , GIN[2] , PHI , GOUT[2] );
   BLOCK2A U23 (PIN[1] , GIN[1] , GIN[3] , PHI , GOUT[3] );
  genvar k;
  generate
  for(k=0;k<=N-4;k=k+1) begin: gen_prop
  BLOCK2 U(PIN[k] , PIN[k+2] , GIN[k+2] , GIN[k+4] , PHI , POUT[k] , GOUT[k+4] );
  end
  endgenerate
  endmodule


module DBLC_2_N ( PIN, GIN, PHI, POUT, GOUT );
parameter N=8;
input  [N-4:0] PIN;
input  [N:0] GIN;
input  PHI;
output [N-8:0] POUT;
output [N:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   BLOCK1A U24 (PIN[0] , GIN[0] , GIN[4] , PHI , GOUT[4] );
   BLOCK1A U25 (PIN[1] , GIN[1] , GIN[5] , PHI , GOUT[5] );
   BLOCK1A U26 (PIN[2] , GIN[2] , GIN[6] , PHI , GOUT[6] );
   BLOCK1A U27 (PIN[3] , GIN[3] , GIN[7] , PHI , GOUT[7] );
   BLOCK1 U(PIN[0] , PIN[N/2] , GIN[N/2] , GIN[N] , PHI , POUT[0] , GOUT[N] );
   endmodule
  
//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_32 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
parameter N=8;
input  [N-1:0] A;
input  [N-1:0] B;
input  PBIT;
input  PHI;
input  [N:0] CARRY;
output [N-1:0] SUM;
output COUT;

 genvar l;
  generate
  for(l=0;l<=N-1;l=l+1) begin: f_sum
   XXOR1 U20 (A[l] , B[l] , CARRY[l] , PHI , SUM[l] );
  end
  endgenerate
  
   BLOCK1A U1 (PBIT , CARRY[0] , CARRY[N] , PHI , COUT );
endmodule
module INVBLOCK ( GIN, PHI, GOUT );
input  GIN;
input  PHI;
output GOUT;
   assign GOUT =   GIN;
endmodule


module XXOR1 ( A, B, GIN, PHI, SUM );
input  A;
input  B;
input  GIN;
input  PHI;
output SUM;
   assign SUM = (  (A ^ B)) ^ GIN;
endmodule


module BLOCK0 ( A, B, PHI, POUT, GOUT );
input  A;
input  B;
input  PHI;
output POUT;
output GOUT;
   assign POUT =   (A | B);
   assign GOUT =   (A & B);
endmodule


module BLOCK1 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =   (PIN1 & PIN2);
   assign GOUT =  (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK2 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =   (PIN1 & PIN2);
   assign GOUT =   (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK1A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT = (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK2A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT =   (GIN2 | (PIN2 & GIN1));
endmodule