module rounding(normalized, res_sign, exp_normalized, rnd, result_pre);
  parameter CWIDTH=32;
  parameter CSIG_WIDTH=23;
  parameter EXP_WIDTH=8;

 
  input [(CSIG_WIDTH+1)+2:0] normalized;//26:0 -- 27-bit
  input [EXP_WIDTH-1:0] exp_normalized;
  input res_sign;
  input [1:0] rnd;

  output [CWIDTH-1:0] result_pre;
 
  wire G, R, T;
  wire [CSIG_WIDTH+1:0] round_nearest;
  wire [CSIG_WIDTH+1:0] round_zero;
  wire [CSIG_WIDTH+1:0] round_rne;
  reg [CSIG_WIDTH+1:0] rounded;
  
  assign G = normalized[2];
  assign R = normalized[1];
  assign T = normalized[0];
  wire [CSIG_WIDTH+2:0] preround_rn = {1'b0,normalized[(CSIG_WIDTH+1)+2:2]} + 1'b1;//26:2 -- 25-bit
  assign round_rne = (G & ~(R | T))?/*make L=0*/{preround_rn[CSIG_WIDTH+1:2],1'b0}: preround_rn[CSIG_WIDTH+2:1]/*no change*/;
  assign round_nearest =  preround_rn[CSIG_WIDTH+2:1];
  assign round_zero = normalized[(CSIG_WIDTH+1)+2:3];

  always @(*) begin
    casex(rnd)
      2'b00: rounded = round_zero;
      2'b01: rounded = round_nearest;
      default: rounded = round_rne;
    endcase
  end
  
  
  
  //Renormalize if required
  wire [CSIG_WIDTH:0] renormalized = (rounded[CSIG_WIDTH+1])?rounded[CSIG_WIDTH+1:1]:rounded[CSIG_WIDTH:0];
  wire [EXP_WIDTH-1:0] exp_update2 = (rounded[CSIG_WIDTH+1])?exp_normalized+1:exp_normalized;
  
  //Pack
  wire [CWIDTH-1:0] result_pre;
  assign result_pre = {res_sign,exp_update2,renormalized[CSIG_WIDTH-1:0]}; 
endmodule
