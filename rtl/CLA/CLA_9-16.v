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
parameter N=13;
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
   PRESTAGE_32 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_32 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_32 U3 (OPA[N-1:0] , OPB[N-1:0] , PBIT , PHI , CARRY[N:0] , SUM , COUT );
endmodule

//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_32 ( A, B, CIN, PHI, POUT, GOUT );
parameter N=13;
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
module DBLCTREE_32 ( PIN, GIN, PHI, GOUT, POUT );
parameter N=13;
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
//   wire [0:N-16] INTPROP_3;
//   wire [0:N] INTGEN_3;
//   wire [0:N-32] INTPROP_4;
//   wire [0:N] INTGEN_4;
   //wire [8:0] INTPROP_3;
   //wire [24:0] INTGEN_3;
  
   DBLC_0_32 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_32 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_32 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_32 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
   //DBLC_4_32 U_4 (.PIN(INTPROP_3) , .GIN(INTGEN_3) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule

module DBLC_0_32 ( PIN, GIN, PHI, POUT, GOUT );
parameter N=13;
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


module DBLC_1_32 ( PIN, GIN, PHI, POUT, GOUT );
parameter N=13;
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


module DBLC_2_32 ( PIN, GIN, PHI, POUT, GOUT );
parameter N=13;
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
  
module DBLC_3_32 ( PIN, GIN, PHI, POUT, GOUT );
parameter N=13;
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
   BLOCK1 U(PIN[0] , PIN[N/2] , GIN[N/2] , GIN[N] , PHI , POUT[0] , GOUT[N] );
  /*  BLOCK2 U316 (PIN[0] , PIN[8] , GIN[8] , GIN[16] , PHI , POUT[0] , GOUT[16] );
   BLOCK2 U317 (PIN[1] , PIN[9] , GIN[9] , GIN[17] , PHI , POUT[1] , GOUT[17] );
   BLOCK2 U318 (PIN[2] , PIN[10] , GIN[10] , GIN[18] , PHI , POUT[2] , GOUT[18] );
   BLOCK2 U319 (PIN[3] , PIN[11] , GIN[11] , GIN[19] , PHI , POUT[3] , GOUT[19] );
   BLOCK2 U320 (PIN[4] , PIN[12] , GIN[12] , GIN[20] , PHI , POUT[4] , GOUT[20] );
   BLOCK2 U321 (PIN[5] , PIN[13] , GIN[13] , GIN[21] , PHI , POUT[5] , GOUT[21] );
   BLOCK2 U322 (PIN[6] , PIN[14] , GIN[14] , GIN[22] , PHI , POUT[6] , GOUT[22] );
   BLOCK2 U323 (PIN[7] , PIN[15] , GIN[15] , GIN[23] , PHI , POUT[7] , GOUT[23] );
   BLOCK2 U324 (PIN[8] , PIN[16] , GIN[16] , GIN[24] , PHI , POUT[8] , GOUT[24] );
   //BLOCK2 U325 (PIN[9] , PIN[17] , GIN[17] , GIN[25] , PHI , POUT[9] , GOUT[25] );
   //BLOCK2 U326 (PIN[10] , PIN[18] , GIN[18] , GIN[26] , PHI , POUT[10] , GOUT[26] );
   //BLOCK2 U327 (PIN[11] , PIN[19] , GIN[19] , GIN[27] , PHI , POUT[11] , GOUT[27] );
   //BLOCK2 U328 (PIN[12] , PIN[20] , GIN[20] , GIN[28] , PHI , POUT[12] , GOUT[28] );
   //BLOCK2 U329 (PIN[13] , PIN[21] , GIN[21] , GIN[29] , PHI , POUT[13] , GOUT[29] );
   //BLOCK2 U330 (PIN[14] , PIN[22] , GIN[22] , GIN[30] , PHI , POUT[14] , GOUT[30] );
   //BLOCK2 U331 (PIN[15] , PIN[23] , GIN[23] , GIN[31] , PHI , POUT[15] , GOUT[31] );
   //BLOCK2 U332 (PIN[16] , PIN[24] , GIN[24] , GIN[32] , PHI , POUT[16] , GOUT[32] ); */
endmodule



