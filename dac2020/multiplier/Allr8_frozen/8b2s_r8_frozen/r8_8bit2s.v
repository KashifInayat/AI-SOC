module mb8 #(parameter WIDTH = 8)(
input wire [WIDTH-1:0] mx,
input wire [WIDTH-1:0] my,
input wire CLK,
input wire RST,
output wire [(WIDTH*2)-1:0] product);

parameter group_cnt=(WIDTH>>2)+1; 

wire [group_cnt - 1:0] s;  //single
wire [group_cnt - 1:0] d;  //double 
wire [group_cnt - 1:0] t;  //triple 
wire [group_cnt - 1:0] q;  //quadruple 
wire [group_cnt - 1:0] n;  //neg


wire [WIDTH+1:0] epp2d[0:group_cnt - 1];
wire [10:0] fpp0;
wire [10:0] fpp1;
wire [9:0] fpp2;

wire [WIDTH+1:0] tmy;

// 3Y Calculation
pre_process_TMY prep00(.my(my), .TMY(tmy)); 

//Booth Encoding

			booth_encoder b_e0(.x({mx[2], mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .triple(t[0]), .quad(q[0]), .neg(n[0]));
			booth_encoder b_e1(.x({mx[5],mx[4], mx[3], mx[2]}), .single(s[1]), .double(d[1]), .triple(t[1]), .quad(q[1]), .neg(n[1]));
			booth_encoder b_e2(.x({1'b0, mx[WIDTH - 1:WIDTH-3]}), .single(s[2]), .double(d[2]), .triple(t[2]), .quad(q[2]), .neg(n[2]));
			

// Booth selection------Partial Products generation
genvar i, j;
generate
    for (j = 0; j < group_cnt; j = j + 1) begin: b_selector 
       		booth_sel bs(.y({my[0],2'b00}), .ty(tmy[0]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][0]));
			booth_sel bs0(.y({my[1:0],1'b0}), .ty(tmy[1]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][1]));
			booth_sel bs1(.y(my[2:0]), .ty(tmy[2]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][2]));
			booth_sel bs2(.y(my[3:1]), .ty(tmy[3]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][3]));
			booth_sel bs3(.y(my[4:2]), .ty(tmy[4]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][4]));
			booth_sel bs4(.y(my[5:3]), .ty(tmy[5]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][5]));
			booth_sel bs5(.y(my[6:4]), .ty(tmy[6]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][6]));
			booth_sel bs6(.y(my[7:5]), .ty(tmy[7]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][7]));
			booth_sel bs7(.y({1'b0, my[7:6]}), .ty(tmy[8]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][8]));  
			booth_sel bs8(.y({2'b00, my[7]}), .ty(tmy[9]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][9]));
end
endgenerate    

//Partial Products
assign fpp0 = {~n[0] , epp2d[0]};
assign fpp1 = {~n[1] , epp2d[1]};
assign fpp2 = {epp2d [2] [9:0]};

//Correction vector
wire [15:0]cv= {6'b110111,6'b000000,n[1],1'b0,1'b0,n[0]};

//******************** STAGE 1 of Wallace tree ********************//**//*
wire has00;
wire hac00;
wire has01;
wire hac01;
wire has02; 
wire hac02;

wire ahas00;
wire ahac00;
wire ahas01;
wire ahac01;
//wire ahas02;
//wire ahac02;

wire [7:0] fas0;
wire [7:0] fac0; 

wire [2:0] fas1;
wire [2:0] fac1; 


wire [15:0] st00;
wire [14:0] st01;
wire [4:0] st02;


HALF_ADDER ha0s0210(.a(fpp0[0]), .b(cv[0]) , .sum(has00), .cout(hac00));
HALF_ADDER ha0s0311(.a(fpp0[1]), .b(cv[1]) , .sum(has01), .cout(hac01));
HALF_ADDER ha0s0211(.a(fpp0[2]), .b(cv[2]) , .sum(has02), .cout(hac02));

HALF_ADDER aha0s0210(.a(cv[14]), .b(fpp2[8]) , .sum(ahas00), .cout(ahac00));
HALF_ADDER aha0s0311(.a(cv[15]), .b(fpp2[9]) , .sum(ahas01), .cout(ahac01));
//HALF_ADDER aha0s0312(.a(fpp1[10]), .b(fpp2[7]) , .sum(ahas02), .cout(ahac02));


generate
	for (i = 0; i < 8; i = i + 1) begin:	for_s0 
		FULL_ADDER fa000(.a(cv[i+3]), .b(fpp0[i + 3]), .cin(fpp1[i]), .sum(fas0[i]), .cout(fac0[i]));
	end
endgenerate

generate
	for (i = 0; i < 3; i = i + 1) begin:	for_s1 
		FULL_ADDER fa0001(.a(cv[i+11]), .b(fpp1[i + 8]), .cin(fpp2[i+5]), .sum(fas1[i]), .cout(fac1[i]));
	end
endgenerate

assign st00 = {ahas01, ahas00, fas1, fas0, has02, has01, has00};	
assign st01 = { ahac00, fac1, fac0, hac02, hac01, hac00};				 
assign st02 = fpp2[4:0];	

/*reg [15:0] st00;
reg [14:0] st01;
reg [4:0] st02;
			 
always @(posedge CLK or negedge RST)
begin
if (!RST)
begin
st00<=16'h0;
st01<=15'h0;
st02<=5'h0;
end
else
begin
st00<=ast00;
st01<=ast01;
st02<=ast02;
end
end*/
/*wire [15:0] cfpp1;
assign cfpp1= st00+{st01,1'b0}+{st02,6'b000000};
assign product=cfpp1; */


//******************** STAGE 2 of Wallace tree********************//**//*
wire ha1ss00;
wire ha1ss01;
wire ha1ss02;
wire ha1ss03;
wire ha1ss04;

wire ha1sc00;
wire ha1sc01;
wire ha1sc02;
wire ha1sc03;
wire ha1sc04;

wire aha1ss10;
wire aha1sc10;
wire aha1ss11;
wire aha1sc11;
wire aha1ss12;
wire aha1sc12;
wire aha1ss13;
wire aha1sc13;
wire aha1ss14;
wire aha1sc14;

wire [4:0] fa1ss0;
wire [4:0] fa1sc0;

wire [15:0] st10;
wire [13:0] st11;

HALF_ADDER ha1s0310(.a(st00[1]), .b(st01[0]) , .sum(ha1ss00), .cout(ha1sc00));
HALF_ADDER ha1s0411(.a(st00[2]), .b(st01[1]) , .sum(ha1ss01), .cout(ha1sc01));
HALF_ADDER ha1s0512(.a(st00[3]), .b(st01[2]) , .sum(ha1ss02), .cout(ha1sc02));
HALF_ADDER ha1s0513(.a(st00[4]), .b(st01[3]) , .sum(ha1ss03), .cout(ha1sc03));
HALF_ADDER ha1s0514(.a(st00[5]), .b(st01[4]) , .sum(ha1ss04), .cout(ha1sc04));

HALF_ADDER aha1s0510(.a(st00[11]), .b(st01[10]) , .sum(aha1ss10), .cout(aha1sc10));
HALF_ADDER aha1s0511(.a(st00[12]), .b(st01[11]) , .sum(aha1ss11), .cout(aha1sc11));
HALF_ADDER aha1s0512(.a(st00[13]), .b(st01[12]) , .sum(aha1ss12), .cout(aha1sc12));
HALF_ADDER aha1s0513(.a(st00[14]), .b(st01[13]) , .sum(aha1ss13), .cout(aha1sc13));
HALF_ADDER aha1s0514(.a(st00[15]), .b(st01[14]) , .sum(aha1ss14), .cout(aha1sc14));

generate
	for (i = 0; i < 5; i = i + 1) begin:	for_s3
		FULL_ADDER fa03(.a(st00[i + 6]), .b(st01[i + 5]), .cin(st02[i]), .sum(fa1ss0[i]), .cout(fa1sc0[i]));
	end
endgenerate



assign st10 = {aha1ss14, aha1ss13, aha1ss12, aha1ss11, aha1ss10, fa1ss0, ha1ss04, ha1ss03, ha1ss02, ha1ss01, ha1ss00, st00[0]};	// 19 bit
assign st11 = { aha1sc13, aha1sc12, aha1sc11, aha1sc10, fa1sc0, ha1sc04 , ha1sc03, ha1sc02, ha1sc01, ha1sc00};						// 16 bit

/*wire [15:0] cfpp1;
assign cfpp1= st10+{st11,2'b00};
assign product=cfpp1;*/ 

wire [15:0] SUM_reg;
wire [13:0] CARRY_reg;

assign SUM_reg=st10;
assign CARRY_reg=st11;


//******************** Tree ADDER STAGE  ********************//*
wire  [0:13] OPA;
wire  [0:13] OPB;
wire CIN;
wire PHI;
wire [0:0] PBIT;
wire [0:14] CARRY;
assign CIN=1'b0;
assign PHI=1'b0;
wire [13:0]prod;

assign OPA=(SUM_reg[15:2]);
assign OPB=(CARRY_reg);

DBLCADDER_32_32 D (.OPA(OPA) , .OPB(OPB) , .CIN (CIN) , .PHI (PHI) , .SUM(prod), .COUT() );


reg [(WIDTH*2)-1:0] pipereg;

always @(posedge CLK) 
begin
        pipereg <= {prod,SUM_reg[1:0]};
end

assign product=pipereg;




//assign product={prod,SUM_reg[1:0]};
endmodule
module pre_process_TMY #(parameter WIDTH = 8)(
input wire [WIDTH-1:0] my,
output wire [WIDTH+1:0] TMY);
`define TMY_W 10        // outputs width  
`define M_W 8        // width 
wire [WIDTH:0] OPA;
wire [WIDTH:0] OPB;
wire CIN;
wire PHI;
assign CIN=1'b0;
assign PHI=1'b0;

assign OPA={my,1'b0}; 
assign OPB={1'b0,my}; 
assign TMY[0]=OPB[0];

DBLCADDER_8_8 D (.OPA(OPA[WIDTH:1]) , .OPB(OPB[WIDTH:1]) , .CIN (CIN) , .PHI (PHI) , .SUM(TMY[WIDTH:1]), .COUT(TMY[WIDTH+1]) );

         
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
input  [13:0] OPA;
input  [13:0] OPB;
input  CIN;
input  PHI;
output [13:0] SUM;
output COUT;
   wire [13:0] INTPROP;
   wire [14:0] INTGEN;
   wire [0:0] PBIT;
   wire [14:0] CARRY;
   PRESTAGE_32 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_32 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_32 U3 (OPA[13:0] , OPB[13:0] , 1'b0 , PHI , CARRY[14:0] , SUM , COUT );

endmodule
//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_32 ( A, B, CIN, PHI, POUT, GOUT );
input  [13:0] A;
input  [13:0] B;
input  CIN;
input  PHI;
output [13:0] POUT;
output [14:0] GOUT;
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
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule
//******************** Carry Look Ahead Adder Tree ********************//
module DBLCTREE_32 ( PIN, GIN, PHI, GOUT, POUT );
input  [13:0] PIN;
input  [14:0] GIN;
input  PHI;
output [14:0] GOUT;
output [0:0] POUT;

   wire [12:0] INTPROP_0;
   wire [14:0] INTGEN_0;
   wire [10:0] INTPROP_1;
   wire [14:0] INTGEN_1;
   wire [6:0] INTPROP_2;
   wire [14:0] INTGEN_2;
  
   DBLC_0_32 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_32 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_32 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_32 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule
module DBLC_0_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [13:0] PIN;
input  [14:0] GIN;
input  PHI;
output [12:0] POUT;
output [14:0] GOUT;
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
endmodule


module DBLC_1_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [12:0] PIN;
input  [14:0] GIN;
input  PHI;
output [10:0] POUT;
output [14:0] GOUT;
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
endmodule


module DBLC_2_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [10:0] PIN;
input  [14:0] GIN;
input  PHI;
output [6:0] POUT;
output [14:0] GOUT;
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
endmodule
module DBLC_3_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [6:0] PIN;
input  [14:0] GIN;
input  PHI;
output [0:0] POUT;
output [14:0] GOUT;
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
   BLOCK2 U316 (PIN[0] , PIN[6] , GIN[6] , GIN[14] , PHI , POUT[0] , GOUT[14] );
endmodule
//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_32 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [13:0] A;
input  [13:0] B;
input  PBIT;
input  PHI;
input  [14:0] CARRY;
output [13:0] SUM;
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
endmodule
module DBLCADDER_8_8 ( OPA, OPB, CIN, PHI, SUM, COUT );
input  [7:0] OPA;
input  [7:0] OPB;
input  CIN;
input  PHI;
output [7:0] SUM;
output COUT;
   wire [7:0] INTPROP;
   wire [8:0] INTGEN;
   wire [0:0] PBIT;
   wire [8:0] CARRY;
   PRESTAGE_8 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_8 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_8 U3 (OPA[7:0] , OPB[7:0] , 1'b0 , PHI , CARRY[8:0] , SUM , COUT );

endmodule
//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_8 ( A, B, CIN, PHI, POUT, GOUT );
input  [7:0] A;
input  [7:0] B;
input  CIN;
input  PHI;
output [7:0] POUT;
output [8:0] GOUT;
   BLOCK0 U10 (A[0] , B[0] , PHI , POUT[0] , GOUT[1] );
   BLOCK0 U11 (A[1] , B[1] , PHI , POUT[1] , GOUT[2] );
   BLOCK0 U12 (A[2] , B[2] , PHI , POUT[2] , GOUT[3] );
   BLOCK0 U13 (A[3] , B[3] , PHI , POUT[3] , GOUT[4] );
   BLOCK0 U14 (A[4] , B[4] , PHI , POUT[4] , GOUT[5] );
   BLOCK0 U15 (A[5] , B[5] , PHI , POUT[5] , GOUT[6] );
   BLOCK0 U16 (A[6] , B[6] , PHI , POUT[6] , GOUT[7] );
   BLOCK0 U17 (A[7] , B[7] , PHI , POUT[7] , GOUT[8] );
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule
//******************** Carry Look Ahead Adder Tree ********************//
module DBLCTREE_8 ( PIN, GIN, PHI, GOUT, POUT );
input  [7:0] PIN;
input  [8:0] GIN;
input  PHI;
output [8:0] GOUT;
output [0:0] POUT;


   wire [6:0] INTPROP_0;
   wire [8:0] INTGEN_0;
   wire [4:0] INTPROP_1;
   wire [8:0] INTGEN_1;

  
   DBLC_0_8 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_8 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_8 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule
module DBLC_0_8 ( PIN, GIN, PHI, POUT, GOUT );
input  [7:0] PIN;
input  [8:0] GIN;
input  PHI;
output [6:0] POUT;
output [8:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   BLOCK1A U21 (PIN[0] , GIN[0] , GIN[1] , PHI , GOUT[1] );
   BLOCK1 U32 (PIN[0] , PIN[1] , GIN[1] , GIN[2] , PHI , POUT[0] , GOUT[2] );
   BLOCK1 U33 (PIN[1] , PIN[2] , GIN[2] , GIN[3] , PHI , POUT[1] , GOUT[3] );
   BLOCK1 U34 (PIN[2] , PIN[3] , GIN[3] , GIN[4] , PHI , POUT[2] , GOUT[4] );
   BLOCK1 U35 (PIN[3] , PIN[4] , GIN[4] , GIN[5] , PHI , POUT[3] , GOUT[5] );
   BLOCK1 U36 (PIN[4] , PIN[5] , GIN[5] , GIN[6] , PHI , POUT[4] , GOUT[6] );
   BLOCK1 U37 (PIN[5] , PIN[6] , GIN[6] , GIN[7] , PHI , POUT[5] , GOUT[7] );
   BLOCK1 U38 (PIN[6] , PIN[7] , GIN[7] , GIN[8] , PHI , POUT[6] , GOUT[8] );
endmodule

module DBLC_1_8 ( PIN, GIN, PHI, POUT, GOUT );
input  [6:0] PIN;
input  [8:0] GIN;
input  PHI;
output [4:0] POUT;
output [8:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   BLOCK2A U22 (PIN[0] , GIN[0] , GIN[2] , PHI , GOUT[2] );
   BLOCK2A U23 (PIN[1] , GIN[1] , GIN[3] , PHI , GOUT[3] );
   BLOCK2 U34 (PIN[0] , PIN[2] , GIN[2] , GIN[4] , PHI , POUT[0] , GOUT[4] );
   BLOCK2 U35 (PIN[1] , PIN[3] , GIN[3] , GIN[5] , PHI , POUT[1] , GOUT[5] );
   BLOCK2 U36 (PIN[2] , PIN[4] , GIN[4] , GIN[6] , PHI , POUT[2] , GOUT[6] );
   BLOCK2 U37 (PIN[3] , PIN[5] , GIN[5] , GIN[7] , PHI , POUT[3] , GOUT[7] );
   BLOCK2 U38 (PIN[4] , PIN[6] , GIN[6] , GIN[8] , PHI , POUT[4] , GOUT[8] );
   endmodule

module DBLC_2_8 ( PIN, GIN, PHI, POUT, GOUT );
input  [4:0] PIN;
input  [8:0] GIN;
input  PHI;
output [0:0] POUT;
output [8:0] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   BLOCK1A U24 (PIN[0] , GIN[0] , GIN[4] , PHI , GOUT[4] );
   BLOCK1A U25 (PIN[1] , GIN[1] , GIN[5] , PHI , GOUT[5] );
   BLOCK1A U26 (PIN[2] , GIN[2] , GIN[6] , PHI , GOUT[6] );
   BLOCK1A U27 (PIN[3] , GIN[3] , GIN[7] , PHI , GOUT[7] );
   BLOCK1 U38 (PIN[0] , PIN[4] , GIN[4] , GIN[8] , PHI , POUT[0] , GOUT[8] );
endmodule
//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_8 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [7:0] A;
input  [7:0] B;
input  PBIT;
input  PHI;
input  [8:0] CARRY;
output [7:0] SUM;
output COUT;
   XXOR1 U20 (A[0] , B[0] , CARRY[0] , PHI , SUM[0] );
   XXOR1 U21 (A[1] , B[1] , CARRY[1] , PHI , SUM[1] );
   XXOR1 U22 (A[2] , B[2] , CARRY[2] , PHI , SUM[2] );
   XXOR1 U23 (A[3] , B[3] , CARRY[3] , PHI , SUM[3] );
   XXOR1 U24 (A[4] , B[4] , CARRY[4] , PHI , SUM[4] );
   XXOR1 U25 (A[5] , B[5] , CARRY[5] , PHI , SUM[5] );
   XXOR1 U26 (A[6] , B[6] , CARRY[6] , PHI , SUM[6] );
   XXOR1 U27 (A[7] , B[7] , CARRY[7] , PHI , SUM[7] );
   BLOCK1A U1 (PBIT , CARRY[0] , CARRY[8] , PHI , COUT );
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
module booth_sel(y, ty, single, double, triple, quad, neg, p);

input [2:0] y;

input ty;

input single;

input double;

input triple;

input quad;

input neg;

output p;

assign  p = (neg ^ ((y[2] & single)|(ty & triple)| (y[1] & double) | (y[0] & quad)));

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


