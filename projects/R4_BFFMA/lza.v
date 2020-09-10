
module lza(opA, opB, ldCount);
  //Parameters
  `include "parameters.v"

  //leading digit anticipator
  localparam m=CSIG_WIDTH;
  input [m:0] opA, opB;
  output reg [5:0] ldCount; 
  
  //Genrate, Propageate and Kill vectors
  
  wire [m:0] G,T,Z;
  
  
  
  
  generate 
    genvar i;
    for(i=m;i>=0;i=i-1) begin:lzd
      assign G[i]=opA[i] & opB[i];
      assign T[i]=opA[i] ^ opB[i];
      assign Z[i]=~opA[i] & ~opB[i];
    end
  endgenerate
  
  
  //Indicator vector
  wire [m:0]f;
  assign f[m]=~T[m] & T[m-1];
  generate
    genvar j;
    for(j=m-1;j>0;j=j-1)begin:indicators
      assign f[j]=(T[j+1] & ( (G[j] & ~Z[j-1]) | (Z[j] & ~G[j-1]) ) ) | 
                 (~T[j+1] & ( (Z[j] & ~Z[j-1]) | (G[j] & ~G[j-1]) ) ); 
    end
  endgenerate
  
  reg [5:0] normalizeAmt;
  always @ (*) begin
   ldCount = normalizeAmt;
 end
 
 
  always @ (*) begin
      casex(f)
      {1'b1,{23{1'bx}}}: normalizeAmt=0;
      {1'b0, 1'b1,{22{1'bx}}}: normalizeAmt=1;
      {1'b0, 2'b1,{21{1'bx}}}: normalizeAmt=2;
      {1'b0, 3'b1,{20{1'bx}}}: normalizeAmt=2+1;
      {1'b0, 4'b1,{19{1'bx}}}: normalizeAmt=3+1;
      {1'b0, 5'b1,{18{1'bx}}}: normalizeAmt=4+1;
      {1'b0, 6'b1,{17{1'bx}}}: normalizeAmt=5+1;
      {1'b0, 7'b1,{16{1'bx}}}: normalizeAmt=6+1;
      {1'b0, 8'b1,{15{1'bx}}}: normalizeAmt=7+1;
      {1'b0, 9'b1,{14{1'bx}}}: normalizeAmt=8+1;
      {1'b0, 10'b1,{13{1'bx}}}: normalizeAmt=9+1;
      {1'b0, 11'b1,{12{1'bx}}}: normalizeAmt=10+1;
      {1'b0, 12'b1,{11{1'bx}}}: normalizeAmt=11+1;
      {1'b0, 13'b1,{10{1'bx}}}: normalizeAmt=12+1;
      {1'b0, 14'b1,{9{1'bx}}}: normalizeAmt=13+1;
      {1'b0, 15'b1,{8{1'bx}}}: normalizeAmt=14+1;
      {1'b0, 16'b1,{7{1'bx}}}: normalizeAmt=15+1;
      {1'b0, 16'b1,{6{1'bx}}}: normalizeAmt=16+1;
      {1'b0, 16'b1,{5{1'bx}}}: normalizeAmt=17+1;
      {1'b0, 16'b1,{4{1'bx}}}: normalizeAmt=18+1;
      {1'b0, 16'b1,{3{1'bx}}}: normalizeAmt=19+1;
      {1'b0, 16'b1,{2{1'bx}}}: normalizeAmt=20+1;
      {1'b0, 16'b1,{1{1'bx}}}: normalizeAmt=21+1;
      24'b1: normalizeAmt=22+1;
    default: normalizeAmt=0;
     endcase
  end
  
  
endmodule
