module normalizeAndExpUpdate(prenormalized, lza_shamt, cExpIsSmall, shamt, exp_correction, normalized, res_exp, normalized_exp);
  //Parameters
  `include "parameters.v"  
  
  input [2*(SIG_WIDTH+1)+CSIG_WIDTH+8:0] prenormalized;//32-bit (Kashif: 46:0 -- 47 bits)
  input [5:0] lza_shamt, shamt;
  input cExpIsSmall;
  input [EXP_WIDTH-1:0] res_exp;
  output [EXP_WIDTH-1:0] normalized_exp;
  
  
  output exp_correction;
  output [(CSIG_WIDTH+1)+2:0] normalized; //27-bit
  
  wire [2*(SIG_WIDTH+1)+CSIG_WIDTH+8:0] normalized1,normalized2;  //51 bit//32-bit (Kashif: 46:0 -- 47 bit)
  //If cExp was small, the top 8 bits only  so add 8
  //to lza_shamt
 
  wire shamt_portion = (shamt >2*(SIG_WIDTH+1)+4);
  wire [5:0] lza_corrected1 = (shamt_portion)? lza_shamt+(2*(SIG_WIDTH+1)+4) : shamt;
  wire [EXP_WIDTH-1:0] exp_update1 = (shamt_portion)? res_exp-lza_shamt+3+cExpIsSmall-(shamt<=21) : res_exp+1;//(It should be shamt==20)
  
  //Big shift
  assign normalized1 = prenormalized << lza_corrected1;
   
  //Correction shamt
  reg [1:0] corr_shamt;
  reg [EXP_WIDTH-1:0] exp_update2;
  always @ * begin
     casex(normalized1[2*(SIG_WIDTH+1)+CSIG_WIDTH+8:2*(SIG_WIDTH+1)+CSIG_WIDTH+8-2])//31:29
       3'b001: begin corr_shamt=2;  exp_update2 = exp_update1 - 2; end//Originally 2
       3'b01x: begin corr_shamt=1; exp_update2 = exp_update1 - 1; end//Originally 1
       3'b000: begin corr_shamt=3; exp_update2 = exp_update1 - 3; end//Originally 3
       default: begin corr_shamt=0; exp_update2 = exp_update1; end//Originally 0
     endcase
  end
  //LZA correction shift
  assign normalized2 = normalized1<< corr_shamt;

  assign normalized = normalized2[2*(SIG_WIDTH+1)+CSIG_WIDTH+8:2*(SIG_WIDTH+1)+5]; //46:20 -- 27-bit
  assign exp_correction = (~normalized1[2*(SIG_WIDTH+1)+CSIG_WIDTH+8]);
  
  assign normalized_exp = exp_update2;
  
endmodule
