module RCA_16b_final(clk, reset, cin, iso, ret, pse, a,b,s, cout);
  input clk;
  input reset;
  input cin;
  input iso;
  input ret;
  input pse;
  input [15:0] a,b; 
  output reg [15:0] s;
  output reg cout;
  
always@(posedge clk)
{cout, s} <= a+b+cin;


endmodule


