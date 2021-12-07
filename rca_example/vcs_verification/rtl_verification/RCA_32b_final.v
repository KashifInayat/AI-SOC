module RCA_32b_final(clk, reset, cin, pwr_sig,  a,b,s);
  input clk;
  input reset;
  input cin;
  input pwr_sig;
  input [31:0] a,b;
  output [32:0]s; 
 
  wire cout_lsb;
  wire iso;
  wire ret;
  wire pse;
  wire iso1;
  wire ret1;
  wire pse1;

  RCA_16b_final lsb_rca(.clk(clk), .reset(reset), .cin(cin), .iso(iso1), .ret(
                ret1), .pse(pse1), .a(a[15:0]), .b(b[15:0]),.s(s[15:0]),.cout(cout_lsb));


  RCA_16b_final msb_rca(.clk(clk), .reset(reset), .cin(cout_lsb), .iso(iso), .ret(
                ret), .pse(pse), .a(a[31:16]), .b(b[31:16]),.s(s[31:16]),.cout(s[32]));

  powercontrol_final pwr_ctrl(.clk(clk), .reset(reset), .pwr_sig(pwr_sig), .pse(pse),.pse1(pse1), .iso(iso), .iso1(iso1), .ret(ret), .ret1(ret1));
endmodule


