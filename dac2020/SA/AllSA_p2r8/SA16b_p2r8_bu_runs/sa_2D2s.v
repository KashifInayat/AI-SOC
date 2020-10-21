`timescale 1ns / 10ps
module sa_2D( AA, BB, CLK, RST, Y);

parameter HPE=64;  // step 1 horizontal processing elements
parameter VPE=64;  // vertical processing elements

parameter WIDTH=16;   // step 2 operands width  
`define P_W 32        // outputs width  
`define M_W 16        // width 
parameter group_cnt=(WIDTH>>2)+2;     // no of groups

input   [WIDTH*HPE-1:0]  AA;
input   [WIDTH*HPE-1:0]  BB;
input           CLK;
input           RST;
output   [(2*WIDTH*HPE*VPE)-1:0]  Y;

wire [WIDTH-1:0] Ain[0:HPE-1];
wire [WIDTH-1:0] Bin[0:HPE-1];

genvar z;
  generate for (z = 0; z < HPE; z = z+1) begin:Input_weights 
      assign Ain[z] = AA[(((z+1)*WIDTH)-1) : ((z)*WIDTH)];
      assign Bin[z] = BB[(((z+1)*WIDTH)-1) : ((z)*WIDTH)];
end
endgenerate

wire [group_cnt - 1:0] S [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] D [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] T [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] Q [0:VPE-1][0:HPE-1];
wire [group_cnt - 1:0] N [0:VPE-1][0:HPE-1];

wire [WIDTH-1:0] MY_OUT[0:VPE-1][0:HPE-1];

wire [WIDTH+1:0] TMY[0:VPE-1][0:HPE-1];

wire [WIDTH*2-1:0] Y_OUT[0:VPE-1][0:HPE-1];

genvar i,j;
generate
    for (j = 0; j < HPE; j = j + 1) begin: outputs
        for (i = 0; i < VPE; i = i + 1) begin : outputsss
         assign Y[((((HPE*VPE)-((j*HPE)+i))*(WIDTH*2))-1) : ((((HPE*VPE)-((j*HPE)+(i+1)))*(WIDTH*2)))]=Y_OUT[j][i];
        end
        end
endgenerate    

wire [group_cnt - 1:0] s [0:HPE-1];
wire [group_cnt - 1:0] d [0:HPE-1];
wire [group_cnt - 1:0] t [0:HPE-1];
wire [group_cnt - 1:0] q [0:HPE-1];
wire [group_cnt - 1:0] n [0:HPE-1];

genvar l;
generate
	for (l = 0; l < HPE; l = l + 1) begin: pre_pro1

pre_process_be pre_pro_be(.mx(Ain[l]), .CLK(CLK), .sr(s[l]), .dr(d[l]), .tr(t[l]), .qr(q[l]), .nr(n[l]));

    end
endgenerate    


genvar k;
generate
	for (k = 0; k < HPE; k = k + 1) begin: pre_process
    pre_process_TMY prep00(.my(Bin[k]), .CLK(CLK), .RST(RST), .my_out(MY_OUT[k][0]), .TMY(TMY[k][0])); 	
    end
endgenerate        


generate
    for (j = 0; j < HPE-1; j = j + 1) begin: first_col_PEs 
    PE_OS_16_R8 PE00( .s(s[j]), .d(d[j]), .t(t[j]), .q(q[j]), .n(n[j]), .Y(MY_OUT[0][j]), .TMY(TMY[0][j]), .CLK(CLK), .RST(RST), .S_OUT(S[j][0]), .D_OUT(D[j][0]), .T_OUT(T[j][0]), .Q_OUT(Q[j][0]), .N_OUT(N[j][0]), .Y_OUT(MY_OUT[0][j+1]), .TMY_OUT(TMY[0][j+1]), .MAC_OUT(Y_OUT[j][0]));
    end
endgenerate   
PE_OS_16_R8 PE1111( .s(s[HPE-1]), .d(d[HPE-1]), .t(t[HPE-1]), .q(q[HPE-1]), .n(n[HPE-1]), .Y(MY_OUT[0][HPE-1]), .TMY(TMY[0][HPE-1]), .CLK(CLK), .RST(RST), .S_OUT(S[HPE-1][0]), .D_OUT(D[HPE-1][0]), .T_OUT(T[HPE-1][0]), .Q_OUT(Q[HPE-1][0]), .N_OUT(N[HPE-1][0]), .Y_OUT(), .TMY_OUT(), .MAC_OUT(Y_OUT[HPE-1][0]) );


generate
    for (j = 0; j < HPE-1; j = j + 1) begin: systolic_2D_PEs 
		for (i = 0; i < VPE-1; i = i + 1) begin : systolic_2D_PEsss 
		PE_OS_16_R8 PEyy( .s(S[i][j]), .d(D[i][j]), .t(T[i][j]), .q(Q[i][j]), .n(N[i][j]), .Y(MY_OUT[j+1][i]), .TMY(TMY[j+1][i]), .CLK(CLK), .RST(RST), .S_OUT(S[i][j+1]), .D_OUT(D[i][j+1]), .T_OUT(T[i][j+1]), .Q_OUT(Q[i][j+1]), .N_OUT(N[i][j+1]), .Y_OUT(MY_OUT[j+1][i+1]), .TMY_OUT(TMY[j+1][i+1]), .MAC_OUT(Y_OUT[i][j+1]) );
		end	
		PE_OS_16_R8 PEzz( .s(S[HPE-1][j]), .d(D[HPE-1][j]), .t(T[HPE-1][j]), .q(Q[HPE-1][j]), .n(N[HPE-1][j]), .Y(MY_OUT[j+1][HPE-1]), .TMY(TMY[j+1][HPE-1]), .CLK(CLK), .RST(RST), .S_OUT(S[HPE-1][j+1]), .D_OUT(D[HPE-1][j+1]), .T_OUT(T[HPE-1][j+1]), .Q_OUT(Q[HPE-1][j+1]), .N_OUT(N[HPE-1][j+1]), .Y_OUT(), .TMY_OUT(), .MAC_OUT(Y_OUT[HPE-1][j+1]) );
end
endgenerate

  
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


module pre_process_TMY #(parameter WIDTH = 16)(
input [WIDTH-1:0] my,
input CLK,
input RST,
output reg [WIDTH-1:0] my_out,
output reg [WIDTH+1:0] TMY);
`define TMY_W 18        // outputs width  
`define M_W 16        // width 
//wire [WIDTH:0] OPA;
//wire [WIDTH:0] OPB;
wire [WIDTH+1:0] SUM;
//wire CIN;
//wire PHI;
//assign CIN=1'b0;
//assign PHI=1'b0;

//assign OPA={my,1'b0}; 
//assign OPB={1'b0,my}; 
//assign SUM[0]=OPB[0];
assign SUM=my+(my<<1);

//DBLCADDER_16_16 D (.OPA(OPA[WIDTH:1]) , .OPB(OPB[WIDTH:1]) , .CIN (CIN) , .PHI (PHI) , .SUM(SUM[WIDTH:1]), .COUT(SUM[`M_W+1]) );

