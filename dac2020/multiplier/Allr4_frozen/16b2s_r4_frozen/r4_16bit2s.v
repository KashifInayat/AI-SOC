module mb16 #(parameter WIDTH = 16)(
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
wire [17:0] fpp0;
wire [17:0] fpp1;
wire [17:0] fpp2;
wire [17:0] fpp3;
wire [17:0] fpp4;
wire [17:0] fpp5;
wire [17:0] fpp6;
wire [17:0] fpp7;
wire [15:0] fpp8;



/******************** Booth Encoding ********************/
		    booth_encoder b_e0(.x({mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .neg(n[0]));
			booth_encoder b_e1(.x({mx[3], mx[2], mx[1]}), .single(s[1]), .double(d[1]), .neg(n[1]));
			booth_encoder b_e2(.x({mx[5], mx[4], mx[3]}), .single(s[2]), .double(d[2]), .neg(n[2]));
			booth_encoder b_e3(.x({mx[7], mx[6], mx[5]}), .single(s[3]), .double(d[3]), .neg(n[3]));
			booth_encoder b_e4(.x({mx[9], mx[8], mx[7]}), .single(s[4]), .double(d[4]), .neg(n[4]));
			booth_encoder b_e5(.x({mx[11], mx[10], mx[9]}), .single(s[5]), .double(d[5]), .neg(n[5]));
			booth_encoder b_e6(.x({mx[13], mx[12], mx[11]}), .single(s[6]), .double(d[6]), .neg(n[6]));
			booth_encoder b_e7(.x({mx[15], mx[14], mx[13]}), .single(s[7]), .double(d[7]), .neg(n[7]));
			booth_encoder b_e8(.x({1'b0, 1'b0, mx[WIDTH - 1]}), .single(s[8]), .double(d[8]), .neg(n[8]));
			
/******************** Booth Selector--------Partial Product Generation ********************/
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
			booth_selector bs7(.double(d[j]), .shifted(my[7]), .single(s[j]), .y(my[8]), .neg(n[j]), .p(epp2d[j][8]));
			booth_selector bs8(.double(d[j]), .shifted(my[8]), .single(s[j]), .y(my[9]), .neg(n[j]), .p(epp2d[j][9]));
			booth_selector bs9(.double(d[j]), .shifted(my[9]), .single(s[j]), .y(my[10]), .neg(n[j]), .p(epp2d[j][10]));
			booth_selector bs10(.double(d[j]), .shifted(my[10]), .single(s[j]), .y(my[11]), .neg(n[j]), .p(epp2d[j][11]));
			booth_selector bs11(.double(d[j]), .shifted(my[11]), .single(s[j]), .y(my[12]), .neg(n[j]), .p(epp2d[j][12]));
			booth_selector bs12(.double(d[j]), .shifted(my[12]), .single(s[j]), .y(my[13]), .neg(n[j]), .p(epp2d[j][13]));
			booth_selector bs13(.double(d[j]), .shifted(my[13]), .single(s[j]), .y(my[14]), .neg(n[j]), .p(epp2d[j][14]));
			booth_selector bs14(.double(d[j]), .shifted(my[14]), .single(s[j]), .y(my[15]), .neg(n[j]), .p(epp2d[j][15]));		
			booth_selector bs15(.double(d[j]), .shifted(my[15]), .single(s[j]), .y(1'b0), .neg(n[j]), .p(epp2d[j][16]));
    end
endgenerate

assign fpp0 = {~n[0] , epp2d[0]};
assign fpp1 = {~n[1] , epp2d[1]};
assign fpp2 = {~n[2] , epp2d[2]};
assign fpp3 = {~n[3] , epp2d[3]};
assign fpp4 = {~n[4] , epp2d[4]};
assign fpp5 = {~n[5] , epp2d[5]};
assign fpp6 = {~n[6] , epp2d[6]};
assign fpp7 = {~n[7] , epp2d[7]};
assign fpp8 = {epp2d[8][15:0]};

wire [(WIDTH*2)-1:0] cv={15'b010101010101011,1'b0,1'b0,n[7],1'b0,n[6],1'b0,n[5],1'b0,n[4],1'b0,n[3],1'b0,n[2],1'b0,n[1],1'b0,n[0]}; 

/*wire [31:0] cfpp;
assign cfpp= fpp0+{fpp1,2'b00}+{fpp2,4'b0000}+{fpp3,6'b000000}+{fpp4,8'b00000000}+{fpp5,10'b0000000000}+{fpp6,12'b000000000000}+{fpp7,14'b00000000000000}+{fpp8,16'b0000000000000000};
wire [31:0] cfpp1;
assign product=cfpp+ {15'b010101010101011,1'b0,1'b0,n[7],1'b0,n[6],1'b0,n[5],1'b0,n[4],1'b0,n[3],1'b0,n[2],1'b0,n[1],1'b0,n[0]};
*/
//******************** Partial Products Reduction Using Wallace Tree ********************//*
//******************** STAGE 1 of Wallace Tree ********************
wire has00;
wire hac00;
wire has01;
wire hac01;

wire has10;
wire has11;
wire hac10;
wire hac11;

wire has20;
wire has21;
wire hac20;
wire hac21;

wire ahas00;
wire ahac00;
wire ahas01;
wire ahac01;

wire ahas10;
wire ahas11;
wire ahac10;
wire ahac11;

wire ahas20;
wire ahas21;
wire ahac20;
wire ahac21;

wire [15:0] fas0;
wire [15:0] fac0; 
wire [13:0] fas1;
wire [13:0] fac1;
wire [13:0] fas2;
wire [13:0] fac2;

wire [(WIDTH*2)-1:0] st00;
wire [19:0] st01;
wire [21:0] st02;
wire [17:0] st03;
wire [21:0] st04;
wire [17:0] st05;
wire [15:0] st06;

HALF_ADDER ha0s0210(.a(cv[0]), .b(fpp0[0]) , .sum(has00), .cout(hac00));
HALF_ADDER ha0s0311(.a(cv[1]), .b(fpp0[1]) , .sum(has01), .cout(hac01));

HALF_ADDER aha0s0210(.a(cv[18]), .b(fpp1[16]) , .sum(ahas00), .cout(ahac00));
HALF_ADDER aha0s0311(.a(cv[19]), .b(fpp1[17]) , .sum(ahas01), .cout(ahac01));

generate
	for (i = 0; i < 16; i = i + 1) begin:	for_s0 
		FULL_ADDER fa00(.a(cv[i + 2]), .b(fpp0[i + 2]), .cin(fpp1[i]), .sum(fas0[i]), .cout(fac0[i]));
	end
endgenerate

HALF_ADDER ha0s3240(.a(fpp2[2]), .b(fpp3[0]) , .sum(has10), .cout(hac10));
HALF_ADDER ha0s3341(.a(fpp2[3]), .b(fpp3[1]) , .sum(has11), .cout(hac11));

HALF_ADDER aha0s3240(.a(fpp3[16]), .b(fpp4[14]) , .sum(ahas10), .cout(ahac10));
HALF_ADDER aha0s3341(.a(fpp3[17]), .b(fpp4[15]) , .sum(ahas11), .cout(ahac11));

generate
	for (i = 0; i < 14; i = i + 1) begin:	for_s1  
		FULL_ADDER fa01(.a(fpp2[i + 4]), .b(fpp3[i + 2]), .cin(fpp4[i]), .sum(fas1[i]), .cout(fac1[i]));
	end
endgenerate

HALF_ADDER ha0s6270(.a(fpp5[2]), .b(fpp6[0]) , .sum(has20), .cout(hac20));
HALF_ADDER ha0s6371(.a(fpp5[3]), .b(fpp6[1]) , .sum(has21), .cout(hac21));

HALF_ADDER aha0s6270(.a(fpp6[16]), .b(fpp7[14]) , .sum(ahas20), .cout(ahac20));
HALF_ADDER aha0s6371(.a(fpp6[17]), .b(fpp7[15]) , .sum(ahas21), .cout(ahac21));


generate
	for (i = 0; i < 14; i = i + 1) begin:	for_s2  
		FULL_ADDER fa02(.a(fpp5[i + 4]), .b(fpp6[i + 2]), .cin(fpp7[i]), .sum(fas2[i]), .cout(fac2[i]));
	end
endgenerate

assign st00 = {cv[31:20],ahas01,ahas00,fas0, has01, has00};	
assign st01 = {ahac01, ahac00,fac0, hac01, hac00};				 
assign st02 = {fpp4[17], fpp4[16],ahas11,ahas10,fas1, has11, has10, fpp2[1], fpp2[0]};	 
assign st03 = {ahac11, ahac10,fac1, hac11, hac10};				 
assign st04 = {fpp7[17:16],ahas21,ahas20,fas2, has21, has20, fpp5[1], fpp5[0]};	
assign st05 = {ahac21, ahac20,fac2, hac21, hac20};
assign st06 = fpp8;				

/*wire [31:0] cst0;
assign cst0=st00+{st01,1'b0}+{st02,4'b0000}+{st03,7'b0000000}+{st04,10'b0000000000}+{st05,13'b0000000000000}+{st06,16'b0000000000000000};
assign product=cst0;*/


//******************** STAGE 2 of Wallace Tree ********************//*
wire ha1ss00;
wire ha1ss01;
wire ha1ss02;
wire ha1sc00;
wire ha1sc01;
wire ha1sc02;

wire ha1ss10;
wire ha1ss11;
wire ha1ss12;
wire ha1sc10;
wire ha1sc11;
wire ha1sc12;

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

wire aha1ss15;
wire aha1sc15;

wire [16:0] fa1ss0;
wire [16:0] fa1sc0;
wire [11:0] fa1ss1;
wire [11:0] fa1sc1;
wire [5:0] fa1ss2;
wire [5:0] fa1sc2;

wire [(WIDTH*2)-1:0] st10;
wire [24:0] st11;
wire [24:0] st12;
wire [20:0] st13;
wire [8:0]  st14;

HALF_ADDER ha1s0310(.a(st00[1]), .b(st01[0]) , .sum(ha1ss00), .cout(ha1sc00));
HALF_ADDER ha1s0411(.a(st00[2]), .b(st01[1]) , .sum(ha1ss01), .cout(ha1sc01));
HALF_ADDER ha1s0512(.a(st00[3]), .b(st01[2]) , .sum(ha1ss02), .cout(ha1sc02));

HALF_ADDER aha1s3340(.a(st00[21]), .b(st02[17]) , .sum(aha1ss10), .cout(aha1sc10));
HALF_ADDER aha1s3441(.a(st00[22]), .b(st02[18]) , .sum(aha1ss11), .cout(aha1sc11));
HALF_ADDER aha1s3542(.a(st00[23]), .b(st02[19]) , .sum(aha1ss12), .cout(aha1sc12));
HALF_ADDER aha1s3343(.a(st00[24]), .b(st02[20]) , .sum(aha1ss13), .cout(aha1sc13));
HALF_ADDER aha1s3444(.a(st00[25]), .b(st02[21]) , .sum(aha1ss14), .cout(aha1sc14));



generate
	for (i = 0; i < 17; i = i + 1) begin:	for_s3
		FULL_ADDER fa03(.a(st00[i + 4]), .b(st01[i + 3]), .cin(st02[i]), .sum(fa1ss0[i]), .cout(fa1sc0[i]));
	end
endgenerate

HALF_ADDER ha1s3340(.a(st03[3]), .b(st04[0]) , .sum(ha1ss10), .cout(ha1sc10));
HALF_ADDER ha1s3441(.a(st03[4]), .b(st04[1]) , .sum(ha1ss11), .cout(ha1sc11));
HALF_ADDER ha1s3542(.a(st03[5]), .b(st04[2]) , .sum(ha1ss12), .cout(ha1sc12));

HALF_ADDER aha1s0512(.a(st04[21]), .b(st06[15]) , .sum(aha1ss15), .cout(aha1sc15));


generate
	for (i = 0; i < 12; i = i + 1) begin:	for_s4
		FULL_ADDER fa04(.a(st03[i + 6]), .b(st04[i + 3]), .cin(st05[i]), .sum(fa1ss1[i]), .cout(fa1sc1[i]));
	end
endgenerate

generate
	for (i = 0; i < 6; i = i + 1) begin:	for_s44
		FULL_ADDER fa044(.a(st04[i + 15]), .b(st05[i + 12]), .cin(st06[i+9]), .sum(fa1ss2[i]), .cout(fa1sc2[i]));
	end
endgenerate

assign st10 = {st00[31:26], aha1ss14, aha1ss13, aha1ss12, aha1ss11, aha1ss10, fa1ss0, ha1ss02, ha1ss01, ha1ss00, st00[0]};	
assign st11 = {aha1sc14, aha1sc13, aha1sc12, aha1sc11, aha1sc10, fa1sc0, ha1sc02, ha1sc01, ha1sc00};						
assign st12 = {aha1ss15, fa1ss2, fa1ss1, ha1ss12, ha1ss11, ha1ss10, st03[2], st03[1], st03[0]};	
assign st13 = {fa1sc2, fa1sc1, ha1sc12, ha1sc11, ha1sc10};			
assign st14 = st06[8:0];	
	

/*wire [31:0] cst1;
assign cst1=st10+{st11,2'b00}+{st12,7'b0000000}+{st13,11'b00000000000}+{st14,16'b0000000000000000};
assign product=cst1;*/

//******************** STAGE 3 of Wallace Tree ********************//*
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

/*wire aha2ss01;
wire aha2ss02;
wire aha2ss03; 
wire aha2ss04;
wire aha2sc01;
wire aha2sc02;
wire aha2sc03;
wire aha2sc04;*/

wire [19:0] fa2ss0;
wire [19:0] fa2sc0;

wire [4:0] afa2ss0;
wire [4:0] afa2sc0;

wire [(WIDTH*2)-1:0] st20;
wire [28:0] st21;
wire [15:0] st22;
wire [8:0]  st23;

HALF_ADDER ha2s0410(.a(st10[2]), .b(st11[0]) , .sum(ha2ss00), .cout(ha2sc00));
HALF_ADDER ha2s0511(.a(st10[3]), .b(st11[1]) , .sum(ha2ss01), .cout(ha2sc01));
HALF_ADDER ha2s0612(.a(st10[4]), .b(st11[2]) , .sum(ha2ss02), .cout(ha2sc02));
HALF_ADDER ha2s0713(.a(st10[5]), .b(st11[3]) , .sum(ha2ss03), .cout(ha2sc03));
HALF_ADDER ha2s0814(.a(st10[6]), .b(st11[4]) , .sum(ha2ss04), .cout(ha2sc04));

/*HALF_ADDER aha2s0511(.a(st12[19]), .b(st13[15]) , .sum(aha2ss01), .cout(aha2sc01));
HALF_ADDER aha2s0612(.a(st12[20]), .b(st13[16]) , .sum(aha2ss02), .cout(aha2sc02));
HALF_ADDER aha2s0713(.a(st12[21]), .b(st13[17]) , .sum(aha2ss03), .cout(aha2sc03));
HALF_ADDER aha2s0814(.a(st12[22]), .b(st13[18]) , .sum(aha2ss04), .cout(aha2sc04));
*/
generate
	for (i = 0; i < 20; i = i + 1) begin:	for_s5
		FULL_ADDER fa05(.a(st10[i + 7]), .b(st11[i + 5]), .cin(st12[i]), .sum(fa2ss0[i]), .cout(fa2sc0[i]));
	end
endgenerate

generate
	for (i = 0; i < 5; i = i + 1) begin:	afor_s6
		FULL_ADDER afa06(.a(st10[i + 27]), .b(st12[i + 20]), .cin(st13[i+16]), .sum(afa2ss0[i]), .cout(afa2sc0[i]));
	end
endgenerate

assign st20 = {afa2ss0, fa2ss0, ha2ss04, ha2ss03, ha2ss02, ha2ss01, ha2ss00, st10[1], st10[0]};	// 32 bit
assign st21 = {afa2sc0[3:0], fa2sc0, ha2sc04, ha2sc03, ha2sc02, ha2sc01, ha2sc00};					// 27 bit
assign st22 = st13[15:0];
assign st23 = st14;


/*wire [31:0] cst2;
assign cst2=st20+{st21,3'b000}+{st22,11'b00000000000}+{st23,16'b0000000000000000};
assign product=cst2;*/
//******************** STAGE 4 of Wallace Tree********************//*
wire ha3ss00;
wire ha3ss01;
wire ha3ss02;
wire ha3ss03;
wire ha3ss04;
wire ha3ss05;
wire ha3ss06;
wire ha3ss07;

wire ha3sc00;
wire ha3sc01;
wire ha3sc02;
wire ha3sc03;
wire ha3sc04;
wire ha3sc05;
wire ha3sc06;
wire ha3sc07;

wire aha4ss00;
wire aha4ss01;
wire aha4ss02;
wire aha4ss03;
wire aha4ss04;

wire aha4sc00;
wire aha4sc01;
wire aha4sc02;
wire aha4sc03;
wire aha4sc04;

wire [15:0] fa3ss0;
wire [15:0] fa3sc0;

wire [(WIDTH*2)-1:0] st30;
wire [27:0] st31;
wire [8:0] st32;

HALF_ADDER ha3s0510(.a(st20[3]), .b(st21[0]) , .sum(ha3ss00), .cout(ha3sc00));
HALF_ADDER ha3s0611(.a(st20[4]), .b(st21[1]) , .sum(ha3ss01), .cout(ha3sc01));
HALF_ADDER ha3s0712(.a(st20[5]), .b(st21[2]) , .sum(ha3ss02), .cout(ha3sc02));
HALF_ADDER ha3s0813(.a(st20[6]), .b(st21[3]) , .sum(ha3ss03), .cout(ha3sc03));
HALF_ADDER ha3s0914(.a(st20[7]), .b(st21[4]) , .sum(ha3ss04), .cout(ha3sc04));
HALF_ADDER ha3s01015(.a(st20[8]), .b(st21[5]) , .sum(ha3ss05), .cout(ha3sc05));
HALF_ADDER ha3s01116(.a(st20[9]), .b(st21[6]) , .sum(ha3ss06), .cout(ha3sc06));
HALF_ADDER ha3s01217(.a(st20[10]), .b(st21[7]) , .sum(ha3ss07), .cout(ha3sc07));

HALF_ADDER aha4s0510(.a(st20[27]), .b(st21[24]) , .sum(aha4ss00), .cout(aha4sc00));
HALF_ADDER aha4s0611(.a(st20[28]), .b(st21[25]) , .sum(aha4ss01), .cout(aha4sc01));
HALF_ADDER aha4s0712(.a(st20[29]), .b(st21[26]) , .sum(aha4ss02), .cout(aha4sc02));
HALF_ADDER aha4s0813(.a(st20[30]), .b(st21[27]) , .sum(aha4ss03), .cout(aha4sc03));
HALF_ADDER aha4s0914(.a(st20[31]), .b(st21[28]) , .sum(aha4ss04), .cout(aha4sc04));


generate
	for (i = 0; i < 16; i = i + 1) begin:	for_s6
		FULL_ADDER fa06(.a(st20[i + 11]), .b(st21[i + 8]), .cin(st22[i]), .sum(fa3ss0[i]), .cout(fa3sc0[i]));
	end
endgenerate

assign st30 = {aha4ss04,aha4ss03,aha4ss02,aha4ss01,aha4ss00,fa3ss0, ha3ss07, ha3ss06, ha3ss05, ha3ss04, ha3ss03, ha3ss02, ha3ss01, ha3ss00, st20[2], st20[1], st20[0]};	// 32 bit
assign st31 = {aha4sc03,aha4sc02,aha4sc01,aha4sc00,fa3sc0, ha3sc07, ha3sc06, ha3sc05, ha3sc04, ha3sc03, ha3sc02, ha3sc01, ha3sc00};					// 26 bit
assign st32 = st23;

/*wire [31:0] cst3;
assign cst3=st30+{st31,4'b0000}+{st32,11'b00000000000};
assign product=cst3;
*/
//******************** STAGE 5 of Wallace Tree  ********************//*
wire ha4ss00;
wire ha4ss01;
wire ha4ss02;
wire ha4ss03;
wire ha4ss04;
wire ha4ss05;
wire ha4ss06;
wire ha4ss07;
wire ha4ss08;
wire ha4ss09;
wire ha4ss010;
wire ha4ss011;

wire ha4sc00;
wire ha4sc01;
wire ha4sc02;
wire ha4sc03;
wire ha4sc04;
wire ha4sc05;
wire ha4sc06;
wire ha4sc07;
wire ha4sc08;
wire ha4sc09;
wire ha4sc010;
wire ha4sc011;

wire aha5ss00;
wire aha5ss01;
wire aha5ss02;
wire aha5ss03;
wire aha5ss04;
wire aha5ss05;
wire aha5ss06;

wire aha5sc00;
wire aha5sc01;
wire aha5sc02;
wire aha5sc03;
wire aha5sc04;
wire aha5sc05;
wire aha5sc06;

HALF_ADDER ha4s0510(.a(st30[4]), .b(st31[0]) , .sum(ha4ss00), .cout(ha4sc00));
HALF_ADDER ha4s0611(.a(st30[5]), .b(st31[1]) , .sum(ha4ss01), .cout(ha4sc01));
HALF_ADDER ha4s0712(.a(st30[6]), .b(st31[2]) , .sum(ha4ss02), .cout(ha4sc02));
HALF_ADDER ha4s0813(.a(st30[7]), .b(st31[3]) , .sum(ha4ss03), .cout(ha4sc03));
HALF_ADDER ha4s0914(.a(st30[8]), .b(st31[4]) , .sum(ha4ss04), .cout(ha4sc04));
HALF_ADDER ha4s01015(.a(st30[9]), .b(st31[5]) , .sum(ha4ss05), .cout(ha4sc05));
HALF_ADDER ha4s01116(.a(st30[10]), .b(st31[6]) , .sum(ha4ss06), .cout(ha4sc06));
HALF_ADDER ha4s01217(.a(st30[11]), .b(st31[7]) , .sum(ha4ss07), .cout(ha4sc07));
HALF_ADDER ha4s0918(.a(st30[12]), .b(st31[8]) , .sum(ha4ss08), .cout(ha4sc08));
HALF_ADDER ha4s01019(.a(st30[13]), .b(st31[9]) , .sum(ha4ss09), .cout(ha4sc09));
HALF_ADDER ha4s01120(.a(st30[14]), .b(st31[10]) , .sum(ha4ss010), .cout(ha4sc010));
HALF_ADDER ha4s01221(.a(st30[15]), .b(st31[11]) , .sum(ha4ss011), .cout(ha4sc011));

HALF_ADDER aaha3s0510(.a(st30[25]), .b(st31[21]) , .sum(aha5ss00), .cout(aha5sc00));
HALF_ADDER aaha3s0611(.a(st30[26]), .b(st31[22]) , .sum(aha5ss01), .cout(aha5sc01));
HALF_ADDER aaha3s0712(.a(st30[27]), .b(st31[23]) , .sum(aha5ss02), .cout(aha5sc02));
HALF_ADDER aaha3s0813(.a(st30[28]), .b(st31[24]) , .sum(aha5ss03), .cout(aha5sc03));
HALF_ADDER aaha3s0914(.a(st30[29]), .b(st31[25]) , .sum(aha5ss04), .cout(aha5sc04));
HALF_ADDER aaha3s0915(.a(st30[30]), .b(st31[26]) , .sum(aha5ss05), .cout(aha5sc05));
HALF_ADDER aaha3s0916(.a(st30[31]), .b(st31[27]) , .sum(aha5ss06), .cout(aha5sc06));

wire [8:0] afa3ss0;
wire [8:0] afa3sc0;
wire [(WIDTH*2)-1:0] ast40;
wire [26:0] ast41;

generate
	for (i = 0; i < 9; i = i + 1) begin:	for_as6
        FULL_ADDER aafa06(.a(st30[i + 16]), .b(st31[i + 12]), .cin(st32[i]), .sum(afa3ss0[i]), .cout(afa3sc0[i]));
	end
endgenerate

assign ast40={aha5ss06, aha5ss05, aha5ss04, aha5ss03, aha5ss02, aha5ss01, aha5ss00, afa3ss0, ha4ss011, ha4ss010, ha4ss09, ha4ss08, ha4ss07, ha4ss06, ha4ss05, ha4ss04, ha4ss03, ha4ss02, ha4ss01, ha4ss00, st30[3:0]};
assign ast41={aha5sc05, aha5sc04, aha5sc03, aha5sc02, aha5sc01, aha5sc00, afa3sc0, ha4sc011, ha4sc010, ha4sc09, ha4sc08, ha4sc07, ha4sc06, ha4sc05, ha4sc04, ha4sc03, ha4sc02, ha4sc01, ha4sc00};

//wire [31:0] SUM_reg;
//wire [26:0] CARRY_reg;
//assign SUM_reg=ast40;
//assign CARRY_reg=ast41;


//******************** Tree ADDER STAGE  ********************//
wire  [0:26] OPA;
wire  [0:26] OPB;
wire CIN;
wire PHI;
wire [0:0] PBIT;
wire [0:27] CARRY;
assign CIN=1'b0;
assign PHI=1'b0;
wire [26:0]prod;
assign OPA=(ast40[(WIDTH*2)-1:5]);
assign OPB=(ast41);

DBLCADDER_32_32 D (.OPA(OPA) , .OPB(OPB) , .CIN (CIN) , .PHI (PHI) , .SUM(prod), .COUT() );

//assign product={prod,ast40[4:0]};
reg [(WIDTH*2)-1:0] pipereg;

always @(posedge CLK) 
begin
        pipereg <= {prod,ast40[4:0]};
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
input  [26:0] OPA;
input  [26:0] OPB;
input  CIN;
input  PHI;
output [26:0] SUM;
output COUT;
   wire [26:0] INTPROP;
   wire [27:0] INTGEN;
   wire [0:0] PBIT;
   wire [27:0] CARRY;
   PRESTAGE_32 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_32 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_32 U3 (OPA[26:0] , OPB[26:0] , 1'b0 , PHI , CARRY[27:0] , SUM , COUT );

endmodule
//******************** Initial Generate and Propagate bits ********************//
module PRESTAGE_32 ( A, B, CIN, PHI, POUT, GOUT );
input  [26:0] A;
input  [26:0] B;
input  CIN;
input  PHI;
output [26:0] POUT;
output [27:0] GOUT;
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
   //BLOCK0 U127 (A[27] , B[27] , PHI , POUT[27] , GOUT[28] );
   //BLOCK0 U128 (A[28] , B[28] , PHI , POUT[28] , GOUT[29] );
   //BLOCK0 U129 (A[29] , B[29] , PHI , POUT[29] , GOUT[30] );
   //BLOCK0 U130 (A[30] , B[30] , PHI , POUT[30] , GOUT[31] );
   //BLOCK0 U131 (A[31] , B[31] , PHI , POUT[31] , GOUT[32] );
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule
//******************** Carry Look Ahead Adder Tree ********************//
module DBLCTREE_32 ( PIN, GIN, PHI, GOUT, POUT );
input  [26:0] PIN;
input  [27:0] GIN;
input  PHI;
output [27:0] GOUT;
output [0:0] POUT;


   wire [25:0] INTPROP_0;
   wire [27:0] INTGEN_0;
   wire [23:0] INTPROP_1;
   wire [27:0] INTGEN_1;
   wire [19:0] INTPROP_2;
   wire [27:0] INTGEN_2;
   wire [11:0] INTPROP_3;
   wire [27:0] INTGEN_3;
  
   DBLC_0_32 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   
   DBLC_1_32 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_32 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_32 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(INTPROP_3) , .GOUT(INTGEN_3) );
   DBLC_4_32 U_4 (.PIN(INTPROP_3) , .GIN(INTGEN_3) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule
module DBLC_0_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [26:0] PIN;
input  [27:0] GIN;
input  PHI;
output [25:0] POUT;
output [27:0] GOUT;
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
   //BLOCK1 U328 (PIN[26] , PIN[27] , GIN[27] , GIN[28] , PHI , POUT[26] , GOUT[28] );
   //BLOCK1 U329 (PIN[27] , PIN[28] , GIN[28] , GIN[29] , PHI , POUT[27] , GOUT[29] );
   //BLOCK1 U330 (PIN[28] , PIN[29] , GIN[29] , GIN[30] , PHI , POUT[28] , GOUT[30] );
   //BLOCK1 U331 (PIN[29] , PIN[30] , GIN[30] , GIN[31] , PHI , POUT[29] , GOUT[31] );
   //BLOCK1 U332 (PIN[30] , PIN[31] , GIN[31] , GIN[32] , PHI , POUT[30] , GOUT[32] );
endmodule


module DBLC_1_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [25:0] PIN;
input  [27:0] GIN;
input  PHI;
output [23:0] POUT;
output [27:0] GOUT;
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
   //BLOCK2 U328 (PIN[24] , PIN[26] , GIN[26] , GIN[28] , PHI , POUT[24] , GOUT[28] );
   //BLOCK2 U329 (PIN[25] , PIN[27] , GIN[27] , GIN[29] , PHI , POUT[25] , GOUT[29] );
   //BLOCK2 U330 (PIN[26] , PIN[28] , GIN[28] , GIN[30] , PHI , POUT[26] , GOUT[30] );
   //BLOCK2 U331 (PIN[27] , PIN[29] , GIN[29] , GIN[31] , PHI , POUT[27] , GOUT[31] );
   //BLOCK2 U332 (PIN[28] , PIN[30] , GIN[30] , GIN[32] , PHI , POUT[28] , GOUT[32] );
endmodule


module DBLC_2_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [23:0] PIN;
input  [27:0] GIN;
input  PHI;
output [19:0] POUT;
output [27:0] GOUT;
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
   //BLOCK1 U328 (PIN[20] , PIN[24] , GIN[24] , GIN[28] , PHI , POUT[20] , GOUT[28] );
   //BLOCK1 U329 (PIN[21] , PIN[25] , GIN[25] , GIN[29] , PHI , POUT[21] , GOUT[29] );
   //BLOCK1 U330 (PIN[22] , PIN[26] , GIN[26] , GIN[30] , PHI , POUT[22] , GOUT[30] );
   //BLOCK1 U331 (PIN[23] , PIN[27] , GIN[27] , GIN[31] , PHI , POUT[23] , GOUT[31] );
   //BLOCK1 U332 (PIN[24] , PIN[28] , GIN[28] , GIN[32] , PHI , POUT[24] , GOUT[32] );
endmodule
module DBLC_3_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [19:0] PIN;
input  [27:0] GIN;
input  PHI;
output [11:0] POUT;
output [27:0] GOUT;
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
   //BLOCK2 U328 (PIN[12] , PIN[20] , GIN[20] , GIN[28] , PHI , POUT[12] , GOUT[28] );
   //BLOCK2 U329 (PIN[13] , PIN[21] , GIN[21] , GIN[29] , PHI , POUT[13] , GOUT[29] );
   //BLOCK2 U330 (PIN[14] , PIN[22] , GIN[22] , GIN[30] , PHI , POUT[14] , GOUT[30] );
   //BLOCK2 U331 (PIN[15] , PIN[23] , GIN[23] , GIN[31] , PHI , POUT[15] , GOUT[31] );
   //BLOCK2 U332 (PIN[16] , PIN[24] , GIN[24] , GIN[32] , PHI , POUT[16] , GOUT[32] );
endmodule

module DBLC_4_32 ( PIN, GIN, PHI, POUT, GOUT );
input  [11:0] PIN;
input  [27:0] GIN;
input  PHI;
output [0:0] POUT;
output [27:0] GOUT;
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
   BLOCK1 U227 (PIN[0] , PIN[11] , GIN[11] , GIN[27] , PHI , POUT[0], GOUT[27] );
   //BLOCK1A U228 (PIN[12] , GIN[12] , GIN[28] , PHI , GOUT[28] );
   //BLOCK1A U229 (PIN[13] , GIN[13] , GIN[29] , PHI , GOUT[29] );
   //BLOCK1A U230 (PIN[14] , GIN[14] , GIN[30] , PHI , GOUT[30] );
   //BLOCK1A U231 (PIN[15] , GIN[15] , GIN[31] , PHI , GOUT[31] );
   //BLOCK1 U332 (PIN[0] , PIN[16] , GIN[16] , GIN[32] , PHI , POUT[0] , GOUT[32] );
endmodule

//******************** XOR STAGE TO GET FINAL SUM bits********************//
module XORSTAGE_32 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [26:0] A;
input  [26:0] B;
input  PBIT;
input  PHI;
input  [27:0] CARRY;
output [26:0] SUM;
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
   //XXOR1 U227 (A[27] , B[27] , CARRY[27] , PHI , SUM[27] );
   //XXOR1 U228 (A[28] , B[28] , CARRY[28] , PHI , SUM[28] );
   //XXOR1 U229 (A[29] , B[29] , CARRY[29] , PHI , SUM[29] );
   //XXOR1 U230 (A[30] , B[30] , CARRY[30] , PHI , SUM[30] );
   //XXOR1 U231 (A[31] , B[31] , CARRY[31] , PHI , SUM[31] );
   //BLOCK1A U1 (PBIT , CARRY[0] , CARRY[32] , PHI , COUT );
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

