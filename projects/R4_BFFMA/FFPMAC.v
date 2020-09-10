module FFPMAC(A, B, C, rnd, clk, rst,  result);
 //Rounding modes (rnd)
  // 00 -> Round to zero
  // 01 -> Round to nearest
  // 10 -> Round to nearest even
 
  //Parameters
 `include "parameters.v"
  
  //I/O decalarations
  input [WIDTH-1:0] A,B;
  input [CWIDTH-1:0] C;
  // wire [1:0] rnd=1;
  input [1:0] rnd;
  input clk, rst;  
  output reg [CWIDTH-1:0] result;
  //Special cases handling
  wire aIsPZero, bIsPZero, cIsPZero, setResultNaN, setResultPInf,
       aIsNZero, bIsNZero, cIsNZero, setResultNInf;
  fpSpecialCases SCH(A,B,C, aIsPZero, aIsNZero, bIsPZero, bIsNZero, cIsPZero,
                    cIsNZero, setResultNaN, setResultPInf, setResultNInf);
  wire setResultZero = (aIsNZero | aIsPZero | bIsNZero |  bIsPZero ) & (cIsPZero | cIsNZero);    
           
  //Unpacking and subnormal checks
  wire aIsSubnormal, bIsSubnormal, cIsSubnormal;
  wire aSign, bSign, cSign;
  wire [EXP_WIDTH-1:0] aExp, bExp, cExp;
  wire [SIG_WIDTH:0] aSig, bSig;
  wire [CSIG_WIDTH:0] cSig;
  unpack UPCK(A,B,C, aIsSubnormal, aSign, aExp, aSig,
                     bIsSubnormal, bSign, bExp, bSig,
                     cIsSubnormal, cSign, cExp, cSig);
                     
  //Sign handling 
  wire product_sign=aSign ^ bSign;
  wire effectiveOp = cSign ^ product_sign;
  wire [18:0] prodT;

  //Exponent comparison
  wire [SHAMT_WIDTH-1:0] shamt1;
  wire [SHAMT_WIDTH-1:0] shamt;
  wire [EXP_WIDTH-1:0] resExp1;
  wire cExpIsSmall;
  exponentComparison EC(aExp, bExp, cExp, shamt, cIsSubnormal, resExp1, cExpIsSmall);
  
  //**********Alignment Shift
  wire [2*(SIG_WIDTH+1)+CSIG_WIDTH+7:0] CAligned_pre;//47 btis
  wire [2*(SIG_WIDTH+1)+CSIG_WIDTH+7:0] CAligned; //47bits
  
  
  
  
  wire sticky;
  align ALGN(cSig, shamt, CAligned_pre, sticky);
  
  //Bit-invert C for effective subtraction
  assign CAligned = (effectiveOp)?{1'b1,~CAligned_pre[2*(SIG_WIDTH+1)+CSIG_WIDTH+6:0]}:{1'b0,CAligned_pre[2*(SIG_WIDTH+1)+CSIG_WIDTH+6:0]};
  
  
  //Significand multiplier
  wire [2*SIG_WIDTH+3:0] sum_of, carry_of;
  wire [2*(SIG_WIDTH+1)+1:0] sum,carry; //18-bit
  wire [2*(SIG_WIDTH+1)+1:0] sum_custom,carry_custom, carry_custom_pre; //18-bit
  
  significandMultiplier1 SMUL(aSig, bSig, sum_custom, carry_custom_pre);
  assign carry_custom = carry_custom_pre<<1;//Why?
   
   //Assign 18-bit sum and carry vectors for significand multiplier
   assign sum = sum_custom; 
   assign carry = carry_custom;
   assign prodT=sum+carry;
  
  //****************************************************************************************************
  //************************CSA to combine product (sum, product and aligned C)
  //*** 3 groups of aligned C
  //C_low: 2 bits --> Guard and Round bit (sticky bit is kept separate for now)
  //C_mid: 18 bits --> Add to product sum and carry vectors
  //C_hi: 26 bits --> Pass on to the increamenter later 
  
  wire [1:0] C_low = {CAligned[1], CAligned[0]};  
  wire [CSIG_WIDTH:0] C_mid = CAligned[CSIG_WIDTH+2:2];//(23:0 -- 25:2 -- 24-bit)
  wire [2*(SIG_WIDTH+1)+4:0] C_hi = CAligned[2*(SIG_WIDTH+1)+CSIG_WIDTH+7:(CSIG_WIDTH)+3];// [46:26]-- 21 bit, MSB is sign
  
  wire [CSIG_WIDTH:0] sum_add, carry_add;//CSA outputs -- 18-bit
  

  compressor_3_2_group24 ADD({sum,6'b000000}, {carry,6'b000000}, C_mid, sum_add, carry_add); /* 18-bit*/
  
  //*****************************************************************************************************
  //***********************Cout supression for Eac
  wire c_eac; 
  wire smul_no_carry = ~(sum[2*(SIG_WIDTH+1)+1] | carry[2*(SIG_WIDTH+1)+1]);
  wire smul_caligned_carry = smul_no_carry | C_mid[CSIG_WIDTH];
  wire carryin_inc = smul_caligned_carry & c_eac;
  
  //*****************************************************************************************************
  //***********************Increamentor for C_hi
  wire [2*(SIG_WIDTH+1)+4:0] C_hi_inc = C_hi+1'b1;//21-bit, MSB is sign bit
  
  
  //*****************************************************************************************************
  //*********************** EAC adder (18-bit)
  wire cin=0;
  wire [CSIG_WIDTH:0] sum_eac;//18-bit (Kashif: 24-bit)
  wire [CSIG_WIDTH:0] carry_add_wgt = {carry_add[CSIG_WIDTH:0],1'b0}; //discard carry_add MSB
  eac_cla_adder /*24-bit*/ EAC(sum_add , carry_add_wgt, cin, sticky, effectiveOp, sum_eac, c_eac );
    
  wire [CSIG_WIDTH-1:0] sum_small = {sum_add[CSIG_WIDTH-1:0]};//17-bit -- 23 bit
  wire [CSIG_WIDTH-1:0] carry_small = {carry_add[CSIG_WIDTH-2:0],1'b0};// -- 23 bit
  
  //*****************************************************************************************************
  //********************* Leading zero anticipator
  wire [5:0] lza_shamt;
  lza LZA(sum_add, carry_add_wgt, lza_shamt);//24-bit
  

  
  //*****************************************************************************************************
  //*********************** Construct prenormalized result
  wire [2*(SIG_WIDTH+1)+CSIG_WIDTH+7:0] prenormalized, prenormalized_pre;//46:0 -- 47 bit
  assign prenormalized_pre[1:0] = C_low; //Guard and round bits
  assign prenormalized_pre[CSIG_WIDTH+2:2] = sum_eac; //Sum bits 25:2 = 24-bit
  assign prenormalized_pre[2*(SIG_WIDTH+1)+CSIG_WIDTH+7:CSIG_WIDTH+3] = (carryin_inc)?{C_hi_inc}:{C_hi}; //Increamentor bits 46:20 =21-bit
  
  //Bit-complement in case of negative result 
  assign prenormalized = (prenormalized_pre[2*(SIG_WIDTH+1)+CSIG_WIDTH+3] & effectiveOp)?~prenormalized_pre:prenormalized_pre;
  
  //Also set the result sign as negative if a bit-complement is required
  wire res_sign = (prenormalized_pre[2*(SIG_WIDTH+1)+CSIG_WIDTH+3] & effectiveOp)?1'b1:1'b0;
  
  //*****************************************************************************************************
  //*********************** Normalize result
  wire [(CSIG_WIDTH+1)+2:0] normalized;//26:0 -- 27-bit
  wire exp_correction;
  wire [EXP_WIDTH-1:0] exp_normalized;
  normalizeAndExpUpdate NORMALIZE({prenormalized,sticky}, lza_shamt, cExpIsSmall, shamt, exp_correction, normalized,
                      resExp1, exp_normalized);
  
  wire [CWIDTH-1:0] result_pre;
  
  //Round according to rounding mode
  // 00 -> Round to zero
  
  // 01 -> Round to nearest
  // 10 -> Round to nearest even
rounding round(normalized, res_sign, exp_normalized, rnd, result_pre);

  
  //Select result (setResultNaN, setResultPInf, setResultNInf)
  always @ (*) begin
    casex({setResultZero, setResultNaN, setResultPInf, setResultNInf})
      4'b1xxx: //Zero 
              result = 0;
      4'b1xx: //NaN
              result = {code_NaN,16'h0};
      4'b01x: //Positive Infinity
              result = {code_PINF,16'h0};
      4'b001: //Negative Infinity
              result = {code_NINF,16'h0};
      default: //computed result 
              result = result_pre;
    endcase
  end
endmodule


