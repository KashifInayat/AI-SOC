
module fpSpecialCases(A,B,C, aIsPZero, aIsNZero, bIsPZero, bIsNZero, cIsPZero,
                    cIsNZero, setResultNaN, setResultPInf, setResultNInf);
  //Detect FP special cases from input FP operands and raise 
  //relavent flags
  //Parameters
 `include "parameters.v"
  
  input [WIDTH-1:0] A,B;
  input [CWIDTH-1:0] C;
  output aIsPZero, bIsPZero, cIsPZero;
  output aIsNZero, bIsNZero, cIsNZero;
  output setResultNaN, setResultPInf, setResultNInf;
  
  
  //Zero Values
  assign aIsPZero = (A == 0);
  assign bIsPZero = (B == 0);
  assign cIsPZero = (C == 0);
  assign aIsNZero = (A == {1'b1,{(WIDTH-1){1'b0}}});
  assign bIsNZero = (B == {1'b1,{(WIDTH-1){1'b0}}});
  assign cIsNZero = (C == {1'b1,{(CWIDTH-1){1'b0}}});
    
  //NaN Values  
  wire aNaN, bNaN, cNaN;
  assign aNaN = (A[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (|A[SIG_WIDTH-1:0]);
  assign bNaN = (B[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (|B[SIG_WIDTH-1:0]);
  assign cNaN = (C[CWIDTH-2:CWIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (|C[CSIG_WIDTH-1:0]);
  
  assign setResultNaN = aNaN | bNaN  | cNaN;
  
  //Inf Values
  wire aIsPInf, bIsPInf, cIsPInf;
  wire aIsNInf, bIsNInf, cIsNInf;
  assign aIsPInf = (A[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|A[SIG_WIDTH-1:0]) & ~A[WIDTH-1];
  assign bIsPInf = (B[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|B[SIG_WIDTH-1:0]) & ~B[WIDTH-1];
  assign cIsPInf = (C[CWIDTH-2:CWIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|C[CSIG_WIDTH-1:0]) & ~C[CWIDTH-1];
  
  assign aIsNInf = (A[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|A[SIG_WIDTH-1:0]) & A[WIDTH-1];
  assign bIsNInf = (B[WIDTH-2:WIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|B[SIG_WIDTH-1:0]) & B[WIDTH-1];
  assign cIsNInf = (C[CWIDTH-2:CWIDTH-EXP_WIDTH-1]=={EXP_WIDTH{1'b1}}) & (~|C[CSIG_WIDTH-1:0]) & C[CWIDTH-1];
  
  assign setResultPInf = aIsPInf | bIsPInf | cIsPInf;
  assign setResultNInf = aIsNInf | bIsNInf | cIsNInf;
  
endmodule