//module DBLC_4_64 ( PIN, GIN, PHI, POUT, GOUT );
//input  [0:48] PIN;
//input  [0:64] GIN;
//input  PHI;
//output [0:32] POUT;
//output [0:64] GOUT;
//   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
//   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
//   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
//   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
//   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
//   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
//   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
//   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
//   INVBLOCK U18 (GIN[8] , PHI , GOUT[8] );
//   INVBLOCK U19 (GIN[9] , PHI , GOUT[9] );
//   INVBLOCK U110 (GIN[10] , PHI , GOUT[10] );
//   INVBLOCK U111 (GIN[11] , PHI , GOUT[11] );
//   INVBLOCK U112 (GIN[12] , PHI , GOUT[12] );
//   INVBLOCK U113 (GIN[13] , PHI , GOUT[13] );
//   INVBLOCK U114 (GIN[14] , PHI , GOUT[14] );
//   INVBLOCK U115 (GIN[15] , PHI , GOUT[15] );
//   BLOCK1A U216 (PIN[0] , GIN[0] , GIN[16] , PHI , GOUT[16] );
//   BLOCK1A U217 (PIN[1] , GIN[1] , GIN[17] , PHI , GOUT[17] );
//   BLOCK1A U218 (PIN[2] , GIN[2] , GIN[18] , PHI , GOUT[18] );
//   BLOCK1A U219 (PIN[3] , GIN[3] , GIN[19] , PHI , GOUT[19] );
//   BLOCK1A U220 (PIN[4] , GIN[4] , GIN[20] , PHI , GOUT[20] );
//   BLOCK1A U221 (PIN[5] , GIN[5] , GIN[21] , PHI , GOUT[21] );
//   BLOCK1A U222 (PIN[6] , GIN[6] , GIN[22] , PHI , GOUT[22] );
//   BLOCK1A U223 (PIN[7] , GIN[7] , GIN[23] , PHI , GOUT[23] );
//   BLOCK1A U224 (PIN[8] , GIN[8] , GIN[24] , PHI , GOUT[24] );
//   BLOCK1A U225 (PIN[9] , GIN[9] , GIN[25] , PHI , GOUT[25] );
//   BLOCK1A U226 (PIN[10] , GIN[10] , GIN[26] , PHI , GOUT[26] );
//   BLOCK1A U227 (PIN[11] , GIN[11] , GIN[27] , PHI , GOUT[27] );
//   BLOCK1A U228 (PIN[12] , GIN[12] , GIN[28] , PHI , GOUT[28] );
//   BLOCK1A U229 (PIN[13] , GIN[13] , GIN[29] , PHI , GOUT[29] );
//   BLOCK1A U230 (PIN[14] , GIN[14] , GIN[30] , PHI , GOUT[30] );
//   BLOCK1A U231 (PIN[15] , GIN[15] , GIN[31] , PHI , GOUT[31] );
//   BLOCK1 U332 (PIN[0] , PIN[16] , GIN[16] , GIN[32] , PHI , POUT[0] , GOUT[32] );
//   BLOCK1 U333 (PIN[1] , PIN[17] , GIN[17] , GIN[33] , PHI , POUT[1] , GOUT[33] );
//   BLOCK1 U334 (PIN[2] , PIN[18] , GIN[18] , GIN[34] , PHI , POUT[2] , GOUT[34] );
//   BLOCK1 U335 (PIN[3] , PIN[19] , GIN[19] , GIN[35] , PHI , POUT[3] , GOUT[35] );
//   BLOCK1 U336 (PIN[4] , PIN[20] , GIN[20] , GIN[36] , PHI , POUT[4] , GOUT[36] );
//   BLOCK1 U337 (PIN[5] , PIN[21] , GIN[21] , GIN[37] , PHI , POUT[5] , GOUT[37] );
//   BLOCK1 U338 (PIN[6] , PIN[22] , GIN[22] , GIN[38] , PHI , POUT[6] , GOUT[38] );
//   BLOCK1 U339 (PIN[7] , PIN[23] , GIN[23] , GIN[39] , PHI , POUT[7] , GOUT[39] );
//   BLOCK1 U340 (PIN[8] , PIN[24] , GIN[24] , GIN[40] , PHI , POUT[8] , GOUT[40] );
//   BLOCK1 U341 (PIN[9] , PIN[25] , GIN[25] , GIN[41] , PHI , POUT[9] , GOUT[41] );
//   BLOCK1 U342 (PIN[10] , PIN[26] , GIN[26] , GIN[42] , PHI , POUT[10] , GOUT[42] );
//   BLOCK1 U343 (PIN[11] , PIN[27] , GIN[27] , GIN[43] , PHI , POUT[11] , GOUT[43] );
//   BLOCK1 U344 (PIN[12] , PIN[28] , GIN[28] , GIN[44] , PHI , POUT[12] , GOUT[44] );
//   BLOCK1 U345 (PIN[13] , PIN[29] , GIN[29] , GIN[45] , PHI , POUT[13] , GOUT[45] );
//   BLOCK1 U346 (PIN[14] , PIN[30] , GIN[30] , GIN[46] , PHI , POUT[14] , GOUT[46] );
//   BLOCK1 U347 (PIN[15] , PIN[31] , GIN[31] , GIN[47] , PHI , POUT[15] , GOUT[47] );
//   BLOCK1 U348 (PIN[16] , PIN[32] , GIN[32] , GIN[48] , PHI , POUT[16] , GOUT[48] );
//   BLOCK1 U349 (PIN[17] , PIN[33] , GIN[33] , GIN[49] , PHI , POUT[17] , GOUT[49] );
//   BLOCK1 U350 (PIN[18] , PIN[34] , GIN[34] , GIN[50] , PHI , POUT[18] , GOUT[50] );
//   BLOCK1 U351 (PIN[19] , PIN[35] , GIN[35] , GIN[51] , PHI , POUT[19] , GOUT[51] );
//   BLOCK1 U352 (PIN[20] , PIN[36] , GIN[36] , GIN[52] , PHI , POUT[20] , GOUT[52] );
//   BLOCK1 U353 (PIN[21] , PIN[37] , GIN[37] , GIN[53] , PHI , POUT[21] , GOUT[53] );
//   BLOCK1 U354 (PIN[22] , PIN[38] , GIN[38] , GIN[54] , PHI , POUT[22] , GOUT[54] );
//   BLOCK1 U355 (PIN[23] , PIN[39] , GIN[39] , GIN[55] , PHI , POUT[23] , GOUT[55] );
//   BLOCK1 U356 (PIN[24] , PIN[40] , GIN[40] , GIN[56] , PHI , POUT[24] , GOUT[56] );
//   BLOCK1 U357 (PIN[25] , PIN[41] , GIN[41] , GIN[57] , PHI , POUT[25] , GOUT[57] );
//   BLOCK1 U358 (PIN[26] , PIN[42] , GIN[42] , GIN[58] , PHI , POUT[26] , GOUT[58] );
//   BLOCK1 U359 (PIN[27] , PIN[43] , GIN[43] , GIN[59] , PHI , POUT[27] , GOUT[59] );
//   BLOCK1 U360 (PIN[28] , PIN[44] , GIN[44] , GIN[60] , PHI , POUT[28] , GOUT[60] );
//   BLOCK1 U361 (PIN[29] , PIN[45] , GIN[45] , GIN[61] , PHI , POUT[29] , GOUT[61] );
//   BLOCK1 U362 (PIN[30] , PIN[46] , GIN[46] , GIN[62] , PHI , POUT[30] , GOUT[62] );
//   BLOCK1 U363 (PIN[31] , PIN[47] , GIN[47] , GIN[63] , PHI , POUT[31] , GOUT[63] );
//   BLOCK1 U364 (PIN[32] , PIN[48] , GIN[48] , GIN[64] , PHI , POUT[32] , GOUT[64] );
//endmodule