always @(posedge CLK) // or negedge RST )
begin
/*
if(RST==1'b0)
begin
         TMY<=`TMY_W'h0;
         my_out<=`M_W'h0;
end
else
begin
*/
         TMY<=SUM;
         my_out<=my;
//end
end

endmodule
module DBLCADDER_16_16 ( OPA, OPB, CIN, PHI, SUM, COUT );
input  [15:0] OPA;
input  [15:0] OPB;
input  CIN;
input  PHI;
output [15:0] SUM;
output COUT;
   wire [15:0] INTPROP;
   wire [16:0] INTGEN;
   wire [0:0] PBIT;
   wire [16:0] CARRY;
   PRESTAGE_16 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_16 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_16 U3 (OPA[15:0] , OPB[15:0] , 1'b0 , PHI , CARRY[16:0] , SUM , COUT );

endmodule
//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_16 ( A, B, CIN, PHI, POUT, GOUT );
input  [15:0] A;
input  [15:0] B;
input  CIN;
input  PHI;
output [15:0] POUT;
output [16:0] GOUT;
   BLOCK0 U10 (A[0] , B[0] , PHI , POUT[0] , GOUT[1] );
   BLOCK0 U11 (A[1] , B[1] , PHI , POUT[1] , GOUT[2] );
   BLOCK0 U12 (A[2] , B[2] , PHI , POUT[2] , GOUT[3] );
   BLOCK0 U13 (A[3] , B[3] , PHI , POUT[3] , GOUT[4] );
   BLOCK0 U14 (A[4] , B[4] , PHI , POUT[4] , GOUT[5] );
   BLOCK0 U15 (A[5] , B[5] , PHI , POUT[5] , GOUT[6] );
   BLOCK0 U16 (A[6] , B[6] , PHI , POUT[6] , GOUT[7] );
   BLOCK0 U17 (A[7] , B[7] , PHI , POUT[7] , GOUT[8] );
   BLOCK0 U18 (A[8] , B[8] , PHI , POUT[8] , GOUT[9] );
   BLOCK0 U19 (A[9] , B[9] , PHI , POUT[9] , GOUT[10] );
   BLOCK0 U110 (A[10] , B[10] , PHI , POUT[10] , GOUT[11] );
   BLOCK0 U111 (A[11] , B[11] , PHI , POUT[11] , GOUT[12] );
   BLOCK0 U112 (A[12] , B[12] , PHI , POUT[12] , GOUT[13] );
   BLOCK0 U113 (A[13] , B[13] , PHI , POUT[13] , GOUT[14] );
   BLOCK0 U114 (A[14] , B[14] , PHI , POUT[14] , GOUT[15] );
   BLOCK0 U115 (A[15] , B[15] , PHI , POUT[15] , GOUT[16] );
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule
//******************** Carry Look Ahead Adder Tree ********************//
module DBLCTREE_16 ( PIN, GIN, PHI, GOUT, POUT );
input  [15:0] PIN;
input  [16:0] GIN;
input  PHI;
output [16:0] GOUT;
output [0:0] POUT;


   wire [14:0] INTPROP_0;
   wire [16:0] INTGEN_0;
   wire [12:0] INTPROP_1;
   wire [16:0] INTGEN_1;
   wire [8:0] INTPROP_2;
   wire [16:0] INTGEN_2;
   wire [0:0] INTPROP_3;
   wire [16:0] INTGEN_3;
  
   DBLC_0_16 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_16 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_16 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_16 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
   
endmodule
module DBLC_0_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [15:0] PIN;
input  [16:0] GIN;
input  PHI;
output [14:0] POUT;
output [16:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   BLOCK1A U21 (PIN[0] , GIN[0] , GIN[1] , PHI , GOUT[1] );
   BLOCK1 U32 (PIN[0] , PIN[1] , GIN[1] , GIN[2] , PHI , POUT[0] , GOUT[2] );
   BLOCK1 U33 (PIN[1] , PIN[2] , GIN[2] , GIN[3] , PHI , POUT[1] , GOUT[3] );
   BLOCK1 U34 (PIN[2] , PIN[3] , GIN[3] , GIN[4] , PHI , POUT[2] , GOUT[4] );
   BLOCK1 U35 (PIN[3] , PIN[4] , GIN[4] , GIN[5] , PHI , POUT[3] , GOUT[5] );
   BLOCK1 U36 (PIN[4] , PIN[5] , GIN[5] , GIN[6] , PHI , POUT[4] , GOUT[6] );
   BLOCK1 U37 (PIN[5] , PIN[6] , GIN[6] , GIN[7] , PHI , POUT[5] , GOUT[7] );
   BLOCK1 U38 (PIN[6] , PIN[7] , GIN[7] , GIN[8] , PHI , POUT[6] , GOUT[8] );
   BLOCK1 U39 (PIN[7] , PIN[8] , GIN[8] , GIN[9] , PHI , POUT[7] , GOUT[9] );
   BLOCK1 U310 (PIN[8] , PIN[9] , GIN[9] , GIN[10] , PHI , POUT[8] , GOUT[10] );
   BLOCK1 U311 (PIN[9] , PIN[10] , GIN[10] , GIN[11] , PHI , POUT[9] , GOUT[11] );
   BLOCK1 U312 (PIN[10] , PIN[11] , GIN[11] , GIN[12] , PHI , POUT[10] , GOUT[12] );
   BLOCK1 U313 (PIN[11] , PIN[12] , GIN[12] , GIN[13] , PHI , POUT[11] , GOUT[13] );
   BLOCK1 U314 (PIN[12] , PIN[13] , GIN[13] , GIN[14] , PHI , POUT[12] , GOUT[14] );
   BLOCK1 U315 (PIN[13] , PIN[14] , GIN[14] , GIN[15] , PHI , POUT[13] , GOUT[15] );
   BLOCK1 U316 (PIN[14] , PIN[15] , GIN[15] , GIN[16] , PHI , POUT[14] , GOUT[16] );
endmodule

module DBLC_1_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [14:0] PIN;
input  [16:0] GIN;
input  PHI;
output [12:0] POUT;
output [16:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   BLOCK2A U22 (PIN[0] , GIN[0] , GIN[2] , PHI , GOUT[2] );
   BLOCK2A U23 (PIN[1] , GIN[1] , GIN[3] , PHI , GOUT[3] );
   BLOCK2 U34 (PIN[0] , PIN[2] , GIN[2] , GIN[4] , PHI , POUT[0] , GOUT[4] );
   BLOCK2 U35 (PIN[1] , PIN[3] , GIN[3] , GIN[5] , PHI , POUT[1] , GOUT[5] );
   BLOCK2 U36 (PIN[2] , PIN[4] , GIN[4] , GIN[6] , PHI , POUT[2] , GOUT[6] );
   BLOCK2 U37 (PIN[3] , PIN[5] , GIN[5] , GIN[7] , PHI , POUT[3] , GOUT[7] );
   BLOCK2 U38 (PIN[4] , PIN[6] , GIN[6] , GIN[8] , PHI , POUT[4] , GOUT[8] );
   BLOCK2 U39 (PIN[5] , PIN[7] , GIN[7] , GIN[9] , PHI , POUT[5] , GOUT[9] );
   BLOCK2 U310 (PIN[6] , PIN[8] , GIN[8] , GIN[10] , PHI , POUT[6] , GOUT[10] );
   BLOCK2 U311 (PIN[7] , PIN[9] , GIN[9] , GIN[11] , PHI , POUT[7] , GOUT[11] );
   BLOCK2 U312 (PIN[8] , PIN[10] , GIN[10] , GIN[12] , PHI , POUT[8] , GOUT[12] );
   BLOCK2 U313 (PIN[9] , PIN[11] , GIN[11] , GIN[13] , PHI , POUT[9] , GOUT[13] );
   BLOCK2 U314 (PIN[10] , PIN[12] , GIN[12] , GIN[14] , PHI , POUT[10] , GOUT[14] );
   BLOCK2 U315 (PIN[11] , PIN[13] , GIN[13] , GIN[15] , PHI , POUT[11] , GOUT[15] );
   BLOCK2 U316 (PIN[12] , PIN[14] , GIN[14] , GIN[16] , PHI , POUT[12] , GOUT[16] );
endmodule


module DBLC_2_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [12:0] PIN;
input  [16:0] GIN;
input  PHI;
output [8:0] POUT;
output [16:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   BLOCK1A U24 (PIN[0] , GIN[0] , GIN[4] , PHI , GOUT[4] );
   BLOCK1A U25 (PIN[1] , GIN[1] , GIN[5] , PHI , GOUT[5] );
   BLOCK1A U26 (PIN[2] , GIN[2] , GIN[6] , PHI , GOUT[6] );
   BLOCK1A U27 (PIN[3] , GIN[3] , GIN[7] , PHI , GOUT[7] );
   BLOCK1 U38 (PIN[0] , PIN[4] , GIN[4] , GIN[8] , PHI , POUT[0] , GOUT[8] );
   BLOCK1 U39 (PIN[1] , PIN[5] , GIN[5] , GIN[9] , PHI , POUT[1] , GOUT[9] );
   BLOCK1 U310 (PIN[2] , PIN[6] , GIN[6] , GIN[10] , PHI , POUT[2] , GOUT[10] );
   BLOCK1 U311 (PIN[3] , PIN[7] , GIN[7] , GIN[11] , PHI , POUT[3] , GOUT[11] );
   BLOCK1 U312 (PIN[4] , PIN[8] , GIN[8] , GIN[12] , PHI , POUT[4] , GOUT[12] );
   BLOCK1 U313 (PIN[5] , PIN[9] , GIN[9] , GIN[13] , PHI , POUT[5] , GOUT[13] );
   BLOCK1 U314 (PIN[6] , PIN[10] , GIN[10] , GIN[14] , PHI , POUT[6] , GOUT[14] );
   BLOCK1 U315 (PIN[7] , PIN[11] , GIN[11] , GIN[15] , PHI , POUT[7] , GOUT[15] );
   BLOCK1 U316 (PIN[8] , PIN[12] , GIN[12] , GIN[16] , PHI , POUT[8] , GOUT[16] );
endmodule
module DBLC_3_16 ( PIN, GIN, PHI, POUT, GOUT );
input  [8:0] PIN;
input  [16:0] GIN;
input  PHI;
output [0:0] POUT;
output [16:0] GOUT;
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
   BLOCK2 U316 (PIN[0] , PIN[8] , GIN[8] , GIN[16] , PHI , POUT[0] , GOUT[16] );
endmodule

//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_16 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [15:0] A;
input  [15:0] B;
input  PBIT;
input  PHI;
input  [16:0] CARRY;
output [15:0] SUM;
output COUT;
   XXOR1 U20 (A[0] , B[0] , CARRY[0] , PHI , SUM[0] );
   XXOR1 U21 (A[1] , B[1] , CARRY[1] , PHI , SUM[1] );
   XXOR1 U22 (A[2] , B[2] , CARRY[2] , PHI , SUM[2] );
   XXOR1 U23 (A[3] , B[3] , CARRY[3] , PHI , SUM[3] );
   XXOR1 U24 (A[4] , B[4] , CARRY[4] , PHI , SUM[4] );
   XXOR1 U25 (A[5] , B[5] , CARRY[5] , PHI , SUM[5] );
   XXOR1 U26 (A[6] , B[6] , CARRY[6] , PHI , SUM[6] );
   XXOR1 U27 (A[7] , B[7] , CARRY[7] , PHI , SUM[7] );
   XXOR1 U28 (A[8] , B[8] , CARRY[8] , PHI , SUM[8] );
   XXOR1 U29 (A[9] , B[9] , CARRY[9] , PHI , SUM[9] );
   XXOR1 U210 (A[10] , B[10] , CARRY[10] , PHI , SUM[10] );
   XXOR1 U211 (A[11] , B[11] , CARRY[11] , PHI , SUM[11] );
   XXOR1 U212 (A[12] , B[12] , CARRY[12] , PHI , SUM[12] );
   XXOR1 U213 (A[13] , B[13] , CARRY[13] , PHI , SUM[13] );
   XXOR1 U214 (A[14] , B[14] , CARRY[14] , PHI , SUM[14] );
   XXOR1 U215 (A[15] , B[15] , CARRY[15] , PHI , SUM[15] );
   BLOCK1A U1 (PBIT , CARRY[0] , CARRY[16] , PHI , COUT );
endmodule



module pre_process_be #(parameter WIDTH = 16)(mx, CLK, sr, dr, tr, qr, nr);
    
parameter group_cnt=(WIDTH>>2)+2; 

input [WIDTH-1:0] mx;
input CLK;
output reg [group_cnt - 1:0]sr;
output reg [group_cnt - 1:0]dr;
output reg [group_cnt - 1:0]tr;
output reg [group_cnt - 1:0]qr;
output reg [group_cnt - 1:0]nr;

wire [group_cnt - 1:0]s, d, t, q, n;


//Booth Encoding
			booth_encoder b_e0(.x({mx[2], mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .triple(t[0]), .quad(q[0]), .neg(n[0]));
			booth_encoder b_e1(.x({mx[5],mx[4], mx[3], mx[2]}), .single(s[1]), .double(d[1]), .triple(t[1]), .quad(q[1]), .neg(n[1]));
			booth_encoder b_e2(.x({mx[8],mx[7], mx[6], mx[5]}), .single(s[2]), .double(d[2]), .triple(t[2]), .quad(q[2]), .neg(n[2]));
			booth_encoder b_e3(.x({mx[11],mx[10], mx[9], mx[8]}), .single(s[3]), .double(d[3]), .triple(t[3]), .quad(q[3]), .neg(n[3]));
			booth_encoder b_e4(.x({mx[14],mx[13], mx[12], mx[11]}), .single(s[4]), .double(d[4]), .triple(t[4]), .quad(q[4]), .neg(n[4]));
			booth_encoder b_e5(.x({2'b00, mx[WIDTH - 1:WIDTH-2]}), .single(s[5]), .double(d[5]), .triple(t[5]), .quad(q[5]), .neg(n[5]));
			
    
always@(posedge CLK)
begin
sr<=s;
dr<=d;
tr<=t;
qr<=q;
nr<=n;
end
endmodule

/******************** Booth Encoder ********************/
module booth_encoder (x, single, double, triple, quad, neg);

input [3:0]x;

output single;

output  double;

output triple;

output  quad;

output neg;

wire w0;

wire w1;

wire w2;

wire w3;

wire w4;

wire w5;

assign neg=x[3];

assign w0=x[0]^x[1];

assign w1=x[1]^x[2];

assign w2=x[2]^x[3];

assign single=~((~w0)|w2);

assign double=~((~w1)|w0);

assign triple=~((~w2)|(~w0));

assign quad=~((~w2)|(w0|w1));

endmodule

/******************** Booth Selector ********************/
//module booth_selector(y,ty,single,double,triple,quad,neg,p);
module booth_sel(y2, y1, y0, ty, single, double, triple, quad, neg, p);
input y2;
input y1;
input y0;
input ty;
input single;
input double;
input triple;
input quad;
input neg;
output p;

assign  p = (neg ^ ((y2 & single)|(ty & triple)| (y1 & double) | (y0 & quad)));
endmodule
/******************** 1bit Full Adder ********************/

module FULL_ADDER ( a, b, cin, sum, cout );

input  a;

input  b;

input  cin;

output sum;

output cout;

   wire TMP;

   assign TMP = a ^ b;

   assign sum = TMP ^ cin;

   assign cout =  ~ (( ~ (TMP & cin)) & ( ~ (a & b)));

endmodule
 
module HALF_ADDER ( a, b, sum, cout );

input  a;

input  b;

output sum;

output cout;

   assign sum = a ^ b;

   assign cout = a & b;

endmodule



