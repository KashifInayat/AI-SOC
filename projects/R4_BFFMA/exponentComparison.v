module exponentComparison(aExp, bExp, cExp, shamt, cIsSubnormal, res_exp, cExpIsSmall);
    //Parameters
 `include "parameters.v"
  
  input [EXP_WIDTH-1:0] aExp, bExp, cExp;
  input cIsSubnormal;
  output [SHAMT_WIDTH-1:0] shamt;
  output [EXP_WIDTH-1:0] res_exp;
  output cExpIsSmall;
  
  wire [EXP_WIDTH-1:0] product_exp;
  
  wire [SHAMT_WIDTH-1:0] shamt_internal, shamt_pre;
  
  assign product_exp = aExp + bExp;
  assign shamt_pre = product_exp - BIAS - cExp + (2*SIG_WIDTH+3+6);//only shift of 23, why?It should be 23 bits.
  assign shamt_internal = (cExp > (product_exp - BIAS + (2*SIG_WIDTH+3+6)))?0:shamt_pre;
  
  assign shamt=(cIsSubnormal)? shamt_internal+1:shamt_internal;
  
  assign cExpIsSmall = ((product_exp - BIAS) >= cExp);
  
  assign res_exp= ( cExpIsSmall )?product_exp-BIAS:cExp;//Result exponent
  

  
  
  
  
endmodule
