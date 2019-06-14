`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2019 10:55:15 AM
// Design Name: 
// Module Name: mb8_radix8
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


module mb8_radix8 #(parameter WIDTH = 8)(
input wire [WIDTH-1:0] mx,
input wire [WIDTH-1:0] my,
input  wire [WIDTH+1:0] tmy,
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
//wire [WIDTH+1:0] tmy;
// 3Y Calculation
//assign tmy = my + (my<<1);


//Booth Encoding
genvar i, j;
generate
	for (j = 0; j < group_cnt; j = j + 1) begin: b_encoder
		case (j)
			1'b0: booth_encoder b_e0(.x({mx[2], mx[1], mx[0], 1'b0}), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]));
			2'b10: booth_encoder b_e2(.x({1'b0, mx[WIDTH - 1:WIDTH-3]}), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]));
			default : booth_encoder b_e1(.x({mx[(3*j) + 2],mx[(3*j) + 1], mx[3*j], mx[(3*j) -1]}), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]));

		endcase 
	end
endgenerate

// Booth selection------Partial Products generation
generate
    for (j = 0; j < group_cnt; j = j + 1) begin: b_selector 
        for (i = 0; i < WIDTH+1; i = i + 1) begin 
			case (i)
			1'b0: begin 
			         booth_sel bs(.y({my[i],2'b00}), .ty(tmy[i]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][i]));
			         booth_sel bs1(.y({my[i+1:i],1'b0}), .ty(tmy[i+1]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][i+1]));
			      end
			4'b1000: booth_sel bs(.y({2'b00, my[i-1]}), .ty(tmy[i+1]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][i+1]));  
			4'b0111: booth_sel bs(.y({1'b0, my[i:i-1]}), .ty(tmy[i+1]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][i+1]));  
			default : booth_sel bs(.y(my[i+1:i-1]), .ty(tmy[i+1]), .single(s[j]), .double(d[j]), .triple(t[j]), .quad(q[j]), .neg(n[j]), .p(epp2d[j][i+1]));
			endcase
		end	
end
endgenerate    

//Partial Products
assign fpp0 = {~n[0] , epp2d[0]};
assign fpp1 = {~n[1] , epp2d[1]};
assign fpp2 = {epp2d [2] [9:0]};

//Correction vector
wire [15:0]cv= {6'b110111,6'b000000,n[1],1'b0,1'b0,n[0]};

wire [15:0] cfpp1;
assign cfpp1= fpp0+{fpp1,3'b000}+{fpp2,6'b000000}+cv;
assign product=cfpp1; 


/**//******************** STAGE 1 of Wallace tree ********************//*
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

wire [4:0] fas0;
wire [4:0] fac0; 

wire [15:0] st00;
wire [10:0] st01;


half_adder ha0s0210(.a(fpp0[3]), .b(fpp1[0]) , .sum(has00), .cout(hac00));
half_adder ha0s0311(.a(fpp0[4]), .b(fpp1[1]) , .sum(has01), .cout(hac01));
half_adder ha0s0211(.a(fpp0[5]), .b(fpp1[2]) , .sum(has02), .cout(hac02));

half_adder aha0s0210(.a(fpp1[8]), .b(fpp2[5]) , .sum(ahas00), .cout(ahac00));
half_adder aha0s0311(.a(fpp1[9]), .b(fpp2[6]) , .sum(ahas01), .cout(ahac01));
half_adder aha0s0312(.a(fpp1[10]), .b(fpp2[7]) , .sum(ahas02), .cout(ahac02));

generate
	for (i = 0; i < 5; i = i + 1) begin:	for_s0 
		full_adder fa000(.a(fpp0[i + 6]), .b(fpp1[i + 3]), .cin(fpp2[i]), .sum(fas0[i]), .cout(fac0[i]));
	end
endgenerate

assign st00 = {fpp2[9], fpp2[8],ahas02,ahas01,ahas00,fas0, has02, has01, has00, fpp0[2], fpp0[1], fpp0[0]};	
assign st01 = {ahac02, ahac01, ahac00, fac0, hac02, hac01, hac00};				 

*//*wire [15:0] cfpp1;
assign cfpp1= st00+{st01,4'b0000}+cv;
assign product=cfpp1; *//*

*//******************** STAGE 2 of Wallace tree********************//*
wire ha1ss00;
wire ha1ss01;
wire ha1ss02;
wire ha1ss03;
wire ha1sc00;
wire ha1sc01;
wire ha1sc02;
wire ha1sc03;
wire ha1ss10;
wire ha1sc10;

wire [10:0] fa1ss0;
wire [10:0] fa1sc0;

wire [15:0] st10;
wire [14:0] st11;

half_adder ha1s0310(.a(st00[0]), .b(cv[0]) , .sum(ha1ss00), .cout(ha1sc00));
half_adder ha1s0411(.a(st00[1]), .b(cv[1]) , .sum(ha1ss01), .cout(ha1sc01));
half_adder ha1s0512(.a(st00[2]), .b(cv[2]) , .sum(ha1ss02), .cout(ha1sc02));
half_adder ha1s0513(.a(st00[3]), .b(cv[3]) , .sum(ha1ss03), .cout(ha1sc03));

half_adder aha1s0512(.a(st00[15]), .b(cv[15]) , .sum(ha1ss10), .cout(ha1sc10));

generate
	for (i = 0; i < 11; i = i + 1) begin:	for_s3
		full_adder fa03(.a(st00[i + 4]), .b(st01[i ]), .cin(cv[i+4]), .sum(fa1ss0[i]), .cout(fa1sc0[i]));
	end
endgenerate



assign st10 = {ha1ss10,fa1ss0, ha1ss03, ha1ss02, ha1ss01, ha1ss00};	// 19 bit
assign st11 = {fa1sc0, ha1sc03, ha1sc02, ha1sc01, ha1sc00};						// 16 bit

*//*wire [15:0] cfpp1;
assign cfpp1= st10+{st11,1'b0};
assign product=cfpp1; 
*//*

*//******************** Ripple Carry Adder to generate product bits ********************//*

wire [14:0] fa4ss0;
 wire [14:0] fa4sc0;
wire [15:0] st40;
full_adder fa07(.a(st10[1]), .b(st11[0]), .cin(1'b0), .sum(fa4ss0[0]), .cout(fa4sc0[0]));

generate
	for (i = 0; i < 14; i = i + 1) begin:	for_s7
		full_adder fa08(.a(st10[i + 2]), .b(st11[i + 1]), .cin(fa4sc0[i]), .sum(fa4ss0[i+1]), .cout(fa4sc0[i + 1]));
	end
endgenerate

assign st40 = {fa4ss0, st10[0]};
assign product = st40;
*/
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
wire w6;
wire w7;
wire w8;
wire w9;
wire w10;


assign neg=x[3];

xor  xor0(w0, x[0], x[1]);
xor  xor1(w1, x[1], x[2]);
xor  xor2(w2, x[2], x[3]);

not  not0(w3, w0);
not  not1(w4, w1);
not  not2(w5, w2);

or  or0(w6, w3, w2);
not not3(single,w6);
or  or1(w7, w3, w5);
not not4(triple,w7);
or  or2(w8, w0, w4);
not not5(double,w8);
or  or3(w9, w1, w5);
or  or4(w10, w0, w9);
not not6(quad,w10);

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
module full_adder(a,b,cin,sum, cout);
input a;
input b;
input cin;
output sum;
output cout;
wire x; 
wire y;
wire z;
half_adder h1(.a(a), .b(b), .sum(x), .cout(y));
half_adder h2(.a(x), .b(cin), .sum(sum), .cout(z));
or or_1(cout,z,y);
endmodule
 
/******************** 1 bit Half Adder ********************/
module half_adder( a,b, sum, cout );
input a;
input b;
output sum;
output cout;
xor xor_1 (sum,a,b);
and and_1 (cout,a,b);
endmodule
