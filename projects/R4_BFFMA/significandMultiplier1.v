module significandMultiplier1 #(parameter WIDTH = 8)(
input [WIDTH-1:0] mx,
input [WIDTH-1:0] my,
output [(WIDTH*2)+1:0] sum,
output [(WIDTH*2)+1:0] carry);
 
parameter group_cnt=(WIDTH>>1)+1; 

wire [group_cnt - 1:0] s;
wire [group_cnt - 1:0] d;
wire [group_cnt - 1:0] n;

wire [WIDTH:0] epp2d[0:group_cnt - 1];
wire [9:0] fpp0;
wire [9:0] fpp1;
wire [9:0] fpp2;
wire [9:0] fpp3;
wire [9:0] fpp4;



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
			booth_selector bs2(.double(d[j]), .shifted(my[2]), .single(s[j]), .y(my[3]), .neg(n[j]), .p(epp2d[j][3]));		
                 	booth_selector bs3(.double(d[j]), .shifted(my[3]), .single(s[j]), .y(my[4]), .neg(n[j]), .p(epp2d[j][4]));
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
assign fpp4 = {~n[4] , epp2d[4]};

//Correction vector
wire [17:0]cv= {9'b010101011,n[4],1'b0,n[3],1'b0,n[2],1'b0,n[1],1'b0,n[0]};

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

wire [17:0] st00;
wire [11:0] st01;
wire [13:0] st02;
wire [9:0] st03;


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

assign st00 = {cv[17:12], ahas01,ahas00,fas0, has01, has00};	
assign st01 = {ahac01, ahac00,fac0, hac01, hac00};				 
assign st02 = {fpp4[9:8],ahas11, ahas10, fas1, has11, has10, fpp2[1:0]};	 
assign st03 = {ahac11, ahac10, fac1, hac11, hac10};				 

//******************** Pipeline register ********************//
/*reg [15:0] st00;
reg [11:0] st01;
reg [11:0] st02;
reg [8:0] st03;

always @(posedge CLK or negedge RST)
begin
if (!RST)
begin
st00<=16'h0;
st01<=12'h0;
st02<=12'h0;
st03<=9'h0;
end
else
begin
st00<=ast00;
st01<=ast01;
st02<=ast02;
st03<=ast03;
end
end*/

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
wire aha1ss13;
wire aha1ss14;

wire aha1sc10;
wire aha1sc11;
wire aha1sc12;
wire aha1sc13;
wire aha1sc14;

wire [8:0] fa1ss0;
wire [8:0] fa1sc0;

wire [17:0] st10;
wire [16:0] st11;
wire [9:0] st12;

HALF_ADDER ha1s0310(.a(st00[1]), .b(st01[0]) , .sum(ha1ss00), .cout(ha1sc00));
HALF_ADDER ha1s0411(.a(st00[2]), .b(st01[1]) , .sum(ha1ss01), .cout(ha1sc01));
HALF_ADDER ha1s0512(.a(st00[3]), .b(st01[2]) , .sum(ha1ss02), .cout(ha1sc02));

HALF_ADDER aha1s0512(.a(st00[13]), .b(st02[9]) , .sum(aha1ss10), .cout(aha1sc10));
HALF_ADDER aha1s0513(.a(st00[14]), .b(st02[10]) , .sum(aha1ss11), .cout(aha1sc11));
HALF_ADDER aha1s0514(.a(st00[15]), .b(st02[11]) , .sum(aha1ss12), .cout(aha1sc12));
HALF_ADDER aha1s0515(.a(st00[16]), .b(st02[12]) , .sum(aha1ss13), .cout(aha1sc13));
HALF_ADDER aha1s0516(.a(st00[17]), .b(st02[13]) , .sum(aha1ss14), .cout(aha1sc14));

generate
	for (i = 0; i < 9; i = i + 1) begin:	for_s3
		FULL_ADDER fa03(.a(st00[i + 4]), .b(st01[i + 3 ]), .cin(st02[i]), .sum(fa1ss0[i]), .cout(fa1sc0[i]));
	end
endgenerate



assign st10 = {aha1ss14, aha1ss13, aha1ss12, aha1ss11, aha1ss10, fa1ss0, ha1ss02, ha1ss01, ha1ss00, st00[0]};	
assign st11 = {aha1sc14, aha1sc13, aha1sc12, aha1sc11, aha1sc10, fa1sc0, ha1sc02, ha1sc01, ha1sc00};						

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
wire aha2ss00;
wire aha2sc00;

wire [9:0] fa2ss0;
wire [9:0] fa2sc0;

wire [17:0] st20;
wire [14:0] st21;

HALF_ADDER ha2s0410(.a(st10[2]), .b(st11[0]) , .sum(ha2ss00), .cout(ha2sc00));
HALF_ADDER ha2s0511(.a(st10[3]), .b(st11[1]) , .sum(ha2ss01), .cout(ha2sc01));
HALF_ADDER ha2s0612(.a(st10[4]), .b(st11[2]) , .sum(ha2ss02), .cout(ha2sc02));
HALF_ADDER ha2s0713(.a(st10[5]), .b(st11[3]) , .sum(ha2ss03), .cout(ha2sc03));
HALF_ADDER ha2s0614(.a(st10[6]), .b(st11[4]) , .sum(ha2ss04), .cout(ha2sc04));

generate
	for (i = 0; i < 10; i = i + 1) begin:	for_s5
		FULL_ADDER fa05(.a(st10[i + 7]), .b(st11[i + 5 ]), .cin(st12[i]), .sum(fa2ss0[i]), .cout(fa2sc0[i]));
	end
endgenerate
HALF_ADDER ha2s04110(.a(st10[17]), .b(st11[15]) , .sum(aha2ss00), .cout(aha2sc00));

assign st20 = {aha2ss00, fa2ss0, ha2ss04, ha2ss03, ha2ss02, ha2ss01, ha2ss00, st10[1:0]};	
assign st21 = {fa2sc0, ha2sc04, ha2sc03, ha2sc02, ha2sc01, ha2sc00};					


/*wire [15:0] cst2;
assign cst2=st20+{st21,3'b000};
assign product = cst2;*/
//******************** Pipeline register ********************//
/*reg [15:0] SUM_reg;
reg [12:0] CARRY_reg;
always @(posedge CLK or negedge RST)
begin
if (!RST)
begin
SUM_reg<=16'h0;
CARRY_reg<=13'h0;
end
else
begin
SUM_reg<=st20;
CARRY_reg<=st21;
end
end*/


assign sum=st20;
assign carry={st21,2'b00};

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

