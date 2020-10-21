`timescale 1ns / 10ps
module sa_2D(AA, BB, CLK, RST, Y );
//Inorder to change the size of the Systolic Array:
// 1. Change the values of the parameters HPE (Horizontal processing elements) and VPE (Vertical processing elements)
// 2. Inorder to instantiate the last row of processing elements we have to mention its index manually in the line 64 and 72.

parameter HPE=64;  // step 1 horizontal processing elements
parameter VPE=64;  // vertical processing elements
parameter WIDTH=32;   // step 2 operands width  
`define P_W 64        // outputs width  
`define M_W 32        // width
 
parameter group_cnt=(WIDTH>>1)+1;   // no of groups

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

wire [WIDTH-1:0] A_OUT[0:VPE-1][0:HPE-1];
wire [WIDTH-1:0] B_OUT[0:VPE-2][0:HPE-1];

wire [WIDTH*2-1:0] Y_OUT[0:VPE-1][0:HPE-1];


genvar i,j;
generate
    for (j = 0; j < HPE; j = j + 1) begin: outputs
        for (i = 0; i < VPE; i = i + 1) begin : outputs1
         assign Y[((((HPE*VPE)-((j*HPE)+i))*(WIDTH*2))-1) : ((((HPE*VPE)-((j*HPE)+(i+1)))*(WIDTH*2)))]=Y_OUT[j][i];
        end
        end
endgenerate        
      

// First Row of Processing Elements
PE_OS_16 PE00(.X(Ain[0]), .Y(Bin[0]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[0][0]), .Y_OUT(B_OUT[0][0]), .MAC_OUT(Y_OUT[0][0]) );
genvar k; 
generate
	for (k = 1; k < HPE; k = k + 1) begin: first_column
    PE_OS_16 PE01(.X(A_OUT[0][k-1]), .Y(Bin[k]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[0][k]), .Y_OUT(B_OUT[0][k]), .MAC_OUT(Y_OUT[0][k]) );
    end
endgenerate 



// First Column of Processing Elements
genvar n; 
generate
	for (n = 0; n < HPE-2; n = n + 1) begin: first_row
        PE_OS_16 PE10(.X(Ain[n+1]), .Y(B_OUT[n][0]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[n+1][0]), .Y_OUT(B_OUT[n+1][0]), .MAC_OUT(Y_OUT[n+1][0]) );
    end
endgenerate
PE_OS_16 PE1127(.X(Ain[HPE-1]), .Y(B_OUT[HPE-2][0]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[HPE-1][0]), .Y_OUT(), .MAC_OUT(Y_OUT[HPE-1][0]));
//PE_OS_16 PE1127(.X(Ain[7]), .Y(B_OUT[6][0]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[7][0]), .Y_OUT(), .MAC_OUT(Y_OUT[7][0]));

// 2D systolic array of Processing Elements
generate
    for (j = 0; j < HPE-1; j = j + 1) begin: systolic_2D_PEs 
        for (i = 0; i < VPE-2; i = i + 1) begin : systolic_2D_PEs1 
			PE_OS_16 PE( .X(A_OUT[i+1][j]), .Y(B_OUT[i][j+1]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[i+1][j+1]), .Y_OUT(B_OUT[i+1][j+1]), .MAC_OUT(Y_OUT[i+1][j+1]));
		end	
		PE_OS_16 PEss( .X(A_OUT[HPE-1][j]), .Y(B_OUT[HPE-2][j+1]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[HPE-1][j+1]), .Y_OUT(), .MAC_OUT(Y_OUT[HPE-1][j+1]) );
//		PE_OS_16 PEss( .X(A_OUT[7][j]), .Y(B_OUT[6][j+1]), .CLK(CLK), .RST(RST), .X_OUT(A_OUT[7][j+1]), .Y_OUT(), .MAC_OUT(Y_OUT[7][j+1]) );

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

