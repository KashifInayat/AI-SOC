module pre_process_be #(parameter WIDTH = 16)(mx, s, d, t, q, n);
    
parameter group_cnt=(WIDTH>>2)+2; 

input [WIDTH-1:0] mx;

output wire [group_cnt - 1:0]s;
output wire [group_cnt - 1:0]d;
output wire [group_cnt - 1:0]t;
output wire [group_cnt - 1:0]q;
output wire [group_cnt - 1:0]n;



//Booth Encoding
			booth_encoder b_e0(.x({mx[2], mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .triple(t[0]), .quad(q[0]), .neg(n[0]));
			booth_encoder b_e1(.x({mx[5],mx[4], mx[3], mx[2]}), .single(s[1]), .double(d[1]), .triple(t[1]), .quad(q[1]), .neg(n[1]));
			booth_encoder b_e2(.x({mx[8],mx[7], mx[6], mx[5]}), .single(s[2]), .double(d[2]), .triple(t[2]), .quad(q[2]), .neg(n[2]));
			booth_encoder b_e3(.x({mx[11],mx[10], mx[9], mx[8]}), .single(s[3]), .double(d[3]), .triple(t[3]), .quad(q[3]), .neg(n[3]));
			booth_encoder b_e4(.x({mx[14],mx[13], mx[12], mx[11]}), .single(s[4]), .double(d[4]), .triple(t[4]), .quad(q[4]), .neg(n[4]));
			booth_encoder b_e5(.x({2'b00, mx[WIDTH - 1:WIDTH-2]}), .single(s[5]), .double(d[5]), .triple(t[5]), .quad(q[5]), .neg(n[5]));
			
    

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
module mb16 #(parameter WIDTH = 16)(s, d, t, q, n, my, tmy, CLK, RST, product);
parameter group_cnt=(WIDTH>>2)+2; 
input wire [group_cnt-1:0] s;
input wire [group_cnt-1:0] d;
input wire [group_cnt-1:0] t;
input wire [group_cnt-1:0] q;
input wire [group_cnt-1:0] n;
input wire [WIDTH-1:0] my;
input  wire [WIDTH+1:0] tmy;
input CLK;
input RST;
output wire [(WIDTH*2)-1:0] product;
wire [WIDTH+1:0] epp2d[0:group_cnt - 1];
wire [18:0] fpp0;
wire [18:0] fpp1;
wire [18:0] fpp2;
wire [18:0] fpp3;
wire [18:0] fpp4;
wire [16:0] fpp5;

// load
wire [group_cnt - 1:0]s2, d2, t2, q2, n2;
wire [WIDTH-1:0]  Y2;
wire [WIDTH+1:0]  TMY2;

/*
BUFX0_MB_6  sbuf0 (s, s2);
BUFX0_MB_6  sbuf1 (d, d2);
BUFX0_MB_6  sbuf2 (t, t2);
BUFX0_MB_6  sbuf3 (q, q2);
BUFX0_MB_6  sbuf4 (n, n2);
BUFX0_MB_16  sbuf5 (my, Y2);
BUFX0_MB_18  sbuf6 (tmy, TMY2);
*/


genvar i, j;
generate
    for (j = 0; j < group_cnt; j = j + 1) begin: b_selector 
				  booth_sel bs(.y2(my[0]),.y1(1'b0),.y0(1'b0), .ty(tmy[0]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][0]));
			      booth_sel bs0(.y2(my[1]), .y1(my[0]),.y0(1'b0), .ty(tmy[1]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][1]));
			      booth_sel bs1(.y2(my[2]),.y1(my[1]),.y0(my[0]), .ty(tmy[2]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][2]));
			      booth_sel bs2(.y2(my[3]),.y1(my[2]),.y0(my[1]), .ty(tmy[3]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][3]));
                  booth_sel bs3(.y2(my[4]),.y1(my[3]),.y0(my[2]), .ty(tmy[4]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][4]));
                  booth_sel bs4(.y2(my[5]),.y1(my[4]),.y0(my[3]), .ty(tmy[5]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][5]));
                  booth_sel bs5(.y2(my[6]),.y1(my[5]),.y0(my[4]), .ty(tmy[6]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][6]));
                  booth_sel bs6(.y2(my[7]),.y1(my[6]),.y0(my[5]), .ty(tmy[7]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][7]));
                  booth_sel bs7(.y2(my[8]),.y1(my[7]),.y0(my[6]), .ty(tmy[8]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][8]));
                  booth_sel bs8(.y2(my[9]),.y1(my[8]),.y0(my[7]), .ty(tmy[9]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][9]));
                  booth_sel bs9(.y2(my[10]),.y1(my[9]),.y0(my[8]), .ty(tmy[10]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][10]));
                  booth_sel bs10(.y2(my[11]),.y1(my[10]),.y0(my[9]), .ty(tmy[11]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][11]));
                  booth_sel bs11(.y2(my[12]),.y1(my[11]),.y0(my[10]), .ty(tmy[12]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][12]));
                  booth_sel bs12(.y2(my[13]),.y1(my[12]),.y0(my[11]), .ty(tmy[13]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][13]));
                  booth_sel bs13(.y2(my[14]),.y1(my[13]),.y0(my[12]), .ty(tmy[14]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][14]));
                  booth_sel bs14(.y2(my[15]), .y1(my[14]), .y0(my[13]), .ty(tmy[15]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][15]));
                  booth_sel bs15(.y2(1'b0), .y1(my[15]), .y0(my[14]), .ty(tmy[16]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][16]));
                  booth_sel bs16(.y2(1'b0), .y1(1'b0), .y0(my[15]), .ty(tmy[17]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][17]));
                  //booth_sel bs14(.y2(1'b0), .y1(1'b0), .y0(my[13]), .ty(tmy[15]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][15]));
                  //booth_sel bs15(.y2(1'b0), .y1(my[15]),.y0(my[14]), .ty(tmy[16]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][16]));   
	end
endgenerate    


//Partial Products
assign fpp0 = {~n[0] , epp2d[0]};
assign fpp1 = {~n[1] , epp2d[1]};
assign fpp2 = {~n[2] , epp2d[2]};
assign fpp3 = {~n[3] , epp2d[3]};
assign fpp4 = {~n[4] , epp2d[4]};
assign fpp5 = {epp2d [5][16:0]};

//Correction vector
wire [31:0]cv= {14'b10110110110111, 5'b00000, n[4], 2'b00, n[3], 2'b00, n[2], 2'b00, n[1], 2'b00, n[0]};

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
wire ahas02;
wire ahac02;

wire has10;
wire hac10;
wire has11;
wire hac11;
wire has12;  
wire hac12;

wire ahas10;
wire ahac10;
wire ahas11;
wire ahac11;
wire ahas12;
wire ahac12;

wire [15:0] fas0;
wire [15:0] fac0; 

wire [12:0] fas1;
wire [12:0] fac1; 

wire [31:0] st00;
wire [21:0] st01;
wire [24:0] st02;
wire [18:0] st03;
wire [16:0] st04;


HALF_ADDER ha0s0210(.a(cv[0]), .b(fpp0[0]) , .sum(has00), .cout(hac00));
HALF_ADDER ha0s0311(.a(cv[1]), .b(fpp0[1]) , .sum(has01), .cout(hac01));
HALF_ADDER ha0s0211(.a(cv[2]), .b(fpp0[2]) , .sum(has02), .cout(hac02));

HALF_ADDER aha0s0210(.a(cv[19]), .b(fpp1[16]) , .sum(ahas00), .cout(ahac00));
HALF_ADDER aha0s0311(.a(cv[20]), .b(fpp1[17]) , .sum(ahas01), .cout(ahac01));
HALF_ADDER aha0s0312(.a(cv[21]), .b(fpp1[18]) , .sum(ahas02), .cout(ahac02));

generate
	for (i = 0; i < 16; i = i + 1) begin:	for_s0 
		FULL_ADDER fa000(.a(cv[i + 3]), .b(fpp0[i + 3]), .cin(fpp1[i]), .sum(fas0[i]), .cout(fac0[i]));
	end
endgenerate

assign st00 = { cv[31:22],ahas02,ahas01,ahas00,fas0, has02, has01, has00};	
assign st01 = {ahac02, ahac01, ahac00, fac0, hac02, hac01, hac00};				 

HALF_ADDER ha0s1210(.a(fpp2[3]), .b(fpp3[0]) , .sum(has10), .cout(hac10));
HALF_ADDER ha0s1311(.a(fpp2[4]), .b(fpp3[1]) , .sum(has11), .cout(hac11));
HALF_ADDER ha0s1211(.a(fpp2[5]), .b(fpp3[2]) , .sum(has12), .cout(hac12));

HALF_ADDER aha1s0210(.a(fpp3[16]), .b(fpp4[13]) , .sum(ahas10), .cout(ahac10));
HALF_ADDER aha1s0311(.a(fpp3[17]), .b(fpp4[14]) , .sum(ahas11), .cout(ahac11));
HALF_ADDER aha1s0312(.a(fpp3[18]), .b(fpp4[15]) , .sum(ahas12), .cout(ahac12));

generate
	for (i = 0; i < 13; i = i + 1) begin:	for_s1 
		FULL_ADDER fa100(.a(fpp2[i + 6]), .b(fpp3[i + 3]), .cin(fpp4[i]), .sum(fas1[i]), .cout(fac1[i]));
	end
endgenerate

assign st02 = {fpp4[18:16],ahas12,ahas11,ahas10,fas1, has12, has11, has10, fpp2[2:0]};	
assign st03 = {ahac12, ahac11, ahac10, fac1, hac12, hac11, hac10};				 
assign st04 = fpp5;


/*wire [31:0] cfpp1;
assign cfpp1= st00+{st01,1'b0}+{st02,6'b000000}+{st03,10'b0000000000}+{st04,15'b000000000000000};
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

wire [16:0] fa1ss0;
wire [16:0] fa1sc0;

wire [5:0] fa2ss0;
wire [5:0] fa2sc0;

wire [31:0] st10;
wire [21:0] st11;
wire [21:0] st12;
wire [16:0] st13;

HALF_ADDER ha1s0310(.a(st00[1]), .b(st01[0]) , .sum(ha1ss00), .cout(ha1sc00));
HALF_ADDER ha1s0411(.a(st00[2]), .b(st01[1]) , .sum(ha1ss01), .cout(ha1sc01));
HALF_ADDER ha1s0512(.a(st00[3]), .b(st01[2]) , .sum(ha1ss02), .cout(ha1sc02));
HALF_ADDER ha1s0513(.a(st00[4]), .b(st01[3]) , .sum(ha1ss03), .cout(ha1sc03));
HALF_ADDER ha1s0514(.a(st00[5]), .b(st01[4]) , .sum(ha1ss04), .cout(ha1sc04));

HALF_ADDER aha1s0512(.a(st02[23]), .b(st04[14]) , .sum(aha1ss10), .cout(aha1sc10));
HALF_ADDER aha1s0513(.a(st02[24]), .b(st04[15]) , .sum(aha1ss11), .cout(aha1sc11));

generate
	for (i = 0; i < 17; i = i + 1) begin:	for_s2
		FULL_ADDER fa2000(.a(st00[i + 6]), .b(st01[i+5 ]), .cin(st02[i]), .sum(fa1ss0[i]), .cout(fa1sc0[i]));
	end
endgenerate

generate
	for (i = 0; i < 6; i = i + 1) begin:	for_s3
		FULL_ADDER fa2001(.a(st02[i + 17]), .b(st03[i+13 ]), .cin(st04[i+8]), .sum(fa2ss0[i]), .cout(fa2sc0[i]));
	end
endgenerate


assign st10 = {st00[31:23], fa1ss0, ha1ss04, ha1ss03, ha1ss02, ha1ss01, ha1ss00, st00[0]};	
assign st11 = {fa1sc0, ha1sc04 , ha1sc03, ha1sc02, ha1sc01, ha1sc00};						
assign st12 = {st04[16], aha1ss11, aha1ss10, fa2ss0, st03[12:0]};
assign st13 = {aha1sc11, aha1sc10, fa2sc0, 1'b0, st04[7:0]};

/*wire [31:0] cfpp1;
assign cfpp1= st10+{st11,2'b00}+{st12,10'b0000000000}+{st13,15'b000000000000000};
assign product=cfpp1;*/


//******************** STAGE 3 of Wallace tree********************//**//*
wire ha1ss20;
wire ha1ss21;
wire ha1ss22;
wire ha1ss23;
wire ha1ss24;
wire ha1ss25;
wire ha1ss26;
wire ha1ss27;


wire ha1sc20;
wire ha1sc21;
wire ha1sc22;
wire ha1sc23;
wire ha1sc24;
wire ha1sc25;
wire ha1sc26;
wire ha1sc27;

wire [13:0] fa22ss0;
wire [13:0] fa22sc0;

wire [7:0] fa3ss0;
wire [7:0] fa3sc0;

wire [31:0] st20;
wire [28:0] st21;
wire [7:0] st22;

HALF_ADDER ha2s0310(.a(st10[2]), .b(st11[0]) , .sum(ha1ss20), .cout(ha1sc20));
HALF_ADDER ha2s0411(.a(st10[3]), .b(st11[1]) , .sum(ha1ss21), .cout(ha1sc21));
HALF_ADDER ha2s0512(.a(st10[4]), .b(st11[2]) , .sum(ha1ss22), .cout(ha1sc22));
HALF_ADDER ha2s0513(.a(st10[5]), .b(st11[3]) , .sum(ha1ss23), .cout(ha1sc23));
HALF_ADDER ha2s0514(.a(st10[6]), .b(st11[4]) , .sum(ha1ss24), .cout(ha1sc24));
HALF_ADDER ha2s0315(.a(st10[7]), .b(st11[5]) , .sum(ha1ss25), .cout(ha1sc25));
HALF_ADDER ha2s0416(.a(st10[8]), .b(st11[6]) , .sum(ha1ss26), .cout(ha1sc26));
HALF_ADDER ha2s0517(.a(st10[9]), .b(st11[7]) , .sum(ha1ss27), .cout(ha1sc27));

generate
	for (i = 0; i < 14; i = i + 1) begin:	for_s33
		FULL_ADDER fa30001(.a(st10[i + 10]), .b(st11[i + 8]), .cin(st12[i]), .sum(fa22ss0[i]), .cout(fa22sc0[i]));
	end
endgenerate

generate
	for (i = 0; i < 8; i = i + 1) begin:	for_s4
		FULL_ADDER fa4000(.a(st10[i + 24]), .b(st12[i + 14]), .cin(st13[i + 9]), .sum(fa3ss0[i]), .cout(fa3sc0[i]));
	end
endgenerate



assign st20 = {fa3ss0 , fa22ss0, ha1ss27, ha1ss26, ha1ss25, ha1ss24, ha1ss23, ha1ss22, ha1ss21, ha1ss20,st10[1:0]};	
assign st21 = {fa3sc0[6:0], fa22sc0, ha1sc27, ha1sc26, ha1sc25, ha1sc24 , ha1sc23, ha1sc22, ha1sc21, ha1sc20};						
assign st22 = st13[7:0];

/*wire [31:0] cfpp1;
assign cfpp1= st20+{st21,3'b000}+{st22,15'b000000000000000000};
assign product=cfpp1; 
*/
//******************** STAGE 4 of Wallace tree********************//**//*
wire aha2ss20;
wire aha2ss21;
wire aha2ss22;
wire aha2ss23;
wire aha2ss24;
wire aha2ss25;
wire aha2ss26;
wire aha2ss27;
wire aha2ss28;
wire aha2ss29;
wire aha2ss210;
wire aha2ss211;

wire aha2sc20;
wire aha2sc21;
wire aha2sc22;
wire aha2sc23;
wire aha2sc24;
wire aha2sc25;
wire aha2sc26;
wire aha2sc27;
wire aha2sc28;
wire aha2sc29;
wire aha2sc210;
wire aha2sc211;

wire aha3ss20;
wire aha3ss21;
wire aha3ss22;
wire aha3ss23;
wire aha3ss24;
wire aha3ss25;
wire aha3ss26;
wire aha3ss27;
wire aha3ss28;

wire aha3sc20;
wire aha3sc21;
wire aha3sc22;
wire aha3sc23;
wire aha3sc24;
wire aha3sc25;
wire aha3sc26;
wire aha3sc27;
wire aha3sc28;

wire [7:0] fa4ss0;
wire [7:0] fa4sc0;

wire [31:0] st30;
wire [27:0] st31;

HALF_ADDER aha2s0310(.a(st20[3]), .b(st21[0]) , .sum(aha2ss20), .cout(aha2sc20));
HALF_ADDER aha2s0411(.a(st20[4]), .b(st21[1]) , .sum(aha2ss21), .cout(aha2sc21));
HALF_ADDER aha2s0512(.a(st20[5]), .b(st21[2]) , .sum(aha2ss22), .cout(aha2sc22));
HALF_ADDER aha2s0513(.a(st20[6]), .b(st21[3]) , .sum(aha2ss23), .cout(aha2sc23));
HALF_ADDER aha2s0514(.a(st20[7]), .b(st21[4]) , .sum(aha2ss24), .cout(aha2sc24));
HALF_ADDER aha2s0515(.a(st20[8]), .b(st21[5]) , .sum(aha2ss25), .cout(aha2sc25));
HALF_ADDER aha2s0316(.a(st20[9]), .b(st21[6]) , .sum(aha2ss26), .cout(aha2sc26));
HALF_ADDER aha2s0417(.a(st20[10]), .b(st21[7]) , .sum(aha2ss27), .cout(aha2sc27));
HALF_ADDER aha2s0518(.a(st20[11]), .b(st21[8]) , .sum(aha2ss28), .cout(aha2sc28));
HALF_ADDER aha2s0519(.a(st20[12]), .b(st21[9]) , .sum(aha2ss29), .cout(aha2sc29));
HALF_ADDER aha2s05110(.a(st20[13]), .b(st21[10]) , .sum(aha2ss210), .cout(aha2sc210));
HALF_ADDER aha2s05111(.a(st20[14]), .b(st21[11]) , .sum(aha2ss211), .cout(aha2sc211));

HALF_ADDER aha3s0310(.a(st20[23]), .b(st21[20]) , .sum(aha3ss20), .cout(aha3sc20));
HALF_ADDER aha3s0411(.a(st20[24]), .b(st21[21]) , .sum(aha3ss21), .cout(aha3sc21));
HALF_ADDER aha3s0512(.a(st20[25]), .b(st21[22]) , .sum(aha3ss22), .cout(aha3sc22));
HALF_ADDER aha3s0513(.a(st20[26]), .b(st21[23]) , .sum(aha3ss23), .cout(aha3sc23));
HALF_ADDER aha3s0514(.a(st20[27]), .b(st21[24]) , .sum(aha3ss24), .cout(aha3sc24));
HALF_ADDER aha3s0515(.a(st20[28]), .b(st21[25]) , .sum(aha3ss25), .cout(aha3sc25));
HALF_ADDER aha3s0516(.a(st20[29]), .b(st21[26]) , .sum(aha3ss26), .cout(aha3sc26));
HALF_ADDER aha3s0517(.a(st20[30]), .b(st21[27]) , .sum(aha3ss27), .cout(aha3sc27));
HALF_ADDER aha3s0518(.a(st20[31]), .b(st21[28]) , .sum(aha3ss28), .cout(aha3sc28));

generate
	for (i = 0; i < 8; i = i + 1) begin:	for_s5
		FULL_ADDER fa3000(.a(st20[i + 15]), .b(st21[i + 12]), .cin(st22[i]), .sum(fa4ss0[i]), .cout(fa4sc0[i]));
	end
endgenerate

assign st30 = {aha3ss28, aha3ss27, aha3ss26, aha3ss25, aha3ss24, aha3ss23, aha3ss22, aha3ss21, aha3ss20, fa4ss0, aha2ss211, aha2ss210, aha2ss29, aha2ss28, aha2ss27, aha2ss26, aha2ss25, aha2ss24, aha2ss23, aha2ss22, aha2ss21, aha2ss20, st20[2:0]};	
assign st31 = {aha3sc27, aha3sc26, aha3sc25, aha3sc24, aha3sc23, aha3sc22, aha3sc21, aha3sc20, fa4sc0, aha2sc211, aha2sc210, aha2sc29, aha2sc28, aha2sc27, aha2sc26, aha2sc25, aha2sc24, aha2sc23, aha2sc22, aha2sc21, aha2sc20};						

/* wire [31:0] cfpp1;
assign cfpp1= st30+{st31,4'b0000};
assign product=cfpp1;  */
/*reg [31:0] SUM_reg;
reg [27:0] CARRY_reg;
always @(posedge CLK or negedge RST)
begin
if (!RST)
begin
SUM_reg<=32'h0;
CARRY_reg<=28'h0;
end
else
begin
SUM_reg<=st30;
CARRY_reg<=st31;
end
end*/
//******************** Tree ADDER STAGE  ********************//*
wire  [0:27] OPA;
wire  [0:27] OPB;
wire CIN;
wire PHI;
wire [0:0] PBIT;
wire [0:28] CARRY;
assign CIN=1'b0;
assign PHI=1'b0;
wire [27:0]prod;

assign OPA=(st30[31:4]);
assign OPB=(st31);

DBLCADDER_32_32 D (.OPA(OPA) , .OPB(OPB) , .CIN (CIN) , .PHI (PHI) , .SUM(prod), .COUT() );

//assign product={prod,st30[3:0]};

reg [(WIDTH*2)-1:0] pipereg;

always @(posedge CLK) 
begin
        pipereg <= {prod, st30[3:0]};
end

assign product=pipereg;
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
input  [27:0] OPA;
input  [27:0] OPB;
input  CIN;
input  PHI;
output [27:0] SUM;
output COUT;
   wire [27:0] INTPROP;
   wire [28:0] INTGEN;
   wire [0:0] PBIT;
   wire [28:0] CARRY;
   PRESTAGE_32 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_32 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_32 U3 (OPA[27:0] , OPB[27:0] , 1'b0 , PHI , CARRY[28:0] , SUM , COUT );

endmodule
//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_32 ( A, B, CIN, PHI, POUT, GOUT );
input  [27:0] A;
input  [27:0] B;
input  CIN;
input  PHI;
output [27:0] POUT;
output [28:0] GOUT;
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
   BLOCK0 U116 (A[16] , B[16] , PHI , POUT[16] , GOUT[17] );
   BLOCK0 U117 (A[17] , B[17] , PHI , POUT[17] , GOUT[18] );
   BLOCK0 U118 (A[18] , B[18] , PHI , POUT[18] , GOUT[19] );
   BLOCK0 U119 (A[19] , B[19] , PHI , POUT[19] , GOUT[20] );
   BLOCK0 U120 (A[20] , B[20] , PHI , POUT[20] , GOUT[21] );
   BLOCK0 U121 (A[21] , B[21] , PHI , POUT[21] , GOUT[22] );
   BLOCK0 U122 (A[22] , B[22] , PHI , POUT[22] , GOUT[23] );
   BLOCK0 U123 (A[23] , B[23] , PHI , POUT[23] , GOUT[24] );
   BLOCK0 U124 (A[24] , B[24] , PHI , POUT[24] , GOUT[25] );
   BLOCK0 U125 (A[25] , B[25] , PHI , POUT[25] , GOUT[26] );
   BLOCK0 U126 (A[26] , B[26] , PHI , POUT[26] , GOUT[27] );
   BLOCK0 U127 (A[27] , B[27] , PHI , POUT[27] , GOUT[28] );
   //BLOCK0 U128 (A[28] , B[28] , PHI , POUT[28] , GOUT[29] );
   //BLOCK0 U129 (A[29] , B[29] , PHI , POUT[29] , GOUT[30] );
   //BLOCK0 U130 (A[30] , B[30] , PHI , POUT[30] , GOUT[31] );
   //BLOCK0 U131 (A[31] , B[31] , PHI , POUT[31] , GOUT[32] );
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule
//******************** Carry Look Ahead Adder Tree ********************//
module DBLCTREE_32 ( PIN, GIN, PHI, GOUT, POUT );
input  [27:0] PIN;
input  [28:0] GIN;
input  PHI;
output [28:0] GOUT;
output [0:0] POUT;

   wire [26:0] INTPROP_0;
   wire [28:0] INTGEN_0;
   wire [24:0] INTPROP_1;
   wire [28:0] INTGEN_1;
   wire [20:0] INTPROP_2;
   wire [28:0] INTGEN_2;
   wire [12:0] INTPROP_3;
   wire [28:0] INTGEN_3;
  
   DBLC_0_32 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_32 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_32 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_32 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(INTPROP_3) , .GOUT(INTGEN_3) );
   DBLC_4_32 U_4 (.PIN(INTPROP_3) , .GIN(INTGEN_3) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule
module DBLC_0_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [27:0] PIN;
input  [28:0] GIN;
input  PHI;
output [26:0] POUT;
output [28:0] GOUT;
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
   BLOCK1 U317 (PIN[15] , PIN[16] , GIN[16] , GIN[17] , PHI , POUT[15] , GOUT[17] );
   BLOCK1 U318 (PIN[16] , PIN[17] , GIN[17] , GIN[18] , PHI , POUT[16] , GOUT[18] );
   BLOCK1 U319 (PIN[17] , PIN[18] , GIN[18] , GIN[19] , PHI , POUT[17] , GOUT[19] );
   BLOCK1 U320 (PIN[18] , PIN[19] , GIN[19] , GIN[20] , PHI , POUT[18] , GOUT[20] );
   BLOCK1 U321 (PIN[19] , PIN[20] , GIN[20] , GIN[21] , PHI , POUT[19] , GOUT[21] );
   BLOCK1 U322 (PIN[20] , PIN[21] , GIN[21] , GIN[22] , PHI , POUT[20] , GOUT[22] );
   BLOCK1 U323 (PIN[21] , PIN[22] , GIN[22] , GIN[23] , PHI , POUT[21] , GOUT[23] );
   BLOCK1 U324 (PIN[22] , PIN[23] , GIN[23] , GIN[24] , PHI , POUT[22] , GOUT[24] );
   BLOCK1 U325 (PIN[23] , PIN[24] , GIN[24] , GIN[25] , PHI , POUT[23] , GOUT[25] );
   BLOCK1 U326 (PIN[24] , PIN[25] , GIN[25] , GIN[26] , PHI , POUT[24] , GOUT[26] );
   BLOCK1 U327 (PIN[25] , PIN[26] , GIN[26] , GIN[27] , PHI , POUT[25] , GOUT[27] );
   BLOCK1 U328 (PIN[26] , PIN[27] , GIN[27] , GIN[28] , PHI , POUT[26] , GOUT[28] );
   //BLOCK1 U329 (PIN[27] , PIN[28] , GIN[28] , GIN[29] , PHI , POUT[27] , GOUT[29] );
   //BLOCK1 U330 (PIN[28] , PIN[29] , GIN[29] , GIN[30] , PHI , POUT[28] , GOUT[30] );
   //BLOCK1 U331 (PIN[29] , PIN[30] , GIN[30] , GIN[31] , PHI , POUT[29] , GOUT[31] );
   //BLOCK1 U332 (PIN[30] , PIN[31] , GIN[31] , GIN[32] , PHI , POUT[30] , GOUT[32] );
endmodule


module DBLC_1_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [26:0] PIN;
input  [28:0] GIN;
input  PHI;
output [24:0] POUT;
output [28:0] GOUT;
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
   BLOCK2 U317 (PIN[13] , PIN[15] , GIN[15] , GIN[17] , PHI , POUT[13] , GOUT[17] );
   BLOCK2 U318 (PIN[14] , PIN[16] , GIN[16] , GIN[18] , PHI , POUT[14] , GOUT[18] );
   BLOCK2 U319 (PIN[15] , PIN[17] , GIN[17] , GIN[19] , PHI , POUT[15] , GOUT[19] );
   BLOCK2 U320 (PIN[16] , PIN[18] , GIN[18] , GIN[20] , PHI , POUT[16] , GOUT[20] );
   BLOCK2 U321 (PIN[17] , PIN[19] , GIN[19] , GIN[21] , PHI , POUT[17] , GOUT[21] );
   BLOCK2 U322 (PIN[18] , PIN[20] , GIN[20] , GIN[22] , PHI , POUT[18] , GOUT[22] );
   BLOCK2 U323 (PIN[19] , PIN[21] , GIN[21] , GIN[23] , PHI , POUT[19] , GOUT[23] );
   BLOCK2 U324 (PIN[20] , PIN[22] , GIN[22] , GIN[24] , PHI , POUT[20] , GOUT[24] );
   BLOCK2 U325 (PIN[21] , PIN[23] , GIN[23] , GIN[25] , PHI , POUT[21] , GOUT[25] );
   BLOCK2 U326 (PIN[22] , PIN[24] , GIN[24] , GIN[26] , PHI , POUT[22] , GOUT[26] );
   BLOCK2 U327 (PIN[23] , PIN[25] , GIN[25] , GIN[27] , PHI , POUT[23] , GOUT[27] );
   BLOCK2 U328 (PIN[24] , PIN[26] , GIN[26] , GIN[28] , PHI , POUT[24] , GOUT[28] );
   //BLOCK2 U329 (PIN[25] , PIN[27] , GIN[27] , GIN[29] , PHI , POUT[25] , GOUT[29] );
   //BLOCK2 U330 (PIN[26] , PIN[28] , GIN[28] , GIN[30] , PHI , POUT[26] , GOUT[30] );
   //BLOCK2 U331 (PIN[27] , PIN[29] , GIN[29] , GIN[31] , PHI , POUT[27] , GOUT[31] );
   //BLOCK2 U332 (PIN[28] , PIN[30] , GIN[30] , GIN[32] , PHI , POUT[28] , GOUT[32] );
endmodule


module DBLC_2_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [24:0] PIN;
input  [28:0] GIN;
input  PHI;
output [20:0] POUT;
output [28:0] GOUT;
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
   BLOCK1 U317 (PIN[9] , PIN[13] , GIN[13] , GIN[17] , PHI , POUT[9] , GOUT[17] );
   BLOCK1 U318 (PIN[10] , PIN[14] , GIN[14] , GIN[18] , PHI , POUT[10] , GOUT[18] );
   BLOCK1 U319 (PIN[11] , PIN[15] , GIN[15] , GIN[19] , PHI , POUT[11] , GOUT[19] );
   BLOCK1 U320 (PIN[12] , PIN[16] , GIN[16] , GIN[20] , PHI , POUT[12] , GOUT[20] );
   BLOCK1 U321 (PIN[13] , PIN[17] , GIN[17] , GIN[21] , PHI , POUT[13] , GOUT[21] );
   BLOCK1 U322 (PIN[14] , PIN[18] , GIN[18] , GIN[22] , PHI , POUT[14] , GOUT[22] );
   BLOCK1 U323 (PIN[15] , PIN[19] , GIN[19] , GIN[23] , PHI , POUT[15] , GOUT[23] );
   BLOCK1 U324 (PIN[16] , PIN[20] , GIN[20] , GIN[24] , PHI , POUT[16] , GOUT[24] );
   BLOCK1 U325 (PIN[17] , PIN[21] , GIN[21] , GIN[25] , PHI , POUT[17] , GOUT[25] );
   BLOCK1 U326 (PIN[18] , PIN[22] , GIN[22] , GIN[26] , PHI , POUT[18] , GOUT[26] );
   BLOCK1 U327 (PIN[19] , PIN[23] , GIN[23] , GIN[27] , PHI , POUT[19] , GOUT[27] );
   BLOCK1 U328 (PIN[20] , PIN[24] , GIN[24] , GIN[28] , PHI , POUT[20] , GOUT[28] );
   //BLOCK1 U329 (PIN[21] , PIN[25] , GIN[25] , GIN[29] , PHI , POUT[21] , GOUT[29] );
   //BLOCK1 U330 (PIN[22] , PIN[26] , GIN[26] , GIN[30] , PHI , POUT[22] , GOUT[30] );
   //BLOCK1 U331 (PIN[23] , PIN[27] , GIN[27] , GIN[31] , PHI , POUT[23] , GOUT[31] );
   //BLOCK1 U332 (PIN[24] , PIN[28] , GIN[28] , GIN[32] , PHI , POUT[24] , GOUT[32] );
endmodule
module DBLC_3_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [20:0] PIN;
input  [28:0] GIN;
input  PHI;
output [12:0] POUT;
output [28:0] GOUT;
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
   BLOCK2 U317 (PIN[1] , PIN[9] , GIN[9] , GIN[17] , PHI , POUT[1] , GOUT[17] );
   BLOCK2 U318 (PIN[2] , PIN[10] , GIN[10] , GIN[18] , PHI , POUT[2] , GOUT[18] );
   BLOCK2 U319 (PIN[3] , PIN[11] , GIN[11] , GIN[19] , PHI , POUT[3] , GOUT[19] );
   BLOCK2 U320 (PIN[4] , PIN[12] , GIN[12] , GIN[20] , PHI , POUT[4] , GOUT[20] );
   BLOCK2 U321 (PIN[5] , PIN[13] , GIN[13] , GIN[21] , PHI , POUT[5] , GOUT[21] );
   BLOCK2 U322 (PIN[6] , PIN[14] , GIN[14] , GIN[22] , PHI , POUT[6] , GOUT[22] );
   BLOCK2 U323 (PIN[7] , PIN[15] , GIN[15] , GIN[23] , PHI , POUT[7] , GOUT[23] );
   BLOCK2 U324 (PIN[8] , PIN[16] , GIN[16] , GIN[24] , PHI , POUT[8] , GOUT[24] );
   BLOCK2 U325 (PIN[9] , PIN[17] , GIN[17] , GIN[25] , PHI , POUT[9] , GOUT[25] );
   BLOCK2 U326 (PIN[10] , PIN[18] , GIN[18] , GIN[26] , PHI , POUT[10] , GOUT[26] );
   BLOCK2 U327 (PIN[11] , PIN[19] , GIN[19] , GIN[27] , PHI , POUT[11] , GOUT[27] );
   BLOCK2 U328 (PIN[12] , PIN[20] , GIN[20] , GIN[28] , PHI , POUT[12] , GOUT[28] );
   //BLOCK2 U329 (PIN[13] , PIN[21] , GIN[21] , GIN[29] , PHI , POUT[13] , GOUT[29] );
   //BLOCK2 U330 (PIN[14] , PIN[22] , GIN[22] , GIN[30] , PHI , POUT[14] , GOUT[30] );
   //BLOCK2 U331 (PIN[15] , PIN[23] , GIN[23] , GIN[31] , PHI , POUT[15] , GOUT[31] );
   //BLOCK2 U332 (PIN[16] , PIN[24] , GIN[24] , GIN[32] , PHI , POUT[16] , GOUT[32] );
endmodule

module DBLC_4_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [12:0] PIN;
input  [28:0] GIN;
input  PHI;
output [0:0] POUT;
output [28:0] GOUT;
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
   BLOCK1A U228 (PIN[11] , GIN[11] , GIN[27] , PHI , GOUT[27] );
   BLOCK1 U227 (PIN[0] , PIN[12] , GIN[12] , GIN[28] , PHI , POUT[0], GOUT[28] );
   //BLOCK1A U228 (PIN[12] , GIN[12] , GIN[28] , PHI , GOUT[28] );
   //BLOCK1A U229 (PIN[13] , GIN[13] , GIN[29] , PHI , GOUT[29] );
   //BLOCK1A U230 (PIN[14] , GIN[14] , GIN[30] , PHI , GOUT[30] );
   //BLOCK1A U231 (PIN[15] , GIN[15] , GIN[31] , PHI , GOUT[31] );
   //BLOCK1 U332 (PIN[0] , PIN[16] , GIN[16] , GIN[32] , PHI , POUT[0] , GOUT[32] );
endmodule

//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_32 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [27:0] A;
input  [27:0] B;
input  PBIT;
input  PHI;
input  [28:0] CARRY;
output [27:0] SUM;
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
   XXOR1 U216 (A[16] , B[16] , CARRY[16] , PHI , SUM[16] );
   XXOR1 U217 (A[17] , B[17] , CARRY[17] , PHI , SUM[17] );
   XXOR1 U218 (A[18] , B[18] , CARRY[18] , PHI , SUM[18] );
   XXOR1 U219 (A[19] , B[19] , CARRY[19] , PHI , SUM[19] );
   XXOR1 U220 (A[20] , B[20] , CARRY[20] , PHI , SUM[20] );
   XXOR1 U221 (A[21] , B[21] , CARRY[21] , PHI , SUM[21] );
   XXOR1 U222 (A[22] , B[22] , CARRY[22] , PHI , SUM[22] );
   XXOR1 U223 (A[23] , B[23] , CARRY[23] , PHI , SUM[23] );
   XXOR1 U224 (A[24] , B[24] , CARRY[24] , PHI , SUM[24] );
   XXOR1 U225 (A[25] , B[25] , CARRY[25] , PHI , SUM[25] );
   XXOR1 U226 (A[26] , B[26] , CARRY[26] , PHI , SUM[26] );
   XXOR1 U227 (A[27] , B[27] , CARRY[27] , PHI , SUM[27] );
   //XXOR1 U228 (A[28] , B[28] , CARRY[28] , PHI , SUM[28] );
   //XXOR1 U229 (A[29] , B[29] , CARRY[29] , PHI , SUM[29] );
   //XXOR1 U230 (A[30] , B[30] , CARRY[30] , PHI , SUM[30] );
   //XXOR1 U231 (A[31] , B[31] , CARRY[31] , PHI , SUM[31] );
   //BLOCK1A U1 (PBIT , CARRY[0] , CARRY[32] , PHI , COUT );
endmodule
/******************** Booth Selector ********************/
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



