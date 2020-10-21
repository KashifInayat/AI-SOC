module mb8 #(parameter WIDTH = 8)(
input [WIDTH-1:0] mx,
input [WIDTH-1:0] my,
input CLK,
input RST,
output [(WIDTH*2)-1:0] product);
 
parameter group_cnt=(WIDTH>>1)+1; 

wire [group_cnt - 1:0] s;
wire [group_cnt - 1:0] d;
wire [group_cnt - 1:0] n;

wire [WIDTH:0] epp2d[0:group_cnt - 1];
wire [9:0] fpp0;
wire [9:0] fpp1;
wire [9:0] fpp2;
wire [9:0] fpp3;
wire [7:0] fpp4;



/******************** Booth encoding ********************/

			booth_encoder b_e0(.x({mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .neg(n[0]));
			booth_encoder b_e1(.x({mx[3], mx[2], mx[1]}), .single(s[1]), .double(d[1]), .neg(n[1]));
			booth_encoder b_e2(.x({mx[5], mx[4], mx[3]}), .single(s[2]), .double(d[2]), .neg(n[2]));
            booth_encoder b_e3(.x({mx[7], mx[6], mx[5]}), .single(s[3]), .double(d[3]), .neg(n[3]));
			booth_encoder b_e4(.x({1'b0, 1'b0, mx[WIDTH - 1]}), .single(s[4]), .double(d[4]), .neg(n[4]));
			

/******************** Booth Selector-----Partial Product Generation ********************/
genvar i, j;

generate
    for (j = 0; j < group_cnt; j = j + 1) begin: b_selector 
			booth_selector bs(.double(d[j]), .shifted(1'b0), .single(s[j]), .y(my[0]), .neg(n[j]), .p(epp2d[j][0]));
			booth_selector bs0(.double(d[j]), .shifted(my[0]), .single(s[j]), .y(my[1]), .neg(n[j]), .p(epp2d[j][1]));
			booth_selector bs1(.double(d[j]), .shifted(my[1]), .single(s[j]), .y(my[2]), .neg(n[j]), .p(epp2d[j][2]));
			booth_selector bs2(.double(d[j]), .shifted(my[2]), .single(s[j]), .y(my[3]), .neg(n[j]), .p(epp2d[j][3]));			booth_selector bs3(.double(d[j]), .shifted(my[3]), .single(s[j]), .y(my[4]), .neg(n[j]), .p(epp2d[j][4]));
			booth_selector bs4(.double(d[j]), .shifted(my[4]), .single(s[j]), .y(my[5]), .neg(n[j]), .p(epp2d[j][5]));
			booth_selector bs5(.double(d[j]), .shifted(my[5]), .single(s[j]), .y(my[6]), .neg(n[j]), .p(epp2d[j][6]));
			booth_selector bs6(.double(d[j]), .shifted(my[6]), .single(s[j]), .y(my[7]), .neg(n[j]), .p(epp2d[j][7]));
			booth_selector bs7(.double(d[j]), .shifted(my[7]), .single(s[j]), .y(1'b0), .neg(n[j]), .p(epp2d[j][8]));
			
end
endgenerate
//Partial Products
assign fpp0 = {~n[0] , epp2d[0]};
assign fpp1 = {~n[1] , epp2d[1]};
assign fpp2 = {~n[2] , epp2d[2]};
assign fpp3 = {~n[3] , epp2d[3]};
assign fpp4 = {epp2d[4][7:0]};

//Correction vector
wire [15:0]cv= {7'b0101011,1'b0,1'b0,n[3],1'b0,n[2],1'b0,n[1],1'b0,n[0]};

/*wire [15:0] cfpp;
assign cfpp= fpp0+{fpp1,2'b00}+{fpp2,4'b0000}+{fpp3,6'b000000}+{fpp4,8'b00000000};
wire [15:0] cfpp1;
assign cfpp1=cfpp+ cv;
*/
 
/******************** STAGE 1 of Wallace tree ********************/
wire has00;
wire hac00;
wire has01;
wire hac01;

wire ahas00;
wire ahac00;
wire ahas01;
wire ahac01;

wire has10;
wire hac10;
wire has11;
wire hac11;

wire ahas10;
wire ahac10;
wire ahas11;
wire ahac11;

wire [7:0] fas0;
wire [7:0] fac0; 

wire [5:0] fas1;
wire [5:0] fac1; 

wire [15:0] st00;
wire [11:0] st01;
wire [11:0] st02;
wire [8:0] st03;


HALF_ADDER ha0s0210(.a(cv[0]), .b(fpp0[0]) , .sum(has00), .cout(hac00));
HALF_ADDER ha0s0311(.a(cv[1]), .b(fpp0[1]) , .sum(has01), .cout(hac01));

HALF_ADDER aha0s0210(.a(cv[10]), .b(fpp1[8]) , .sum(ahas00), .cout(ahac00));
HALF_ADDER aha0s0311(.a(cv[11]), .b(fpp1[9]) , .sum(ahas01), .cout(ahac01));

generate
	for (i = 0; i < 8; i = i + 1) begin:	for_s0 
		FULL_ADDER fa000(.a(cv[i + 2]), .b(fpp0[i + 2]), .cin(fpp1[i]), .sum(fas0[i]), .cout(fac0[i]));
	end
endgenerate

HALF_ADDER ha0s0220(.a(fpp2[2]), .b(fpp3[0]) , .sum(has10), .cout(hac10));
HALF_ADDER ha0s0321(.a(fpp2[3]), .b(fpp3[1]) , .sum(has11), .cout(hac11));

HALF_ADDER aha0s0220(.a(fpp3[8]), .b(fpp4[6]) , .sum(ahas10), .cout(ahac10));
HALF_ADDER aha0s0321(.a(fpp3[9]), .b(fpp4[7]) , .sum(ahas11), .cout(ahac11));
 
generate
	for (i = 0; i < 6; i = i + 1) begin:	for_s1 
		FULL_ADDER fa001(.a(fpp2[i + 4]), .b(fpp3[i + 2]), .cin(fpp4[i]), .sum(fas1[i]), .cout(fac1[i]));
	end
endgenerate

assign st00 = {cv[15:12], ahas01,ahas00,fas0, has01, has00};	
assign st01 = {ahac01, ahac00,fac0, hac01, hac00};				 
assign st02 = {ahas11, ahas10, fas1, has11, has10, fpp2[1:0]};	 
assign st03 = {ahac10, fac1, hac11, hac10};				 

/*wire [15:0] cst0;
assign cst0=st00+{st01,1'b0}+{st02,4'b0000}+{st03,7'b0000000};
assign product = cst0;
*/
//******************** STAGE 2 of Wallace tree********************//*
wire ha1ss00;
wire ha1ss01;
wire ha1ss02;

wire ha1sc00;
wire ha1sc01;
wire ha1sc02;

wire aha1ss10;
wire aha1ss11;
wire aha1ss12;

wire aha1sc10;
wire aha1sc11;
wire aha1sc12;

wire [8:0] fa1ss0;
wire [8:0] fa1sc0;

wire [15:0] st10;
wire [13:0] st11;
wire [8:0] st12;

HALF_ADDER ha1s0310(.a(st00[1]), .b(st01[0]) , .sum(ha1ss00), .cout(ha1sc00));
HALF_ADDER ha1s0411(.a(st00[2]), .b(st01[1]) , .sum(ha1ss01), .cout(ha1sc01));
HALF_ADDER ha1s0512(.a(st00[3]), .b(st01[2]) , .sum(ha1ss02), .cout(ha1sc02));

HALF_ADDER aha1s0512(.a(st00[13]), .b(st02[9]) , .sum(aha1ss10), .cout(aha1sc10));
HALF_ADDER aha1s0513(.a(st00[14]), .b(st02[10]) , .sum(aha1ss11), .cout(aha1sc11));
HALF_ADDER aha1s0514(.a(st00[15]), .b(st02[11]) , .sum(aha1ss12), .cout(aha1sc12));

generate
	for (i = 0; i < 9; i = i + 1) begin:	for_s3
		FULL_ADDER fa03(.a(st00[i + 4]), .b(st01[i + 3 ]), .cin(st02[i]), .sum(fa1ss0[i]), .cout(fa1sc0[i]));
	end
endgenerate



assign st10 = {aha1ss12, aha1ss11, aha1ss10, fa1ss0, ha1ss02, ha1ss01, ha1ss00, st00[0]};	
assign st11 = {aha1sc11, aha1sc10,fa1sc0, ha1sc02, ha1sc01, ha1sc00};						

assign st12 = st03;	

/*wire [15:0] cst1;
assign cst1=st10+{st11,2'b00}+{st12,7'b0000000};
assign product = cst1;*/
//******************** STAGE 3 of Wallace tree********************//*
wire ha2ss00;
wire ha2ss01;
wire ha2ss02;
wire ha2ss03;
wire ha2ss04;

wire ha2sc00;
wire ha2sc01;
wire ha2sc02;
wire ha2sc03;
wire ha2sc04;

wire [8:0] fa2ss0;
wire [8:0] fa2sc0;

wire [15:0] st20;
wire [12:0] st21;

HALF_ADDER ha2s0410(.a(st10[2]), .b(st11[0]) , .sum(ha2ss00), .cout(ha2sc00));
HALF_ADDER ha2s0511(.a(st10[3]), .b(st11[1]) , .sum(ha2ss01), .cout(ha2sc01));
HALF_ADDER ha2s0612(.a(st10[4]), .b(st11[2]) , .sum(ha2ss02), .cout(ha2sc02));
HALF_ADDER ha2s0713(.a(st10[5]), .b(st11[3]) , .sum(ha2ss03), .cout(ha2sc03));
HALF_ADDER ha2s0614(.a(st10[6]), .b(st11[4]) , .sum(ha2ss04), .cout(ha2sc04));

generate
	for (i = 0; i < 9; i = i + 1) begin:	for_s5
		FULL_ADDER fa05(.a(st10[i + 7]), .b(st11[i + 5 ]), .cin(st12[i]), .sum(fa2ss0[i]), .cout(fa2sc0[i]));
	end
endgenerate

assign st20 = {fa2ss0, ha2ss04, ha2ss03, ha2ss02, ha2ss01, ha2ss00, st10[1:0]};	
assign st21 = {fa2sc0, ha2sc04, ha2sc03, ha2sc02, ha2sc01, ha2sc00};					

wire [15:0] SUM_reg;
wire [12:0] CARRY_reg;
assign SUM_reg=st20;
assign CARRY_reg=st21;

//******************** Tree ADDER STAGE  ********************/
wire  [0:12] OPA;
wire  [0:12] OPB;
wire CIN;
wire PHI;
wire [0:0] PBIT;
wire [0:13] CARRY;
assign CIN=1'b0;
assign PHI=1'b0;
wire [12:0]prod;

assign OPA=(SUM_reg[15:3]);
assign OPB=(CARRY_reg);

DBLCADDER_32_32 D (.OPA(OPA) , .OPB(OPB) , .CIN (CIN) , .PHI (PHI) , .SUM(prod), .COUT() );


reg [(WIDTH*2)-1:0] pipereg;
reg [(WIDTH*2)-1:0] pipereg1;
always @(posedge CLK) 
begin
        pipereg <= {prod,SUM_reg[2:0]};
        pipereg1 <= pipereg;
end
assign product=pipereg1;
//assign product={prod,SUM_reg[2:0]};
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

module DBLCADDER_32_32 ( OPA, OPB, CIN, PHI, SUM, COUT );
input  [12:0] OPA;
input  [12:0] OPB;
input  CIN;
input  PHI;
output [12:0] SUM;
output COUT;
   wire [12:0] INTPROP;
   wire [13:0] INTGEN;
   wire [0:0] PBIT;
   wire [13:0] CARRY;
   PRESTAGE_32 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_32 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_32 U3 (OPA[12:0] , OPB[12:0] , 1'b0 , PHI , CARRY[13:0] , SUM , COUT );

endmodule
//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_32 ( A, B, CIN, PHI, POUT, GOUT );
input  [12:0] A;
input  [12:0] B;
input  CIN;
input  PHI;
output [12:0] POUT;
output [13:0] GOUT;
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
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule
//******************** Carry Look Ahead Adder Tree ********************//
module DBLCTREE_32 ( PIN, GIN, PHI, GOUT, POUT );
input  [12:0] PIN;
input  [13:0] GIN;
input  PHI;
output [13:0] GOUT;
output [0:0] POUT;

   wire [11:0] INTPROP_0;
   wire [13:0] INTGEN_0;
   wire [9:0] INTPROP_1;
   wire [13:0] INTGEN_1;
   wire [5:0] INTPROP_2;
   wire [13:0] INTGEN_2;
  
   DBLC_0_32 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_32 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_32 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_32 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule
module DBLC_0_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [12:0] PIN;
input  [13:0] GIN;
input  PHI;
output [11:0] POUT;
output [13:0] GOUT;
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
endmodule


module DBLC_1_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [11:0] PIN;
input  [13:0] GIN;
input  PHI;
output [9:0] POUT;
output [13:0] GOUT;
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
endmodule


module DBLC_2_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [9:0] PIN;
input  [13:0] GIN;
input  PHI;
output [5:0] POUT;
output [13:0] GOUT;
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
endmodule
module DBLC_3_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [5:0] PIN;
input  [13:0] GIN;
input  PHI;
output [0:0] POUT;
output [13:0] GOUT;
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
   BLOCK2 U316 (PIN[0] , PIN[5] , GIN[5] , GIN[13] , PHI , POUT[0] , GOUT[13] );
endmodule
//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_32 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [12:0] A;
input  [12:0] B;
input  PBIT;
input  PHI;
input  [13:0] CARRY;
output [12:0] SUM;
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
endmodule

/******************** Booth Encoder ********************/
module booth_encoder (x, single, double, neg);

input [2:0]x;

output single;

output  double;

output neg;

wire w0;

wire w1;

assign single = x[0] ^ x[1];

assign neg = x[2];

assign  w0 = ~(x[1] ^ x[2]);

assign  w1 = (x[0] ^ x[1]);

assign double =~(w0|w1);

endmodule

/******************** Booth Selector ********************/
module booth_selector (double, shifted, single, y, neg, p);

input double;

input shifted;

input single;

input y;

input neg;

output p;

assign  p = (neg ^ ((y & single) | (shifted & double)));

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

