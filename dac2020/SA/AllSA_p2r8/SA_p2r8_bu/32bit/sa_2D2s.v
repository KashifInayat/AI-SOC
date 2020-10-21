`timescale 1ns / 10ps
module sa_2D( AA, BB, CLK, RST, Y);

parameter HPE=64;  // step 1 horizontal processing elements
parameter VPE=64;  // vertical processing elements

parameter WIDTH=32;   // step 2 operands width  
`define P_W 64        // outputs width  
`define M_W 32        // width 
parameter group_cnt=(WIDTH>>2)+3;     // no of groups

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


module pre_process_TMY #(parameter WIDTH = 32)(
input [WIDTH-1:0] my,
input CLK,
input RST,
output reg [WIDTH-1:0] my_out,
output reg [WIDTH+1:0] TMY);
`define TMY_W 34        // outputs width  
`define M_W 32        // width 
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

module pre_process_be #(parameter WIDTH = 32)(mx, CLK, sr, dr, tr, qr, nr);
    
parameter group_cnt=(WIDTH>>2)+3; 

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
	    booth_encoder b_e5(.x({mx[17],mx[16], mx[15], mx[14]}), .single(s[5]), .double(d[5]), .triple(t[5]), .quad(q[5]), .neg(n[5]));
            booth_encoder b_e6(.x({mx[20],mx[19], mx[18], mx[17]}), .single(s[6]), .double(d[6]), .triple(t[6]), .quad(q[6]), .neg(n[6]));
	    booth_encoder b_e7(.x({mx[23],mx[22], mx[21], mx[20]}), .single(s[7]), .double(d[7]), .triple(t[7]), .quad(q[7]), .neg(n[7]));
	    booth_encoder b_e8(.x({mx[26],mx[25], mx[24], mx[23]}), .single(s[8]), .double(d[8]), .triple(t[8]), .quad(q[8]), .neg(n[8]));
	    booth_encoder b_e9(.x({mx[29],mx[28], mx[27], mx[26]}), .single(s[9]), .double(d[9]), .triple(t[9]), .quad(q[9]), .neg(n[9]));
	    booth_encoder b_e10(.x({1'b0,mx[31], mx[30], mx[29]}), .single(s[10]), .double(d[10]), .triple(t[10]), .quad(q[10]), .neg(n[10]));
    
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



