module mb32 #(parameter WIDTH = 32)(
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
wire [WIDTH+1:0] fpp0;
wire [WIDTH+1:0] fpp1;
wire [WIDTH+1:0] fpp2;
wire [WIDTH+1:0] fpp3;
wire [WIDTH+1:0] fpp4;
wire [WIDTH+1:0] fpp5;
wire [WIDTH+1:0] fpp6;
wire [WIDTH+1:0] fpp7;
wire [WIDTH+1:0] fpp8;
wire [WIDTH+1:0] fpp9;
wire [WIDTH+1:0] fpp10;
wire [WIDTH+1:0] fpp11;
wire [WIDTH+1:0] fpp12;
wire [WIDTH+1:0] fpp13;
wire [WIDTH+1:0] fpp14;
wire [WIDTH+1:0] fpp15;
wire [WIDTH-1:0] fpp16;


/******************** Booth Encoding ********************/
		    booth_encoder b_e0(.x({mx[1], mx[0], 1'b0}), .single(s[0]), .double(d[0]), .neg(n[0]));
			booth_encoder b_e1(.x({mx[3], mx[2], mx[1]}), .single(s[1]), .double(d[1]), .neg(n[1]));
			booth_encoder b_e2(.x({mx[5], mx[4], mx[3]}), .single(s[2]), .double(d[2]), .neg(n[2]));
			booth_encoder b_e3(.x({mx[7], mx[6], mx[5]}), .single(s[3]), .double(d[3]), .neg(n[3]));
			booth_encoder b_e4(.x({mx[9], mx[8], mx[7]}), .single(s[4]), .double(d[4]), .neg(n[4]));
			booth_encoder b_e5(.x({mx[11], mx[10], mx[9]}), .single(s[5]), .double(d[5]), .neg(n[5]));
			booth_encoder b_e6(.x({mx[13], mx[12], mx[11]}), .single(s[6]), .double(d[6]), .neg(n[6]));
			booth_encoder b_e7(.x({mx[15], mx[14], mx[13]}), .single(s[7]), .double(d[7]), .neg(n[7]));
			booth_encoder b_e8(.x({mx[17], mx[16], mx[15]}), .single(s[8]), .double(d[8]), .neg(n[8]));
			booth_encoder b_e9(.x({mx[19], mx[18], mx[17]}), .single(s[9]), .double(d[9]), .neg(n[9]));
			booth_encoder b_e10(.x({mx[21], mx[20], mx[19]}), .single(s[10]), .double(d[10]), .neg(n[10]));
			booth_encoder b_e11(.x({mx[23], mx[22], mx[21]}), .single(s[11]), .double(d[11]), .neg(n[11]));
			booth_encoder b_e12(.x({mx[25], mx[24], mx[23]}), .single(s[12]), .double(d[12]), .neg(n[12]));
			booth_encoder b_e13(.x({mx[27], mx[26], mx[25]}), .single(s[13]), .double(d[13]), .neg(n[13]));
			booth_encoder b_e14(.x({mx[29], mx[28], mx[27]}), .single(s[14]), .double(d[14]), .neg(n[14]));
			booth_encoder b_e15(.x({mx[31], mx[30], mx[29]}), .single(s[15]), .double(d[15]), .neg(n[15]));
			booth_encoder b_e16(.x({1'b0, 1'b0, mx[31]}), .single(s[16]), .double(d[16]), .neg(n[16]));
			
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
			booth_selector bs15(.double(d[j]), .shifted(my[15]), .single(s[j]), .y(my[16]), .neg(n[j]), .p(epp2d[j][16]));
			booth_selector bs16(.double(d[j]), .shifted(my[16]), .single(s[j]), .y(my[17]), .neg(n[j]), .p(epp2d[j][17]));
			booth_selector bs17(.double(d[j]), .shifted(my[17]), .single(s[j]), .y(my[18]), .neg(n[j]), .p(epp2d[j][18]));
			booth_selector bs18(.double(d[j]), .shifted(my[18]), .single(s[j]), .y(my[19]), .neg(n[j]), .p(epp2d[j][19]));
			booth_selector bs19(.double(d[j]), .shifted(my[19]), .single(s[j]), .y(my[20]), .neg(n[j]), .p(epp2d[j][20]));
			booth_selector bs20(.double(d[j]), .shifted(my[20]), .single(s[j]), .y(my[21]), .neg(n[j]), .p(epp2d[j][21]));
			booth_selector bs21(.double(d[j]), .shifted(my[21]), .single(s[j]), .y(my[22]), .neg(n[j]), .p(epp2d[j][22]));
			booth_selector bs22(.double(d[j]), .shifted(my[22]), .single(s[j]), .y(my[23]), .neg(n[j]), .p(epp2d[j][23]));
			booth_selector bs23(.double(d[j]), .shifted(my[23]), .single(s[j]), .y(my[24]), .neg(n[j]), .p(epp2d[j][24]));
			booth_selector bs24(.double(d[j]), .shifted(my[24]), .single(s[j]), .y(my[25]), .neg(n[j]), .p(epp2d[j][25]));
			booth_selector bs25(.double(d[j]), .shifted(my[25]), .single(s[j]), .y(my[26]), .neg(n[j]), .p(epp2d[j][26]));
			booth_selector bs26(.double(d[j]), .shifted(my[26]), .single(s[j]), .y(my[27]), .neg(n[j]), .p(epp2d[j][27]));
			booth_selector bs27(.double(d[j]), .shifted(my[27]), .single(s[j]), .y(my[28]), .neg(n[j]), .p(epp2d[j][28]));
			booth_selector bs28(.double(d[j]), .shifted(my[28]), .single(s[j]), .y(my[29]), .neg(n[j]), .p(epp2d[j][29]));
			booth_selector bs29(.double(d[j]), .shifted(my[29]), .single(s[j]), .y(my[30]), .neg(n[j]), .p(epp2d[j][30]));
			booth_selector bs30(.double(d[j]), .shifted(my[30]), .single(s[j]), .y(my[31]), .neg(n[j]), .p(epp2d[j][31]));
			booth_selector bs31(.double(d[j]), .shifted(my[31]), .single(s[j]), .y(1'b0), .neg(n[j]), .p(epp2d[j][32]));
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
assign fpp8 = {~n[8] , epp2d[8]};
assign fpp9 = {~n[9] , epp2d[9]};
assign fpp10 = {~n[10] , epp2d[10]};
assign fpp11 = {~n[11] , epp2d[11]};
assign fpp12 = {~n[12] , epp2d[12]};
assign fpp13 = {~n[13] , epp2d[13]};
assign fpp14 = {~n[14] , epp2d[14]};
assign fpp15 = {~n[15] , epp2d[15]};
assign fpp16 = {epp2d[16][31:0]};

wire [63:0] cv={31'h2aaaaaab,1'b0,1'b0,n[15],1'b0,n[14],1'b0,n[13],1'b0,n[12],1'b0,n[11],1'b0,n[10],1'b0,n[9],1'b0,n[8],1'b0,n[7],1'b0,n[6],1'b0,n[5],1'b0,n[4],1'b0,n[3],1'b0,n[2],1'b0,n[1],1'b0,n[0]}; 

/*wire [63:0] cfpp;
assign cfpp= fpp0+{fpp1,2'b00}+{fpp2,4'b0000}+{fpp3,6'b000000}+{fpp4,8'b00000000}+{fpp5,10'b0000000000}+{fpp6,12'b000000000000}+{fpp7,14'b00000000000000}+{fpp8,16'b0000000000000000}+{fpp9,18'b000000000000000000}+{fpp10,20'b00000000000000000000}+{fpp11,22'b0000000000000000000000}+{fpp12,24'b000000000000000000000000}+{fpp13,26'b00000000000000000000000000}+{fpp14,28'b0000000000000000000000000000}+{fpp15,30'b000000000000000000000000000000}+{fpp16,32'b00000000000000000000000000000000};
assign product=cfpp+ cv;*/

//******************** Partial Products Reduction Using Wallace Tree ********************//*
//******************** STAGE 1 of Wallace Tree ********************
wire has000;
wire hac000;
wire has001;
wire hac001;

wire has010;
wire has011;
wire hac010;
wire hac011;

wire has020;
wire has021;
wire hac020;
wire hac021;

wire has030;
wire has031;
wire hac030;
wire hac031;

wire has040;
wire has041;
wire hac040;
wire hac041;

wire has050;
wire has051;
wire hac050;
wire hac051;

wire ahas000;
wire ahac000;
wire ahas001;
wire ahac001;

wire ahas010;
wire ahas011;
wire ahac010;
wire ahac011;

wire ahas020;
wire ahas021;
wire ahac020;
wire ahac021;

wire ahas030;
wire ahas031;
wire ahac030;
wire ahac031;

wire ahas040;
wire ahas041;
wire ahac040;
wire ahac041;

wire ahas050;
wire ahas051;
wire ahac050;

wire [31:0] fas00;
wire [31:0] fac00;
 
wire [29:0] fas01;
wire [29:0] fac01;

wire [29:0] fas02;
wire [29:0] fac02;

wire [29:0] fas03;
wire [29:0] fac03;

wire [29:0] fas04;
wire [29:0] fac04;

wire [29:0] fas05;
wire [29:0] fac05;

wire [63:0] st00;
wire [35:0] st01;
wire [37:0] st02;
wire [33:0] st03;
wire [37:0] st04;
wire [33:0] st05;
wire [37:0] st06;
wire [33:0] st07;
wire [37:0] st08;
wire [33:0] st09;
wire [35:0] st010;
wire [32:0] st011;

HALF_ADDER ha000(.a(cv[0]), .b(fpp0[0]) , .sum(has000), .cout(hac000));
HALF_ADDER ha001(.a(cv[1]), .b(fpp0[1]) , .sum(has001), .cout(hac001));

HALF_ADDER aha000(.a(cv[34]), .b(fpp1[32]) , .sum(ahas000), .cout(ahac000));
HALF_ADDER aha001(.a(cv[35]), .b(fpp1[33]) , .sum(ahas001), .cout(ahac001));

generate
	for (i = 0; i < 32; i = i + 1) begin:	for_s0 
		FULL_ADDER fa00(.a(cv[i + 2]), .b(fpp0[i + 2]), .cin(fpp1[i]), .sum(fas00[i]), .cout(fac00[i]));
	end
endgenerate

assign st00 = {cv[63:36],ahas001,ahas000,fas00, has001, has000};	
assign st01 = {ahac001, ahac000,fac00, hac001, hac000};	

HALF_ADDER ha010(.a(fpp2[2]), .b(fpp3[0]) , .sum(has010), .cout(hac010));
HALF_ADDER ha011(.a(fpp2[3]), .b(fpp3[1]) , .sum(has011), .cout(hac011));

HALF_ADDER aha010(.a(fpp3[32]), .b(fpp4[30]) , .sum(ahas010), .cout(ahac010));
HALF_ADDER aha011(.a(fpp3[33]), .b(fpp4[31]) , .sum(ahas011), .cout(ahac011));

generate
	for (i = 0; i < 30; i = i + 1) begin:	for_s1  
		FULL_ADDER fa01(.a(fpp2[i + 4]), .b(fpp3[i + 2]), .cin(fpp4[i]), .sum(fas01[i]), .cout(fac01[i]));
	end
endgenerate

assign st02 = {fpp4[33], fpp4[32],ahas011,ahas010,fas01, has011, has010, fpp2[1], fpp2[0]};	 
assign st03 = {ahac011, ahac010,fac01, hac011, hac010};	

HALF_ADDER ha020(.a(fpp5[2]), .b(fpp6[0]) , .sum(has020), .cout(hac020));
HALF_ADDER ha021(.a(fpp5[3]), .b(fpp6[1]) , .sum(has021), .cout(hac021));

HALF_ADDER aha020(.a(fpp6[32]), .b(fpp7[30]) , .sum(ahas020), .cout(ahac020));
HALF_ADDER aha021(.a(fpp6[33]), .b(fpp7[31]) , .sum(ahas021), .cout(ahac021));

generate
	for (i = 0; i < 30; i = i + 1) begin:	for_s2  
		FULL_ADDER fa02(.a(fpp5[i + 4]), .b(fpp6[i + 2]), .cin(fpp7[i]), .sum(fas02[i]), .cout(fac02[i]));
	end
endgenerate

assign st04 = {fpp7[33:32],ahas021,ahas020,fas02, has021, has020, fpp5[1], fpp5[0]};	
assign st05 = {ahac021, ahac020,fac02, hac021, hac020};

HALF_ADDER ha030(.a(fpp8[2]), .b(fpp9[0]) , .sum(has030), .cout(hac030));
HALF_ADDER ha031(.a(fpp8[3]), .b(fpp9[1]) , .sum(has031), .cout(hac031));

HALF_ADDER aha030(.a(fpp9[32]), .b(fpp10[30]) , .sum(ahas030), .cout(ahac030));
HALF_ADDER aha031(.a(fpp9[33]), .b(fpp10[31]) , .sum(ahas031), .cout(ahac031));

generate
	for (i = 0; i < 30; i = i + 1) begin:	for_s3  
		FULL_ADDER fa03(.a(fpp8[i + 4]), .b(fpp9[i + 2]), .cin(fpp10[i]), .sum(fas03[i]), .cout(fac03[i]));
	end
endgenerate

assign st06 = {fpp10[33:32],ahas031,ahas030,fas03, has031, has030, fpp8[1], fpp8[0]};	
assign st07 = {ahac031, ahac030,fac03, hac031, hac030};

HALF_ADDER ha040(.a(fpp11[2]), .b(fpp12[0]) , .sum(has040), .cout(hac040));
HALF_ADDER ha041(.a(fpp11[3]), .b(fpp12[1]) , .sum(has041), .cout(hac041));

HALF_ADDER aha040(.a(fpp12[32]), .b(fpp13[30]) , .sum(ahas040), .cout(ahac040));
HALF_ADDER aha041(.a(fpp12[33]), .b(fpp13[31]) , .sum(ahas041), .cout(ahac041));

generate
	for (i = 0; i < 30; i = i + 1) begin:	for_s4  
		FULL_ADDER fa04(.a(fpp11[i + 4]), .b(fpp12[i + 2]), .cin(fpp13[i]), .sum(fas04[i]), .cout(fac04[i]));
	end
endgenerate

assign st08 = {fpp13[33:32],ahas041,ahas040,fas04, has041, has040, fpp11[1], fpp11[0]};	
assign st09 = {ahac041, ahac040,fac04, hac041, hac040};

HALF_ADDER ha050(.a(fpp14[2]), .b(fpp15[0]) , .sum(has050), .cout(hac050));
HALF_ADDER ha051(.a(fpp14[3]), .b(fpp15[1]) , .sum(has051), .cout(hac051));

HALF_ADDER aha050(.a(fpp15[32]), .b(fpp16[30]) , .sum(ahas050), .cout(ahac050));
HALF_ADDER aha051(.a(fpp15[33]), .b(fpp16[31]) , .sum(ahas051), .cout(ahac051));

generate
	for (i = 0; i < 30; i = i + 1) begin:	for_s5  
		FULL_ADDER fa05(.a(fpp14[i + 4]), .b(fpp15[i + 2]), .cin(fpp16[i]), .sum(fas05[i]), .cout(fac05[i]));
	end
endgenerate

assign st010 = {ahas051,ahas050,fas05, has051, has050, fpp14[1], fpp14[0]};	
assign st011 = {ahac050,fac05, hac051, hac050};

/*wire [63:0] cst0;
assign cst0=st00+{st01,1'b0}+{st02,4'b0000}+{st03,7'b0000000}+{st04,10'b0000000000}+{st05,13'b0000000000000}+{st06,16'b0000000000000000}+{st07,19'b00000000000000000000}+{st08,22'b0000000000000000000000}+{st09,25'b0000000000000000000000000}+{st010,28'b0000000000000000000000000000}+{st011,31'b00000000000000000000000000000000};
assign product=cst0;*/

//******************** STAGE 2 of Wallace Tree ********************//**//*
wire has100;
wire has101;
wire has102;
wire hac100;
wire hac101;
wire hac102;

wire has110;
wire has111;
wire has112;
wire hac110;
wire hac111;
wire hac112;

wire has120;
wire has121;
wire has122;
wire hac120;
wire hac121;
wire hac122;

wire has130;
wire has131;
wire has132;
wire hac130;
wire hac131;
wire hac132;

wire ahas100;
wire ahas101;
wire ahas102;
wire ahas103;
wire ahas104;
wire ahac100;
wire ahac101;
wire ahac102;
wire ahac103;
wire ahac104;

wire ahas110;
wire ahas111;
wire ahas112;
wire ahas113;
wire ahas114;
wire ahas115;
wire ahac110;
wire ahac111;
wire ahac112;
wire ahac113;
wire ahac114;
wire ahac115;

wire ahas120;
wire ahac120;

wire ahas130;
wire ahas131;
wire ahas132;
wire ahas133;
wire ahas134;
wire ahac130;
wire ahac131;
wire ahac132;
wire ahac133;
wire ahac134;

wire [32:0] fas10;
wire [32:0] fac10;
wire [27:0] fas11;
wire [27:0] fac11;
wire [30:0] fas12;
wire [30:0] fac12;
wire [27:0] fas13;
wire [27:0] fac13;

wire [63:0] st10;
wire [40:0] st11;
wire [40:0] st12;
wire [36:0] st13;
wire [43:0] st14;
wire [34:0] st15;
wire [38:0] st16;
wire [34:0] st17;

HALF_ADDER ha100(.a(st00[1]), .b(st01[0]) , .sum(has100), .cout(hac100));
HALF_ADDER ha101(.a(st00[2]), .b(st01[1]) , .sum(has101), .cout(hac101));
HALF_ADDER ha102(.a(st00[3]), .b(st01[2]) , .sum(has102), .cout(hac102));


HALF_ADDER aha100(.a(st00[37]), .b(st02[33]) , .sum(ahas100), .cout(ahac100));
HALF_ADDER aha101(.a(st00[38]), .b(st02[34]) , .sum(ahas101), .cout(ahac101));
HALF_ADDER aha102(.a(st00[39]), .b(st02[35]) , .sum(ahas102), .cout(ahac102));
HALF_ADDER aha103(.a(st00[40]), .b(st02[36]) , .sum(ahas103), .cout(ahac103));
HALF_ADDER aha104(.a(st00[41]), .b(st02[37]) , .sum(ahas104), .cout(ahac104));

generate
	for (i = 0; i < 33; i = i + 1) begin:	for_s10
		FULL_ADDER fa10(.a(st00[i + 4]), .b(st01[i + 3]), .cin(st02[i]), .sum(fas10[i]), .cout(fac10[i]));
	end
endgenerate

assign st10 = {st00[63:42], ahas104, ahas103, ahas102, ahas101, ahas100, fas10, has102, has101, has100, st00[0]};
assign st11 = {ahac104, ahac103, ahac102, ahac101, ahac100, fac10, hac102, hac101, hac100};

HALF_ADDER ha110(.a(st03[3]), .b(st04[0]) , .sum(has110), .cout(hac110));
HALF_ADDER ha111(.a(st03[4]), .b(st04[1]) , .sum(has111), .cout(hac111));
HALF_ADDER ha112(.a(st03[5]), .b(st04[2]) , .sum(has112), .cout(hac112));

HALF_ADDER aha110(.a(st04[31]), .b(st05[28]) , .sum(ahas110), .cout(ahac110));
HALF_ADDER aha111(.a(st04[32]), .b(st05[29]) , .sum(ahas111), .cout(ahac111));
HALF_ADDER aha112(.a(st04[33]), .b(st05[30]) , .sum(ahas112), .cout(ahac112));
HALF_ADDER aha113(.a(st04[34]), .b(st05[31]) , .sum(ahas113), .cout(ahac113));
HALF_ADDER aha114(.a(st04[35]), .b(st05[32]) , .sum(ahas114), .cout(ahac114));
HALF_ADDER aha115(.a(st04[36]), .b(st05[33]) , .sum(ahas115), .cout(ahac115));

generate
	for (i = 0; i < 28; i = i + 1) begin:	for_s11
		FULL_ADDER fa11(.a(st03[i + 6]), .b(st04[i + 3]), .cin(st05[i]), .sum(fas11[i]), .cout(fac11[i]));
	end
endgenerate

assign st12 = {st04[37],ahas115,ahas114,ahas113,ahas112,ahas111,ahas110, fas11, has112, has111, has110, st03[2], st03[1], st03[0]};
assign st13 = {ahac115,ahac114,ahac113,ahac112,ahac111,ahac110, fac11, hac112, hac111, hac110};

HALF_ADDER ha120(.a(st06[3]), .b(st07[0]) , .sum(has120), .cout(hac120));
HALF_ADDER ha121(.a(st06[4]), .b(st07[1]) , .sum(has121), .cout(hac121));
HALF_ADDER ha122(.a(st06[5]), .b(st07[2]) , .sum(has122), .cout(hac122));

HALF_ADDER aha120(.a(st06[37]), .b(st08[31]) , .sum(ahas120), .cout(ahac120));

generate
	for (i = 0; i < 31; i = i + 1) begin:	for_s12
		FULL_ADDER fa12(.a(st06[i + 6]), .b(st07[i + 3]), .cin(st08[i]), .sum(fas12[i]), .cout(fac12[i]));
	end
endgenerate

assign st14 = {st08[37:32], ahas120, fas12, has122, has121, has120, st06[2], st06[1], st06[0]};
assign st15 = {ahac120, fac12, hac122, hac121, hac120};

HALF_ADDER ha130(.a(st09[3]), .b(st010[0]) , .sum(has130), .cout(hac130));
HALF_ADDER ha131(.a(st09[4]), .b(st010[1]) , .sum(has131), .cout(hac131));
HALF_ADDER ha132(.a(st09[5]), .b(st010[2]) , .sum(has132), .cout(hac132));

HALF_ADDER ahs130(.a(st010[31]), .b(st011[28]) , .sum(ahas130), .cout(ahac130));
HALF_ADDER ahs131(.a(st010[32]), .b(st011[29]) , .sum(ahas131), .cout(ahac131));
HALF_ADDER ahs132(.a(st010[33]), .b(st011[30]) , .sum(ahas132), .cout(ahac132));
HALF_ADDER ahs133(.a(st010[34]), .b(st011[31]) , .sum(ahas133), .cout(ahac133));
HALF_ADDER ahs134(.a(st010[35]), .b(st011[32]) , .sum(ahas134), .cout(ahac134));


generate
        for (i = 0; i < 28; i = i + 1) begin:   for_s13
                FULL_ADDER fa13(.a(st09[i + 6]), .b(st010[i + 3]), .cin(st011[i]), .sum(fas13[i]), .cout(fac13[i]));
        end
endgenerate


assign st16 = {ahas134,ahas133,ahas132,ahas131, ahas130, fas13, has132, has131, has130, st09[2], st09[1], st09[0]};
assign st17 = {ahac133, ahac132, ahac131, ahac130, fac13, hac132, hac131, hac130};
/*
wire [63:0] cst1;
assign cst1=st10+{st11,2'b00}+{st12,7'b0000000}+{st13,11'b00000000000}+{st14,16'b0000000000000000}+{st15,20'b00000000000000000000}+{st16,25'b0000000000000000000000000}+{st17,29'b00000000000000000000000000000};
assign product=cst1;
*/

//******************** STAGE 3 of Wallace Tree ********************//**//*
wire has200;
wire has201;
wire has202;
wire has203;
wire has204;

wire hac200;
wire hac201;
wire hac202;
wire hac203;
wire hac204;

wire ahas200;
wire ahas201;
wire ahas202;
wire ahas203; 
wire ahas204;

wire ahac200;
wire ahac201;
wire ahac202;
wire ahac203;
wire ahac204;

wire has210;
wire has211;
wire has212;
wire has213;

wire hac210;
wire hac211;
wire hac212;
wire hac213;

wire ahas210;
wire ahas211;
wire ahas212;
wire ahas213; 
wire ahas214;
wire ahas215;
wire ahas216;

wire ahac210;
wire ahac211;
wire ahac212;
wire ahac213;
wire ahac214;
wire ahac215;
wire ahac216;

wire [35:0] fas20;
wire [35:0] fac20;

wire [27:0] fas21;
wire [27:0] fac21;

wire [63:0] st20;
wire [45:0] st21;
wire [48:0] st22;
wire [38:0] st23;
wire [38:0] st24;
wire [34:0] st25;

HALF_ADDER ha200(.a(st10[2]), .b(st11[0]) , .sum(has200), .cout(hac200));
HALF_ADDER ha201(.a(st10[3]), .b(st11[1]) , .sum(has201), .cout(hac201));
HALF_ADDER ha202(.a(st10[4]), .b(st11[2]) , .sum(has202), .cout(hac202));
HALF_ADDER ha203(.a(st10[5]), .b(st11[3]) , .sum(has203), .cout(hac203));
HALF_ADDER ha204(.a(st10[6]), .b(st11[4]) , .sum(has204), .cout(hac204));


HALF_ADDER aha200(.a(st10[43]), .b(st12[36]) , .sum(ahas200), .cout(ahac200));
HALF_ADDER aha201(.a(st10[44]), .b(st12[37]) , .sum(ahas201), .cout(ahac201));
HALF_ADDER aha203(.a(st10[45]), .b(st12[38]) , .sum(ahas202), .cout(ahac202));
HALF_ADDER aha204(.a(st10[46]), .b(st12[39]) , .sum(ahas203), .cout(ahac203));
HALF_ADDER aha205(.a(st10[47]), .b(st12[40]) , .sum(ahas204), .cout(ahac204));


generate
	for (i = 0; i < 36; i = i + 1) begin:	for_s20
		FULL_ADDER fa20(.a(st10[i + 7]), .b(st11[i + 5]), .cin(st12[i]), .sum(fas20[i]), .cout(fac20[i]));
	end
endgenerate

assign st20 = {st10[63:48], ahas204, ahas203, ahas202, ahas201, ahas200, fas20, has204, has203, has202, has201, has200, st10[1], st10[0]};	
assign st21 = {ahac204, ahac203, ahac202, ahac201, ahac200, fac20, hac204, hac203, hac202, hac201, hac200};			

HALF_ADDER ha210(.a(st13[5]), .b(st14[0]) , .sum(has210), .cout(hac210));
HALF_ADDER ha211(.a(st13[6]), .b(st14[1]) , .sum(has211), .cout(hac211));
HALF_ADDER ha212(.a(st13[7]), .b(st14[2]) , .sum(has212), .cout(hac212));
HALF_ADDER ha213(.a(st13[8]), .b(st14[3]) , .sum(has213), .cout(hac213));

HALF_ADDER aha210(.a(st14[32]), .b(st15[28]) , .sum(ahas210), .cout(ahac210));
HALF_ADDER aha211(.a(st14[33]), .b(st15[29]) , .sum(ahas211), .cout(ahac211));
HALF_ADDER aha212(.a(st14[34]), .b(st15[30]) , .sum(ahas212), .cout(ahac212));
HALF_ADDER aha213(.a(st14[35]), .b(st15[31]) , .sum(ahas213), .cout(ahac213));
HALF_ADDER aha214(.a(st14[36]), .b(st15[32]) , .sum(ahas214), .cout(ahac214));
HALF_ADDER aha215(.a(st14[37]), .b(st15[33]) , .sum(ahas215), .cout(ahac215));
HALF_ADDER aha216(.a(st14[38]), .b(st15[34]) , .sum(ahas216), .cout(ahac216));

generate
        for (i = 0; i < 28; i = i + 1) begin:   for_s21
                FULL_ADDER fa21(.a(st13[i + 9]), .b(st14[i + 4]), .cin(st15[i]), .sum(fas21[i]), .cout(fac21[i]));
        end
endgenerate

assign st22 = {st14[43:39], ahas216, ahas215, ahas214, ahas213, ahas212, ahas211, ahas210, fas21, has213, has212, has211, has210, st13[4], st13[3], st13[2], st13[1], st13[0]};
assign st23 = {ahac216, ahac215, ahac214, ahac213, ahac212, ahac211, ahac210, fac21, hac213, hac212, hac211, hac210};

assign st24 = st16;
assign st25 = st17;



/*wire [63:0] cst2;
assign cst2=st20+{st21,3'b000}+{st22,11'b00000000000}+{st23,17'b00000000000000000}+{st24,25'b0000000000000000000000000}+{st25,29'b00000000000000000000000000000};
assign product=cst2;*/

//******************** STAGE 4 of Wallace Tree********************//**//*
wire has300;
wire has301;
wire has302;
wire has303;
wire has304;
wire has305;
wire has306;
wire has307;

wire hac300;
wire hac301;
wire hac302;
wire hac303;
wire hac304;
wire hac305;
wire hac306;
wire hac307;

wire ahas300;
wire ahas301;
wire ahas302;
wire ahas303;
wire ahas304;
wire ahas305;
wire ahas306;
wire ahas307;
wire ahas308;
wire ahas309;
wire ahas3010;

wire ahac300;
wire ahac301;
wire ahac302;
wire ahac303;
wire ahac304;
wire ahac305;
wire ahac306;
wire ahac307;
wire ahac308;
wire ahac309;
wire ahac3010;

wire has310;
wire has311;
wire has312;
wire has313;

wire hac310;
wire hac311;
wire hac312;
wire hac313;

wire ahas310;
wire ahas311;
wire ahas312;
wire ahas313;
wire ahas314;
wire ahas315;
wire ahas316;
wire ahas317;

wire ahac310;
wire ahac311;
wire ahac312;
wire ahac313;
wire ahac314;
wire ahac315;
wire ahac316;
wire ahac317;

wire [37:0] fas30;
wire [37:0] fac30;

wire [26:0] fas31;
wire [26:0] fac31;

wire [63:0] st30;
wire [56:0] st31;
wire [46:0] st32;
wire [37:0] st33;

HALF_ADDER ha300(.a(st20[3]), .b(st21[0]) , .sum(has300), .cout(hac300));
HALF_ADDER ha301(.a(st20[4]), .b(st21[1]) , .sum(has301), .cout(hac301));
HALF_ADDER ha302(.a(st20[5]), .b(st21[2]) , .sum(has302), .cout(hac302));
HALF_ADDER ha303(.a(st20[6]), .b(st21[3]) , .sum(has303), .cout(hac303));
HALF_ADDER ha304(.a(st20[7]), .b(st21[4]) , .sum(has304), .cout(hac304));
HALF_ADDER ha305(.a(st20[8]), .b(st21[5]) , .sum(has305), .cout(hac305));
HALF_ADDER ha306(.a(st20[9]), .b(st21[6]) , .sum(has306), .cout(hac306));
HALF_ADDER ha307(.a(st20[10]), .b(st21[7]) , .sum(has307), .cout(hac307));

HALF_ADDER aha300(.a(st20[49]), .b(st22[38]) , .sum(ahas300), .cout(ahac300));
HALF_ADDER aha301(.a(st20[50]), .b(st22[39]) , .sum(ahas301), .cout(ahac301));
HALF_ADDER aha302(.a(st20[51]), .b(st22[40]) , .sum(ahas302), .cout(ahac302));
HALF_ADDER aha303(.a(st20[52]), .b(st22[41]) , .sum(ahas303), .cout(ahac303));
HALF_ADDER aha304(.a(st20[53]), .b(st22[42]) , .sum(ahas304), .cout(ahac304));
HALF_ADDER aha305(.a(st20[54]), .b(st22[43]) , .sum(ahas305), .cout(ahac305));
HALF_ADDER aha306(.a(st20[55]), .b(st22[44]) , .sum(ahas306), .cout(ahac306));
HALF_ADDER aha307(.a(st20[56]), .b(st22[45]) , .sum(ahas307), .cout(ahac307));
HALF_ADDER aha308(.a(st20[57]), .b(st22[46]) , .sum(ahas308), .cout(ahac308));
HALF_ADDER aha309(.a(st20[58]), .b(st22[47]) , .sum(ahas309), .cout(ahac309));
HALF_ADDER aha3010(.a(st20[59]), .b(st22[48]) , .sum(ahas3010), .cout(ahac3010));

generate
	for (i = 0; i < 38; i = i + 1) begin:	for_s30
		FULL_ADDER fa30(.a(st20[i + 11]), .b(st21[i + 8]), .cin(st22[i]), .sum(fas30[i]), .cout(fac30[i]));
	end
endgenerate

assign st30 = {st20[63:60], ahas3010,ahas309,ahas308,ahas307,ahas306,ahas305,ahas304,ahas303,ahas302,ahas301,ahas300,fas30, has307, has306, has305, has304, has303, has302, has301, has300, st20[2], st20[1], st20[0]};
assign st31 = {ahac3010,ahac309,ahac308,ahac307,ahac306,ahac305,ahac304,ahac303,ahac302,ahac301,ahac300,fac30, hac307, hac306, hac305, hac304, hac303, hac302, hac301, hac300};			

HALF_ADDER ha310(.a(st23[8]), .b(st24[0]) , .sum(has310), .cout(hac310));
HALF_ADDER ha311(.a(st23[9]), .b(st24[1]) , .sum(has311), .cout(hac311));
HALF_ADDER ha312(.a(st23[10]), .b(st24[2]) , .sum(has312), .cout(hac312));
HALF_ADDER ha313(.a(st23[11]), .b(st24[3]) , .sum(has313), .cout(hac313));

HALF_ADDER aha310(.a(st24[31]), .b(st25[27]) , .sum(ahas310), .cout(ahac310));
HALF_ADDER aha311(.a(st24[32]), .b(st25[28]) , .sum(ahas311), .cout(ahac311));
HALF_ADDER aha312(.a(st24[33]), .b(st25[29]) , .sum(ahas312), .cout(ahac312));
HALF_ADDER aha313(.a(st24[34]), .b(st25[30]) , .sum(ahas313), .cout(ahac313));
HALF_ADDER aha314(.a(st24[35]), .b(st25[31]) , .sum(ahas314), .cout(ahac314));
HALF_ADDER aha315(.a(st24[36]), .b(st25[32]) , .sum(ahas315), .cout(ahac315));
HALF_ADDER aha316(.a(st24[37]), .b(st25[33]) , .sum(ahas316), .cout(ahac316));
HALF_ADDER aha317(.a(st24[38]), .b(st25[34]) , .sum(ahas317), .cout(ahac317));

generate
        for (i = 0; i < 27; i = i + 1) begin:   for_s31
                FULL_ADDER fa31(.a(st23[i + 12]), .b(st24[i + 4]), .cin(st25[i]), .sum(fas31[i]), .cout(fac31[i]));
        end
endgenerate

assign st32 = {ahas317,ahas316,ahas315,ahas314,ahas313,ahas312,ahas311,ahas310,fas31,  has313, has312, has311, has310, st23[7], st23[6], st23[5], st23[4], st23[3], st23[2], st23[1], st23[0]};
assign st33 = {ahac317,ahac316,ahac315,ahac314,ahac313,ahac312,ahac311,ahac310,fac31, hac313, hac312, hac311, hac310};


/*wire [63:0] cst3;
assign cst3=st30+{st31,4'b0000}+{st32,17'b00000000000000000}+{st33,26'b00000000000000000000000000};
assign product=cst3;*/


//******************** STAGE 5 of Wallace Tree  ********************//**//*

wire has400;
wire has401;
wire has402;
wire has403;
wire has404;
wire has405;
wire has406;
wire has407;
wire has408;
wire has409;
wire has4010;
wire has4011;
wire has4012;

wire hac400;
wire hac401;
wire hac402;
wire hac403;
wire hac404;
wire hac405;
wire hac406;
wire hac407;
wire hac408;
wire hac409;
wire hac4010;
wire hac4011;
wire hac4012;

wire ahas400;
wire ahas401;
wire ahas402;
wire ahac400;
wire ahac401;
wire ahac402;

wire [43:0] fas40;
wire [43:0] fac40;

wire [63:0] st40;
wire [58:0] st41;
wire [37:0] st42;

HALF_ADDER ha400(.a(st30[4]), .b(st31[0]) , .sum(has400), .cout(hac400));
HALF_ADDER ha401(.a(st30[5]), .b(st31[1]) , .sum(has401), .cout(hac401));
HALF_ADDER ha402(.a(st30[6]), .b(st31[2]) , .sum(has402), .cout(hac402));
HALF_ADDER ha403(.a(st30[7]), .b(st31[3]) , .sum(has403), .cout(hac403));
HALF_ADDER ha404(.a(st30[8]), .b(st31[4]) , .sum(has404), .cout(hac404));
HALF_ADDER ha405(.a(st30[9]), .b(st31[5]) , .sum(has405), .cout(hac405));
HALF_ADDER ha406(.a(st30[10]), .b(st31[6]) , .sum(has406), .cout(hac406));
HALF_ADDER ha407(.a(st30[11]), .b(st31[7]) , .sum(has407), .cout(hac407));
HALF_ADDER ha408(.a(st30[12]), .b(st31[8]) , .sum(has408), .cout(hac408));
HALF_ADDER ha409(.a(st30[13]), .b(st31[9]) , .sum(has409), .cout(hac409));
HALF_ADDER ha4010(.a(st30[14]), .b(st31[10]) , .sum(has4010), .cout(hac4010));
HALF_ADDER ha4011(.a(st30[15]), .b(st31[11]) , .sum(has4011), .cout(hac4011));
HALF_ADDER ha4012(.a(st30[16]), .b(st31[12]) , .sum(has4012), .cout(hac4012));

HALF_ADDER aha400(.a(st30[61]), .b(st32[44]) , .sum(ahas400), .cout(ahac400));
HALF_ADDER aha401(.a(st30[62]), .b(st32[45]) , .sum(ahas401), .cout(ahac401));
HALF_ADDER aha402(.a(st30[63]), .b(st32[46]) , .sum(ahas402), .cout(ahac402));

generate
	for (i = 0; i < 44; i = i + 1) begin:	for_as40
        FULL_ADDER fa40(.a(st30[i + 17]), .b(st31[i + 13]), .cin(st32[i]), .sum(fas40[i]), .cout(fac40[i]));
	end
endgenerate

assign st40={ahas402, ahas401, ahas400, fas40, has4012, has4011, has4010, has409, has408, has407, has406, has405, has404, has403, has402, has401, has400, st30[3:0]};
assign st41={ ahac401, ahac400, fac40, hac4012, hac4011, hac4010, hac409, hac408, hac407, hac406, hac405, hac404, hac403, hac402, hac401, hac400};
assign st42=st33;


/*wire [63:0] cst4;
assign cst4=st40+{st41,5'b00000}+{st42,26'b00000000000000000000000000};
assign product=cst4;*/


//******************** STAGE 6 of Wallace Tree  ********************//**//*

wire has500;
wire has501;
wire has502;
wire has503;
wire has504;
wire has505;
wire has506;
wire has507;
wire has508;
wire has509;
wire has5010;
wire has5011;
wire has5012;
wire has5013;
wire has5014;
wire has5015;
wire has5016;
wire has5017;
wire has5018;
wire has5019;
wire has5020;

wire hac500;
wire hac501;
wire hac502;
wire hac503;
wire hac504;
wire hac505;
wire hac506;
wire hac507;
wire hac508;
wire hac509;
wire hac5010;
wire hac5011;
wire hac5012;
wire hac5013;
wire hac5014;
wire hac5015;
wire hac5016;
wire hac5017;
wire hac5018;
wire hac5019;
wire hac5020;

wire [37:0] fas50;
wire [37:0] fac50;

wire [63:0] st50;
wire [57:0] st51;

HALF_ADDER ha500(.a(st40[5]), .b(st41[0]) , .sum(has500), .cout(hac500));
HALF_ADDER ha501(.a(st40[6]), .b(st41[1]) , .sum(has501), .cout(hac501));
HALF_ADDER ha502(.a(st40[7]), .b(st41[2]) , .sum(has502), .cout(hac502));
HALF_ADDER ha503(.a(st40[8]), .b(st41[3]) , .sum(has503), .cout(hac503));
HALF_ADDER ha504(.a(st40[9]), .b(st41[4]) , .sum(has504), .cout(hac504));
HALF_ADDER ha505(.a(st40[10]), .b(st41[5]) , .sum(has505), .cout(hac505));
HALF_ADDER ha506(.a(st40[11]), .b(st41[6]) , .sum(has506), .cout(hac506));
HALF_ADDER ha507(.a(st40[12]), .b(st41[7]) , .sum(has507), .cout(hac507));
HALF_ADDER ha508(.a(st40[13]), .b(st41[8]) , .sum(has508), .cout(hac508));
HALF_ADDER ha509(.a(st40[14]), .b(st41[9]) , .sum(has509), .cout(hac509));
HALF_ADDER ha5010(.a(st40[15]), .b(st41[10]) , .sum(has5010), .cout(hac5010));
HALF_ADDER ha5011(.a(st40[16]), .b(st41[11]) , .sum(has5011), .cout(hac5011));
HALF_ADDER ha5012(.a(st40[17]), .b(st41[12]) , .sum(has5012), .cout(hac5012));
HALF_ADDER ha5013(.a(st40[18]), .b(st41[13]) , .sum(has5013), .cout(hac5013));
HALF_ADDER ha5014(.a(st40[19]), .b(st41[14]) , .sum(has5014), .cout(hac5014));
HALF_ADDER ha5015(.a(st40[20]), .b(st41[15]) , .sum(has5015), .cout(hac5015));
HALF_ADDER ha5016(.a(st40[21]), .b(st41[16]) , .sum(has5016), .cout(hac5016));
HALF_ADDER ha5017(.a(st40[22]), .b(st41[17]) , .sum(has5017), .cout(hac5017));
HALF_ADDER ha5018(.a(st40[23]), .b(st41[18]) , .sum(has5018), .cout(hac5018));
HALF_ADDER ha5019(.a(st40[24]), .b(st41[19]) , .sum(has5019), .cout(hac5019));
HALF_ADDER ha5020(.a(st40[25]), .b(st41[20]) , .sum(has5020), .cout(hac5020));

generate
        for (i = 0; i < 38; i = i + 1) begin:   for_as50
        FULL_ADDER fa50(.a(st40[i + 26]), .b(st41[i + 21]), .cin(st42[i]), .sum(fas50[i]), .cout(fac50[i]));
        end
endgenerate

assign st50={fas50,has5020, has5019, has5018, has5017, has5016, has5015, has5014, has5013, has5012, has5011, has5010, has509, has508, has507, has506, has505, has504, has503, has502, has501, has500, st40[4:0]};
assign st51={ fac50[36:0],hac5020, hac5019, hac5018, hac5017, hac5016, hac5015, hac5014, hac5013, hac5012, hac5011, hac5010, hac509, hac508, hac507, hac506, hac505, hac504, hac503, hac502, hac501, hac500};

/*wire [63:0] cst5;
assign cst5=st50+{st51,6'b000000};
assign product=cst5;*/

wire [63:0] SUM_reg;
wire [57:0] CARRY_reg;

assign SUM_reg=st50;
assign CARRY_reg=st51; 
wire  [57:0] OPA;
wire  [57:0] OPB;
wire CIN;
wire PHI;
wire [0:0] PBIT;
wire [57:0] CARRY;
assign CIN=1'b0;
assign PHI=1'b0;
wire [57:0]prod;

assign OPA=(SUM_reg[63:6]);

assign OPB=(CARRY_reg);

DBLCADDER_64_64 ADDER (.OPA(OPA) , .OPB(OPB) , .CIN (CIN) , .PHI (PHI) , .SUM(prod), .COUT() );

reg [(2*WIDTH)-1:0] pipereg;
reg [(2*WIDTH)-1:0] pipereg1;

always@(posedge CLK)
begin
pipereg <= {prod,SUM_reg[5:0]};
pipereg1 <= pipereg;
end

assign product=pipereg1 ;

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

module PRESTAGE_64 ( A, B, CIN, PHI, POUT, GOUT );
input  [57:0] A;
input  [57:0] B;
input  CIN;
input  PHI;
output [57:0] POUT;
output [58:0] GOUT;
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
   BLOCK0 U128 (A[28] , B[28] , PHI , POUT[28] , GOUT[29] );
   BLOCK0 U129 (A[29] , B[29] , PHI , POUT[29] , GOUT[30] );
   BLOCK0 U130 (A[30] , B[30] , PHI , POUT[30] , GOUT[31] );
   BLOCK0 U131 (A[31] , B[31] , PHI , POUT[31] , GOUT[32] );
   BLOCK0 U132 (A[32] , B[32] , PHI , POUT[32] , GOUT[33] );
   BLOCK0 U133 (A[33] , B[33] , PHI , POUT[33] , GOUT[34] );
   BLOCK0 U134 (A[34] , B[34] , PHI , POUT[34] , GOUT[35] );
   BLOCK0 U135 (A[35] , B[35] , PHI , POUT[35] , GOUT[36] );
   BLOCK0 U136 (A[36] , B[36] , PHI , POUT[36] , GOUT[37] );
   BLOCK0 U137 (A[37] , B[37] , PHI , POUT[37] , GOUT[38] );
   BLOCK0 U138 (A[38] , B[38] , PHI , POUT[38] , GOUT[39] );
   BLOCK0 U139 (A[39] , B[39] , PHI , POUT[39] , GOUT[40] );
   BLOCK0 U140 (A[40] , B[40] , PHI , POUT[40] , GOUT[41] );
   BLOCK0 U141 (A[41] , B[41] , PHI , POUT[41] , GOUT[42] );
   BLOCK0 U142 (A[42] , B[42] , PHI , POUT[42] , GOUT[43] );
   BLOCK0 U143 (A[43] , B[43] , PHI , POUT[43] , GOUT[44] );
   BLOCK0 U144 (A[44] , B[44] , PHI , POUT[44] , GOUT[45] );
   BLOCK0 U145 (A[45] , B[45] , PHI , POUT[45] , GOUT[46] );
   BLOCK0 U146 (A[46] , B[46] , PHI , POUT[46] , GOUT[47] );
   BLOCK0 U147 (A[47] , B[47] , PHI , POUT[47] , GOUT[48] );
   BLOCK0 U148 (A[48] , B[48] , PHI , POUT[48] , GOUT[49] );
   BLOCK0 U149 (A[49] , B[49] , PHI , POUT[49] , GOUT[50] );
   BLOCK0 U150 (A[50] , B[50] , PHI , POUT[50] , GOUT[51] );
   BLOCK0 U151 (A[51] , B[51] , PHI , POUT[51] , GOUT[52] );
   BLOCK0 U152 (A[52] , B[52] , PHI , POUT[52] , GOUT[53] );
   BLOCK0 U153 (A[53] , B[53] , PHI , POUT[53] , GOUT[54] );
   BLOCK0 U154 (A[54] , B[54] , PHI , POUT[54] , GOUT[55] );
   BLOCK0 U155 (A[55] , B[55] , PHI , POUT[55] , GOUT[56] );
   BLOCK0 U156 (A[56] , B[56] , PHI , POUT[56] , GOUT[57] );
   BLOCK0 U157 (A[57] , B[57] , PHI , POUT[57] , GOUT[58] );
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule


module DBLC_0_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [57:0] PIN;
input  [58:0] GIN;
input  PHI;
output [56:0] POUT;
output [58:0] GOUT;
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
   BLOCK1 U329 (PIN[27] , PIN[28] , GIN[28] , GIN[29] , PHI , POUT[27] , GOUT[29] );
   BLOCK1 U330 (PIN[28] , PIN[29] , GIN[29] , GIN[30] , PHI , POUT[28] , GOUT[30] );
   BLOCK1 U331 (PIN[29] , PIN[30] , GIN[30] , GIN[31] , PHI , POUT[29] , GOUT[31] );
   BLOCK1 U332 (PIN[30] , PIN[31] , GIN[31] , GIN[32] , PHI , POUT[30] , GOUT[32] );
   BLOCK1 U333 (PIN[31] , PIN[32] , GIN[32] , GIN[33] , PHI , POUT[31] , GOUT[33] );
   BLOCK1 U334 (PIN[32] , PIN[33] , GIN[33] , GIN[34] , PHI , POUT[32] , GOUT[34] );
   BLOCK1 U335 (PIN[33] , PIN[34] , GIN[34] , GIN[35] , PHI , POUT[33] , GOUT[35] );
   BLOCK1 U336 (PIN[34] , PIN[35] , GIN[35] , GIN[36] , PHI , POUT[34] , GOUT[36] );
   BLOCK1 U337 (PIN[35] , PIN[36] , GIN[36] , GIN[37] , PHI , POUT[35] , GOUT[37] );
   BLOCK1 U338 (PIN[36] , PIN[37] , GIN[37] , GIN[38] , PHI , POUT[36] , GOUT[38] );
   BLOCK1 U339 (PIN[37] , PIN[38] , GIN[38] , GIN[39] , PHI , POUT[37] , GOUT[39] );
   BLOCK1 U340 (PIN[38] , PIN[39] , GIN[39] , GIN[40] , PHI , POUT[38] , GOUT[40] );
   BLOCK1 U341 (PIN[39] , PIN[40] , GIN[40] , GIN[41] , PHI , POUT[39] , GOUT[41] );
   BLOCK1 U342 (PIN[40] , PIN[41] , GIN[41] , GIN[42] , PHI , POUT[40] , GOUT[42] );
   BLOCK1 U343 (PIN[41] , PIN[42] , GIN[42] , GIN[43] , PHI , POUT[41] , GOUT[43] );
   BLOCK1 U344 (PIN[42] , PIN[43] , GIN[43] , GIN[44] , PHI , POUT[42] , GOUT[44] );
   BLOCK1 U345 (PIN[43] , PIN[44] , GIN[44] , GIN[45] , PHI , POUT[43] , GOUT[45] );
   BLOCK1 U346 (PIN[44] , PIN[45] , GIN[45] , GIN[46] , PHI , POUT[44] , GOUT[46] );
   BLOCK1 U347 (PIN[45] , PIN[46] , GIN[46] , GIN[47] , PHI , POUT[45] , GOUT[47] );
   BLOCK1 U348 (PIN[46] , PIN[47] , GIN[47] , GIN[48] , PHI , POUT[46] , GOUT[48] );
   BLOCK1 U349 (PIN[47] , PIN[48] , GIN[48] , GIN[49] , PHI , POUT[47] , GOUT[49] );
   BLOCK1 U350 (PIN[48] , PIN[49] , GIN[49] , GIN[50] , PHI , POUT[48] , GOUT[50] );
   BLOCK1 U351 (PIN[49] , PIN[50] , GIN[50] , GIN[51] , PHI , POUT[49] , GOUT[51] );
   BLOCK1 U352 (PIN[50] , PIN[51] , GIN[51] , GIN[52] , PHI , POUT[50] , GOUT[52] );
   BLOCK1 U353 (PIN[51] , PIN[52] , GIN[52] , GIN[53] , PHI , POUT[51] , GOUT[53] );
   BLOCK1 U354 (PIN[52] , PIN[53] , GIN[53] , GIN[54] , PHI , POUT[52] , GOUT[54] );
   BLOCK1 U355 (PIN[53] , PIN[54] , GIN[54] , GIN[55] , PHI , POUT[53] , GOUT[55] );
   BLOCK1 U356 (PIN[54] , PIN[55] , GIN[55] , GIN[56] , PHI , POUT[54] , GOUT[56] );
   BLOCK1 U357 (PIN[55] , PIN[56] , GIN[56] , GIN[57] , PHI , POUT[55] , GOUT[57] );
   BLOCK1 U358 (PIN[56] , PIN[57] , GIN[57] , GIN[58] , PHI , POUT[56] , GOUT[58] );
endmodule


module DBLC_1_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [56:0] PIN;
input  [58:0] GIN;
input  PHI;
output [54:0] POUT;
output [58:0] GOUT;
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
   BLOCK2 U329 (PIN[25] , PIN[27] , GIN[27] , GIN[29] , PHI , POUT[25] , GOUT[29] );
   BLOCK2 U330 (PIN[26] , PIN[28] , GIN[28] , GIN[30] , PHI , POUT[26] , GOUT[30] );
   BLOCK2 U331 (PIN[27] , PIN[29] , GIN[29] , GIN[31] , PHI , POUT[27] , GOUT[31] );
   BLOCK2 U332 (PIN[28] , PIN[30] , GIN[30] , GIN[32] , PHI , POUT[28] , GOUT[32] );
   BLOCK2 U333 (PIN[29] , PIN[31] , GIN[31] , GIN[33] , PHI , POUT[29] , GOUT[33] );
   BLOCK2 U334 (PIN[30] , PIN[32] , GIN[32] , GIN[34] , PHI , POUT[30] , GOUT[34] );
   BLOCK2 U335 (PIN[31] , PIN[33] , GIN[33] , GIN[35] , PHI , POUT[31] , GOUT[35] );
   BLOCK2 U336 (PIN[32] , PIN[34] , GIN[34] , GIN[36] , PHI , POUT[32] , GOUT[36] );
   BLOCK2 U337 (PIN[33] , PIN[35] , GIN[35] , GIN[37] , PHI , POUT[33] , GOUT[37] );
   BLOCK2 U338 (PIN[34] , PIN[36] , GIN[36] , GIN[38] , PHI , POUT[34] , GOUT[38] );
   BLOCK2 U339 (PIN[35] , PIN[37] , GIN[37] , GIN[39] , PHI , POUT[35] , GOUT[39] );
   BLOCK2 U340 (PIN[36] , PIN[38] , GIN[38] , GIN[40] , PHI , POUT[36] , GOUT[40] );
   BLOCK2 U341 (PIN[37] , PIN[39] , GIN[39] , GIN[41] , PHI , POUT[37] , GOUT[41] );
   BLOCK2 U342 (PIN[38] , PIN[40] , GIN[40] , GIN[42] , PHI , POUT[38] , GOUT[42] );
   BLOCK2 U343 (PIN[39] , PIN[41] , GIN[41] , GIN[43] , PHI , POUT[39] , GOUT[43] );
   BLOCK2 U344 (PIN[40] , PIN[42] , GIN[42] , GIN[44] , PHI , POUT[40] , GOUT[44] );
   BLOCK2 U345 (PIN[41] , PIN[43] , GIN[43] , GIN[45] , PHI , POUT[41] , GOUT[45] );
   BLOCK2 U346 (PIN[42] , PIN[44] , GIN[44] , GIN[46] , PHI , POUT[42] , GOUT[46] );
   BLOCK2 U347 (PIN[43] , PIN[45] , GIN[45] , GIN[47] , PHI , POUT[43] , GOUT[47] );
   BLOCK2 U348 (PIN[44] , PIN[46] , GIN[46] , GIN[48] , PHI , POUT[44] , GOUT[48] );
   BLOCK2 U349 (PIN[45] , PIN[47] , GIN[47] , GIN[49] , PHI , POUT[45] , GOUT[49] );
   BLOCK2 U350 (PIN[46] , PIN[48] , GIN[48] , GIN[50] , PHI , POUT[46] , GOUT[50] );
   BLOCK2 U351 (PIN[47] , PIN[49] , GIN[49] , GIN[51] , PHI , POUT[47] , GOUT[51] );
   BLOCK2 U352 (PIN[48] , PIN[50] , GIN[50] , GIN[52] , PHI , POUT[48] , GOUT[52] );
   BLOCK2 U353 (PIN[49] , PIN[51] , GIN[51] , GIN[53] , PHI , POUT[49] , GOUT[53] );
   BLOCK2 U354 (PIN[50] , PIN[52] , GIN[52] , GIN[54] , PHI , POUT[50] , GOUT[54] );
   BLOCK2 U355 (PIN[51] , PIN[53] , GIN[53] , GIN[55] , PHI , POUT[51] , GOUT[55] );
   BLOCK2 U356 (PIN[52] , PIN[54] , GIN[54] , GIN[56] , PHI , POUT[52] , GOUT[56] );
   BLOCK2 U357 (PIN[53] , PIN[55] , GIN[55] , GIN[57] , PHI , POUT[53] , GOUT[57] );
   BLOCK2 U358 (PIN[54] , PIN[56] , GIN[56] , GIN[58] , PHI , POUT[54] , GOUT[58] );
endmodule


module DBLC_2_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [54:0] PIN;
input  [58:0] GIN;
input  PHI;
output [50:0] POUT;
output [58:0] GOUT;
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
   BLOCK1 U329 (PIN[21] , PIN[25] , GIN[25] , GIN[29] , PHI , POUT[21] , GOUT[29] );
   BLOCK1 U330 (PIN[22] , PIN[26] , GIN[26] , GIN[30] , PHI , POUT[22] , GOUT[30] );
   BLOCK1 U331 (PIN[23] , PIN[27] , GIN[27] , GIN[31] , PHI , POUT[23] , GOUT[31] );
   BLOCK1 U332 (PIN[24] , PIN[28] , GIN[28] , GIN[32] , PHI , POUT[24] , GOUT[32] );
   BLOCK1 U333 (PIN[25] , PIN[29] , GIN[29] , GIN[33] , PHI , POUT[25] , GOUT[33] );
   BLOCK1 U334 (PIN[26] , PIN[30] , GIN[30] , GIN[34] , PHI , POUT[26] , GOUT[34] );
   BLOCK1 U335 (PIN[27] , PIN[31] , GIN[31] , GIN[35] , PHI , POUT[27] , GOUT[35] );
   BLOCK1 U336 (PIN[28] , PIN[32] , GIN[32] , GIN[36] , PHI , POUT[28] , GOUT[36] );
   BLOCK1 U337 (PIN[29] , PIN[33] , GIN[33] , GIN[37] , PHI , POUT[29] , GOUT[37] );
   BLOCK1 U338 (PIN[30] , PIN[34] , GIN[34] , GIN[38] , PHI , POUT[30] , GOUT[38] );
   BLOCK1 U339 (PIN[31] , PIN[35] , GIN[35] , GIN[39] , PHI , POUT[31] , GOUT[39] );
   BLOCK1 U340 (PIN[32] , PIN[36] , GIN[36] , GIN[40] , PHI , POUT[32] , GOUT[40] );
   BLOCK1 U341 (PIN[33] , PIN[37] , GIN[37] , GIN[41] , PHI , POUT[33] , GOUT[41] );
   BLOCK1 U342 (PIN[34] , PIN[38] , GIN[38] , GIN[42] , PHI , POUT[34] , GOUT[42] );
   BLOCK1 U343 (PIN[35] , PIN[39] , GIN[39] , GIN[43] , PHI , POUT[35] , GOUT[43] );
   BLOCK1 U344 (PIN[36] , PIN[40] , GIN[40] , GIN[44] , PHI , POUT[36] , GOUT[44] );
   BLOCK1 U345 (PIN[37] , PIN[41] , GIN[41] , GIN[45] , PHI , POUT[37] , GOUT[45] );
   BLOCK1 U346 (PIN[38] , PIN[42] , GIN[42] , GIN[46] , PHI , POUT[38] , GOUT[46] );
   BLOCK1 U347 (PIN[39] , PIN[43] , GIN[43] , GIN[47] , PHI , POUT[39] , GOUT[47] );
   BLOCK1 U348 (PIN[40] , PIN[44] , GIN[44] , GIN[48] , PHI , POUT[40] , GOUT[48] );
   BLOCK1 U349 (PIN[41] , PIN[45] , GIN[45] , GIN[49] , PHI , POUT[41] , GOUT[49] );
   BLOCK1 U350 (PIN[42] , PIN[46] , GIN[46] , GIN[50] , PHI , POUT[42] , GOUT[50] );
   BLOCK1 U351 (PIN[43] , PIN[47] , GIN[47] , GIN[51] , PHI , POUT[43] , GOUT[51] );
   BLOCK1 U352 (PIN[44] , PIN[48] , GIN[48] , GIN[52] , PHI , POUT[44] , GOUT[52] );
   BLOCK1 U353 (PIN[45] , PIN[49] , GIN[49] , GIN[53] , PHI , POUT[45] , GOUT[53] );
   BLOCK1 U354 (PIN[46] , PIN[50] , GIN[50] , GIN[54] , PHI , POUT[46] , GOUT[54] );
   BLOCK1 U355 (PIN[47] , PIN[51] , GIN[51] , GIN[55] , PHI , POUT[47] , GOUT[55] );
   BLOCK1 U356 (PIN[48] , PIN[52] , GIN[52] , GIN[56] , PHI , POUT[48] , GOUT[56] );
   BLOCK1 U357 (PIN[49] , PIN[53] , GIN[53] , GIN[57] , PHI , POUT[49] , GOUT[57] );
   BLOCK1 U358 (PIN[50] , PIN[54] , GIN[54] , GIN[58] , PHI , POUT[50] , GOUT[58] );
endmodule


module DBLC_3_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [50:0] PIN;
input  [58:0] GIN;
input  PHI;
output [42:0] POUT;
output [58:0] GOUT;
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
   BLOCK2 U329 (PIN[13] , PIN[21] , GIN[21] , GIN[29] , PHI , POUT[13] , GOUT[29] );
   BLOCK2 U330 (PIN[14] , PIN[22] , GIN[22] , GIN[30] , PHI , POUT[14] , GOUT[30] );
   BLOCK2 U331 (PIN[15] , PIN[23] , GIN[23] , GIN[31] , PHI , POUT[15] , GOUT[31] );
   BLOCK2 U332 (PIN[16] , PIN[24] , GIN[24] , GIN[32] , PHI , POUT[16] , GOUT[32] );
   BLOCK2 U333 (PIN[17] , PIN[25] , GIN[25] , GIN[33] , PHI , POUT[17] , GOUT[33] );
   BLOCK2 U334 (PIN[18] , PIN[26] , GIN[26] , GIN[34] , PHI , POUT[18] , GOUT[34] );
   BLOCK2 U335 (PIN[19] , PIN[27] , GIN[27] , GIN[35] , PHI , POUT[19] , GOUT[35] );
   BLOCK2 U336 (PIN[20] , PIN[28] , GIN[28] , GIN[36] , PHI , POUT[20] , GOUT[36] );
   BLOCK2 U337 (PIN[21] , PIN[29] , GIN[29] , GIN[37] , PHI , POUT[21] , GOUT[37] );
   BLOCK2 U338 (PIN[22] , PIN[30] , GIN[30] , GIN[38] , PHI , POUT[22] , GOUT[38] );
   BLOCK2 U339 (PIN[23] , PIN[31] , GIN[31] , GIN[39] , PHI , POUT[23] , GOUT[39] );
   BLOCK2 U340 (PIN[24] , PIN[32] , GIN[32] , GIN[40] , PHI , POUT[24] , GOUT[40] );
   BLOCK2 U341 (PIN[25] , PIN[33] , GIN[33] , GIN[41] , PHI , POUT[25] , GOUT[41] );
   BLOCK2 U342 (PIN[26] , PIN[34] , GIN[34] , GIN[42] , PHI , POUT[26] , GOUT[42] );
   BLOCK2 U343 (PIN[27] , PIN[35] , GIN[35] , GIN[43] , PHI , POUT[27] , GOUT[43] );
   BLOCK2 U344 (PIN[28] , PIN[36] , GIN[36] , GIN[44] , PHI , POUT[28] , GOUT[44] );
   BLOCK2 U345 (PIN[29] , PIN[37] , GIN[37] , GIN[45] , PHI , POUT[29] , GOUT[45] );
   BLOCK2 U346 (PIN[30] , PIN[38] , GIN[38] , GIN[46] , PHI , POUT[30] , GOUT[46] );
   BLOCK2 U347 (PIN[31] , PIN[39] , GIN[39] , GIN[47] , PHI , POUT[31] , GOUT[47] );
   BLOCK2 U348 (PIN[32] , PIN[40] , GIN[40] , GIN[48] , PHI , POUT[32] , GOUT[48] );
   BLOCK2 U349 (PIN[33] , PIN[41] , GIN[41] , GIN[49] , PHI , POUT[33] , GOUT[49] );
   BLOCK2 U350 (PIN[34] , PIN[42] , GIN[42] , GIN[50] , PHI , POUT[34] , GOUT[50] );
   BLOCK2 U351 (PIN[35] , PIN[43] , GIN[43] , GIN[51] , PHI , POUT[35] , GOUT[51] );
   BLOCK2 U352 (PIN[36] , PIN[44] , GIN[44] , GIN[52] , PHI , POUT[36] , GOUT[52] );
   BLOCK2 U353 (PIN[37] , PIN[45] , GIN[45] , GIN[53] , PHI , POUT[37] , GOUT[53] );
   BLOCK2 U354 (PIN[38] , PIN[46] , GIN[46] , GIN[54] , PHI , POUT[38] , GOUT[54] );
   BLOCK2 U355 (PIN[39] , PIN[47] , GIN[47] , GIN[55] , PHI , POUT[39] , GOUT[55] );
   BLOCK2 U356 (PIN[40] , PIN[48] , GIN[48] , GIN[56] , PHI , POUT[40] , GOUT[56] );
   BLOCK2 U357 (PIN[41] , PIN[49] , GIN[49] , GIN[57] , PHI , POUT[41] , GOUT[57] );
   BLOCK2 U358 (PIN[42] , PIN[50] , GIN[50] , GIN[58] , PHI , POUT[42] , GOUT[58] );
endmodule


module DBLC_4_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [42:0] PIN;
input  [58:0] GIN;
input  PHI;
output [26:0] POUT;
output [58:0] GOUT;
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
   BLOCK1 U332 (PIN[0] , PIN[16] , GIN[16] , GIN[32] , PHI , POUT[0] , GOUT[32] );
   BLOCK1 U333 (PIN[1] , PIN[17] , GIN[17] , GIN[33] , PHI , POUT[1] , GOUT[33] );
   BLOCK1 U334 (PIN[2] , PIN[18] , GIN[18] , GIN[34] , PHI , POUT[2] , GOUT[34] );
   BLOCK1 U335 (PIN[3] , PIN[19] , GIN[19] , GIN[35] , PHI , POUT[3] , GOUT[35] );
   BLOCK1 U336 (PIN[4] , PIN[20] , GIN[20] , GIN[36] , PHI , POUT[4] , GOUT[36] );
   BLOCK1 U337 (PIN[5] , PIN[21] , GIN[21] , GIN[37] , PHI , POUT[5] , GOUT[37] );
   BLOCK1 U338 (PIN[6] , PIN[22] , GIN[22] , GIN[38] , PHI , POUT[6] , GOUT[38] );
   BLOCK1 U339 (PIN[7] , PIN[23] , GIN[23] , GIN[39] , PHI , POUT[7] , GOUT[39] );
   BLOCK1 U340 (PIN[8] , PIN[24] , GIN[24] , GIN[40] , PHI , POUT[8] , GOUT[40] );
   BLOCK1 U341 (PIN[9] , PIN[25] , GIN[25] , GIN[41] , PHI , POUT[9] , GOUT[41] );
   BLOCK1 U342 (PIN[10] , PIN[26] , GIN[26] , GIN[42] , PHI , POUT[10] , GOUT[42] );
   BLOCK1 U343 (PIN[11] , PIN[27] , GIN[27] , GIN[43] , PHI , POUT[11] , GOUT[43] );
   BLOCK1 U344 (PIN[12] , PIN[28] , GIN[28] , GIN[44] , PHI , POUT[12] , GOUT[44] );
   BLOCK1 U345 (PIN[13] , PIN[29] , GIN[29] , GIN[45] , PHI , POUT[13] , GOUT[45] );
   BLOCK1 U346 (PIN[14] , PIN[30] , GIN[30] , GIN[46] , PHI , POUT[14] , GOUT[46] );
   BLOCK1 U347 (PIN[15] , PIN[31] , GIN[31] , GIN[47] , PHI , POUT[15] , GOUT[47] );
   BLOCK1 U348 (PIN[16] , PIN[32] , GIN[32] , GIN[48] , PHI , POUT[16] , GOUT[48] );
   BLOCK1 U349 (PIN[17] , PIN[33] , GIN[33] , GIN[49] , PHI , POUT[17] , GOUT[49] );
   BLOCK1 U350 (PIN[18] , PIN[34] , GIN[34] , GIN[50] , PHI , POUT[18] , GOUT[50] );
   BLOCK1 U351 (PIN[19] , PIN[35] , GIN[35] , GIN[51] , PHI , POUT[19] , GOUT[51] );
   BLOCK1 U352 (PIN[20] , PIN[36] , GIN[36] , GIN[52] , PHI , POUT[20] , GOUT[52] );
   BLOCK1 U353 (PIN[21] , PIN[37] , GIN[37] , GIN[53] , PHI , POUT[21] , GOUT[53] );
   BLOCK1 U354 (PIN[22] , PIN[38] , GIN[38] , GIN[54] , PHI , POUT[22] , GOUT[54] );
   BLOCK1 U355 (PIN[23] , PIN[39] , GIN[39] , GIN[55] , PHI , POUT[23] , GOUT[55] );
   BLOCK1 U356 (PIN[24] , PIN[40] , GIN[40] , GIN[56] , PHI , POUT[24] , GOUT[56] );
   BLOCK1 U357 (PIN[25] , PIN[41] , GIN[41] , GIN[57] , PHI , POUT[25] , GOUT[57] );
   BLOCK1 U358 (PIN[26] , PIN[42] , GIN[42] , GIN[58] , PHI , POUT[26] , GOUT[58] );
endmodule


module DBLC_5_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [26:0] PIN;
input  [58:0] GIN;
input  PHI;
output [0:0] POUT;
output [58:0] GOUT;
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
   INVBLOCK U116 (GIN[16] , PHI , GOUT[16] );
   INVBLOCK U117 (GIN[17] , PHI , GOUT[17] );
   INVBLOCK U118 (GIN[18] , PHI , GOUT[18] );
   INVBLOCK U119 (GIN[19] , PHI , GOUT[19] );
   INVBLOCK U120 (GIN[20] , PHI , GOUT[20] );
   INVBLOCK U121 (GIN[21] , PHI , GOUT[21] );
   INVBLOCK U122 (GIN[22] , PHI , GOUT[22] );
   INVBLOCK U123 (GIN[23] , PHI , GOUT[23] );
   INVBLOCK U124 (GIN[24] , PHI , GOUT[24] );
   INVBLOCK U125 (GIN[25] , PHI , GOUT[25] );
   INVBLOCK U126 (GIN[26] , PHI , GOUT[26] );
   INVBLOCK U127 (GIN[27] , PHI , GOUT[27] );
   INVBLOCK U128 (GIN[28] , PHI , GOUT[28] );
   INVBLOCK U129 (GIN[29] , PHI , GOUT[29] );
   INVBLOCK U130 (GIN[30] , PHI , GOUT[30] );
   INVBLOCK U131 (GIN[31] , PHI , GOUT[31] );
   BLOCK2A U232 (PIN[0] , GIN[0] , GIN[32] , PHI , GOUT[32] );
   BLOCK2A U233 (PIN[1] , GIN[1] , GIN[33] , PHI , GOUT[33] );
   BLOCK2A U234 (PIN[2] , GIN[2] , GIN[34] , PHI , GOUT[34] );
   BLOCK2A U235 (PIN[3] , GIN[3] , GIN[35] , PHI , GOUT[35] );
   BLOCK2A U236 (PIN[4] , GIN[4] , GIN[36] , PHI , GOUT[36] );
   BLOCK2A U237 (PIN[5] , GIN[5] , GIN[37] , PHI , GOUT[37] );
   BLOCK2A U238 (PIN[6] , GIN[6] , GIN[38] , PHI , GOUT[38] );
   BLOCK2A U239 (PIN[7] , GIN[7] , GIN[39] , PHI , GOUT[39] );
   BLOCK2A U240 (PIN[8] , GIN[8] , GIN[40] , PHI , GOUT[40] );
   BLOCK2A U241 (PIN[9] , GIN[9] , GIN[41] , PHI , GOUT[41] );
   BLOCK2A U242 (PIN[10] , GIN[10] , GIN[42] , PHI , GOUT[42] );
   BLOCK2A U243 (PIN[11] , GIN[11] , GIN[43] , PHI , GOUT[43] );
   BLOCK2A U244 (PIN[12] , GIN[12] , GIN[44] , PHI , GOUT[44] );
   BLOCK2A U245 (PIN[13] , GIN[13] , GIN[45] , PHI , GOUT[45] );
   BLOCK2A U246 (PIN[14] , GIN[14] , GIN[46] , PHI , GOUT[46] );
   BLOCK2A U247 (PIN[15] , GIN[15] , GIN[47] , PHI , GOUT[47] );
   BLOCK2A U248 (PIN[16] , GIN[16] , GIN[48] , PHI , GOUT[48] );
   BLOCK2A U249 (PIN[17] , GIN[17] , GIN[49] , PHI , GOUT[49] );
   BLOCK2A U250 (PIN[18] , GIN[18] , GIN[50] , PHI , GOUT[50] );
   BLOCK2A U251 (PIN[19] , GIN[19] , GIN[51] , PHI , GOUT[51] );
   BLOCK2A U252 (PIN[20] , GIN[20] , GIN[52] , PHI , GOUT[52] );
   BLOCK2A U253 (PIN[21] , GIN[21] , GIN[53] , PHI , GOUT[53] );
   BLOCK2A U254 (PIN[22] , GIN[22] , GIN[54] , PHI , GOUT[54] );
   BLOCK2A U255 (PIN[23] , GIN[23] , GIN[55] , PHI , GOUT[55] );
   BLOCK2A U256 (PIN[24] , GIN[24] , GIN[56] , PHI , GOUT[56] );
   BLOCK2A U257 (PIN[25] , GIN[25] , GIN[57] , PHI , GOUT[57] );
   BLOCK2 U364 (PIN[0] , PIN[26] , GIN[26] , GIN[58] , PHI , POUT[0] , GOUT[58] );
endmodule


module XORSTAGE_64 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [57:0] A;
input  [57:0] B;
input  PBIT;
input  PHI;
input  [58:0] CARRY;
output [57:0] SUM;
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
   XXOR1 U228 (A[28] , B[28] , CARRY[28] , PHI , SUM[28] );
   XXOR1 U229 (A[29] , B[29] , CARRY[29] , PHI , SUM[29] );
   XXOR1 U230 (A[30] , B[30] , CARRY[30] , PHI , SUM[30] );
   XXOR1 U231 (A[31] , B[31] , CARRY[31] , PHI , SUM[31] );
   XXOR1 U232 (A[32] , B[32] , CARRY[32] , PHI , SUM[32] );
   XXOR1 U233 (A[33] , B[33] , CARRY[33] , PHI , SUM[33] );
   XXOR1 U234 (A[34] , B[34] , CARRY[34] , PHI , SUM[34] );
   XXOR1 U235 (A[35] , B[35] , CARRY[35] , PHI , SUM[35] );
   XXOR1 U236 (A[36] , B[36] , CARRY[36] , PHI , SUM[36] );
   XXOR1 U237 (A[37] , B[37] , CARRY[37] , PHI , SUM[37] );
   XXOR1 U238 (A[38] , B[38] , CARRY[38] , PHI , SUM[38] );
   XXOR1 U239 (A[39] , B[39] , CARRY[39] , PHI , SUM[39] );
   XXOR1 U240 (A[40] , B[40] , CARRY[40] , PHI , SUM[40] );
   XXOR1 U241 (A[41] , B[41] , CARRY[41] , PHI , SUM[41] );
   XXOR1 U242 (A[42] , B[42] , CARRY[42] , PHI , SUM[42] );
   XXOR1 U243 (A[43] , B[43] , CARRY[43] , PHI , SUM[43] );
   XXOR1 U244 (A[44] , B[44] , CARRY[44] , PHI , SUM[44] );
   XXOR1 U245 (A[45] , B[45] , CARRY[45] , PHI , SUM[45] );
   XXOR1 U246 (A[46] , B[46] , CARRY[46] , PHI , SUM[46] );
   XXOR1 U247 (A[47] , B[47] , CARRY[47] , PHI , SUM[47] );
   XXOR1 U248 (A[48] , B[48] , CARRY[48] , PHI , SUM[48] );
   XXOR1 U249 (A[49] , B[49] , CARRY[49] , PHI , SUM[49] );
   XXOR1 U250 (A[50] , B[50] , CARRY[50] , PHI , SUM[50] );
   XXOR1 U251 (A[51] , B[51] , CARRY[51] , PHI , SUM[51] );
   XXOR1 U252 (A[52] , B[52] , CARRY[52] , PHI , SUM[52] );
   XXOR1 U253 (A[53] , B[53] , CARRY[53] , PHI , SUM[53] );
   XXOR1 U254 (A[54] , B[54] , CARRY[54] , PHI , SUM[54] );
   XXOR1 U255 (A[55] , B[55] , CARRY[55] , PHI , SUM[55] );
   XXOR1 U256 (A[56] , B[56] , CARRY[56] , PHI , SUM[56] );
   XXOR1 U257 (A[57] , B[57] , CARRY[57] , PHI , SUM[57] );
   BLOCK1A U1 (PBIT , CARRY[0] , CARRY[58] , PHI , COUT );
endmodule


module DBLCTREE_64 ( PIN, GIN, PHI, GOUT, POUT );
input  [57:0] PIN;
input  [58:0] GIN;
input  PHI;
output [58:0] GOUT;
output [0:0] POUT;
   wire [56:0] INTPROP_0;
   wire [58:0] INTGEN_0;
   wire [54:0] INTPROP_1;
   wire [58:0] INTGEN_1;
   wire [50:0] INTPROP_2;
   wire [58:0] INTGEN_2;
   wire [42:0] INTPROP_3;
   wire [58:0] INTGEN_3;
   wire [26:0] INTPROP_4;
   wire [58:0] INTGEN_4;
   DBLC_0_64 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   DBLC_1_64 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_64 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_64 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(INTPROP_3) , .GOUT(INTGEN_3) );
   DBLC_4_64 U_4 (.PIN(INTPROP_3) , .GIN(INTGEN_3) , .PHI(PHI) , .POUT(INTPROP_4) , .GOUT(INTGEN_4) );
   DBLC_5_64 U_5 (.PIN(INTPROP_4) , .GIN(INTGEN_4) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule


module DBLCADDER_64_64 ( OPA, OPB, CIN, PHI, SUM, COUT );
input  [57:0] OPA;
input  [57:0] OPB;
input  CIN;
input  PHI;
output [57:0] SUM;
output COUT;
   wire [57:0] INTPROP;
   wire [58:0] INTGEN;
   wire [0:0] PBIT;
   wire [58:0] CARRY;
   PRESTAGE_64 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_64 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_64 U3 (OPA[57:0] , OPB[57:0] , PBIT[0] , PHI , CARRY[58:0] , SUM , COUT );
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

