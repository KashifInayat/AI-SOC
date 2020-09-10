module align(C, shamt, CAligned,  sticky);
  //Parameters
 `include "parameters.v" 
  
  input [CSIG_WIDTH:0] C;
  input [SHAMT_WIDTH-1:0] shamt;
//  wire [SHAMT_WIDTH-1:0] shamt_adjusted;
  output [2*(SIG_WIDTH+1)+CSIG_WIDTH+7:0] CAligned;//53-bit, However, I counted 46
  output sticky;
  
  wire [2*(SIG_WIDTH+1)+2*(CSIG_WIDTH+1):0] T;//65 bits for T when 
///////////////////////////For the OR of first 23 bits  ////////////////////// 
  genvar i;
  generate
    for(i=2*(SIG_WIDTH+1);i<2*(SIG_WIDTH+2)+(CSIG_WIDTH)-1;i=i+1) begin: gen_T
      assign T[i]=|C[i-2*(SIG_WIDTH+1):0];//Or  the bits 16-16=0 till 38-16=22
    end
  endgenerate
  ///////////////////////////For the OR of all bits////////////////////// 
   /*genvar i;
  generate
    for(i=2*(SIG_WIDTH+1)+(CSIG_WIDTH);i<=2*(SIG_WIDTH+1)+2*(CSIG_WIDTH+1);i=i+1) begin: gen_T1
      assign T[i]=|C[CSIG_WIDTH:0];//OR all 24 bits of C
    end
  endgenerate  */ 
  
 
  assign CAligned = {1'b0,C,{(2*(SIG_WIDTH+1)+2+2+2){1'b0}}} >> shamt; //1, 24, 54
  assign sticky = ((shamt< (2*(SIG_WIDTH+1)+4)) | (shamt>21))?1'b0:T[shamt];//(it should be 2*(SIG_WIDTH+1)+1+ 5)

  
endmodule

