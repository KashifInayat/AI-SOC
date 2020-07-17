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
parameter N=32;
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
parameter N=32;
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
parameter N=32;
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
   wire [0:N-16] INTPROP_3;
   wire [0:N] INTGEN_3;
//   wire [0:N-32] INTPROP_4;
//   wire [0:N] INTGEN_4;
   //wire [8:0] INTPROP_3;
   //wire [24:0] INTGEN_3;
  
   DBLC_0_N U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_N U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_N U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_N U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(INTPROP_3) , .GOUT(INTGEN_3) );
   DBLC_4_N U_4 (.PIN(INTPROP_3) , .GIN(INTGEN_3) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule

module DBLC_0_N ( PIN, GIN, PHI, POUT, GOUT );
parameter N=32;
input  [N-1:0] PIN;
input  [N:0] GIN;
input  PHI;
output [N-2:0] POUT;
output [N:0] GOUT;
INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
BLOCK1A U21 (PIN[0] , GIN[0] , GIN[1] , PHI , GOUT[1] );
genvar j;
  generate
  for(j=0;j<=N-2;j=j+1) begin: gen_prop
  BLOCK1 U32 (PIN[j] , PIN[j+1] , GIN[j+1] , GIN[j+2] , PHI , POUT[j] , GOUT[j+2] );
  end
  endgenerate
endmodule


module DBLC_1_N ( PIN, GIN, PHI, POUT, GOUT );
parameter N=32;
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
parameter N=32;
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
  
  genvar l;
  generate
  for(l=0;l<=N-8;l=l+1) begin: gen_prop
  BLOCK2 U(PIN[l] , PIN[l+4] , GIN[l+4] , GIN[l+8] , PHI , POUT[l] , GOUT[l+8] );
  end
  endgenerate
  endmodule
  
module DBLC_3_N ( PIN, GIN, PHI, POUT, GOUT );
parameter N=32;
input  [N-8:0] PIN;
input  [N:0] GIN;
input  PHI;
output [N-16:0] POUT;
output [N:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
   BLOCK2A U28 (PIN[0] , GIN[0] , GIN[8] , PHI , GOUT[8] );
   BLOCK2A U29 (PIN[1] , GIN[1] , GIN[9] , PHI , GOUT[9] );
   BLOCK2A U210 (PIN[2] , GIN[2] , GIN[10] , PHI , GOUT[10] );
   BLOCK2A U211 (PIN[3] , GIN[3] , GIN[11] , PHI , GOUT[11] );
   BLOCK2A U212 (PIN[4] , GIN[4] , GIN[12] , PHI , GOUT[12] );
   BLOCK2A U213 (PIN[5] , GIN[5] , GIN[13] , PHI , GOUT[13] );
   BLOCK2A U214 (PIN[6] , GIN[6] , GIN[14] , PHI , GOUT[14] );
   BLOCK2A U215 (PIN[7] , GIN[7] , GIN[15] , PHI , GOUT[15] );   
   genvar l;
  generate
  for(l=0;l<=N/2;l=l+1) begin: gen_prop
  BLOCK2 U316 (PIN[l] , PIN[l+8] , GIN[l+8] , GIN[l+16] , PHI , POUT[l] , GOUT[l+16] );
  end
  endgenerate
  endmodule
   
//BLOCK1 U(PIN[0] , PIN[N/2] , GIN[N/2] , GIN[N] , PHI , POUT[0] , GOUT[N] );


module DBLC_4_N ( PIN, GIN, PHI, POUT, GOUT );
parameter N=32;
input  [N-16:0] PIN;
input  [N:0] GIN;
input  PHI;
output [N-32:0] POUT;
output [N:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
   INVBLOCK U18 (GIN[8] , PHI , GOUT[8] );
   INVBLOCK U19 (GIN[9] , PHI , GOUT[9] );
   INVBLOCK U110 (GIN[10] , PHI , GOUT[10] );
   INVBLOCK U111 (GIN[11] , PHI , GOUT[11] );
   INVBLOCK U112 (GIN[12] , PHI , GOUT[12] );
   INVBLOCK U113 (GIN[13] , PHI , GOUT[13] );
   INVBLOCK U114 (GIN[14] , PHI , GOUT[14] );
   INVBLOCK U115 (GIN[15] , PHI , GOUT[15] );
   BLOCK1A U216 (PIN[0] , GIN[0] , GIN[16] , PHI , GOUT[16] );
   BLOCK1A U217 (PIN[1] , GIN[1] , GIN[17] , PHI , GOUT[17] );
   BLOCK1A U218 (PIN[2] , GIN[2] , GIN[18] , PHI , GOUT[18] );
   BLOCK1A U219 (PIN[3] , GIN[3] , GIN[19] , PHI , GOUT[19] );
   BLOCK1A U220 (PIN[4] , GIN[4] , GIN[20] , PHI , GOUT[20] );
   BLOCK1A U221 (PIN[5] , GIN[5] , GIN[21] , PHI , GOUT[21] );
   BLOCK1A U222 (PIN[6] , GIN[6] , GIN[22] , PHI , GOUT[22] );
   BLOCK1A U223 (PIN[7] , GIN[7] , GIN[23] , PHI , GOUT[23] );
   BLOCK1A U224 (PIN[8] , GIN[8] , GIN[24] , PHI , GOUT[24] );
   BLOCK1A U225 (PIN[9] , GIN[9] , GIN[25] , PHI , GOUT[25] );
   BLOCK1A U226 (PIN[10] , GIN[10] , GIN[26] , PHI , GOUT[26] );
   BLOCK1A U227 (PIN[11] , GIN[11] , GIN[27] , PHI , GOUT[27] );
   BLOCK1A U228 (PIN[12] , GIN[12] , GIN[28] , PHI , GOUT[28] );
   BLOCK1A U229 (PIN[13] , GIN[13] , GIN[29] , PHI , GOUT[29] );
   BLOCK1A U230 (PIN[14] , GIN[14] , GIN[30] , PHI , GOUT[30] );
   BLOCK1A U231 (PIN[15] , GIN[15] , GIN[31] , PHI , GOUT[31] );
   BLOCK1 U332 (PIN[0] , PIN[N/2] , GIN[N/2] , GIN[N] , PHI , POUT[0] , GOUT[N] );
endmodule

//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_N ( A, B, PBIT, PHI, CARRY, SUM, COUT );
parameter N=32;
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