//module DBLC_5_64 ( PIN, GIN, PHI, POUT, GOUT );
//input  [0:32] PIN;
//input  [0:64] GIN;
//input  PHI;
//output [0:0] POUT;
//output [0:64] GOUT;
//   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
//   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
//   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
//   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
//   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
//   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
//   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
//   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
//   INVBLOCK U18 (GIN[8] , PHI , GOUT[8] );
//   INVBLOCK U19 (GIN[9] , PHI , GOUT[9] );
//   INVBLOCK U110 (GIN[10] , PHI , GOUT[10] );
//   INVBLOCK U111 (GIN[11] , PHI , GOUT[11] );
//   INVBLOCK U112 (GIN[12] , PHI , GOUT[12] );
//   INVBLOCK U113 (GIN[13] , PHI , GOUT[13] );
//   INVBLOCK U114 (GIN[14] , PHI , GOUT[14] );
//   INVBLOCK U115 (GIN[15] , PHI , GOUT[15] );
//   INVBLOCK U116 (GIN[16] , PHI , GOUT[16] );
//   INVBLOCK U117 (GIN[17] , PHI , GOUT[17] );
//   INVBLOCK U118 (GIN[18] , PHI , GOUT[18] );
//   INVBLOCK U119 (GIN[19] , PHI , GOUT[19] );
//   INVBLOCK U120 (GIN[20] , PHI , GOUT[20] );
//   INVBLOCK U121 (GIN[21] , PHI , GOUT[21] );
//   INVBLOCK U122 (GIN[22] , PHI , GOUT[22] );
//   INVBLOCK U123 (GIN[23] , PHI , GOUT[23] );
//   INVBLOCK U124 (GIN[24] , PHI , GOUT[24] );
//   INVBLOCK U125 (GIN[25] , PHI , GOUT[25] );
//   INVBLOCK U126 (GIN[26] , PHI , GOUT[26] );
//   INVBLOCK U127 (GIN[27] , PHI , GOUT[27] );
//   INVBLOCK U128 (GIN[28] , PHI , GOUT[28] );
//   INVBLOCK U129 (GIN[29] , PHI , GOUT[29] );
//   INVBLOCK U130 (GIN[30] , PHI , GOUT[30] );
//   INVBLOCK U131 (GIN[31] , PHI , GOUT[31] );
//   BLOCK2A U232 (PIN[0] , GIN[0] , GIN[32] , PHI , GOUT[32] );
//   BLOCK2A U233 (PIN[1] , GIN[1] , GIN[33] , PHI , GOUT[33] );
//   BLOCK2A U234 (PIN[2] , GIN[2] , GIN[34] , PHI , GOUT[34] );
//   BLOCK2A U235 (PIN[3] , GIN[3] , GIN[35] , PHI , GOUT[35] );
//   BLOCK2A U236 (PIN[4] , GIN[4] , GIN[36] , PHI , GOUT[36] );
//   BLOCK2A U237 (PIN[5] , GIN[5] , GIN[37] , PHI , GOUT[37] );
//   BLOCK2A U238 (PIN[6] , GIN[6] , GIN[38] , PHI , GOUT[38] );
//   BLOCK2A U239 (PIN[7] , GIN[7] , GIN[39] , PHI , GOUT[39] );
//   BLOCK2A U240 (PIN[8] , GIN[8] , GIN[40] , PHI , GOUT[40] );
//   BLOCK2A U241 (PIN[9] , GIN[9] , GIN[41] , PHI , GOUT[41] );
//   BLOCK2A U242 (PIN[10] , GIN[10] , GIN[42] , PHI , GOUT[42] );
//   BLOCK2A U243 (PIN[11] , GIN[11] , GIN[43] , PHI , GOUT[43] );
//   BLOCK2A U244 (PIN[12] , GIN[12] , GIN[44] , PHI , GOUT[44] );
//   BLOCK2A U245 (PIN[13] , GIN[13] , GIN[45] , PHI , GOUT[45] );
//   BLOCK2A U246 (PIN[14] , GIN[14] , GIN[46] , PHI , GOUT[46] );
//   BLOCK2A U247 (PIN[15] , GIN[15] , GIN[47] , PHI , GOUT[47] );
//   BLOCK2A U248 (PIN[16] , GIN[16] , GIN[48] , PHI , GOUT[48] );
//   BLOCK2A U249 (PIN[17] , GIN[17] , GIN[49] , PHI , GOUT[49] );
//   BLOCK2A U250 (PIN[18] , GIN[18] , GIN[50] , PHI , GOUT[50] );
//   BLOCK2A U251 (PIN[19] , GIN[19] , GIN[51] , PHI , GOUT[51] );
//   BLOCK2A U252 (PIN[20] , GIN[20] , GIN[52] , PHI , GOUT[52] );
//   BLOCK2A U253 (PIN[21] , GIN[21] , GIN[53] , PHI , GOUT[53] );
//   BLOCK2A U254 (PIN[22] , GIN[22] , GIN[54] , PHI , GOUT[54] );
//   BLOCK2A U255 (PIN[23] , GIN[23] , GIN[55] , PHI , GOUT[55] );
//   BLOCK2A U256 (PIN[24] , GIN[24] , GIN[56] , PHI , GOUT[56] );
//   BLOCK2A U257 (PIN[25] , GIN[25] , GIN[57] , PHI , GOUT[57] );
//   BLOCK2A U258 (PIN[26] , GIN[26] , GIN[58] , PHI , GOUT[58] );
//   BLOCK2A U259 (PIN[27] , GIN[27] , GIN[59] , PHI , GOUT[59] );
//   BLOCK2A U260 (PIN[28] , GIN[28] , GIN[60] , PHI , GOUT[60] );
//   BLOCK2A U261 (PIN[29] , GIN[29] , GIN[61] , PHI , GOUT[61] );
//   BLOCK2A U262 (PIN[30] , GIN[30] , GIN[62] , PHI , GOUT[62] );
//   BLOCK2A U263 (PIN[31] , GIN[31] , GIN[63] , PHI , GOUT[63] );
//   BLOCK2 U364 (PIN[0] , PIN[32] , GIN[32] , GIN[64] , PHI , POUT[0] , GOUT[64] );
//endmodule


//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_32 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
parameter N=13;
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